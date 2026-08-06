# -*- coding: utf-8 -*-

from fastapi import APIRouter
from fastapi import Request
from fastapi import Form

from api.database import get_connection
from api.shared import templates
from fastapi.responses import RedirectResponse


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
            asset_id,
            asset_name,
            transaction_code,
            status,
            script_name
        FROM repository_assets
        WHERE module = %s
        ORDER BY asset_id ASC
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
    
@router.post("/repository/delete")
def delete_repository_assets(
    request: Request,
    asset_ids: list[str] = Form(...)
):

    conn = get_connection()
    cur = conn.cursor()

    for asset_id in asset_ids:

        cur.execute(
            """
            DELETE FROM repository_assets
            WHERE asset_id = %s
            """,
            (asset_id,)
        )

    conn.commit()

    cur.close()
    conn.close()

    return {
        "status": "success"
    }
    
    
@router.get("/repository/add/{module}")
def add_asset_page(
    request: Request,
    module: str
):

    return templates.TemplateResponse(
        request=request,
        name="repository_add.html",
        context={
            "module": module
        }
    )
    
@router.post("/repository/add/{module}")
def save_asset(
    request: Request,
    module: str,
    asset_name: str = Form(...),
    transaction_code: str = Form(...),
    script_name: str = Form(...),
    description: str = Form("")
):

    conn = get_connection()
    cur = conn.cursor()

    cur.execute(
        """
        INSERT INTO repository_assets
        (
            asset_name,
            module,
            transaction_code,
            script_name,
            description,
            status
        )
        VALUES
        (%s,%s,%s,%s,%s,%s)
        """,
        (
            asset_name,
            module,
            transaction_code,
            script_name,
            description,
            "Draft"
        )
    )

    conn.commit()

    cur.close()
    conn.close()

    return RedirectResponse(
        url=f"/repository/{module}",
        status_code=303
    )
    
