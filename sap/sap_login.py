# -*- coding: utf-8 -*-

import os
import time

from dotenv import load_dotenv


load_dotenv()


class SAPLogin:

    def __init__(
        self,
        session,
        system_data=None
    ):

        self.session = session

        self.system_data = (
            system_data
            if system_data
            else {}
        )

    def login(self):

        session = self.session

        print(
            "Starting login..."
        )

        try:

            title = session.findById(
                "wnd[0]"
            ).Text

            print(
                "Current screen:",
                title
            )

        except Exception as error:

            raise RuntimeError(
                "SAP session is not ready."
            ) from error

        already_logged_in_titles = [
            "SAP Easy Access",
            "Easy Access",
            "User Menu"
        ]

        if any(
            title_text in title
            for title_text
            in already_logged_in_titles
        ):

            print(
                "Already logged in"
            )

            return True

        try:

            session.findById(
                "wnd[0]/usr/txtRSYST-BNAME"
            )

        except Exception:

            print(
                "Login screen not available. "
                "Skipping login."
            )

            return True

        user = os.getenv(
            "SAP_USER"
        )

        password = os.getenv(
            "SAP_PASS"
        )

        client = (
            self.system_data.get(
                "client"
            )
            or os.getenv(
                "SAP_CLIENT"
            )
        )

        language = (
            self.system_data.get(
                "language"
            )
            or os.getenv(
                "SAP_LANG"
            )
            or "EN"
        )

        if not user or not password:

            raise ValueError(
                "SAP credentials are missing. "
                "SAP_USER and SAP_PASS must be "
                "configured in the environment."
            )

        print(
            "Filling credentials..."
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
            f"   Client: "
            f"{client or 'SAP_DEFAULT'}"
        )

        print(
            f"   Language: "
            f"{language}"
        )

        if client:

            try:

                session.findById(
                    "wnd[0]/usr/txtRSYST-MANDT"
                ).text = str(client)

            except Exception as error:

                raise RuntimeError(
                    "SAP client field could not "
                    "be populated."
                ) from error

        session.findById(
            "wnd[0]/usr/txtRSYST-BNAME"
        ).text = user

        session.findById(
            "wnd[0]/usr/pwdRSYST-BCODE"
        ).text = password

        session.findById(
            "wnd[0]/usr/txtRSYST-LANGU"
        ).text = str(language)

        session.findById(
            "wnd[0]"
        ).sendVKey(0)

        time.sleep(3)

        try:

            status_bar = session.findById(
                "wnd[0]/sbar"
            )

            if status_bar.messageType == "E":

                raise RuntimeError(
                    f"SAP login failed: "
                    f"{status_bar.text}"
                )

        except RuntimeError:
            raise

        except Exception:
            pass

        print(
            "Login done"
        )

        return True