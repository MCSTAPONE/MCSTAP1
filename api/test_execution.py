# -*- coding: utf-8 -*-

from fastapi import APIRouter

from services.test_execution_service import (
    TestExecutionService
)

router = APIRouter()


@router.post(
    "/api/testcases/{test_case_id}/execute"
)
def execute_test_case(
    test_case_id: int
):

    service = TestExecutionService()

    result = service.execute_test_case(
        test_case_id
    )

    return {
        "test_case_id": test_case_id,
        "result": result
    }
