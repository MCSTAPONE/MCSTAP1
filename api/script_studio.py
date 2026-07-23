# -*- coding: utf-8 -*-

from fastapi import APIRouter
from fastapi import Request
from fastapi import Form

from api.database import get_connection
from api.shared import templates

from services.script_executor import ScriptExecutor

router = APIRouter()

@router.get("/script-studio")
def script_studio(request: Request):

    return templates.TemplateResponse(
        request=request,
        name="script_studio.html",
        context={}
    )
    
@router.get("/script-studio/login")
def script_login_template(request: Request):

    return templates.TemplateResponse(
        request=request,
        name="template_login.html",
        context={}
    )


@router.get("/script-studio/transaction")
def script_transaction_template(request: Request):

    return templates.TemplateResponse(
        request=request,
        name="template_transaction.html",
        context={}
    )


@router.get("/script-studio/logout")
def script_logout_template(request: Request):

    return templates.TemplateResponse(
        request=request,
        name="template_logout.html",
        context={}
    )
  
@router.get("/script-studio/builder")
def script_builder(request: Request):

    return templates.TemplateResponse(
        request=request,
        name="script_builder.html",
        context={}
    )

  
@router.get("/script-studio/start-recorder")
def start_recorder():

    try:

        client = SAPClient()

        session = client.attach_to_sap()

        login = SAPLogin(session)

        login.login()

        return {
            "status": "SUCCESS",
            "message": "SAP connected and logged in",
            "system": "S4Q"
        }

    except Exception as e:

        return {
            "status": "ERROR",
            "message": str(e)
        }
        
@router.get("/script-studio/library")
def script_library(request: Request):

    conn = get_connection()
    cur = conn.cursor()

    cur.execute(
        """
        SELECT
            script_id,
            script_name,
            module,
            COALESCE(transaction_code,''),
            status
        FROM script_master
        ORDER BY script_id
        """
    )

    scripts = cur.fetchall()

    print("====== SCRIPT DATA ======")

    for row in scripts:
        print(row)

    print("=========================")


    cur.close()
    conn.close()

    return templates.TemplateResponse(
        request=request,
        name="script_library.html",
        context={
            "scripts": scripts
        }
    )
@router.post("/script-studio/add-step/{script_id}")
def add_step(
    script_id: int,
    action_type: str = Form(...),
    parameter_name: str = Form(""),
    parameter_value: str = Form("")
):

    conn = get_connection()
    cur = conn.cursor()

    cur.execute(
        """
        SELECT
            COALESCE(MAX(step_sequence),0)+1
        FROM script_steps
        WHERE script_id = %s
        """,
        (str(script_id),)
    )

    next_seq = cur.fetchone()[0]

    cur.execute(
        """
        INSERT INTO script_steps
        (
            script_id,
            step_sequence,
            action_type,
            parameter_name,
            parameter_value
        )
        VALUES
        (%s,%s,%s,%s,%s)
        """,
        (
            str(script_id),
            next_seq,
            action_type,
            parameter_name,
            parameter_value
        )
    )

    conn.commit()

    cur.close()
    conn.close()

    return RedirectResponse(
        url=f"/script-studio/script/{script_id}",
        status_code=303
    )
    
@router.post("/script-studio/save")
def save_script(
    script_name: str = Form(...),
    module: str = Form(...),
    transaction_code: str = Form(...),
    description: str = Form(...)
):

    conn = get_connection()
    cur = conn.cursor()

    cur.execute(
        """
        INSERT INTO script_master
        (
            script_name,
            module,
            transaction_code,
            description,
            status,
            created_by
        )
        VALUES
        (%s,%s,%s,%s,%s,%s)
        RETURNING script_id
        """,
        (
            script_name,
            module,
            transaction_code,
            description,
            "Draft",
            "Biranchi"
        )
    )

    new_script_id = cur.fetchone()[0]

    cur.execute(
        """
        INSERT INTO script_steps
        (
            script_id,
            step_sequence,
            action_type,
            parameter_name,
            parameter_value
        )
        VALUES
        (%s,1,'LOGIN','','')
        """,
        (str(new_script_id),)
    )

    cur.execute(
        """
        INSERT INTO script_steps
        (
            script_id,
            step_sequence,
            action_type,
            parameter_name,
            parameter_value
        )
        VALUES
        (%s,2,'START_TRANSACTION','TCODE',%s)
        """,
        (
            str(new_script_id),
            transaction_code
        )
    )

    cur.execute(
        """
        INSERT INTO script_steps
        (
            script_id,
            step_sequence,
            action_type,
            parameter_name,
            parameter_value
        )
        VALUES
        (%s,3,'LOGOUT','','')
        """,
        (str(new_script_id),)
    )

    conn.commit()

    cur.close()
    conn.close()

    return RedirectResponse(
        url="/script-studio/library",
        status_code=303
    )
    
@router.get("/script-studio/script/{script_id}")
def open_script(
    request: Request,
    script_id: int
):

    conn = get_connection()
    cur = conn.cursor()

    cur.execute(
        """
        SELECT
            script_name
        FROM script_master
        WHERE script_id = %s
        """,
        (script_id,)
    )

    result = cur.fetchone()

    if result is None:

        cur.close()
        conn.close()

        return RedirectResponse(
            url="/script-studio/library",
            status_code=303
        )

    script_name = result[0]

    cur.execute(
        """
        SELECT
            step_sequence,
            action_type,
            parameter_name,
            parameter_value
        FROM script_steps
        WHERE script_id = %s
        ORDER BY step_sequence
        """,
        (str(script_id),)
    )

    steps = cur.fetchall()

    cur.close()
    conn.close()

    return templates.TemplateResponse(
        request=request,
        name="script_steps.html",
        context={
            "script_id": script_id,
            "script_name": script_name,
            "steps": steps
        }
    )
    
@router.get("/script-studio/edit-step/{script_id}/{step_sequence}")
def edit_step(
    request: Request,
    script_id: int,
    step_sequence: int
):

    conn = get_connection()
    cur = conn.cursor()

    cur.execute(
        """
        SELECT
            action_type,
            parameter_name,
            parameter_value
        FROM script_steps
        WHERE script_id = %s
        AND step_sequence = %s
        """,
        (
            str(script_id),
            step_sequence
        )
    )

    row = cur.fetchone()

    cur.close()
    conn.close()

    if row is None:

        return RedirectResponse(
            url=f"/script-studio/script/{script_id}",
            status_code=303
        )

    return templates.TemplateResponse(
        request=request,
        name="edit_step.html",
        context={
            "script_id": script_id,
            "step_sequence": step_sequence,
            "action_type": row[0],
            "parameter_name": row[1],
            "parameter_value": row[2]
        }
    )
@router.post("/script-studio/edit-step/{script_id}/{step_sequence}")
def save_step_edit(
    script_id: int,
    step_sequence: int,

    action_type: str = Form(...),
    parameter_name: str = Form(""),
    parameter_value: str = Form("")
):

    conn = get_connection()
    cur = conn.cursor()

    cur.execute(
        """
        UPDATE script_steps
        SET
            action_type = %s,
            parameter_name = %s,
            parameter_value = %s
        WHERE script_id = %s
        AND step_sequence = %s
        """,
        (
            action_type,
            parameter_name,
            parameter_value,
            str(script_id),
            step_sequence
        )
    )

    conn.commit()

    cur.close()
    conn.close()

    return RedirectResponse(
        url=f"/script-studio/script/{script_id}",
        status_code=303
    )

    
@router.get("/script-studio/delete-step/{script_id}/{step_sequence}")
def delete_step(
    script_id: int,
    step_sequence: int
):

    conn = get_connection()
    cur = conn.cursor()

    cur.execute(
        """
        DELETE FROM script_steps
        WHERE script_id = %s
        AND step_sequence = %s
        """,
        (
            str(script_id),
            step_sequence
        )
    )

    conn.commit()

    cur.close()
    conn.close()

    return RedirectResponse(
        url=f"/script-studio/script/{script_id}",
        status_code=303
    )

    
@router.get("/script-studio/run/{script_id}")
def run_script(
    request: Request,
    script_id: int
):

    executor = ScriptExecutor()

    logs = executor.execute_script(
        script_id
    )

    return templates.TemplateResponse(
        request=request,
        name="script_execution_result.html",
        context={
            "script_id": script_id,
            "logs": logs
        }
    )