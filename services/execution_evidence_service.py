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
                )
            }

        return {
            "status": "SUCCESS",
            "results": execution_result,
            "runtime": {}
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

            if status_value.startswith(
                "CREATED_"
            ):

                return "SUCCESS"

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

            cur.execute(
                """
                INSERT INTO test_execution_runs
                (
                    test_case_db_id,
                    execution_status,
                    started_at,
                    ended_at,
                    runtime_context
                )
                VALUES
                (
                    %s,
                    %s,
                    %s,
                    %s,
                    %s::jsonb
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
                    )
                )
            )

            execution_id = cur.fetchone()[0]

            sequence_no = 1

            for asset_result in results:

                asset_name = asset_result.get(
                    "asset",
                    "UNKNOWN_ASSET"
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

                sequence_no = sequence_no + 1

            conn.commit()

            return {
                "execution_id": execution_id,
                "test_case_id": test_case_id,
                "status": execution_status,
                "runtime": runtime_context
            }

        except Exception as error:

            conn.rollback()

            raise error

        finally:

            cur.close()

            conn.close()