# -*- coding: utf-8 -*-

from api.database import get_connection


def get_process_steps(process_name):

    conn = get_connection()
    cur = conn.cursor()

    cur.execute(
        """
        SELECT
            MIN(process_id),
            process_name,
            module
        FROM sap_process_library
        WHERE UPPER(process_name) = %s
        GROUP BY
            process_name,
            module
        """,
        (process_name.upper(),)
    )

    process = cur.fetchone()

    if not process:

        cur.close()
        conn.close()

        return None

    process_id = process[0]

    cur.execute(
        """
        SELECT DISTINCT
            sequence_no,
            transaction_code,
            step_name
        FROM sap_process_steps
        WHERE process_id = %s
        ORDER BY sequence_no
        """,
        (process_id,)
    )

    rows = cur.fetchall()

    cur.close()
    conn.close()

    return {
        "process_name": process[1],
        "module": process[2],
        "steps": rows
    }