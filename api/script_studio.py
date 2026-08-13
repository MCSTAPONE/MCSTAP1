# -*- coding: utf-8 -*-

from fastapi import APIRouter
from fastapi import Request
from fastapi import Form
from fastapi import Body
from pathlib import Path

from fastapi import UploadFile
from fastapi import File
from fastapi.responses import JSONResponse
from fastapi.responses import (HTMLResponse, RedirectResponse)
import re
import time
import json

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

    conn = get_connection()
    cur = conn.cursor()

    cur.execute(
        """
        SELECT
            flow_id,
            flow_name
        FROM flow_master
        ORDER BY flow_name
        """
    )

    flows = cur.fetchall()

    cur.close()
    conn.close()

    return templates.TemplateResponse(
        request=request,
        name="script_builder.html",
        context={
            "flows": flows
        }
    )
    
@router.get("/script-studio/flow-steps/{flow_id}")
def get_flow_steps(flow_id: int):

    conn = get_connection()
    cur = conn.cursor()

    cur.execute(
        """
        SELECT
            sequence_no,
            transaction_code,
            COALESCE(description,'')
        FROM flow_steps
        WHERE flow_id = %s
        ORDER BY sequence_no
        """,
        (flow_id,)
    )

    rows = cur.fetchall()

    cur.close()
    conn.close()

    steps = []

    for row in rows:

        steps.append(
            {
                "sequence_no": row[0],
                "transaction_code": row[1],
                "description": row[2]
            }
        )

    return steps

@router.post("/script-studio/analyze")
async def analyze_recording(
    recording_file: UploadFile = File(...)
):

    try:

        content = await recording_file.read()

        try:

            text = content.decode("utf-16")

        except UnicodeError:

            text = content.decode(
                "utf-8",
                errors="ignore"
            )

        actions = []

        fields = []

        errors = []

        transaction = ""

        seq = 1

        for line in text.splitlines():
            print(line)
            try:

                line = str(line).strip()

                # --------------------------
                # TRANSACTION DETECTION
                # --------------------------

                if (
                    "/okcd" in line
                    and ".text =" in line
                ):

                    value_match = re.search(
                        r'=\s*"([^"]*)"',
                        line
                    )

                    if value_match:

                        transaction = (
                            value_match.group(1)
                            .replace("/n", "")
                            .upper()
                        )

                # --------------------------
                # SET_TEXT
                # --------------------------

                if ".text" in line:

                    print("TEXT FOUND =", line)

                    field_match = re.search(
                        r'([A-Z0-9_]+-[A-Z0-9_]+)',
                        line
                    )
                    
                    locator_match = re.search(
                    r'findById\("([^"]+)"\)',
                    line
                )

                    value_match = re.search(
                        r'=\s*"([^"]*)"',
                        line
                    )

                    field_name = ""

                    sample_value = ""

                    locator = ""
                    
                    

                    if field_match:
                        field_name = field_match.group(1)

                    if value_match:
                        sample_value = value_match.group(1)
                        
                    if locator_match:
                        locator = locator_match.group(1)    

                    actions.append(
                        {
                            "seq": seq,
                            "action": "SET_TEXT",
                            "field": field_name,
                            "locator": locator,
                            "sample_value": sample_value
                        }
                    )

                    if field_name:

                        fields.append(
                            {
                                "field": field_name,
                                "locator": locator,
                                "sample_value": sample_value
                            }
                        )

                    seq += 1

                # --------------------------
                # SEND_VKEY
                # --------------------------

                elif "sendVKey" in line:

                    print("VKEY FOUND =", line)

                    key_match = re.search(
                        r'sendVKey\s+(\d+)',
                        line
                    )

                    vkey = "0"

                    if key_match:
                        vkey = key_match.group(1)

                    actions.append(
                        {
                            "seq": seq,
                            "action": "SEND_VKEY",
                            "field": "ENTER_KEY",
				    "locator": "wnd[0]",
                            "sample_value": vkey
                        }
                    )

                    seq += 1

                # --------------------------
                # PRESS
                # --------------------------

                elif ".press" in line:

                    print("PRESS FOUND =", line)

                    actions.append(
                        {
                            "seq": seq,
                            "action": "PRESS",
                            "field": "",
                            "sample_value": ""
                        }
                    )

                    seq += 1

            except Exception as ex:

                errors.append(str(ex))
        print("================================")
        print("TRANSACTION =", transaction)
        print("ACTION COUNT =", len(actions))
        print("FIELDS =", len(fields))
        print("================================")
        

        return JSONResponse(
            {
                "success": True,
                "transaction": transaction,
                "action_count": len(actions),
                "field_count": len(fields),
                "errors": errors,
                "fields": fields,
                "actions": actions
            }
        )

    except Exception as e:

        print("================================")
        print("ANALYZE ERROR")
        print(str(e))
        print("================================")

        return JSONResponse(
            {
                "success": False,
                "message": str(e)
            }
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
    description: str = Form(...),
    generated_script: str = Form(""),
    analysis_results: str = Form("")
):

    print("========== SAVE ==========")
    print("script_name =", script_name)
    print("module =", module)
    print("transaction_code =", transaction_code)
    print("description =", description)
    print("generated_script length =", len(generated_script))
    print("==========================")

    conn = get_connection()
    cur = conn.cursor()

    # ---------------------------------------
    # SCRIPT MASTER
    # ---------------------------------------

    cur.execute(
        """
        INSERT INTO script_master
        (
            script_name,
            module,
            transaction_code,
            description,
            generated_script,
            status,
            created_by
        )
        VALUES
        (%s,%s,%s,%s,%s,%s,%s)
        RETURNING script_id
        """,
        (
            script_name,
            module,
            transaction_code,
            description,
            generated_script,
            "Draft",
            "Biranchi Das"
        )
    )

    new_script_id = cur.fetchone()[0]

    # ---------------------------------------
    # LOGIN
    # ---------------------------------------

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
        (%s,%s,'LOGIN','','')
        """,
        (
            str(new_script_id),
            1
        )
    )

    # ---------------------------------------
    # TRANSACTION
    # ---------------------------------------

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
        (%s,%s,'START_TRANSACTION','TCODE',%s)
        """,
        (
            str(new_script_id),
            2,
            transaction_code
        )
    )

    step_sequence = 3

    # ---------------------------------------
    # ANALYZED ACTIONS
    # ---------------------------------------

    try:

        results = json.loads(
            analysis_results
        )

        for result in results:

            for action in result["actions"]:

                # Ignore tcode launcher
                if (
                    action.get("locator") ==
                    "wnd[0]/tbar[0]/okcd"
                ):
                    continue

                if (
                    action["action"] ==
                    "SET_TEXT"
                ):

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
                            str(new_script_id),
                            step_sequence,
                            "SET_TEXT",
                            action.get(
                                "locator",
                                ""
                            ),
                            action.get(
                                "sample_value",
                                ""
                            )
                        )
                    )

                    step_sequence += 1

                elif (
                    action["action"] ==
                    "SEND_VKEY"
                ):

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
                            str(new_script_id),
                            step_sequence,
                            "SEND_VKEY",
                            "KEY",
                            action.get(
                                "sample_value",
                                ""
                            )
                        )
                    )

                    step_sequence += 1

    except Exception as ex:

        print(
            "STEP CREATION ERROR:",
            str(ex)
        )

    # ---------------------------------------
    # LOGOUT
    # ---------------------------------------

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
        (%s,%s,'LOGOUT','','')
        """,
        (
            str(new_script_id),
            step_sequence
        )
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