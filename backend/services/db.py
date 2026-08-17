import psycopg2


def get_connection():
    return psycopg2.connect(
        host="localhost",
        database="sap_automation",
        user="postgres",
        password="Podravka"
    )