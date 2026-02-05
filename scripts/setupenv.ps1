# Script to append or update NEW_CHAT_BUTTON_XPATH in the AutoEval .env file

$envFilePath = "C:\Users\LabUser\AppData\Local\Programs\AutoEval\resources\app.asar.unpacked\CopilotAgentEval\.env"
$lineToAppend = 'NEW_CHAT_BUTTON_XPATH="//button[@id=''new-chat-button'' or @data-automation-id=''newChatButton'']"'

# Check if the file exists
if (Test-Path $envFilePath) {
    $content = Get-Content $envFilePath -Raw
    if ($content -match "NEW_CHAT_BUTTON_XPATH") {
        # Replace the existing line
        $newContent = $content -replace "NEW_CHAT_BUTTON_XPATH.*", $lineToAppend
        Set-Content -Path $envFilePath -Value $newContent.TrimEnd()
        Write-Host "Successfully updated NEW_CHAT_BUTTON_XPATH in .env file" -ForegroundColor Green
    } else {
        # Append the new line
        Add-Content -Path $envFilePath -Value $lineToAppend
        Write-Host "Successfully appended NEW_CHAT_BUTTON_XPATH to .env file" -ForegroundColor Green
    }
} else {
    Write-Host "Error: .env file not found at $envFilePath" -ForegroundColor Red
    exit 1
}