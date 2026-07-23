# -*- coding: utf-8 -*-

import os
import win32com.client
from sap.sap_client import SAPClient
from sap.sap_login import SAPLogin

from fastapi import FastAPI, Request
from fastapi.templating import Jinja2Templates
from fastapi.staticfiles import StaticFiles
from fastapi.responses import RedirectResponse
from fastapi import Form
from fastapi.responses import RedirectResponse

from api.database import get_connection
from api.routes.sap import router as sap_router
from api.routes.pm import router as pm_router
from api.ai_assistant import router as ai_router
from api.shared import templates
from api.repository import router as repository_router
from api.test_cases import router as test_cases_router
from api.flow_library import router as flow_router
from api.script_studio import router as script_router

from services.script_executor import ScriptExecutor


app = FastAPI(
    title="SAP Automation Platform"
)

app.include_router(sap_router)
app.include_router(pm_router)
app.include_router(ai_router)
app.include_router(repository_router)
app.include_router(test_cases_router)
app.include_router(flow_router)
app.include_router(script_router)

templates = Jinja2Templates(directory="templates")
app.mount(
    "/static",
    StaticFiles(directory="static"),
    name="static"
)

app.mount(
    "/allure",
    StaticFiles(directory="allure-report"),
    name="allure"
)


@app.get("/dashboard")
def dashboard(request: Request):

    return templates.TemplateResponse(
        request=request,
        name="dashboard.html",
        context={
            "title": "MC STAP 1"
        }
    )
    
    
@app.get("/")
def home():

    return {
        "status": "running",
        "application": "MC STAP 1"
    }


@app.get("/health")
def health():

    return {
        "framework": "OK"
    }


@app.get("/coverage")
def coverage():

    conn = get_connection()

    cur = conn.cursor()

    cur.execute(
        """
        SELECT *
        FROM test_steps
        LIMIT 20
        """
    )

    rows = cur.fetchall()

    cur.close()
    conn.close()

    return rows
    
@app.get("/pm")
def pm(request: Request):

    return templates.TemplateResponse(
        request=request,
        name="pm.html",
        context={}
    )
    
@app.get("/pm/execution")
def pm_execution(request: Request):

    return templates.TemplateResponse(
        request=request,
        name="pm_execution.html",
        context={}
    )
    
@app.get("/reports")
def reports(request: Request):

    return templates.TemplateResponse(
        request=request,
        name="reports.html",
        context={}
    )
    
@app.get("/reports/allure")
def allure_report():

    return RedirectResponse(
        url="/allure/index.html"
    )
    
@app.get("/Coverage")
def coverage_page(request: Request):

    return templates.TemplateResponse(
        request=request,
        name="coverage.html",
        context={}
    )

@app.get("/coverage/summary")
def coverage_summary():

    conn = get_connection()

    cur = conn.cursor()

    cur.execute("""
        SELECT COUNT(*)
        FROM test_steps
    """)

    total_steps = cur.fetchone()[0]

    cur.close()
    conn.close()

    return {
        "total_steps": total_steps,
        "automated": total_steps,
        "coverage_percent": 100,
        "modules": 12
    }
    
@app.get("/risk")
def risk_dashboard(request: Request):

    return templates.TemplateResponse(
        request=request,
        name="risk.html",
        context={}
    )


    

    
@app.get("/test-scripts")
def test_scripts(request: Request):

    scripts = [
        ["test_iw31.py", "PM", "IW31", "Active"],
        ["test_iw32.py", "PM", "IW32", "Active"],
        ["test_iw33.py", "PM", "IW33", "Active"],
        ["test_iw39.py", "PM", "IW39", "Active"],
        ["test_iw40.py", "PM", "IW40", "Active"],
        ["test_iw41.py", "PM", "IW41", "Active"],
        ["test_iw23.py", "PM", "IW23", "Active"],
        ["test_me51n.py", "PM", "ME51N", "Active"],
        ["test_ko88.py", "PM", "KO88", "Active"]
    ]

    return templates.TemplateResponse(
        request=request,
        name="test_scripts.html",
        context={
            "scripts": scripts
        }
    )
    


    

    
