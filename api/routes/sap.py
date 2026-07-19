from fastapi import APIRouter

from services.sap_connection import get_sap_session

router = APIRouter()


@router.get("/sap/status")
def sap_status():

    return {
        "sap_framework": "available",
        "module": "Plant Maintenance"
    }



@router.post("/sap/login")
def sap_login():

    print("API Login Request Received")

    session = get_sap_session()

    if session:

        print("SAP Session Connected")

        return {
            "status": "SUCCESS",
            "message": "SAP Connected"
        }

    return {
        "status": "FAILED",
        "message": "SAP Session Not Available"
    }
@router.get("/sap/test-com")
def test_com():

    import win32com.client

    try:

        sap = win32com.client.GetObject("SAPGUI")

        return {
            "status": "OK"
        }

    except Exception as e:

        return {
            "status": "FAILED",
            "error": str(e)
        }