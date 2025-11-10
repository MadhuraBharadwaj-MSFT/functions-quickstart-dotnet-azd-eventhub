Write-Host "Deployment completed successfully!" -ForegroundColor Green
Write-Host ""

# Get the outputs from the deployment
$outputs = azd env get-values --output json | ConvertFrom-Json

Write-Host "News Streaming System deployed successfully!" -ForegroundColor Yellow
Write-Host ""
Write-Host "System components:" -ForegroundColor Cyan
Write-Host "  � News Generator Function: Generates 3-8 news articles every 10 seconds" -ForegroundColor White
Write-Host "  🔄 News Processor Function: Processes articles from Event Hub with sentiment analysis" -ForegroundColor White
Write-Host "  📨 Event Hub: $($outputs.EVENTHUB_NAME)" -ForegroundColor White
Write-Host "  🌐 Event Hub Namespace: $($outputs.EVENTHUB_CONNECTION__fullyQualifiedNamespace)" -ForegroundColor White
Write-Host ""
Write-Host "🚀 Both functions are now running in Azure!" -ForegroundColor Green
Write-Host ""
Write-Host "To monitor the system:" -ForegroundColor Yellow
Write-Host "  1. View Function App logs in Azure Portal" -ForegroundColor White
Write-Host "  2. Check Application Insights for real-time metrics" -ForegroundColor White
Write-Host "  3. Monitor Event Hub message flow (32 partitions)" -ForegroundColor White
Write-Host ""
Write-Host "Expected behavior:" -ForegroundColor Cyan
Write-Host "  • News Generator creates 3-8 realistic articles every 10 seconds" -ForegroundColor White
Write-Host "  • News Processor analyzes sentiment and detects viral content" -ForegroundColor White
Write-Host "  • View processing logs with emojis (📰 😊 � � 📊)" -ForegroundColor White
Write-Host "  • High throughput: ~180-270 articles/minute" -ForegroundColor White
Write-Host ""
Write-Host "Function App Name: $($outputs.SERVICE_API_NAME)" -ForegroundColor Yellow

# Create local.settings.json for local development
Write-Host ""
Write-Host "Setting up local development environment..." -ForegroundColor Cyan
& "$PSScriptRoot\createlocalsettings.ps1"