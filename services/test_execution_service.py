# services/test_execution_service.py

from services.test_case_executor import (
    TestCaseExecutor
)


class TestExecutionService:

    def execute_test_case(
        self,
        test_case_id
    ):

        executor = TestCaseExecutor()

        result = executor.execute(
            test_case_id
        )

        return result