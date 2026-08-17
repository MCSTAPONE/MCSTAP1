# -*- coding: utf-8 -*-

from api.database import get_connection


def get_automation_recommendation():

    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT
            p.process_name,
            p.module,
            COUNT(DISTINCT s.transaction_code) required_steps
        FROM sap_process_library p
        JOIN sap_process_steps s
            ON p.process_id = s.process_id
        GROUP BY
            p.process_name,
            p.module
    """)

    rows = cur.fetchall()

    recommendations = []

    for row in rows:

        process_name = row[0]
        module = row[1]
        required_steps = row[2]

        cur.execute("""
            SELECT DISTINCT transaction_code
            FROM sap_process_steps s
            JOIN sap_process_library p
                ON s.process_id = p.process_id
            WHERE p.process_name = %s
        """, (process_name,))

        process_steps = cur.fetchall()

        available = 0

        for step in process_steps:

            cur.execute("""
                SELECT COUNT(*)
                FROM repository_assets
                WHERE transaction_code = %s
            """, (step[0],))

            if cur.fetchone()[0] > 0:
                available += 1

        coverage = 0

        if required_steps > 0:

            coverage = round(
                (available / required_steps) * 100
            )

        gap = 100 - coverage

        recommendations.append({
            "process": process_name,
            "module": module,
            "coverage": coverage,
            "gap": gap
        })

    recommendations = sorted(
        recommendations,
        key=lambda x: x["gap"],
        reverse=True
    )

    cur.close()
    conn.close()

    return recommendations[:10]