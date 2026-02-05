# Script to append or update NEW_CHAT_BUTTON_XPATH in the AutoEval .env file

$envFilePath = "C:\Users\LabUser\AppData\Local\Programs\AutoEval\resources\app.asar.unpacked\CopilotAgentEval\.env"
$lineToAppend = 'NEW_CHAT_BUTTON_XPATH="//button[@id=''new-chat-button'' or @data-automation-id=''newChatButton'']"'

# Check if the file exists
if (Test-Path $envFilePath) {
    try {
        # Check if file is read-only and remove the attribute
        $fileItem = Get-Item $envFilePath
        $wasReadOnly = $fileItem.IsReadOnly
        if ($wasReadOnly) {
            Set-ItemProperty -Path $envFilePath -Name IsReadOnly -Value $false
        }

        $content = Get-Content $envFilePath -Raw
        if ($content -match "NEW_CHAT_BUTTON_XPATH") {
            # Replace the existing line
            $newContent = $content -replace "NEW_CHAT_BUTTON_XPATH.*", $lineToAppend
            Set-Content -Path $envFilePath -Value $newContent.TrimEnd() -ErrorAction Stop
            Write-Host "Successfully updated NEW_CHAT_BUTTON_XPATH in .env file" -ForegroundColor Green
        } else {
            # Append the new line
            Add-Content -Path $envFilePath -Value $lineToAppend -ErrorAction Stop
            Write-Host "Successfully appended NEW_CHAT_BUTTON_XPATH to .env file" -ForegroundColor Green
        }

        # Restore read-only attribute if it was set
        if ($wasReadOnly) {
            Set-ItemProperty -Path $envFilePath -Name IsReadOnly -Value $true
        }
    } catch {
        Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
        # Try to restore read-only attribute even if there was an error
        if ($wasReadOnly) {
            Set-ItemProperty -Path $envFilePath -Name IsReadOnly -Value $true -ErrorAction SilentlyContinue
        }
        exit 1
    }
} else {
    Write-Host "Error: .env file not found at $envFilePath" -ForegroundColor Red
    exit 1
}