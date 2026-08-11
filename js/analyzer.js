document
.getElementById("analyzeBtn")
.addEventListener(
    "click",
    async function ()
    {

        const fileInputs =
            document.querySelectorAll(
                '#recordingUploads input[type="file"]'
            );

        window.analysisResults = [];

        let validationHtml = "";
        let validSteps = 0;

        let totalActions = 0;
        let totalFields = 0;

        let firstSuccessfulResult = null;

        for (let i = 0; i < fileInputs.length; i++)
        {

            const input = fileInputs[i];

            const expectedTransaction =
                window.flowSteps[i].transaction_code;

            if (
                input.files.length === 0
            )
            {

                validationHtml +=
                    "<div>❌ "
                    + expectedTransaction
                    + " - Missing Recording</div>";

                continue;
            }

            const formData =
                new FormData();

            formData.append(
                "recording_file",
                input.files[0]
            );

            const response =
                await fetch(
                    "/script-studio/analyze",
                    {
                        method: "POST",
                        body: formData
                    }
                );

            const result =
                await response.json();

            if (!result.success)
            {

                validationHtml +=
                    "<div>❌ "
                    + expectedTransaction
                    + " - Analyze Failed</div>";

                continue;
            }

            if (!firstSuccessfulResult)
            {
                firstSuccessfulResult = result;
            }

            window.analysisResults.push(
                result
            );

            totalActions +=
                result.action_count || 0;

            totalFields +=
                result.field_count || 0;

            let status = "❌";

            if (
                result.transaction ===
                expectedTransaction
            )
            {
                status = "✅";
            }

            validationHtml +=
                "<div>"
                +
                status
                +
                " "
                +
                expectedTransaction
                +
                " → "
                +
                result.transaction
                +
                "</div>";

            if (status === "✅")
            {
                validSteps++;
            }

        }

        const expectedSteps =
            window.flowSteps.length;

        let overallStatus =
            validSteps === expectedSteps
            ? "VALID"
            : "INVALID";

        let completion =
            0;

        if (expectedSteps > 0)
        {
            completion = Math.round(
                (
                    validSteps /
                    expectedSteps
                ) * 100
            );
        }

        const flowCompletionElement =
		    document.getElementById(
			  "flowCompletion"
		    );

		if (flowCompletionElement)
		{
		    flowCompletionElement.innerText =
			  completion + "%";
		}

        document
        .getElementById(
            "flowValidation"
        )
        .innerHTML =
            validationHtml
            +
            "<hr>"
            +
            "<b>Overall Flow Status: "
            +
            overallStatus
            +
            "</b>";

        if (!firstSuccessfulResult)
        {

            alert(
                "No valid recordings analyzed."
            );

            return;
        }

        document
        .getElementById(
            "analysisStatus"
        )
        .innerText =
            "SUCCESS";

        document
        .getElementById(
            "detectedTransaction"
        )
        .innerText =
            firstSuccessfulResult.transaction;

        document
        .getElementById(
            "actionCount"
        )
        .innerText =
            totalActions;

        document
        .getElementById(
            "fieldCount"
        )
        .innerText =
            totalFields;

        document
        .getElementById(
            "validationStatus"
        )
        .innerText =
            overallStatus;

        let tableHtml = "";

		window.analysisResults.forEach(
		    result =>
		    {

			  tableHtml +=
				"<tr>" +
				"<td colspan='4' " +
				"style='background:#eef3f8;font-weight:bold;'>" +
				"Transaction: " +
				result.transaction +
				"</td>" +
				"</tr>";

			  result.actions.forEach(
				action =>
				{

				    tableHtml +=
					  "<tr>"
					  +
					  "<td>" + action.seq + "</td>"
					  +
					  "<td>" + action.action + "</td>"
					  +
					  "<td>"
					  +
					  (
						action.field ||
						""
					  )
					  +
					  "</td>"
					  +
					  "<td>"
					  +
					  (
						action.sample_value ||
						""
					  )
					  +
					  "</td>"
					  +
					  "</tr>";

				}
			  );

		    }
		);

        document
        .getElementById(
            "parsedActions"
        )
        .innerHTML =
            tableHtml;

        let fieldHtml = "";

        firstSuccessfulResult.fields.forEach(
            field =>
            {

                fieldHtml +=
                    "<div>✅ "
                    +
                    field.field
                    +
                    "</div>";

            }
        );

        document
        .getElementById(
            "discoveredFields"
        )
        .innerHTML =
            fieldHtml;

        document
        .getElementById(
            "analysisErrors"
        )
        .innerText =
            "No Errors";

        document
        .getElementById(
            "createBtn"
        )
        .disabled = false;

    }
);