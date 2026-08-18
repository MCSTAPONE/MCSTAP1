# services/asset_runner.py


class AssetRunner:

	def run_asset(
	    self,
	    asset_script,
	    session,
	    test_data,
	    runtime
	):
		scope = {}

		exec(
		    asset_script,
		    scope,
		    scope
		)

		if "run" not in scope:
			raise Exception(
			    "Asset script does not contain run()"
			)

		return scope["run"](
		    session,
		    test_data,
            runtime
		)