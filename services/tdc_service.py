# -*- coding: utf-8 -*-

from api.database import get_connection


class TDCService:

    def get_tdcs(self):

        conn = get_connection()

        cur = conn.cursor()

        cur.execute(
            """
            SELECT
                tdc_id,
                tdc_name,
                business_object,
                description,
                status
            FROM tdc_master
            ORDER BY tdc_name
            """
        )

        rows = cur.fetchall()

        cur.close()
        conn.close()

        return rows

    def create_tdc(
        self,
        tdc_name,
        business_object,
        description
    ):

        conn = get_connection()

        cur = conn.cursor()

        cur.execute(
            """
            INSERT INTO tdc_master
            (
                tdc_name,
                business_object,
                description
            )
            VALUES
            (
                %s,
                %s,
                %s
            )
            """,
            (
                tdc_name,
                business_object,
                description
            )
        )

        conn.commit()

        cur.close()
        conn.close()

    def get_tdc(
        self,
        tdc_id
    ):

        conn = get_connection()

        cur = conn.cursor()

        cur.execute(
            """
            SELECT
                tdc_id,
                tdc_name,
                business_object,
                description,
                status
            FROM tdc_master
            WHERE tdc_id = %s
            """,
            (tdc_id,)
        )

        row = cur.fetchone()

        cur.close()
        conn.close()

        return row
	     

    def get_tdc_values(
        self,
        tdc_id
    ):

        conn = get_connection()

        cur = conn.cursor()

        cur.execute(
            """
            SELECT
                parameter_name,
                parameter_value
            FROM tdc_values
            WHERE tdc_id = %s
            ORDER BY parameter_name
            """,
            (tdc_id,)
        )

        rows = cur.fetchall()

        cur.close()
        conn.close()

        return rows
	  
    def add_tdc_value(
	    self,
	    tdc_id,
	    parameter_name,
	    parameter_value
	):

	    conn = get_connection()

	    cur = conn.cursor()

	    cur.execute(
		  """
		  INSERT INTO tdc_values
		  (
			tdc_id,
			parameter_name,
			parameter_value
		  )
		  VALUES
		  (
			%s,
			%s,
			%s
		  )
		  """,
		  (
			tdc_id,
			parameter_name,
			parameter_value
		  )
	    )

	    conn.commit()

	    cur.close()
	    conn.close()