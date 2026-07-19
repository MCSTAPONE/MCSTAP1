# -*- coding: utf-8 -*-
from sap.sap_client import SAPClient
from sap.sap_login import SAPLogin


def get_sap_session():

    try:
        # Step 1 - Attach to SAP
        client = SAPClient()
        session = client.attach_to_sap()

        if not session:
            print("Failed to attach to SAP")
            return None

        # Step 2 - Login automatically
        login = SAPLogin(session)
        login.login()

        return session

    except Exception as e:
        print("SAP connection error:", e)
        return None