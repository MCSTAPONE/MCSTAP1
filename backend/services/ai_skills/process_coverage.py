# -*- coding: utf-8 -*-

from api.database import get_connection


def analyze_process_coverage(process_name):

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
        SELECT DISTINCT
               transaction_code
        FROM sap_process_steps
        WHERE process_id = %s
        ORDER BY transaction_code
        """,
        (process_id,)
    )

    required_steps = cur.fetchall()

    available = []
    missing = []

    for row in required_steps:

        transaction_code = row[0]

        cur.execute(
            """
            SELECT COUNT(*)
            FROM repository_assets
            WHERE transaction_code = %s
            """,
            (transaction_code,)
        )

        count = cur.fetchone()[0]

        if count > 0:
            available.append(transaction_code)
        else:
            missing.append(transaction_code)

    total_steps = len(required_steps)

    coverage = 0

    if total_steps > 0:

        coverage = round(
            (len(available) / total_steps) * 100,
            2
        )

    cur.close()
    conn.close()

    return {
        "process_name": process[1],
        "module": process[2],
        "required": total_steps,
        "available": available,
        "missing": missing,
        "coverage": coverage
    }