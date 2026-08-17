# -*- coding: utf-8 -*-

from api.database import get_connection


def get_missing_assets(process_name):

    conn = get_connection()
    cur = conn.cursor()

    cur.execute(
        """
        SELECT process_id,
                process_name,
                module
        FROM sap_process_library
        WHERE UPPER(process_name) = %s
        ORDER BY process_id
        LIMIT 1
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
        SELECT DISTINCT transaction_code
        FROM sap_process_steps
        WHERE process_id = %s
        ORDER BY transaction_code
        """,
        (process_id,)
    )

    steps = cur.fetchall()

    missing = []

    for step in steps:

        transaction_code = step[0]

        cur.execute(
            """
            SELECT COUNT(*)
            FROM repository_assets
            WHERE transaction_code = %s
            """,
            (transaction_code,)
        )

        exists = cur.fetchone()[0]

        if exists == 0:
            missing.append(transaction_code)

    cur.close()
    conn.close()

    return {
        "process_name": process[1],
        "module": process[2],
        "missing": missing
    }