# =====================================================
# ✅ REPORT (UNCHANGED)
# =====================================================
if menu == "📊 Report":

    if "report_url" not in st.session_state:
        st.session_state["report_url"] = None

    if st.button("Generate & View Report"):

        subprocess.run("allure generate allure-results -o allure-report --clean", shell=True)

        os.chdir("allure-report")
        subprocess.Popen("python -m http.server 8000", shell=True)
        os.chdir("..")

        st.session_state["report_url"] = "http://localhost:8000"

    if st.session_state["report_url"]:
        st.iframe(st.session_state["report_url"], width="stretch", height=1000)
