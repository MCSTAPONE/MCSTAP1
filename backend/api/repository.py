# -*- coding: utf-8 -*-

from fastapi import APIRouter
from fastapi import Request
from fastapi import Form
from fastapi.responses import RedirectResponse

from api.shared import templates

from services.repository_service import (
    RepositoryService
)

router = APIRouter()

service = RepositoryService()


@router.get("/repository")
def repository(
    request: Request
):

    assets = service.get_assets()

    return templates.TemplateResponse(
        request=request,
        name="repository.html",
        context={
            "assets": assets
        }
    )


@router.get("/repository/edit/{asset_id}")
def edit_asset(
    request: Request,
    asset_id: int
):

    asset = service.get_asset(
        asset_id
    )

    return templates.TemplateResponse(
        request=request,
        name="repository_edit.html",
        context={
            "asset": asset
        }
    )


@router.post("/repository/update/{asset_id}")
def update_asset(
    asset_id: int,

    asset_name: str = Form(...),

    module: str = Form(...),

    transaction_code: str = Form(...),

    business_object: str = Form(""),

    operation: str = Form(""),

    description: str = Form("")
):

    service.update_asset(
        asset_id,
        asset_name,
        module,
        transaction_code,
        business_object,
        operation,
        description
    )

    return RedirectResponse(
        url="/repository",
        status_code=303
    )