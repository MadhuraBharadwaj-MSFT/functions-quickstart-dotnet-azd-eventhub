#!/bin/bash
set -e

if [ ! -f "./function-app/local.settings.json" ]; then
    output=$(azd env get-values)

    # Parse the output to get the required values
    EventHubNamespace=$(echo "$output" | grep "EVENTHUB_CONNECTION__fullyQualifiedNamespace" | cut -d'=' -f2 | tr -d '"')
    EventHubName=$(echo "$output" | grep "EVENTHUB_NAME" | cut -d'=' -f2 | tr -d '"')
    AppInsightsConnectionString=$(echo "$output" | grep "APPLICATIONINSIGHTS_CONNECTION_STRING" | cut -d'=' -f2 | tr -d '"')
    AzureClientId=$(echo "$output" | grep "AZURE_CLIENT_ID" | cut -d'=' -f2 | tr -d '"')

    cat <<EOF > ./function-app/local.settings.json
{
    "IsEncrypted": "false",
    "Values": {
        "AzureWebJobsStorage": "UseDevelopmentStorage=true",
        "FUNCTIONS_WORKER_RUNTIME": "dotnet-isolated",
        "EventHubConnection__fullyQualifiedNamespace": "$EventHubNamespace",
        "EventHubConnection__clientId": "$AzureClientId",
        "EventHubConnection__credential": "managedidentity",
        "EventHubNamespace": "$EventHubNamespace",
        "EventHubName": "$EventHubName",
        "APPLICATIONINSIGHTS_CONNECTION_STRING": "$AppInsightsConnectionString",
        "APPLICATIONINSIGHTS_AUTHENTICATION_STRING": "ClientId=$AzureClientId;Authorization=AAD",
        "AZURE_CLIENT_ID": "$AzureClientId"
    }
}
EOF
fi