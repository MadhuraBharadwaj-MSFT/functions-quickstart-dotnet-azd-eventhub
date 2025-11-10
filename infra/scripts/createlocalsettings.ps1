$ErrorActionPreference = "Stop"

if (-not (Test-Path ".\function-app\local.settings.json"))
{
    $output = azd env get-values

    # Parse the output to get the required values
    foreach ($line in $output) {
        if ($line -match "EVENTHUB_CONNECTION__fullyQualifiedNamespace"){
            $EventHubNamespace = ($line -split "=")[1] -replace '"',''
        }
        if ($line -match "EVENTHUB_NAME"){
            $EventHubName = ($line -split "=")[1] -replace '"',''
        }
        if ($line -match "APPLICATIONINSIGHTS_CONNECTION_STRING"){
            $AppInsightsConnectionString = ($line -split "=")[1] -replace '"',''
        }
        if ($line -match "AZURE_CLIENT_ID"){
            $AzureClientId = ($line -split "=")[1] -replace '"',''
        }
    }

    @{
        "IsEncrypted" = "false";
        "Values" = @{
            "AzureWebJobsStorage" = "UseDevelopmentStorage=true";
            "FUNCTIONS_WORKER_RUNTIME" = "dotnet-isolated";
            "EventHubConnection__fullyQualifiedNamespace" = "$EventHubNamespace";
            "EventHubConnection__clientId" = "$AzureClientId";
            "EventHubConnection__credential" = "managedidentity";
            "EventHubNamespace" = "$EventHubNamespace";
            "EventHubName" = "$EventHubName";
            "APPLICATIONINSIGHTS_CONNECTION_STRING" = "$AppInsightsConnectionString";
            "APPLICATIONINSIGHTS_AUTHENTICATION_STRING" = "ClientId=$AzureClientId;Authorization=AAD";
            "AZURE_CLIENT_ID" = "$AzureClientId";
        }
    } | ConvertTo-Json | Out-File -FilePath ".\function-app\local.settings.json" -Encoding ascii
}