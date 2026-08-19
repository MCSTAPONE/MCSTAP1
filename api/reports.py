# -*- coding: utf-8 -*-

from fastapi import APIRouter
from fastapi import Request

from api.database import get_connection
from api.shared import templates


router = APIRouter()


@router.get("/reports")
def reports_home(
    request: Request
):

    return templates.TemplateResponse(
        request=request,
        name="reports.html",
        context={}
    )


@router.get("/reports/executions")
def execution_reports(
    request: Request
):

    conn = get_connection()
    cur = conn.cursor()

    cur.execute(
        """
        SELECT
            ter.execution_id,
            ter.test_case_db_id,
            tc.test_case_id,
            tc.title,
            ter.execution_status,
            ter.runtime_context,
            ter.created_at,
            CASE
                WHEN ter.started_at IS NOT NULL
                 AND ter.ended_at IS NOT NULL
                THEN
                    EXTRACT(
                        EPOCH FROM (
                            ter.ended_at - ter.started_at
                        )
                    )::INTEGER
                ELSE
                    NULL
            END AS duration_seconds
        FROM test_execution_runs ter
        LEFT JOIN test_cases tc
            ON ter.test_case_db_id = tc.id
        ORDER BY ter.execution_id DESC
        """
    )

    rows = cur.fetchall()

    cur.close()
    conn.close()

    return templates.TemplateResponse(
        request=request,
        name="execution_reports.html",
        context={
            "rows": rows
        }
    )


@router.get("/reports/executions/{execution_id}")
def execution_report_detail(
    request: Request,
    execution_id: int
):

    conn = get_connection()
    cur = conn.cursor()

    cur.execute(
        """
        SELECT
            ter.execution_id,
            ter.test_case_db_id,
            tc.test_case_id,
            tc.title,
            ter.execution_status,
            ter.runtime_context,
            ter.started_at,
            ter.ended_at,
            ter.created_at,
            CASE
                WHEN ter.started_at IS NOT NULL
                 AND ter.ended_at IS NOT NULL
                THEN
                    EXTRACT(
                        EPOCH FROM (
                            ter.ended_at - ter.started_at
                        )
                    )::INTEGER
                ELSE
                    NULL
            END AS duration_seconds
        FROM test_execution_runs ter
        LEFT JOIN test_cases tc
            ON ter.test_case_db_id = tc.id
        WHERE ter.execution_id = %s
        """,
        (
            execution_id,
        )
    )

    execution = cur.fetchone()

    cur.execute(
        """
        SELECT
            sequence_no,
            asset_name,
            asset_status,
            asset_details,
            created_at
        FROM test_execution_assets
        WHERE execution_id = %s
        ORDER BY sequence_no
        """,
        (
            execution_id,
        )
    )

    assets = cur.fetchall()

    cur.close()
    conn.close()

    return templates.TemplateResponse(
        request=request,
        name="execution_report_detail.html",
        context={
            "execution": execution,
            "assets": assets
        }
    )
