# -*- coding: utf-8 -*-

import streamlit as st
import pandas as pd
import os


def show_upload_page(get_connection, clean_data):

    st.title("Upload Test Excel")

    # ===============================
    # ✅ FOLDER INIT
    # ===============================
    UPLOAD_FOLDER = "uploaded_files"
    os.makedirs(UPLOAD_FOLDER, exist_ok=True)

    # ===============================
    # ✅ FILE UPLOAD
    # ===============================
    uploaded_file = st.file_uploader("Upload Excel file", type=["xlsx", "csv"])

    # ===============================
    # ✅ ONLY RUN IF FILE EXISTS
    # ===============================
    if uploaded_file is not None:

        try:
            # ✅ SAVE FILE TO DISK
            file_path = os.path.join(UPLOAD_FOLDER, uploaded_file.name)

            with open(file_path, "wb") as f:
                f.write(uploaded_file.getbuffer())

            # ✅ CHANGE MESSAGE (IMPORTANT)
            st.info(f"📁 File uploaded: {uploaded_file.name}")

            # ===============================
            # ✅ READ FILE
            # ===============================
            if uploaded_file.name.endswith(".csv"):
                df = pd.read_csv(uploaded_file)
            else:
                df = pd.read_excel(uploaded_file)

            # ✅ CLEAN DATA
            df = clean_data(df)

            # ===============================
            # ✅ MODULE SELECTION (RIGHT PLACE ✅)
            # ===============================
            module = st.selectbox(
                "Select Module",
                [
                    "Sales Distribution/SD",
                    "Materials Management/MM",
                    "Financial & Accounting/FI",
                    "Controlling/CO",
                    "Warehouse Management/WM",
                    "Logistics/LO",
                    "Treasury/TR",
                    "Plant Maintenance/PM",
                    "Production Planning/PP",
                    "PLM",
                    "Quality Management/QM",
                    "Warehouse Management/WM",
                    "SCM"
                ]
            )

            # ===============================
            # ✅ PROCESS TO DB
            # ===============================
            if st.button("Process & Save to DB"):

                conn = get_connection()
                cursor = conn.cursor()

                inserted = 0

                for idx, row in df.iterrows():

                    try:
                        step_number = idx + 1

                        #CORRECT COLUMN MAPPING (LOWERCASE FIX)
                        transaction_code = str(row.get("transakcija/transaction", "")).strip()
                        company_code = str(row.get("šifra poduzeća/company code", "")).strip()
                        e2e_process = str(row.get("e2e proces/e2e process", "")).strip()
                        scenario = str(row.get("scenarij / scenario", "")).strip()
                        process_step = str(row.get("procesni korak/process step", "")).strip()
                        test_step_name = str(row.get("naziv testnog koraka/test step name", "")).strip()

                        cursor.execute("""
                            INSERT INTO test_steps (
                                module,
                                scenario_id,
                                transaction_code,
                                company_code,
                                e2e_process,
                                process_step,
                                test_step_name,
                                step_description,
                                expected_result,
                                step_number
                            )
                            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                        """, (
                            module,
                            scenario,
                            transaction_code,
                            company_code,
                            e2e_process,
                            process_step,
                            test_step_name,
                            test_step_name,
                            process_step,
                            step_number
                        ))

                        inserted += 1

                    except Exception as e:
                        st.error(f"Row {idx} error: {e}")

                conn.commit()
                cursor.close()
                conn.close()

                st.success(f"✅ {inserted} rows saved to DB")

            # ===============================
            # ✅ SHOW PREVIEW (AFTER MODULE ✅)
            # ===============================
            st.subheader("📄 Preview Uploaded File")
            st.write(f"Rows: {len(df)}")
            st.dataframe(df)

        except Exception as e:
            st.error(f"Error processing file: {e}")

    # ===============================
    # ✅ FILE LIST + VIEW + DELETE
    # ===============================
    st.divider()
    st.subheader("📁 Uploaded Files")

    files = os.listdir(UPLOAD_FOLDER)

    if not files:
        st.info("No files uploaded yet")
    else:
        for file in files:

            col1, col2 = st.columns([17, 2])

            with col1:
                st.write(file)

            with col2:
                btn1, btn2 = st.columns([1, 1])

                with btn1:
                    view_clicked = st.button("View", key=f"view_{file}")

                with btn2:
                    delete_clicked = st.button("DELETE", key=f"delete_{file}")

            # ✅ DELETE FILE + DB
            if delete_clicked:
                try:
                    file_path = os.path.join(UPLOAD_FOLDER, file)

                    if os.path.exists(file_path):
                        os.remove(file_path)

                    conn = get_connection()
                    cursor = conn.cursor()

                    cursor.execute("DELETE FROM test_steps")

                    conn.commit()
                    cursor.close()
                    conn.close()

                    st.success(f"Deleted: {file} + DB data ✅")
                    st.rerun()

                except Exception as e:
                    st.error(f"Delete error: {e}")

            # ✅ VIEW FILE
            if view_clicked:
                try:
                    file_path = os.path.join(UPLOAD_FOLDER, file)

                    if file.endswith(".csv"):
                        df_view = pd.read_csv(file_path)
                    else:
                        df_view = pd.read_excel(file_path)

                    st.subheader(f"📄 {file}")
                    st.dataframe(df_view)

                except Exception as e:
                    st.error(f"View error: {e}")