document
.getElementById("flow_id")
.addEventListener(
    "change",
    function ()
    {

        let flowId = this.value;

        if (!flowId)
        {
            return;
        }

        fetch(
            "/script-studio/flow-steps/" + flowId
        )

        .then(response => response.json())

        .then(data =>
        {

            window.flowSteps = data;

            if (data.length > 0)
            {
                window.expectedTransaction =
                    data[0].transaction_code;
            }

            let stepsHtml = "";
            let uploadHtml = "";

            data.forEach(step =>
            {

                stepsHtml += `
                    <div class="step-card">
                        <div class="step-title">
                            Step ${step.sequence_no}
                        </div>

                        ${step.transaction_code}
                        <br>

                        ${step.description}
                    </div>
                `;

                uploadHtml += `
                    <div class="step-card">

                        <b>
                            ${step.transaction_code}
                        </b>

                        <br>

                        <input
                            type="file"
                            name="recording_${step.sequence_no}"
                            accept=".txt">

                    </div>
                `;

            });

            document
            .getElementById("flowSteps")
            .innerHTML =
                stepsHtml;

            document
            .getElementById("recordingUploads")
            .innerHTML =
                uploadHtml;

        });

    }
);