# -*- coding: utf-8 -*-

from api.database import get_connection


def get_recent_commands(limit=15):

    conn = get_connection()
    cur = conn.cursor()

    cur.execute(
        """
        SELECT command_text
        FROM ai_command_history
        ORDER BY id DESC
        LIMIT %s
                """,
        (limit,)
    )

    rows = cur.fetchall()

    cur.close()
    conn.close()

    return [row[0] for row in rows]