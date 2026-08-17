# -*- coding: utf-8 -*-

from fastapi import APIRouter
from fastapi import Request
from fastapi import Form
from fastapi.responses import RedirectResponse

from api.shared import templates

from services.tdc_service import (
    TDCService
)

router = APIRouter()

service = TDCService()


@router.get("/tdc")
def tdc_library(
    request: Request
):

    tdcs = service.get_tdcs()

    return templates.TemplateResponse(
        request=request,
        name="tdc_library.html",
        context={
            "tdcs": tdcs
        }
    )


@router.get("/tdc/new")
def new_tdc(
    request: Request
):

    return templates.TemplateResponse(
        request=request,
        name="tdc_new.html",
        context={}
    )


@router.post("/tdc/new")
def save_tdc(
    tdc_name: str = Form(...),
    business_object: str = Form(...),
    description: str = Form("")
):

    service.create_tdc(
        tdc_name,
        business_object,
        description
    )

    return RedirectResponse(
        url="/tdc",
        status_code=303
    )


@router.get("/tdc/{tdc_id}")
def tdc_details(
    request: Request,
    tdc_id: int
):

    tdc = service.get_tdc(
        tdc_id
    )

    values = service.get_tdc_values(
        tdc_id
    )

    return templates.TemplateResponse(
        request=request,
        name="tdc_details.html",
        context={
            "tdc": tdc,
            "values": values
        }
    )
    
@router.post("/tdc/{tdc_id}/add-value")
def add_tdc_value(
    tdc_id: int,
    parameter_name: str = Form(...),
    parameter_value: str = Form(...)
):

    service.add_tdc_value(
        tdc_id,
        parameter_name,
        parameter_value
    )

    return RedirectResponse(
        url=f"/tdc/{tdc_id}",
        status_code=303
    )