# -*- coding: utf-8 -*-

from api.database import get_connection


def build_test_strategy(process_name):

    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT process_id,module
        FROM sap_process_library
        WHERE UPPER(process_name)=%s
        ORDER BY process_id
        LIMIT 1
    """, (process_name.upper(),))

    process = cur.fetchone()

    if not process:

        return None

    process_id = process[0]

    cur.execute("""
        SELECT
            transaction_code,
            step_name
        FROM sap_process_steps
        WHERE process_id = %s
        ORDER BY sequence_no
    """, (process_id,))

    steps = cur.fetchall()

    cur.close()
    conn.close()

    return {
        "process": process_name,
        "module": process[1],
        "steps": steps
    }