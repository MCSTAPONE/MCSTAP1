# -*- coding: utf-8 -*-

from services.execution_context_service import (
    ExecutionContextService
)

from services.asset_runner import (
    AssetRunner
)

from services.sap_executor import (
    SAPExecutor
)


class TestCaseExecutor:

    def execute(
        self,
        test_case_id
    ):

        context_service = (
            ExecutionContextService()
        )

        context = (
            context_service.build_context(
                test_case_id
            )
        )

        sap = SAPExecutor()

        sap.connect()

        sap.login()

        runner = AssetRunner()

        results = []

        session = sap.session

        for step in context["flow_steps"]:

            asset_name = step[2]

            asset_script = step[5]

            if not asset_script:

                results.append(
                    {
                        "asset": asset_name,
                        "status": "NO_SCRIPT"
                    }
                )

                continue

            result = runner.run_asset(
                asset_script,
                session,
                context["test_data"],
                context["runtime"]
            )

            print("RUNTIME:")
            print(context["runtime"])

            results.append(
                {
                    "asset": asset_name,
                    "status": result
                }
            )

        sap.logout()

        return {
            "status": "SUCCESS",
            "results": results,
            "runtime": context["runtime"]
        }
