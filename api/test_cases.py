# -*- coding: utf-8 -*-

from typing import Optional

from fastapi import APIRouter
from fastapi import Form
from fastapi import Request
from fastapi.responses import RedirectResponse

from api.database import get_connection
from api.shared import templates


router = APIRouter()


@router.get("/test-cases")
def test_cases(
    request: Request
):

    conn = get_connection()
    cur = conn.cursor()

    try:

        # ==========================================
        # TEST CASE LIST
        # ==========================================

        cur.execute(
            """
            SELECT
                tc.id,
                tc.test_case_id,
                tc.title,
                tc.module,
                fm.flow_name,
                tm.tdc_name,
                sm.sdc_name,
                tc.priority
            FROM test_cases tc
            LEFT JOIN flow_master fm
                ON tc.flow_id = fm.flow_id
            LEFT JOIN tdc_master tm
                ON tc.tdc_id = tm.tdc_id
            LEFT JOIN sdc_master sm
                ON tc.sdc_id = sm.sdc_id
            ORDER BY tc.id
            """
        )

        rows = cur.fetchall()

        # ==========================================
        # AVAILABLE FLOWS
        # ==========================================

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

        # ==========================================
        # ACTIVE TDC RECORDS
        # ==========================================

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

        # ==========================================
        # ACTIVE SDC RECORDS
        # ==========================================

        cur.execute(
            """
            SELECT
                sdc_id,
                sdc_name,
                environment,
                client
            FROM sdc_master
            WHERE status = 'Active'
            ORDER BY sdc_name
            """
        )

        sdcs = cur.fetchall()

    finally:

        cur.close()
        conn.close()

    return templates.TemplateResponse(
        request=request,
        name="test_cases.html",
        context={
            "rows": rows,
            "flows": flows,
            "tdcs": tdcs,
            "sdcs": sdcs
        }
    )


@router.post("/test-cases/save")
def save_test_case(
    title: str = Form(...),
    module: str = Form(...),
    flow_id: int = Form(...),
    tdc_id: int = Form(...),
    sdc_id: int = Form(...),
    priority: str = Form(...)
):

    conn = get_connection()
    cur = conn.cursor()

    try:

        # ==========================================
        # VALIDATE FLOW
        # ==========================================

        cur.execute(
            """
            SELECT
                flow_id
            FROM flow_master
            WHERE flow_id = %s
            """,
            (
                flow_id,
            )
        )

        flow = cur.fetchone()

        if not flow:

            raise ValueError(
                "The selected Flow does not exist."
            )

        # ==========================================
        # VALIDATE ACTIVE TDC
        # ==========================================

        cur.execute(
            """
            SELECT
                tdc_id
            FROM tdc_master
            WHERE tdc_id = %s
            AND status = 'Active'
            """,
            (
                tdc_id,
            )
        )

        active_tdc = cur.fetchone()

        if not active_tdc:

            raise ValueError(
                "The selected Test Data Container "
                "does not exist or is inactive."
            )

        # ==========================================
        # VALIDATE ACTIVE SDC
        # ==========================================

        cur.execute(
            """
            SELECT
                sdc_id
            FROM sdc_master
            WHERE sdc_id = %s
            AND status = 'Active'
            """,
            (
                sdc_id,
            )
        )

        active_sdc = cur.fetchone()

        if not active_sdc:

            raise ValueError(
                "The selected System Data Container "
                "does not exist or is inactive."
            )

        # ==========================================
        # GENERATE NEXT TEST CASE ID
        # ==========================================

        cur.execute(
            """
            SELECT
                COALESCE(
                    MAX(
                        CAST(
                            SUBSTRING(
                                test_case_id
                                FROM 3
                            )
                            AS INTEGER
                        )
                    ),
                    0
                )
            FROM test_cases
            WHERE test_case_id ~ '^TC[0-9]+$'
            """
        )

        last_test_case_number = (
            cur.fetchone()[0]
        )

        next_test_case_number = (
            last_test_case_number + 1
        )

        test_case_id = (
            f"TC{next_test_case_number:04d}"
        )

        # ==========================================
        # SAVE TEST CASE
        # ==========================================

        cur.execute(
            """
            INSERT INTO test_cases
            (
                test_case_id,
                title,
                module,
                flow_id,
                tdc_id,
                sdc_id,
                priority
            )
            VALUES
            (
                %s,
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
                title.strip(),
                module.strip().upper(),
                flow_id,
                tdc_id,
                sdc_id,
                priority.strip()
            )
        )

        conn.commit()

    except Exception:

        conn.rollback()
        raise

    finally:

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

    try:

        cur.execute(
            """
            SELECT
                test_case_id,
                title,
                module,
                transaction_code,
                process_step,
                script_path,
                tdc_id,
                priority
            FROM test_cases
            WHERE test_case_id = %s
               OR id::text = %s
            """,
            (
                test_case_id,
                test_case_id
            )
        )

        row = cur.fetchone()

    finally:

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

    try:

        clean_title = (
            title.strip()
            if title and title.strip()
            else None
        )

        clean_module = (
            module.strip()
            if module and module.strip()
            else None
        )

        clean_tcode = (
            transaction_code.strip()
            if transaction_code
            and transaction_code.strip()
            else None
        )

        clean_step = (
            process_step.strip()
            if process_step
            and process_step.strip()
            else None
        )

        clean_script = (
            script_path.strip()
            if script_path
            and script_path.strip()
            else None
        )

        clean_priority = (
            priority.strip()
            if priority and priority.strip()
            else None
        )

        resolved_tdc_id = None

        if tdc_id and tdc_id.strip():

            tdc_value = tdc_id.strip()

            if tdc_value.isdigit():

                resolved_tdc_id = int(
                    tdc_value
                )

            else:

                cur.execute(
                    """
                    SELECT
                        tdc_id
                    FROM tdc_master
                    WHERE tdc_name = %s
                    """,
                    (
                        tdc_value,
                    )
                )

                tdc_row = cur.fetchone()

                if tdc_row:

                    resolved_tdc_id = (
                        tdc_row[0]
                    )

        # ==========================================
        # UPDATE TEST CASE
        # ==========================================

        cur.execute(
            """
            UPDATE test_cases
            SET
                title = COALESCE(
                    %s,
                    title
                ),
                module = COALESCE(
                    %s,
                    module
                ),
                transaction_code = COALESCE(
                    %s,
                    transaction_code
                ),
                process_step = COALESCE(
                    %s,
                    process_step
                ),
                script_path = COALESCE(
                    %s,
                    script_path
                ),
                tdc_id = COALESCE(
                    %s,
                    tdc_id
                ),
                priority = COALESCE(
                    %s,
                    priority
                )
            WHERE test_case_id = %s
               OR id::text = %s
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

        # ==========================================
        # UPDATE REPOSITORY ASSET IF APPLICABLE
        # ==========================================

        if clean_tcode:

            cur.execute(
                """
                UPDATE repository_assets
                SET
                    asset_name = COALESCE(
                        %s,
                        asset_name
                    ),
                    module = COALESCE(
                        %s,
                        module
                    ),
                    script_name = COALESCE(
                        %s,
                        script_name
                    ),
                    description = COALESCE(
                        %s,
                        description
                    )
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

    except Exception:

        conn.rollback()
        raise

    finally:

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

    try:

        cur.execute(
            """
            SELECT
                tc.test_case_id,
                tc.title,
                tc.module,
                tc.transaction_code,
                tc.process_step,
                tc.script_path,
                tm.tdc_name,
                tc.priority
            FROM test_cases tc
            LEFT JOIN tdc_master tm
                ON tc.tdc_id = tm.tdc_id
            WHERE tc.test_case_id = %s
               OR tc.id::text = %s
            """,
            (
                test_case_id,
                test_case_id
            )
        )

        row = cur.fetchone()

        row_list = (
            list(row)
            if row
            else []
        )

    finally:

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

    try:

        cur.execute(
            """
            DELETE FROM test_cases
            WHERE test_case_id = %s
               OR id::text = %s
            """,
            (
                test_case_id,
                test_case_id
            )
        )

        conn.commit()

    except Exception:

        conn.rollback()
        raise

    finally:

        cur.close()
        conn.close()

    return RedirectResponse(
        url="/test-cases",
        status_code=303
    )