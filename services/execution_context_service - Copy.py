# -*- coding: utf-8 -*-

from api.database import get_connection


class ExecutionContextService:

    def build_context(
        self,
        test_case_id
    ):

        conn = get_connection()

        cur = conn.cursor()

        # ==============================
        # TEST CASE
        # ==============================

        cur.execute(
            """
            SELECT

                tc.id,

                tc.test_case_id,

                tc.title,

                tc.flow_id,

                tc.tdc_id

            FROM test_cases tc

            WHERE tc.id = %s
            """,
            (test_case_id,)
        )

        test_case = cur.fetchone()

        if not test_case:

            cur.close()
            conn.close()

            raise Exception(
                f"Test Case {test_case_id} not found"
            )

        flow_id = test_case[3]

        tdc_id = test_case[4]

        # ==============================
        # FLOW
        # ==============================

        cur.execute(
            """
            SELECT

                flow_id,

                flow_name,

                module

            FROM flow_master

            WHERE flow_id = %s
            """,
            (flow_id,)
        )

        flow = cur.fetchone()

        # ==============================
        # FLOW STEPS
        # ==============================

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

                ON fs.asset_id =
                   ra.asset_id

            WHERE fs.flow_id = %s

            ORDER BY fs.sequence_no
            """,
            (flow_id,)
        )

        flow_steps = cur.fetchall()

        # ==============================
        # TDC HEADER
        # ==============================

        cur.execute(
            """
            SELECT

                tdc_id,

                tdc_name,

                business_object

            FROM tdc_master

            WHERE tdc_id = %s
            """,
            (tdc_id,)
        )

        tdc = cur.fetchone()

        # ==============================
        # TDC VALUES
        # ==============================

        cur.execute(
            """
            SELECT

                parameter_name,

                parameter_value

            FROM tdc_values

            WHERE tdc_id = %s
            """,
            (tdc_id,)
        )

        rows = cur.fetchall()

        test_data = {}

        for row in rows:

            parameter_name = row[0]

            parameter_value = row[1]

            test_data[
                parameter_name
            ] = parameter_value

        cur.close()
        conn.close()

        return {
	    "test_case": test_case,
	    "flow": flow,
	    "flow_steps": flow_steps,
	    "tdc": tdc,
	    "test_data": test_data,
	    "runtime": {}
	  }