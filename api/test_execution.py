# -*- coding: utf-8 -*-

from datetime import datetime
from datetime import timezone

from fastapi import APIRouter
from fastapi import Request

from services.test_execution_service import (
    TestExecutionService
)

from services.execution_evidence_service import (
    ExecutionEvidenceService
)

from api.shared import templates


router = APIRouter()


def normalize_execution_response(
    test_case_id,
    execution_result
):

    if isinstance(
        execution_result,
        dict
    ):

        return {
            "test_case_id": test_case_id,
            "status": execution_result.get(
                "status",
                "SUCCESS"
            ),
            "results": execution_result.get(
                "results",
                []
            ),
            "runtime": execution_result.get(
                "runtime",
                {}
            )
        }

    return {
        "test_case_id": test_case_id,
        "status": "SUCCESS",
        "results": execution_result,
        "runtime": {}
    }


def execute_and_save_evidence(
    test_case_id
):

    started_at = datetime.now(
        timezone.utc
    )

    execution_service = TestExecutionService()

    execution_result = (
        execution_service.execute_test_case(
            test_case_id
        )
    )

    ended_at = datetime.now(
        timezone.utc
    )

    response = normalize_execution_response(
        test_case_id,
        execution_result
    )

    evidence_service = ExecutionEvidenceService()

    evidence = evidence_service.save_execution(
        test_case_id,
        response,
        started_at,
        ended_at
    )

    response["execution_id"] = evidence.get(
        "execution_id"
    )

    return response


@router.post(
    "/api/testcases/{test_case_id}/execute"
)
def execute_test_case_api(
    test_case_id: int
):

    response = execute_and_save_evidence(
        test_case_id
    )

    return response


@router.post(
    "/test-cases/{test_case_id}/execute-result"
)
def execute_test_case_result_page(
    request: Request,
    test_case_id: int
):

    response = execute_and_save_evidence(
        test_case_id
    )

    return templates.TemplateResponse(
        request=request,
        name="test_execution_result.html",
        context={
            "execution": response
        }
    )