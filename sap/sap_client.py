# -*- coding: utf-8 -*-

import subprocess
import time

import pyautogui
import pythoncom
import win32com.client


class SAPClient:

    def __init__(
        self,
        system_data=None
    ):

        self.system_data = (
            system_data
            if system_data
            else {}
        )

    def attach_to_sap(
        self,
        timeout=60
    ):

        pythoncom.CoInitialize()

        sap_logon_entry = (
            self.system_data.get(
                "sap_logon_entry"
            )
            or "S4Q"
        )

        print(
            "👉 Starting SAP Logon..."
        )

        print(
            "👉 SDC system selection:"
        )

        print(
            f"   SDC: "
            f"{self.system_data.get('sdc_name', 'DEFAULT')}"
        )

        print(
            f"   Environment: "
            f"{self.system_data.get('environment', 'DEFAULT')}"
        )

        print(
            f"   SAP Logon Entry: "
            f"{sap_logon_entry}"
        )

        subprocess.Popen(
            [
                (
                    r"C:\Program Files\SAP"
                    r"\FrontEnd\SAPgui"
                    r"\saplogon.exe"
                )
            ]
        )

        time.sleep(6)

        print(
            "👉 Selecting system by SDC "
            "SAP Logon entry..."
        )

        pyautogui.write(
            sap_logon_entry,
            interval=0.05
        )

        time.sleep(1)

        pyautogui.press(
            "enter"
        )

        print(
            "✅ System launch triggered"
        )

        start = time.time()

        application = None

        while True:

            try:

                print(
                    "⏳ Waiting for SAP GUI "
                    "Scripting..."
                )

                sap_gui = (
                    win32com.client.GetObject(
                        "SAPGUI"
                    )
                )

                application = (
                    sap_gui.GetScriptingEngine
                )

                connection_count = (
                    application.Children.Count
                )

                print(
                    f"✅ Connections found: "
                    f"{connection_count}"
                )

                if connection_count > 0:
                    break

            except Exception as error:

                print(
                    f"SAP GUI wait warning: "
                    f"{error}"
                )

            if time.time() - start > timeout:

                raise TimeoutError(
                    "SAP GUI scripting was not "
                    "ready within the configured "
                    "timeout."
                )

            time.sleep(1)

        connection = application.Children(
            application.Children.Count - 1
        )

        print(
            "✅ Connection found"
        )

        while connection.Children.Count == 0:

            print(
                "⏳ Waiting for SAP session..."
            )

            if time.time() - start > timeout:

                raise TimeoutError(
                    "No SAP session was created "
                    "within the configured timeout."
                )

            time.sleep(1)

        session = connection.Children(0)

        print(
            "✅ Session ready"
        )

        return session