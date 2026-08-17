# -*- coding: utf-8 -*-


def get_e2e_process(process_name):

    processes = {

        "PROCURE TO PAY": [
            "Purchase Requisition",
            "Purchase Order",
            "Goods Receipt",
            "Vendor Invoice",
            "Vendor Payment"
        ],

        "ORDER TO CASH": [
            "Quotation",
            "Sales Order",
            "Delivery",
            "Billing",
            "Incoming Payment"
        ],

        "RECORD TO REPORT": [
            "Journal Entry",
            "General Ledger",
            "Financial Closing",
            "Financial Reporting"
        ],

        "HIRE TO RETIRE": [
            "Recruitment",
            "Hiring",
            "Employee Administration",
            "Payroll",
            "Retirement"
        ]
    }

    return processes.get(
        process_name.upper()
    )