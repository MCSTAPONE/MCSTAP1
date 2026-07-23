# -*- coding: utf-8 -*-

import re
import os
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
            context={
                "answer": answer
            }
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

        module = assets[0][1][:2]

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
            context={
                "answer": answer
            }
        )

    # ====================================================
    # FLOW BUILDER RECOMMENDATION ENGINE
    # ====================================================

    if AI_CONTEXT.get("mode") == "FLOW_BUILDER":

        process_name = question.strip()

        conn = get_connection()

        cur = conn.cursor()

        words = process_name.upper().split()

        matching_assets = []

        for word in words:

            cur.execute(
                """
                SELECT
                    asset_name,
                    transaction_code
                FROM repository_assets
                WHERE
                    UPPER(asset_name) LIKE %s
                    OR
                    UPPER(description) LIKE %s
                ORDER BY transaction_code
                """,
                (
                    f"%{word}%",
                    f"%{word}%"
                )
            )

            matches = cur.fetchall()

            for match in matches:

                if match not in matching_assets:

                    matching_assets.append(match)

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

            answer += (
                "Type YES to create this flow."
            )

        else:

            answer = (
                f"No matching repository assets found for:\n\n"
                f"{process_name}"
            )

            AI_CONTEXT.clear()

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
        context={
            "answer": answer
        }
    )