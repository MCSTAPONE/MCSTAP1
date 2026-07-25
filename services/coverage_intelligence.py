from api.database import get_connection


def get_coverage_dashboard():

    conn = get_connection()
    cur = conn.cursor()

    # Total processes

    cur.execute("""
        SELECT COUNT(*)
        FROM sap_process_library
    """)

    total_processes = cur.fetchone()[0]

    # Total process steps

    cur.execute("""
        SELECT COUNT(*)
        FROM sap_process_steps
    """)

    total_steps = cur.fetchone()[0]

    # Module breakdown

    cur.execute("""
        SELECT
            module,
            COUNT(*) as process_count
        FROM sap_process_library
        GROUP BY module
        ORDER BY module
    """)

    module_data = []

    for row in cur.fetchall():

        module_data.append({
            "module": row[0],
            "processes": row[1],
            "coverage": 0
        })

    cur.close()
    conn.close()

    return {
        "total_processes": total_processes,
        "total_steps": total_steps,
        "automation_maturity": 0,
        "modules": module_data
    }