# -*- coding: utf-8 -*-
#sdc.py

from datetime import datetime
from datetime import timezone

from fastapi import APIRouter
from fastapi import HTTPException
from fastapi import Request
from api.shared import templates
from pydantic import BaseModel
from pydantic import Field

from api.database import get_connection


router = APIRouter(
    prefix="/api/sdc",
    tags=["System Data Containers"]
)

page_router = APIRouter(
    tags=["System Data Container Pages"]
)

@page_router.get("/sdc")
def sdc_page(request: Request):
    return templates.TemplateResponse(
        request=request,
        name="sdc.html",
        context={}
    )


ALLOWED_ENVIRONMENTS = {
    "DEV",
    "QA",
    "UAT",
    "PREPROD",
    "PROD",
    "SANDBOX"
}

ALLOWED_STATUSES = {
    "Active",
    "Inactive"
}


class SDCCreateRequest(BaseModel):

    sdc_name: str = Field(
        min_length=1,
        max_length=100
    )

    environment: str = Field(
        min_length=1,
        max_length=30
    )

    sap_logon_entry: str = Field(
        min_length=1,
        max_length=100
    )

    sap_system_id: str | None = Field(
        default=None,
        max_length=20
    )

    client: str = Field(
        min_length=1,
        max_length=10
    )

    language: str = Field(
        default="EN",
        min_length=1,
        max_length=10
    )

    description: str | None = None

    status: str = Field(
        default="Active",
        max_length=20
    )


class SDCStatusRequest(BaseModel):

    status: str


def row_to_sdc(
    row
):

    if not row:

        return None

    return {
        "sdc_id": row[0],
        "sdc_name": row[1],
        "environment": row[2],
        "sap_logon_entry": row[3],
        "sap_system_id": row[4],
        "client": row[5],
        "language": row[6],
        "description": row[7],
        "status": row[8],
        "created_at": row[9],
        "updated_at": row[10]
    }



@router.get("")
def list_sdcs():

    conn = get_connection()
    cur = conn.cursor()

    try:

        cur.execute(
            """
            SELECT
                sdc_id,
                sdc_name,
                environment,
                sap_logon_entry,
                sap_system_id,
                client,
                language,
                description,
                status,
                created_at,
                updated_at
            FROM sdc_master
            ORDER BY sdc_name
            """
        )

        rows = cur.fetchall()

        return {
            "count": len(rows),
            "items": [
                row_to_sdc(row)
                for row in rows
            ]
        }

    finally:

        cur.close()
        conn.close()


@router.get("/active")
def list_active_sdcs():

    conn = get_connection()
    cur = conn.cursor()

    try:

        cur.execute(
            """
            SELECT
                sdc_id,
                sdc_name,
                environment,
                sap_logon_entry,
                sap_system_id,
                client,
                language,
                description,
                status,
                created_at,
                updated_at
            FROM sdc_master
            WHERE status = 'Active'
            ORDER BY sdc_name
            """
        )

        rows = cur.fetchall()

        return {
            "count": len(rows),
            "items": [
                row_to_sdc(row)
                for row in rows
            ]
        }

    finally:

        cur.close()
        conn.close()


@router.get("/{sdc_id}")
def get_sdc(
    sdc_id: int
):

    conn = get_connection()
    cur = conn.cursor()

    try:

        cur.execute(
            """
            SELECT
                sdc_id,
                sdc_name,
                environment,
                sap_logon_entry,
                sap_system_id,
                client,
                language,
                description,
                status,
                created_at,
                updated_at
            FROM sdc_master
            WHERE sdc_id = %s
            """,
            (
                sdc_id,
            )
        )

        row = cur.fetchone()

        if not row:

            raise HTTPException(
                status_code=404,
                detail=(
                    f"SDC with ID {sdc_id} "
                    "was not found."
                )
            )

        return row_to_sdc(
            row
        )

    finally:

        cur.close()
        conn.close()


@router.post(
    "",
    status_code=201
)
def create_sdc(
    request: SDCCreateRequest
):

    sdc_name = request.sdc_name.strip()

    environment = (
        request.environment
        .strip()
        .upper()
    )

    sap_logon_entry = (
        request.sap_logon_entry
        .strip()
    )

    sap_system_id = (
        request.sap_system_id.strip().upper()
        if request.sap_system_id
        else None
    )

    client = request.client.strip()

    language = (
        request.language
        .strip()
        .upper()
    )

    description = (
        request.description.strip()
        if request.description
        else None
    )

    status = request.status.strip().title()

    if environment not in ALLOWED_ENVIRONMENTS:

        raise HTTPException(
            status_code=400,
            detail=(
                "Invalid environment. Allowed values: "
                + ", ".join(
                    sorted(ALLOWED_ENVIRONMENTS)
                )
            )
        )

    if status not in ALLOWED_STATUSES:

        raise HTTPException(
            status_code=400,
            detail=(
                "Invalid status. Allowed values: "
                "Active or Inactive."
            )
        )

    if not client.isdigit():

        raise HTTPException(
            status_code=400,
            detail=(
                "SAP client must contain "
                "digits only."
            )
        )

    conn = get_connection()
    cur = conn.cursor()

    try:

        cur.execute(
            """
            SELECT
                sdc_id
            FROM sdc_master
            WHERE LOWER(sdc_name) = LOWER(%s)
            """,
            (
                sdc_name,
            )
        )

        duplicate = cur.fetchone()

        if duplicate:

            raise HTTPException(
                status_code=409,
                detail=(
                    f"SDC '{sdc_name}' "
                    "already exists."
                )
            )

        cur.execute(
            """
            INSERT INTO sdc_master
            (
                sdc_name,
                environment,
                sap_logon_entry,
                sap_system_id,
                client,
                language,
                description,
                status,
                updated_at
            )
            VALUES
            (
                %s,
                %s,
                %s,
                %s,
                %s,
                %s,
                %s,
                %s,
                %s
            )
            RETURNING
                sdc_id,
                sdc_name,
                environment,
                sap_logon_entry,
                sap_system_id,
                client,
                language,
                description,
                status,
                created_at,
                updated_at
            """,
            (
                sdc_name,
                environment,
                sap_logon_entry,
                sap_system_id,
                client,
                language,
                description,
                status,
                datetime.now(
                    timezone.utc
                )
            )
        )

        row = cur.fetchone()

        conn.commit()

        return row_to_sdc(
            row
        )

    except HTTPException:

        conn.rollback()
        raise

    except Exception:

        conn.rollback()

        raise HTTPException(
            status_code=500,
            detail=(
                "SDC could not be created."
            )
        )

    finally:

        cur.close()
        conn.close()


@router.put(
    "/{sdc_id}/status"
)
def update_sdc_status(
    sdc_id: int,
    request: SDCStatusRequest
):

    status = request.status.strip().title()

    if status not in ALLOWED_STATUSES:

        raise HTTPException(
            status_code=400,
            detail=(
                "Invalid status. Allowed values: "
                "Active or Inactive."
            )
        )

    conn = get_connection()
    cur = conn.cursor()

    try:

        cur.execute(
            """
            UPDATE sdc_master
            SET
                status = %s,
                updated_at = %s
            WHERE sdc_id = %s
            RETURNING
                sdc_id,
                sdc_name,
                environment,
                sap_logon_entry,
                sap_system_id,
                client,
                language,
                description,
                status,
                created_at,
                updated_at
            """,
            (
                status,
                datetime.now(
                    timezone.utc
                ),
                sdc_id
            )
        )

        row = cur.fetchone()

        if not row:

            conn.rollback()

            raise HTTPException(
                status_code=404,
                detail=(
                    f"SDC with ID {sdc_id} "
                    "was not found."
                )
            )

        conn.commit()

        return row_to_sdc(
            row
        )

    except HTTPException:

        raise

    except Exception:

        conn.rollback()

        raise HTTPException(
            status_code=500,
            detail=(
                "SDC status could not be updated."
            )
        )

    finally:

        cur.close()
        conn.close()