from fastapi import APIRouter

import subprocess

router = APIRouter()


@router.post("/pm/run")
def run_pm_flow():

    try:

        result = subprocess.run(
            [
                "python",
                "-m",
                "tests.test_iw_flow"
            ],
            capture_output=True,
            text=True,
            encoding="utf-8",
            errors="replace"
        )

        return {
            "status": "SUCCESS",
            "return_code": result.returncode,
            "output": result.stdout,
            "errors": result.stderr
        }

    except Exception as e:

        return {
            "status": "FAILED",
            "error": str(e)
        }
