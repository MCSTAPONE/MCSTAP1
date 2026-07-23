# -*- coding: utf-8 -*-

from fastapi import APIRouter
from fastapi import Request
from fastapi import Form

from api.database import get_connection
from api.shared import templates

router = APIRouter()

@router.get("/repository")
def repository(request: Request):

    modules = [
        "PM",
        "MM",
        "FI",
        "CO",
        "SD",
        "WM",
        "QM",
        "PP",
        "LO",
        "TR",
        "SCM",
        "PLM",
        "PROC",
	  "E2E"
    ]

    return templates.TemplateResponse(
        request=request,
        name="repository.html",
        context={
            "modules": modules
        }
    )
    
@router.get("/repository/{module}")
def repository_module(
    request: Request,
    module: str
):

    conn = get_connection()

    cur = conn.cursor()

    cur.execute(
        """
        SELECT
            test_case_id,
            title,
            transaction_code,
            automation_status,
            script_path
        FROM test_cases
        WHERE module = %s
        ORDER BY id ASC
        """,
        (module,)
    )

    rows = cur.fetchall()

    cur.close()
    conn.close()

    return templates.TemplateResponse(
        request=request,
        name="repository_module.html",
        context={
            "module": module,
            "rows": rows
        }
    )