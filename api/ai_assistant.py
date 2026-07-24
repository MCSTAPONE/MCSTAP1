# -*- coding: utf-8 -*-

import re

from fastapi import APIRouter
from fastapi import Request
from fastapi import Form

from api.database import get_connection
from api.shared import templates

router = APIRouter()

AI_CONTEXT = {}


@router.get("/ai-assistant")
def ai_assistant(request: Request):

    return templates.TemplateResponse(
        request=request,
        name="ai_assistant.html",
        context={}
    )


@router.post("/ai-assistant")
def ai_assistant_ask(
    request: Request,
    question: str = Form(...)
):

    global AI_CONTEXT

    answer = "I could not understand the question."

    question_upper = question.upper()

    # ====================================================
    # FLOW BUILDER START
    # ====================================================

    if question_upper == "CREATE FLOW":

        AI_CONTEXT["mode"] = "FLOW_BUILDER"

        answer = (
            "Sure.\n\n"
            "What business process would you like to automate?\n\n"
            "Examples:\n"
            "- Cost Center\n"
            "- Purchase Order\n"
            "- Sales Order\n"
            "- Maintenance Plan\n"
            "- Work Order"
        )

        return templates.TemplateResponse(
            request=request,
            name="ai_assistant.html",
            context={"answer": answer}
        )

    # ====================================================
    # FLOW CREATION CONFIRMATION
    # ====================================================

    if (
        AI_CONTEXT.get("mode") == "CREATE_FLOW"
        and question_upper == "YES"
    ):

        conn = get_connection()
        cur = conn.cursor()

        flow_name = AI_CONTEXT["flow_name"]
        assets = AI_CONTEXT["assets"]

        module = assets[0][2]

        description = (
            f"AI Generated Flow for "
            f"{flow_name.replace('_LIFECYCLE', '')}"
        )

        cur.execute(
            """
            INSERT INTO flow_master
            (
                flow_name,
                description,
                module,
                status
            )
            VALUES
            (%s,%s,%s,%s)
            RETURNING flow_id
            """,
            (
                flow_name,
                description,
                module,
                "Draft"
            )
        )

        flow_id = cur.fetchone()[0]

        step_no = 1

        for asset in assets:

            cur.execute(
                """
                INSERT INTO flow_steps
                (
                    flow_id,
                    sequence_no,
                    transaction_code
                )
                VALUES
                (%s,%s,%s)
                """,
                (
                    flow_id,
                    step_no,
                    asset[1]
                )
            )

            step_no += 1

        conn.commit()

        cur.close()
        conn.close()

        AI_CONTEXT.clear()

        answer = (
            f"Flow created successfully.\n\n"
            f"Flow Name: {flow_name}\n"
            f"Flow ID: {flow_id}"
        )

        return templates.TemplateResponse(
            request=request,
            name="ai_assistant.html",
            context={"answer": answer}
        )

    # ====================================================
    # FLOW BUILDER RECOMMENDATION ENGINE
    # ====================================================

    if AI_CONTEXT.get("mode") == "FLOW_BUILDER":

        process_name = question.strip()

        conn = get_connection()
        cur = conn.cursor()

        search_text = process_name.upper()

        cur.execute(
            """
            SELECT
                asset_name,
                transaction_code,
                module
            FROM repository_assets
            WHERE
                UPPER(asset_name) LIKE %s
                OR
                UPPER(description) LIKE %s
            ORDER BY transaction_code
            """,
            (
                f"%{search_text}%",
                f"%{search_text}%"
            )
        )

        matching_assets = cur.fetchall()

        if matching_assets:

            flow_name = (
                process_name.upper()
                .replace(" ", "_")
                + "_LIFECYCLE"
            )

            AI_CONTEXT["mode"] = "CREATE_FLOW"
            AI_CONTEXT["flow_name"] = flow_name
            AI_CONTEXT["assets"] = matching_assets

            answer = (
                f"Recommended Flow\n\n"
                f"Flow Name:\n"
                f"{flow_name}\n\n"
            )

            step_no = 1

            for asset in matching_assets:

                answer += (
                    f"Step {step_no}\n"
                    f"{asset[0]}\n\n"
                )

                step_no += 1

            answer += "\nType YES to create this flow."

        else:

            cur.execute(
                """
                SELECT
                    process_id,
                    process_name,
                    module,
                    flow_type,
                    description
                FROM sap_process_library
                WHERE
                    UPPER(process_name) LIKE %s
                """,
                (
                    f"%{search_text}%",
                )
            )

            process = cur.fetchone()

            if process:

                AI_CONTEXT["mode"] = "PROCESS_LIBRARY"

                AI_CONTEXT["process_id"] = process[0]

                answer = (
                    f"Repository Coverage: 0%\n\n"
                    f"I found a standard SAP process.\n\n"
                    f"Process Name: {process[1]}\n"
                    f"Module: {process[2]}\n"
                    f"Flow Type: {process[3]}\n\n"
                    f"{process[4]}\n\n"
                    f"Would you like to view the process steps?\n\n"
                    f"Type YES to continue."
                )

            else:

                answer = (
                    f"No repository assets found.\n\n"
                    f"No process knowledge found.\n\n"
                    f"Suggested Next Steps:\n\n"
                    f"1. Create repository assets\n"
                    f"2. Import automation scripts\n"
                    f"3. Record business process in Script Studio"
                )

                AI_CONTEXT.clear()

        cur.close()
        conn.close()
        
        return templates.TemplateResponse(
            request=request,
            name="ai_assistant.html",
            context={"answer": answer}
        )

    # ====================================================
    # PROCESS LIBRARY
    # ====================================================

    if (
        AI_CONTEXT.get("mode") == "PROCESS_LIBRARY"
        and question_upper == "YES"
    ):

        conn = get_connection()

        cur = conn.cursor()

        process_id = AI_CONTEXT["process_id"]

        cur.execute(
            """
            SELECT
                process_name,
                module,
                flow_type
            FROM sap_process_library
            WHERE process_id = %s
            """,
            (process_id,)
        )

        process_info = cur.fetchone()

        process_name = process_info[0]
        module = process_info[1]
        flow_type = process_info[2]

        cur.execute(
            """
            SELECT
                sequence_no,
                transaction_code,
                step_name
            FROM sap_process_steps
            WHERE process_id = %s
            ORDER BY sequence_no
            """,
            (process_id,)
        )

        rows = cur.fetchall()

        answer = (
            "Standard SAP Process\n\n"
        )

        for row in rows:

            answer += (
                f"{row[0]}. "
                f"{row[1]} - "
                f"{row[2]}\n"
            )

        AI_CONTEXT["mode"] = "CREATE_PLACEHOLDER"

        AI_CONTEXT["process_id"] = process_id

        AI_CONTEXT["process_name"] = process_name

        AI_CONTEXT["module"] = module

        AI_CONTEXT["flow_type"] = flow_type

        answer += (
            "\n\n"
            "Repository Coverage: 0%\n\n"
            "Would you like me to create a Placeholder Flow?\n\n"
            "Type YES to continue."
        )

        cur.close()
        conn.close()

        return templates.TemplateResponse(
            request=request,
            name="ai_assistant.html",
            context={
                "answer": answer
            }
        )

    # ====================================================
    # CREATE PLACEHOLDER FLOW
    # ====================================================

    if (
        AI_CONTEXT.get("mode") == "CREATE_PLACEHOLDER"
        and question_upper == "YES"
    ):

        conn = get_connection()

        cur = conn.cursor()

        process_id = AI_CONTEXT["process_id"]

        process_name = AI_CONTEXT["process_name"]

        module = AI_CONTEXT["module"]

        flow_type = AI_CONTEXT["flow_type"]

        flow_name = (
            process_name.upper()
            .replace(" ", "_")
            + "_PLACEHOLDER"
        )

        cur.execute(
            """
            INSERT INTO flow_master
            (
                flow_name,
                description,
                module,
                status
            )
            VALUES
            (%s,%s,%s,%s)
            RETURNING flow_id
            """,
            (
                flow_name,
                "AI Generated Placeholder Flow",
                module,
                "Draft"
            )
        )

        flow_id = cur.fetchone()[0]

        cur.execute(
            """
            SELECT
                sequence_no,
                transaction_code
            FROM sap_process_steps
            WHERE process_id = %s
            ORDER BY sequence_no
            """,
            (process_id,)
        )

        steps = cur.fetchall()

        for step in steps:

            cur.execute(
                """
                INSERT INTO flow_steps
                (
                    flow_id,
                    sequence_no,
                    transaction_code
                )
                VALUES
                (%s,%s,%s)
                """,
                (
                    flow_id,
                    step[0],
                    step[1]
                )
            )

        conn.commit()

        cur.close()
        conn.close()

        AI_CONTEXT.clear()

        answer = (
            f"Placeholder Flow Created Successfully\n\n"
            f"Flow Name: {flow_name}\n"
            f"Flow ID: {flow_id}\n"
            f"Module: {module}\n\n"
            f"Repository Coverage: 0%\n\n"
            f"Next Step:\n"
            f"Create Repository Assets for the process."
        )

        return templates.TemplateResponse(
            request=request,
            name="ai_assistant.html",
            context={
                "answer": answer
            }
        )

    # ====================================================
    # COVERAGE ANALYSIS
    # ====================================================

    if "COVERAGE" in question_upper:

        process_name = (
            question_upper
            .replace("ANALYZE", "")
            .replace("COVERAGE", "")
            .strip()
            .title()
        )

        conn = get_connection()

        cur = conn.cursor()

        cur.execute(
            """
            SELECT
                process_id,
                process_name
            FROM sap_process_library
            WHERE UPPER(process_name) = %s
            """,
            (process_name.upper(),)
        )

        process = cur.fetchone()

        if process:

            process_id = process[0]

            cur.execute(
                """
                SELECT
                    transaction_code
                FROM sap_process_steps
                WHERE process_id = %s
                ORDER BY sequence_no
                """,
                (process_id,)
            )

            standard_steps = cur.fetchall()

            total_steps = len(standard_steps)

            available = []

            missing = []

            for step in standard_steps:

                transaction_code = step[0]

                cur.execute(
                    """
                    SELECT COUNT(*)
                    FROM repository_assets
                    WHERE transaction_code = %s
                    """,
                    (transaction_code,)
                )

                count = cur.fetchone()[0]

                if count:

                    available.append(transaction_code)

                else:

                    missing.append(transaction_code)

            coverage = 0

            if total_steps:

                coverage = round(
                    (len(available) / total_steps) * 100
                )

            answer = (
                f"Coverage Analysis\n\n"
                f"Process:\n"
                f"{process_name}\n\n"
            )

            answer += "Available:\n"

            for tx in available:

                answer += f"✅ {tx}\n"

            answer += "\nMissing:\n"

            for tx in missing:

                answer += f"❌ {tx}\n"

            answer += (
                f"\nCoverage:\n"
                f"{coverage}%"
            )

        else:

            answer = (
                f"No process library entry found for:\n\n"
                f"{process_name}"
            )

        cur.close()
        conn.close()

        return templates.TemplateResponse(
            request=request,
            name="ai_assistant.html",
            context={
                "answer": answer
            }
        )

    
    # ====================================================
    # TRANSACTION SEARCH
    # ====================================================

    conn = get_connection()
    cur = conn.cursor()

    transaction_match = re.search(
        r"\b[A-Z]{2,5}[0-9]{2,3}[A-Z]?\b",
        question_upper
    )

    if transaction_match:

        transaction_code = transaction_match.group()

        cur.execute(
            """
            SELECT
                asset_name,
                module,
                transaction_code,
                script_name
            FROM repository_assets
            WHERE transaction_code = %s
            """,
            (transaction_code,)
        )

        asset = cur.fetchone()

        if asset:

            answer = (
                f"Yes.\n\n"
                f"Transaction: {asset[2]}\n"
                f"Module: {asset[1]}\n"
                f"Asset Name: {asset[0]}\n"
                f"Script: {asset[3]}"
            )

        else:

            answer = (
                f"No repository asset found "
                f"for transaction {transaction_code}."
            )

    else:

        modules = [
            "PM",
            "MM",
            "FI",
            "CO",
            "SD",
            "WM",
            "QM",
            "PP",
            "SCM",
            "LO",
            "TR",
            "PLM",
            "PROC"
        ]

        detected_module = None

        for mod in modules:

            if mod in question_upper:

                detected_module = mod
                break

        if detected_module:

            cur.execute(
                """
                SELECT
                    asset_name
                FROM repository_assets
                WHERE module = %s
                ORDER BY asset_name
                """,
                (detected_module,)
            )

            rows = cur.fetchall()

            if rows:

                answer = (
                    f"{detected_module} Repository Assets:\n\n"
                )

                for row in rows:

                    answer += f"- {row[0]}\n"

            else:

                answer = (
                    f"Module {detected_module} recognized.\n\n"
                    f"No repository assets found yet."
                )

    cur.close()
    conn.close()

    return templates.TemplateResponse(
        request=request,
        name="ai_assistant.html",
        context={"answer": answer}
    )