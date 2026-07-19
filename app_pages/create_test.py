# -*- coding: utf-8 -*-
import streamlit as st


def show_create_test_page(get_connection):

    st.title("?? Create Test Manually")

    # ? INPUT FIELDS
    module = st.text_input("Module")
    company_code = st.text_input("Company Code")
    e2e_process = st.text_input("E2E Process")
    scenario_id = st.text_input("Scenario")
    transaction_code = st.text_input("Transaction Code")
    process_step = st.text_area("Process Step")
    test_step_name = st.text_area("Test Step Name")

    # ? SAVE BUTTON
    if st.button("? Save Test"):

        try:
            conn = get_connection()
            cursor = conn.cursor()

            cursor.execute("""
                INSERT INTO test_steps (
                    company_code,
                    module,
                    e2e_process,
                    scenario_id,
                    transaction_code,
                    process_step,
                    test_step_name
                )
                VALUES (%s,%s,%s,%s,%s,%s,%s)
            """, (
                company_code,
                module,
                e2e_process,
                scenario_id,
                transaction_code,
                process_step,
                test_step_name
            ))

            conn.commit()
            cursor.close()
            conn.close()

            st.success("? Test created successfully!")

        except Exception as e:
            st.error(f"? Error: {e}")