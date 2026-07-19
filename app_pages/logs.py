# -*- coding: utf-8 -*-
import streamlit as st
import pandas as pd
from services.db import get_connection


def show_logs_page():

    st.title("Execution History")

    # ===============================
    # ✅ ONLY SHOW HISTORY (CLEAN)
    # ===============================
    conn = get_connection()

    df = pd.read_sql("""
        SELECT test_id, module, process, test_type, status, executed_at
        FROM test_execution_history
        ORDER BY executed_at DESC
        LIMIT 200
    """, conn)

    conn.close()

    if df.empty:
        st.info("No execution history available")
    else:

        # ✅ FILTER OPTION
        status_filter = st.selectbox(
            "Filter by Status",
            ["ALL", "PASSED", "FAILED", "SKIPPED"]
        )

        if status_filter != "ALL":
            df = df[df["status"] == status_filter]

        st.dataframe(df)