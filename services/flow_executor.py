# -*- coding: utf-8 -*-

from services.execution_context_service import (
    ExecutionContextService
)

from services.asset_runner import (
    AssetRunner
)


class FlowExecutor:

    def execute(
        self,
        test_case_id,
        session=None
    ):

        context_service = (
            ExecutionContextService()
        )

        runner = AssetRunner()

        context = (
            context_service.build_context(
                test_case_id
            )
        )

        results = []

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
                context["test_data"]
            )

            results.append(
                {
                    "asset": asset_name,
                    "result": result
                }
            )

        return results