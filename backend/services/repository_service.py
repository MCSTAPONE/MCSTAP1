# -*- coding: utf-8 -*-

from api.database import get_connection


class RepositoryService:

    def get_assets(self):

        conn = get_connection()
        cur = conn.cursor()

        cur.execute(
            """
            SELECT
                asset_id,
                asset_name,
                module,
                transaction_code,
                business_object,
                operation,
                status
            FROM repository_assets
            ORDER BY asset_name
            """
        )

        rows = cur.fetchall()

        cur.close()
        conn.close()

        return rows


    def get_asset(
        self,
        asset_id
    ):

        conn = get_connection()
        cur = conn.cursor()

        cur.execute(
            """
            SELECT
                asset_id,
                asset_name,
                module,
                transaction_code,
                business_object,
                operation,
                description
            FROM repository_assets
            WHERE asset_id = %s
            """,
            (asset_id,)
        )

        row = cur.fetchone()

        cur.close()
        conn.close()

        return row


    def update_asset(
        self,
        asset_id,
        asset_name,
        module,
        transaction_code,
        business_object,
        operation,
        description
    ):

        conn = get_connection()
        cur = conn.cursor()

        cur.execute(
            """
            UPDATE repository_assets
            SET

                asset_name = %s,

                module = %s,

                transaction_code = %s,

                business_object = %s,

                operation = %s,

                description = %s

            WHERE asset_id = %s
            """,
            (
                asset_name,
                module,
                transaction_code,
                business_object,
                operation,
                description,
                asset_id
            )
        )

        conn.commit()

        cur.close()
        conn.close()
	  
    def classify_asset(
	    self,
	    asset_id,
	    business_object,
	    operation
	):

	    conn = get_connection()
	    cur = conn.cursor()

	    cur.execute(
		  """
		  UPDATE repository_assets
		  SET
			business_object = %s,
			operation = %s
		  WHERE asset_id = %s
		  """,
		  (
			business_object,
			operation,
			asset_id
		  )
	    )

	    conn.commit()

	    cur.close()
	    conn.close()