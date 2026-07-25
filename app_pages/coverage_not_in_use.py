# -*- coding: utf-8 -*-

import streamlit as st
import subprocess
import os
import random


from services.sap_runner import run_transaction

from services.coverage_service import (
    create_coverage_structure,
    assign_tests_to_coverage,
    get_coverage_with_tests,
    delete_coverage,
    get_test_steps,
    update_step_status
)

# ? SAFE KEY
def safe_key(text):
    return str(text).replace("/", "_").replace("&", "and").replace(" ", "_")


def show_coverage_page():

    st.title("SAP Automation Platform")
    st.header("Test Coverage Engine")

    # ===============================
    # ? CREATE COVERAGE
    # ===============================
    st.subheader("Create Business Process Coverage")

    module_options = {
        "Sales Distribution (SD)": "Sales Distribution/SD",
        "Materials Management (MM)": "Materials Management/MM",
        "Financial Accounting (FI)": "Financial & Accounting/FI",
        "Controlling (CO)": "Controlling/CO",
        "Logistics (LO)": "Logistics/LO",
        "Treasury (TR)": "Treasury/TR",
        "Plant Maintenance (PM)": "Plant Maintenance/PM",
        "Production Planning (PP)": "Production Planning/PP",
        "Product Lifecycle Management (PLM)": "PLM",
        "Quality Management (QM)": "Quality Management/QM",
        "Warehouse Management (WM)": "Warehouse Management/WM",
        "Supply Chain Management (SCM)": "SCM"
        "Procurment (PROC)": "PROC"
    }

    selected_module = st.selectbox("Select Module", list(module_options.keys()))
    module = module_options[selected_module]

    process = st.text_input("Business Process")
    
    test_type = st.selectbox(
        "Select Test Type",
        ["E2E", "Functional", "Standalone"]
    )

    create_clicked = st.button("Create Coverage")

    if create_clicked:

        if not process:
            st.error("Process is required")
            st.stop()

        # ? Only runs when explicitly clicked
        create_coverage_structure(module, process, test_type)
        assign_tests_to_coverage(module, process, test_type)

        st.success(f"Coverage created for {module} -> {process} [{test_type}]")

        st.session_state["coverage_created"] = True
        
    if "coverage_created" not in st.session_state:
        st.session_state["coverage_created"] = False


    # ===============================
    # ? SHOW COVERAGE
    # ===============================
    st.divider()
    st.subheader("Existing Coverage")

    data = get_coverage_with_tests()

    if not data:
        st.info("No coverage yet")
        return

    # ===============================
    # ? GROUP DATA
    # ===============================
    grouped_data = {}

    for module, process, test_type, test_id in data:

        key = (module, process)

        if key not in grouped_data:
            grouped_data[key] = {"types": {}}

        if test_type not in grouped_data[key]["types"]:
            grouped_data[key]["types"][test_type] = []

        grouped_data[key]["types"][test_type].append(test_id)

    # remove duplicates
    for key in grouped_data:
        for t in grouped_data[key]["types"]:
            grouped_data[key]["types"][t] = list(set(grouped_data[key]["types"][t]))

    # ===============================
    # ? RENDER
    # ===============================
    for (module, process), content in grouped_data.items():

        col1, col2 = st.columns([5, 1])

        with col1:
            st.markdown(f"## {module} -> {process}")

        with col2:
            if st.button("DELETE", key=safe_key(f"del_{module}_{process}")):
                delete_coverage(module, process)
                st.rerun()

        # ===============================
        # ? TEST TYPES
        # ===============================
        for test_type, test_ids in content["types"].items():

            st.markdown(f"### {test_type}")

            # ? STEP-LEVEL EXECUTION
            if st.button(f"Run {test_type}", key=safe_key(f"run_{module}_{process}_{test_type}")):

                for test_id in test_ids:

                    st.markdown(f"### Executing Test ID: {test_id}")

                    # ? ALWAYS define steps FIRST
                    steps = get_test_steps(test_id)

                    # ? HANDLE EMPTY CASE
                    if not steps:
                        st.warning("No steps defined for this test")
                        continue

                    test_failed = False

                    for step in steps:

                        step_number, desc, expected, _, transaction_code = step

                        # ? CALL RUNNER
                        status = run_transaction(transaction_code, desc)

                        # ? SAVE RESULT
                        update_step_status(test_id, step_number, status)

                        col1, col2 = st.columns([4, 2])

                        with col1:
                            st.write(f"[{transaction_code}] Step {step_number}: {desc}")

                        with col2:
                            if status == "PASSED":
                                st.success("PASSED")
                            else:
                                st.error("FAILED")
                                test_failed = True

                        if status == "FAILED":
                            st.warning("Execution stopped due to failure")
                            break

                    # ? FINAL RESULT
                    if test_failed:
                        st.error(f"Test {test_id} FAILED")
                    else:
                        st.success(f"Test {test_id} PASSED")

            # ===============================
            # ? DETAIL VIEW
            # ===============================
            for test_id in test_ids:

                if st.button(f"Test ID: {test_id}", key=safe_key(f"detail_{module}_{process}_{test_type}_{test_id}")):

                    steps = get_test_steps(test_id)

                    if steps:
                        for step in steps:

                            step_number, desc, expected, status, transaction_code = step

                            c1, c2 = st.columns([4, 2])

                            with c1:
                                st.write(f"[{transaction_code}] Step {step_number}: {desc}")

                            with c2:
                                if status == "PASSED":
                                    st.success("PASSED")
                                elif status == "FAILED":
                                    st.error("FAILED")
                                else:
                                    st.info("NOT EXECUTED")

                            st.write(f"Expected: {expected}")
                            st.divider()
                    else:
                        st.warning("No steps defined")