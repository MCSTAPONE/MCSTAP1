import streamlit as st
import pandas as pd
from services.coverage_service import (
    get_execution_summary,
    get_failures_by_tcode,
    get_execution_history
)

def show_analytics_page():

    st.title("📊 Analytics Dashboard")

    # ===============================
    # ✅ SUMMARY
    # ===============================
    total, passed, failed = get_execution_summary()

    col1, col2, col3 = st.columns(3)

    col1.metric("Total Steps", total)
    col2.metric("Passed ✅", passed)
    col3.metric("Failed ❌", failed)

    # ===============================
    # ✅ FAILURE BY T-CODE
    # ===============================
    st.subheader("Top Failing Transactions")

    data = get_failures_by_tcode()

    for tcode, count in data:
        st.write(f"{tcode} → {count} failures")

    # ===============================
    # ✅ EXECUTION HISTORY
    # ===============================
    st.subheader("Recent Executions")

    history = get_execution_history()

    for exec_id, test_id, time in history:
        st.write(f"Execution {exec_id} | Test {test_id} | {time}")
        
    data = get_failures_by_tcode()

    df = pd.DataFrame(data, columns=["Transaction", "Failures"])

    st.dataframe(df)

    if st.button("Download Report"):

        st.download_button(
            label="Download CSV",
            data=df.to_csv(index=False),
            file_name="test_report.csv",
            mime="text/csv"
        )
