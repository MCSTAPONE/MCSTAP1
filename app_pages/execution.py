# -*- coding: utf-8 -*-
import streamlit as st
import subprocess
import os


def show_execution_page(coverage_df, TESTS, get_connection):

    mode = st.radio("Execution Mode", ["Test Files", "Coverage Scenarios"])

    # =========================
    # ? TEST FILE MODE
    # =========================
    if mode == "Test Files":

        selected_tests = st.multiselect("Select Tests", list(TESTS.keys()))

        if st.button("Run Selected Tests"):

            if not selected_tests:
                st.warning("Select at least one test")
                st.stop()

            total_results = {"passed": 0, "failed": 0, "skipped": 0}

            for test in selected_tests:
                file_path = TESTS[test]

                st.info(f"Running {test}")

                cmd = ["pytest", file_path, "--alluredir=allure-results", "-q"]
                result = subprocess.run(cmd, capture_output=True, text=True)
                output = result.stdout

                st.text(output)

                total_results["passed"] += output.count("PASSED")
                total_results["failed"] += output.count("FAILED")
                total_results["skipped"] += output.count("SKIPPED")

            col1, col2, col3 = st.columns(3)
            col1.metric("Passed ?", total_results["passed"])
            col2.metric("Failed ?", total_results["failed"])
            col3.metric("Skipped ?", total_results["skipped"])


    # =========================
    # ? COVERAGE MODE
    # =========================
    else:

        modules = sorted(coverage_df["module"].dropna().unique())
        selected_module = st.selectbox("Module", modules)

        df_module = coverage_df[
            coverage_df["module"] == selected_module
        ]

        company_codes = sorted(df_module["company_code"].dropna().unique())
        selected_company = st.selectbox("Company Code", company_codes)

        filtered = df_module[
            df_module["company_code"] == selected_company
        ]

        transactions = sorted(filtered["transaction"].dropna().unique())

        selected_transactions = st.multiselect(
            "Select Transactions",
            transactions
        )

        filtered_tx = filtered[
            filtered["transaction"].isin(selected_transactions)
        ]

        display_df = filtered_tx[
            ["test_id", "company_code", "scenario_id", "transaction"]
        ].rename(columns={
            "test_id": "Test ID",
            "company_code": "Company Code",
            "scenario_id": "Scenario",
            "transaction": "Transaction"
        })

        st.write("Related Test IDs:")

        if not display_df.empty:
            st.dataframe(display_df.reset_index(drop=True))
        else:
            st.info("No data to display")
        if st.button("Run Scenarios"):
            total_results = {"passed": 0, "failed": 0, "skipped": 0}
            for scenario in selected_scenarios:

                row = filtered[filtered["test_id"] == scenario]
                transaction = row["transaction"].values[0]

                st.info(f"{scenario} -> {transaction}")
                test_id = row["test_id"].values[0]
        # ? ? DELETE ONLY HERE ?
        st.subheader("Delete Test(s)")

        if display_df.empty:
            st.info("No tests available for deletion")
        else:

            selected_tests = st.multiselect(
                "Select Tests to Delete",
                display_df["Test ID"]
            )

            confirm = st.checkbox("Confirm delete")

            if st.button("Delete Selected Tests"):

                if not selected_tests:
                    st.warning("Select at least one test")
                    st.stop()

                if not confirm:
                    st.warning("Please confirm deletion")
                    st.stop()

                conn = get_connection()
                cursor = conn.cursor()

                cursor.execute("""
                    DELETE FROM test_steps
                    WHERE id = ANY(%s)
                """, (selected_tests,))

                cursor.execute("""
                    DELETE FROM test_coverage_mapping
                    WHERE test_id = ANY(%s)
                """, (selected_tests,))

                conn.commit()
                cursor.close()
                conn.close()

                st.success(f"Deleted {len(selected_tests)} tests!")
                st.rerun()