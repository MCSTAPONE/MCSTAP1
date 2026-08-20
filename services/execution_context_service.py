# -*- coding: utf-8 -*-

from api.database import get_connection


class ExecutionContextService:

    def build_context(
        self,
        test_case_id
    ):

        conn = get_connection()
        cur = conn.cursor()

        try:

            # ==========================================
            # TEST CASE
            # ==========================================

            cur.execute(
                """
                SELECT
                    tc.id,
                    tc.test_case_id,
                    tc.title,
                    tc.flow_id,
                    tc.tdc_id,
                    tc.sdc_id
                FROM test_cases tc
                WHERE tc.id = %s
                """,
                (
                    test_case_id,
                )
            )

            test_case = cur.fetchone()

            if not test_case:
                raise ValueError(
                    f"Test Case {test_case_id} "
                    "was not found."
                )

            flow_id = test_case[3]
            tdc_id = test_case[4]
            sdc_id = test_case[5]

            if not flow_id:
                raise ValueError(
                    f"Test Case {test_case_id} "
                    "does not have a Flow assigned."
                )

            if not tdc_id:
                raise ValueError(
                    f"Test Case {test_case_id} "
                    "does not have a TDC assigned."
                )

            if not sdc_id:
                raise ValueError(
                    f"Test Case {test_case_id} "
                    "does not have an SDC assigned."
                )

            # ==========================================
            # FLOW
            # ==========================================

            cur.execute(
                """
                SELECT
                    flow_id,
                    flow_name,
                    module
                FROM flow_master
                WHERE flow_id = %s
                """,
                (
                    flow_id,
                )
            )

            flow = cur.fetchone()

            if not flow:
                raise ValueError(
                    f"Flow {flow_id} assigned to "
                    f"Test Case {test_case_id} "
                    "was not found."
                )

            # ==========================================
            # FLOW STEPS
            # ==========================================

            cur.execute(
                """
                SELECT
                    fs.step_id,
                    fs.sequence_no,
                    ra.asset_name,
                    ra.business_object,
                    ra.operation,
                    ra.asset_script
                FROM flow_steps fs
                INNER JOIN repository_assets ra
                    ON fs.asset_id = ra.asset_id
                WHERE fs.flow_id = %s
                ORDER BY fs.sequence_no
                """,
                (
                    flow_id,
                )
            )

            flow_steps = cur.fetchall()

            if not flow_steps:
                raise ValueError(
                    f"Flow {flow_id} does not contain "
                    "any executable steps."
                )

            # ==========================================
            # TDC HEADER
            # ==========================================

            cur.execute(
                """
                SELECT
                    tdc_id,
                    tdc_name,
                    business_object
                FROM tdc_master
                WHERE tdc_id = %s
                """,
                (
                    tdc_id,
                )
            )

            tdc = cur.fetchone()

            if not tdc:
                raise ValueError(
                    f"TDC {tdc_id} assigned to "
                    f"Test Case {test_case_id} "
                    "was not found."
                )

            # ==========================================
            # TDC VALUES
            # ==========================================

            cur.execute(
                """
                SELECT
                    parameter_name,
                    parameter_value
                FROM tdc_values
                WHERE tdc_id = %s
                """,
                (
                    tdc_id,
                )
            )

            tdc_rows = cur.fetchall()

            test_data = {}

            for row in tdc_rows:
                parameter_name = row[0]
                parameter_value = row[1]

                test_data[
                    parameter_name
                ] = parameter_value

            # ==========================================
            # SDC
            # ==========================================

            cur.execute(
                """
                SELECT
                    sdc_id,
                    sdc_name,
                    environment,
                    sap_logon_entry,
                    sap_system_id,
                    client,
                    language,
                    description,
                    status
                FROM sdc_master
                WHERE sdc_id = %s
                """,
                (
                    sdc_id,
                )
            )

            sdc = cur.fetchone()

            if not sdc:
                raise ValueError(
                    f"SDC {sdc_id} assigned to "
                    f"Test Case {test_case_id} "
                    "was not found."
                )

            if sdc[8] != "Active":
                raise ValueError(
                    f"SDC '{sdc[1]}' is not active."
                )

            # ==========================================
            # SYSTEM DATA
            # ==========================================

            system_data = {
                "sdc_id": sdc[0],
                "sdc_name": sdc[1],
                "environment": sdc[2],
                "sap_logon_entry": sdc[3],
                "sap_system_id": sdc[4],
                "client": sdc[5],
                "language": sdc[6],
                "description": sdc[7],
                "status": sdc[8]
            }

            # ==========================================
            # EXECUTION CONTEXT
            # ==========================================

            context = {
                "test_case": test_case,
                "flow": flow,
                "flow_steps": flow_steps,
                "tdc": tdc,
                "test_data": test_data,
                "sdc": sdc,
                "system_data": system_data,
                "runtime": {}
            }

            return context

        finally:
            cur.close()
            conn.close()