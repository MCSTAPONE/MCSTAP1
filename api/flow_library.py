# -*- coding: utf-8 -*-

import os
from fastapi import APIRouter
from fastapi import Request
from fastapi import Form
from fastapi.responses import RedirectResponse

from api.database import get_connection
from api.shared import templates

router = APIRouter()

@router.get("/flow-library")
def flow_library(
    request: Request,
    module: str = ""
):

    conn = get_connection()

    cur = conn.cursor()

    if module:

        cur.execute(
            """
            SELECT
                flow_id,
                flow_name,
                description,
                module,
                status
            FROM flow_master
            WHERE module = %s
            ORDER BY flow_name
            """,
            (module,)
        )

    else:

        cur.execute(
            """
            SELECT
                flow_id,
                flow_name,
                description,
                module,
                status
            FROM flow_master
            ORDER BY flow_name
            """
        )

    flows = cur.fetchall()
    print("FLOWS =", flows)

    cur.close()
    conn.close()

    return templates.TemplateResponse(
        request=request,
        name="flow_library.html",
        context={
            "flows": flows,
            "selected_module": module
        }
    )
    
@router.get("/flow-library/new")
def new_flow_page(
    request: Request
):

    return templates.TemplateResponse(
        request=request,
        name="new_flow.html",
        context={}
    )
    
@router.post("/flow-library/new")
def create_flow(
    request: Request,
    flow_name: str = Form(...),
    description: str = Form(""),
    module: str = Form("")
):

    conn = get_connection()

    cur = conn.cursor()

    cur.execute(
        """
        INSERT INTO flow_master
        (
            flow_name,
            description,
            module
        )
        VALUES
        (
            %s,
            %s,
            %s
        )
        """,
        (
            flow_name,
            description,
            module
        )
    )

    conn.commit()

    cur.close()
    conn.close()

    return RedirectResponse(
        url="/flow-library",
        status_code=303
    )
    
@router.get("/flow-library/{flow_id}")
def open_flow(
    request: Request,
    flow_id: int
):

    conn = get_connection()

    cur = conn.cursor()

    cur.execute(
        """
        SELECT
            flow_id,
            flow_name,
            description,
            module,
            status
        FROM flow_master
        WHERE flow_id = %s
        """,
        (flow_id,)
    )

    flow = cur.fetchone()
    
    cur.execute(
        """
        SELECT
            step_id,
            sequence_no,
            transaction_code,
            description
        FROM flow_steps
        WHERE flow_id = %s
        ORDER BY sequence_no
        """,
        (flow_id,)
    )

    steps = cur.fetchall()

    cur.close()
    conn.close()

    return templates.TemplateResponse(
        request=request,
        name="flow_details.html",
        context={
            "flow": flow,
            "steps": steps
        }
    )
    
@router.get("/flow-library/edit/{flow_id}")
def edit_flow_page(
    request: Request,
    flow_id: int
):

    conn = get_connection()

    cur = conn.cursor()

    cur.execute(
        """
        SELECT
            flow_id,
            flow_name,
            description,
            module,
            status
        FROM flow_master
        WHERE flow_id = %s
        """,
        (flow_id,)
    )

    flow = cur.fetchone()

    cur.close()
    conn.close()

    return templates.TemplateResponse(
        request=request,
        name="edit_flow.html",
        context={
            "flow": flow
        }
    )
    
@router.post("/flow-library/edit/{flow_id}")
def edit_flow(
    request: Request,
    flow_id: int,
    flow_name: str = Form(...),
    description: str = Form(""),
    module: str = Form("")
):

    conn = get_connection()

    cur = conn.cursor()

    cur.execute(
        """
        UPDATE flow_master
        SET
            flow_name = %s,
            description = %s,
            module = %s
        WHERE flow_id = %s
        """,
        (
            flow_name,
            description,
            module,
            flow_id
        )
    )

    conn.commit()

    cur.close()
    conn.close()

    return RedirectResponse(
        url="/flow-library",
        status_code=303
    )
    
@router.get("/flow-library/delete/{flow_id}")
def delete_flow(
    flow_id: int
):

    conn = get_connection()

    cur = conn.cursor()

    cur.execute(
        """
        DELETE
        FROM flow_master
        WHERE flow_id = %s
        """,
        (flow_id,)
    )

    conn.commit()

    cur.close()
    conn.close()

    return RedirectResponse(
        url="/flow-library",
        status_code=303
    )
    
@router.get("/flow-library/{flow_id}/add-step")
def add_step_page(
    request: Request,
    flow_id: int
):

    conn = get_connection()

    cur = conn.cursor()

    cur.execute(
        """
        SELECT
            asset_id,
            asset_name
        FROM repository_assets
        WHERE status = 'Active'
        ORDER BY asset_name
        """
    )

    assets = cur.fetchall()

    cur.close()
    conn.close()

    return templates.TemplateResponse(
        request=request,
        name="add_step.html",
        context={
            "flow_id": flow_id,
            "assets": assets
        }
    )
    
@router.post("/flow-library/{flow_id}/add-step")
def save_step(
    flow_id: int,
    sequence_no: int = Form(...),
    transaction_code: str = Form(...),
    description: str = Form("")
):

    conn = get_connection()

    cur = conn.cursor()

    cur.execute(
        """
        INSERT INTO flow_steps
        (
            flow_id,
            sequence_no,
            transaction_code,
            description
        )
        VALUES
        (
            %s,
            %s,
            %s,
            %s
        )
        """,
        (
            flow_id,
            sequence_no,
            transaction_code,
            description
        )
    )

    conn.commit()

    cur.close()
    conn.close()

    return RedirectResponse(
        url=f"/flow-library/{flow_id}",
        status_code=303
    )

@router.get("/flow-step/edit/{step_id}")
def edit_step_page(
    request: Request,
    step_id: int
):

    conn = get_connection()

    cur = conn.cursor()

    cur.execute(
        """
        SELECT
            step_id,
            flow_id,
            sequence_no,
            transaction_code,
            description
        FROM flow_steps
        WHERE step_id = %s
        """,
        (step_id,)
    )

    step = cur.fetchone()

    cur.close()
    conn.close()

    return templates.TemplateResponse(
        request=request,
        name="edit_flow_step.html",
        context={
            "step": step
        }
    )
    
@router.post("/flow-step/edit/{step_id}")
def edit_step(
    step_id: int,
    sequence_no: int = Form(...),
    transaction_code: str = Form(...),
    description: str = Form("")
):

    conn = get_connection()

    cur = conn.cursor()

    cur.execute(
        """
        UPDATE flow_steps
        SET
            sequence_no = %s,
            transaction_code = %s,
            description = %s
        WHERE step_id = %s
        """,
        (
            sequence_no,
            transaction_code,
            description,
            step_id
        )
    )

    conn.commit()

    cur.execute(
        """
        SELECT flow_id
        FROM flow_steps
        WHERE step_id = %s
        """,
        (step_id,)
    )

    flow = cur.fetchone()
    flow_id = flow[0]

    cur.close()
    conn.close()

    return RedirectResponse(
        url=f"/flow-library/{flow[0]}",
        status_code=303
    )
    
@router.get("/flow-step/delete/{step_id}")
def delete_step(
    step_id: int
):

    conn = get_connection()

    cur = conn.cursor()

    cur.execute(
        """
        SELECT flow_id
        FROM flow_steps
        WHERE step_id = %s
        """,
        (step_id,)
    )

    flow = cur.fetchone()

    flow_id = flow[0]

    cur.execute(
        """
        DELETE
        FROM flow_steps
        WHERE step_id = %s
        """,
        (step_id,)
    )

    conn.commit()

    cur.close()
    conn.close()

    return RedirectResponse(
        url=f"/flow-library/{flow_id}",
        status_code=303
    )
    
@router.get("/flow-library/{flow_id}/execute")
def execute_flow(
    request: Request,
    flow_id: int
):

    conn = get_connection()

    cur = conn.cursor()

    cur.execute(
        """
        SELECT
            flow_id,
            flow_name
        FROM flow_master
        WHERE flow_id = %s
        """,
        (flow_id,)
    )

    flow = cur.fetchone()

    cur.execute(
        """
        SELECT
            fs.sequence_no,
            fs.transaction_code,
            ra.script_name
        FROM flow_steps fs
        LEFT JOIN repository_assets ra
            ON fs.transaction_code = ra.transaction_code
        WHERE fs.flow_id = %s
        ORDER BY fs.sequence_no
        """,
        (flow_id,)
    )

    steps = cur.fetchall()

    logs = []

    base_path = r"C:\Users\bndas\SAP_Test\Test_Business\tests\CO"

    for step in steps:

        script_name = step[2]

        if not script_name:

            logs.append(
                f"Step {step[0]} | {step[1]} | NO SCRIPT FOUND"
            )

            continue

        script_file = os.path.join(
            base_path,
            script_name
        )

        if os.path.exists(script_file):

            import subprocess

            result = subprocess.run(
                ["python", script_file],
                capture_output=True,
                text=True
            )

            status = (
                result.stdout.strip()
                if result.stdout.strip()
                else "EXECUTED"
            )

        else:

            status = "NOT FOUND"

        logs.append(
            f"Step {step[0]} | {step[1]} | {script_name} | {status}"
        )

    cur.close()
    conn.close()

    return templates.TemplateResponse(
        request=request,
        name="flow_execution.html",
        context={
            "flow": flow,
            "logs": logs
        }
    )