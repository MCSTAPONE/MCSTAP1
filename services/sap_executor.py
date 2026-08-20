# -*- coding: utf-8 -*-

from sap.sap_client import SAPClient
from sap.sap_login import SAPLogin

from services.sap_flows import (
    run_iw31_create_order,
    run_iw32_change_order,
    run_iw33_display_order,
    run_iw41_confirm_order,
    run_me51n_create_pr
)


class SAPExecutor:

    def __init__(
        self,
        system_data=None
    ):

        self.session = None

        self.system_data = (
            system_data
            if system_data
            else {}
        )

    def connect(self):

        if not isinstance(
            self.system_data,
            dict
        ):

            raise TypeError(
                "system_data must be a dictionary."
            )

        sap_logon_entry = (
            self.system_data.get(
                "sap_logon_entry"
            )
        )

        if self.system_data and not sap_logon_entry:

            raise ValueError(
                "SDC system data does not contain "
                "sap_logon_entry."
            )

        client = SAPClient(
            system_data=self.system_data
        )

        self.session = (
            client.attach_to_sap()
        )

        return self.session

    def login(self):

        if self.session is None:

            raise RuntimeError(
                "No SAP session is available."
            )

        login = SAPLogin(
            session=self.session,
            system_data=self.system_data
        )

        return login.login()

    def start_transaction(
        self,
        transaction_code
    ):

        if self.session is None:

            raise RuntimeError(
                "No SAP session is available."
            )

        self.session.findById(
            "wnd[0]/tbar[0]/okcd"
        ).text = (
            f"/n{transaction_code}"
        )

        self.session.findById(
            "wnd[0]"
        ).sendVKey(0)

        return True

    def execute_flow(
        self,
        flow_name
    ):

        if self.session is None:

            raise RuntimeError(
                "No SAP session is available."
            )

        flow_name = flow_name.upper()

        print(
            f"EXECUTE_FLOW CALLED: "
            f"{flow_name}"
        )

        if flow_name == "IW31":

            result = (
                run_iw31_create_order(
                    self.session
                )
            )

            print(
                f"IW31 RESULT = {result}"
            )

            return result

        if flow_name == "IW32":

            result = (
                run_iw32_change_order(
                    self.session
                )
            )

            print(
                f"IW32 RESULT = {result}"
            )

            return result

        if flow_name == "IW33":

            result = (
                run_iw33_display_order(
                    self.session
                )
            )

            print(
                f"IW33 RESULT = {result}"
            )

            return result

        if flow_name == "IW41":

            result = (
                run_iw41_confirm_order(
                    self.session
                )
            )

            print(
                f"IW41 RESULT = {result}"
            )

            return result

        if flow_name == "ME51N":

            result = (
                run_me51n_create_pr(
                    self.session
                )
            )

            print(
                f"ME51N RESULT = {result}"
            )

            return result

        raise ValueError(
            f"Unknown flow: {flow_name}"
        )

    def logout(self):

        if self.session is None:

            return False

        try:

            self.session.findById(
                "wnd[0]/tbar[0]/okcd"
            ).text = "/nex"

            self.session.findById(
                "wnd[0]"
            ).sendVKey(0)

            return True

        except Exception:

            try:

                self.session.findById(
                    "wnd[0]"
                ).close()

                try:

                    self.session.findById(
                        "wnd[1]/usr/"
                        "btnSPOP-OPTION1"
                    ).press()

                except Exception:
                    pass

                return True

            except Exception as error:

                print(
                    f"SAP logout warning: "
                    f"{error}"
                )

                return False
