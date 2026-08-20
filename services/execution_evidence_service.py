# -*- coding: utf-8 -*-

import json

from datetime import datetime
from datetime import timezone

from api.database import get_connection


class ExecutionEvidenceService:

    def normalize_execution_result(
        self,
        execution_result
    ):

        if isinstance(
            execution_result,
            dict
        ):

            return {
                "status": execution_result.get(
                    "status",
                    "SUCCESS"
                ),
                "results": execution_result.get(
                    "results",
                    []
                ),
                "runtime": execution_result.get(
                    "runtime",
                    {}
                ),
                "system_data": execution_result.get(
                    "system_data",
                    {}
                )
            }

        return {
            "status": "SUCCESS",
            "results": (
                execution_result
                if isinstance(
                    execution_result,
                    list
                )
                else []
            ),
            "runtime": {},
            "system_data": {}
        }

    def get_asset_status(
        self,
        asset_result
    ):

        status_value = asset_result.get(
            "status"
        )

        if isinstance(
            status_value,
            dict
        ):

            return status_value.get(
                "status",
                "SUCCESS"
            )

        if isinstance(
            status_value,
            str
        ):

            normalized_status = (
                status_value
                .strip()
                .upper()
            )

            if normalized_status in {
                "FAILED",
                "FAILURE",
                "ERROR"
            }:

                return "FAILED"

            return "SUCCESS"

        return "SUCCESS"

    def get_asset_details(
        self,
        asset_result
    ):

        status_value = asset_result.get(
            "status"
        )

        if isinstance(
            status_value,
            dict
        ):

            return status_value

        return {
            "value": status_value
        }

    def validate_system_data(
        self,
        system_data
    ):

        if not system_data:

            return

        required_fields = [
            "sdc_id",
            "sdc_name",
            "environment",
            "sap_logon_entry",
            "client",
            "language"
        ]

        missing_fields = [
            field_name
            for field_name in required_fields
            if not system_data.get(
                field_name
            )
        ]

        if missing_fields:

            raise ValueError(
                "Execution system data is missing: "
                + ", ".join(
                    missing_fields
                )
            )

    def save_execution(
        self,
        test_case_id,
        execution_result,
        started_at=None,
        ended_at=None
    ):

        normalized_result = (
            self.normalize_execution_result(
                execution_result
            )
        )

        execution_status = (
            normalized_result["status"]
        )

        results = (
            normalized_result["results"]
        )

        runtime_context = (
            normalized_result["runtime"]
        )

        system_data = (
            normalized_result["system_data"]
        )

        self.validate_system_data(
            system_data
        )

        sdc_id = system_data.get(
            "sdc_id"
        )

        sdc_name = system_data.get(
            "sdc_name"
        )

        environment = system_data.get(
            "environment"
        )

        sap_logon_entry = system_data.get(
            "sap_logon_entry"
        )

        sap_system_id = system_data.get(
            "sap_system_id"
        )

        client = system_data.get(
            "client"
        )

        language = system_data.get(
            "language"
        )

        if started_at is None:

            started_at = datetime.now(
                timezone.utc
            )

        if ended_at is None:

            ended_at = datetime.now(
                timezone.utc
            )

        conn = get_connection()
        cur = conn.cursor()

        try:

            # ==========================================
            # EXECUTION HEADER
            # ==========================================

            cur.execute(
                """
                INSERT INTO test_execution_runs
                (
                    test_case_db_id,
                    execution_status,
                    started_at,
                    ended_at,
                    runtime_context,
                    sdc_id,
                    sdc_name,
                    environment,
                    sap_logon_entry,
                    sap_system_id,
                    client,
                    language
                )
                VALUES
                (
                    %s,
                    %s,
                    %s,
                    %s,
                    %s::jsonb,
                    %s,
                    %s,
                    %s,
                    %s,
                    %s,
                    %s,
                    %s
                )
                RETURNING execution_id
                """,
                (
                    test_case_id,
                    execution_status,
                    started_at,
                    ended_at,
                    json.dumps(
                        runtime_context
                    ),
                    sdc_id,
                    sdc_name,
                    environment,
                    sap_logon_entry,
                    sap_system_id,
                    client,
                    language
                )
            )

            execution_id = (
                cur.fetchone()[0]
            )

            # ==========================================
            # ASSET EXECUTION DETAILS
            # ==========================================

            sequence_no = 1

            for asset_result in results:

                asset_name = (
                    asset_result.get(
                        "asset",
                        "UNKNOWN_ASSET"
                    )
                )

                asset_status = (
                    self.get_asset_status(
                        asset_result
                    )
                )

                asset_details = (
                    self.get_asset_details(
                        asset_result
                    )
                )

                cur.execute(
                    """
                    INSERT INTO test_execution_assets
                    (
                        execution_id,
                        sequence_no,
                        asset_name,
                        asset_status,
                        asset_details
                    )
                    VALUES
                    (
                        %s,
                        %s,
                        %s,
                        %s,
                        %s::jsonb
                    )
                    """,
                    (
                        execution_id,
                        sequence_no,
                        asset_name,
                        asset_status,
                        json.dumps(
                            asset_details
                        )
                    )
                )

                sequence_no = (
                    sequence_no + 1
                )

            conn.commit()

            return {
                "execution_id": execution_id,
                "test_case_id": test_case_id,
                "status": execution_status,
                "runtime": runtime_context,
                "system_data": system_data
            }

        except Exception:

            conn.rollback()

            raise

        finally:

            cur.close()
            conn.close()