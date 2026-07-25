# -*- coding: utf-8 -*-

from api.database import get_connection


def analyze_module(module_name):

    conn = get_connection()
    cur = conn.cursor()

    cur.execute(
        """
        SELECT COUNT(*)
        FROM sap_process_library
        WHERE module = %s
        """,
        (module_name,)
    )

    process_count = cur.fetchone()[0]

    cur.execute(
        """
        SELECT COUNT(*)
        FROM sap_process_steps s
        JOIN sap_process_library p
            ON s.process_id = p.process_id
        WHERE p.module = %s
        """,
        (module_name,)
    )

    step_count = cur.fetchone()[0]

    cur.execute(
        """
        SELECT process_name
        FROM sap_process_library
        WHERE module = %s
        ORDER BY process_name
        LIMIT 15
        """,
        (module_name,)
    )

    processes = cur.fetchall()

    cur.close()
    conn.close()

    return {
        "module": module_name,
        "processes": process_count,
        "steps": step_count,
        "process_list": [p[0] for p in processes]
    }