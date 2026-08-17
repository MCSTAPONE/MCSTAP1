class SAPLogoutService:

    def logout(self, session):

        try:
            session.findById(
                "wnd[0]/tbar[0]/okcd"
            ).text = "/nex"

            session.findById(
                "wnd[0]"
            ).sendVKey(0)

            print("✅ SAP session closed")

        except Exception as e:
            print(f"Logout failed: {e}")