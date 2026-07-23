# -*- coding: utf-8 -*-

from fastapi import APIRouter
from fastapi import Request
from fastapi import Form

from api.database import get_connection
from api.shared import templates

router = APIRouter()

@router.get("/test-cases")
def test_cases(request: Request):

    conn = get_connection()

    cur = conn.cursor()

    
    cur.execute("""
        SELECT
            test_case_id,
            module,
            transaction_code,
            process_step,
            automation_status,
            script_path
        FROM test_cases
        ORDER BY id ASC
    """)


    rows = cur.fetchall()

    cur.close()
    conn.close()

    return templates.TemplateResponse(
        request=request,
        name="test_cases.html",
        context={
            "rows": rows
        }
    )
    
@router.post("/test-cases/save")
def save_test_case(
    title: str = Form(...),
    module: str = Form(...),
    transaction_code: str = Form(...),
    process_step: str = Form(...),
    automation_status: str = Form(...),
    script_path: str = Form(...)
):

    conn = get_connection()

    cur = conn.cursor()

    # Generate Test Case ID

    cur.execute(
        """
        SELECT COUNT(*)
        FROM test_cases
        """
    )

    next_id = cur.fetchone()[0] + 1

    test_case_id = f"TC{next_id:04d}"

    # Save Test Case

    cur.execute(
        """
        INSERT INTO test_cases
        (
            test_case_id,
            title,
            module,
            transaction_code,
            process_step,
            automation_status,
            script_path
        )
        VALUES
        (%s,%s,%s,%s,%s,%s,%s)
        """,
        (
            test_case_id,
            title,
            module,
            transaction_code,
            process_step,
            automation_status,
            script_path
        )
    )

    # Check if Repository Asset already exists

    cur.execute(
        """
        SELECT COUNT(*)
        FROM repository_assets
        WHERE transaction_code = %s
        """,
        (transaction_code,)
    )

    exists = cur.fetchone()[0]

    # Auto-register Repository Asset

    if exists == 0:

        cur.execute(
            """
            INSERT INTO repository_assets
            (
                asset_name,
                module,
                transaction_code,
                script_name,
                description
            )
            VALUES
            (%s,%s,%s,%s,%s)
            """,
            (
                title,
                module,
                transaction_code,
                script_path,
                process_step
            )
        )

    conn.commit()

    cur.close()
    conn.close()

    return RedirectResponse(
        url="/test-cases",
        status_code=303
    )

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
            automation_status,
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
            automation_status,
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