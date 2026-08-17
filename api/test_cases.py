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
            test_case_id,
            title,
            module,
            transaction_code,
            process_step,
            script_path,
		repository_assets
        FROM test_cases
        WHERE test_case_id = %s
        """,
        (test_case_id,)
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

@router.post("/test-cases/edit/{test_case_id}")
def update_test_case(
    test_case_id: str,
    title: str = Form(...),
    module: str = Form(...),
    transaction_code: str = Form(...),
    process_step: str = Form(...),
    automation_status: str = Form(...),
    script_path: str = Form(...)
):

    conn = get_connection()

    cur = conn.cursor()

    # Update Test Case

    cur.execute(
        """
        UPDATE test_cases
        SET
            title = %s,
            module = %s,
            transaction_code = %s,
            process_step = %s,
            automation_status = %s,
            script_path = %s
        WHERE test_case_id = %s
        """,
        (
            title,
            module,
            transaction_code,
            process_step,
            automation_status,
            script_path,
            test_case_id
        )
    )

    # Update Repository Asset

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
            title,
            module,
            script_path,
            process_step,
            transaction_code
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

    cur.execute(
        """
        SELECT
            test_case_id,
            title,
            module,
            transaction_code,
            process_step,
            script_path
        FROM test_cases
        WHERE test_case_id = %s
        """,
        (test_case_id,)
    )

    row = cur.fetchone()

    cur.close()
    conn.close()

    return templates.TemplateResponse(
        request=request,
        name="view_test_case.html",
        context={
            "row": row
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