# -*- coding: utf-8 -*-

from services.asset_runner import (
    AssetRunner
)

from services.execution_context_service import (
    ExecutionContextService
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

        system_data = (
            context["system_data"]
        )

        print(
            "SDC EXECUTION CONTEXT:"
        )

        print(
            f"   SDC: "
            f"{system_data['sdc_name']}"
        )

        print(
            f"   Environment: "
            f"{system_data['environment']}"
        )

        print(
            f"   SAP Logon Entry: "
            f"{system_data['sap_logon_entry']}"
        )

        print(
            f"   Client: "
            f"{system_data['client']}"
        )

        print(
            f"   Language: "
            f"{system_data['language']}"
        )

        sap = SAPExecutor(
            system_data=system_data
        )

        runner = AssetRunner()

        results = []

        execution_error = None

        try:

            sap.connect()

            sap.login()

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

                print(
                    f"Executing asset: "
                    f"{asset_name}"
                )

                result = runner.run_asset(
                    asset_script,
                    session,
                    context["test_data"],
                    context["runtime"]
                )

                results.append(
                    {
                        "asset": asset_name,
                        "status": result
                    }
                )

                print(
                    "RUNTIME:"
                )

                print(
                    context["runtime"]
                )

        except Exception as error:

            execution_error = error

            raise

        finally:

            if sap.session is not None:

                try:

                    sap.logout()

                except Exception as logout_error:

                    print(
                        f"SAP logout warning: "
                        f"{logout_error}"
                    )

            if execution_error:

                print(
                    f"Execution failed: "
                    f"{execution_error}"
                )

        return {
            "status": "SUCCESS",
            "results": results,
            "runtime": context["runtime"],
            "system_data": system_data
        }