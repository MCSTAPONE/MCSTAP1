# -*- coding: utf-8 -*-

from fastapi import APIRouter
from fastapi import Request
from fastapi import Form
from urllib3 import request

from api.database import get_connection
from api.shared import templates

from fastapi.responses import RedirectResponse

router = APIRouter()

@router.get("/test-cases")
def test_cases(request: Request):

    conn = get_connection()

    cur = conn.cursor()

    cur.execute(
        """
        SELECT

            tc.id,
            tc.test_case_id,
            tc.title,
            tc.module,
            fm.flow_name,
		tm.tdc_name,
            tc.priority
        FROM test_cases tc
        LEFT JOIN flow_master fm
            ON tc.flow_id = fm.flow_id
	  LEFT JOIN tdc_master tm
		ON tc.tdc_id = tm.tdc_id

        ORDER BY tc.id
        """
    )

    rows = cur.fetchall()

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
    
    cur.execute(
	  """
	  SELECT
	    tdc_id,
	    tdc_name
	  FROM tdc_master
	  WHERE status = 'Active'
	  ORDER BY tdc_name
	  """
    )

    tdcs = cur.fetchall()

    cur.close()
    conn.close()

    return templates.TemplateResponse(
            request=request,
            name="test_cases.html",
            context={
                "rows": rows,
                "flows": flows,
            "tdcs": tdcs
            }
        )
    
@router.post("/test-cases/save")
def save_test_case(
    title: str = Form(...),
    module: str = Form(...),
    flow_id: int = Form(...),
    tdc_id: int = Form(...),
    priority: str = Form(...),
):

    conn = get_connection()

    cur = conn.cursor()

    cur.execute(
        """
        SELECT COUNT(*)
        FROM test_cases
        """
    )

    next_id = cur.fetchone()[0] + 1

    test_case_id = f"TC{next_id:04d}"

    cur.execute(
        """
        INSERT INTO test_cases
		(
		    test_case_id,
		    title,
		    module,
		    flow_id,
		    tdc_id,
		    priority
		)
        VALUES
        (
            %s,
            %s,
            %s,
            %s,
            %s,
            %s
        )
        """,
        (
            test_case_id,
            title,
            module,
            flow_id,
		tdc_id,
            priority
        )
    )

    conn.commit()

    cur.close()
    conn.close()

    return RedirectResponse(
        url="/test-cases",
        status_code=303
    )
@router.get("/test-cases/edit/{test_case_id}")
def edit_test_case(
    request: Request,
    test_case_id: str
):
    conn = get_connection()
    cur = conn.cursor()

    cur.execute(
        """
        SELECT
            test_case_id,   -- row[0]
            title,          -- row[1]
            module,         -- row[2]
            transaction_code,-- row[3]
            process_step,   -- row[4]
            script_path,    -- row[5]
            tdc_id,         -- row[6]
            priority        -- row[7]
        FROM test_cases
        WHERE test_case_id = %s OR id::text = %s
        """,
        (test_case_id, test_case_id)
    )

    row = cur.fetchone()
    cur.close()
    conn.close()

    return templates.TemplateResponse(
        request=request,
        name="edit_test_case.html",
        context={
            "row": row
        }
    )

from typing import Optional
from fastapi import Form
from fastapi.responses import RedirectResponse

@router.post("/test-cases/edit/{test_case_id}")
def update_test_case(
    test_case_id: str,
    title: Optional[str] = Form(None),
    module: Optional[str] = Form(None),
    transaction_code: Optional[str] = Form(None),
    process_step: Optional[str] = Form(None),
    automation_status: Optional[str] = Form(None),
    script_path: Optional[str] = Form(None),
    tdc_id: Optional[str] = Form(None),
    priority: Optional[str] = Form(None)
):
    conn = get_connection()
    cur = conn.cursor()

    # Clean input strings
    clean_title = title.strip() if title and title.strip() else None
    clean_module = module.strip() if module and module.strip() else None
    clean_tcode = transaction_code.strip() if transaction_code and transaction_code.strip() else None
    clean_step = process_step.strip() if process_step and process_step.strip() else None
    clean_script = script_path.strip() if script_path and script_path.strip() else None
    clean_priority = priority.strip() if priority and priority.strip() else None

    # Resolve integer ID for tdc_id if a string name was posted
    resolved_tdc_id = None
    if tdc_id and tdc_id.strip():
        val = tdc_id.strip()
        if val.isdigit():
            resolved_tdc_id = int(val)
        else:
            # Look up the integer ID for the passed container name
            try:
                cur.execute("SELECT id FROM test_data_containers WHERE name = %s OR tdc_name = %s", (val, val))
                tdc_row = cur.fetchone()
                if tdc_row:
                    resolved_tdc_id = tdc_row[0]
            except Exception:
                conn.rollback()

    # 1. Update test_cases table
    cur.execute(
        """
        UPDATE test_cases
        SET
            title = %s,
            module = %s,
            transaction_code = %s,
            process_step = %s,
            script_path = %s,
            tdc_id = %s,
            priority = %s
        WHERE test_case_id = %s OR id::text = %s
        """,
        (
            clean_title,
            clean_module,
            clean_tcode,
            clean_step,
            clean_script,
            resolved_tdc_id,
            clean_priority,
            test_case_id,
            test_case_id
        )
    )

    # 2. Update repository_assets table (only if transaction_code exists)
    if clean_tcode:
        cur.execute(
            """
            UPDATE repository_assets
            SET
                asset_name = %s,
                module = %s,
                script_name = %s,
                description = %s
            WHERE transaction_code = %s
            """,
            (
                clean_title,
                clean_module,
                clean_script,
                clean_step,
                clean_tcode
            )
        )

    conn.commit()
    cur.close()
    conn.close()

    return RedirectResponse(
        url="/test-cases",
        status_code=303
    )

@router.get("/test-cases/view/{test_case_id}")
def view_test_case(
    request: Request,
    test_case_id: str
):
    conn = get_connection()
    cur = conn.cursor()

    # Query test case along with tdc_id and priority
    cur.execute(
        """
        SELECT
            test_case_id,      -- row[0]
            title,             -- row[1]
            module,            -- row[2]
            transaction_code,  -- row[3]
            process_step,      -- row[4]
            script_path,       -- row[5]
            tdc_id,            -- row[6]
            priority           -- row[7]
        FROM test_cases
        WHERE test_case_id = %s OR id::text = %s
        """,
        (test_case_id, test_case_id)
    )

    row = cur.fetchone()
    row_list = list(row) if row else []

    # Safe lookup for the TDC name based on how your main list query gets 'COSTCENTER_DEFAULT'
    if row_list and len(row_list) > 6 and row_list[6]:
        try:
            # Match the TDC table used in your main page route
            cur.execute(
                "SELECT tdc_name FROM test_data_containers WHERE id::text = %s OR tdc_id::text = %s",
                (str(row_list[6]), str(row_list[6]))
            )
            tdc_res = cur.fetchone()
            if tdc_res and tdc_res[0]:
                row_list[6] = tdc_res[0]
        except Exception:
            conn.rollback()
            # If tdc_id is already the string name (e.g. COSTCENTER_DEFAULT), keep it as is

    cur.close()
    conn.close()

    return templates.TemplateResponse(
        request=request,
        name="view_test_case.html",
        context={
            "row": row_list
        }
    )

@router.get("/test-cases/delete/{test_case_id}")
def delete_test_case(
    test_case_id: str
):

    conn = get_connection()

    cur = conn.cursor()

    cur.execute(
        """
        DELETE FROM test_cases
        WHERE test_case_id = %s
        """,
        (test_case_id,)
    )

    conn.commit()

    cur.close()
    conn.close()

    return RedirectResponse(
        url="/test-cases",
        status_code=303
    )