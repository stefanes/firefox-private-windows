
# Create temporary profile for Firefox
$temporaryProfile = New-TemporaryFile | Rename-Item -NewName { $_.Name -replace '^tmp', 'firefox.' } -PassThru | ForEach-Object {
    Remove-Item $_
    New-Item -ItemType Directory -Path $_
}

# Handle parameters
if ($env:FIREFOX_PATH) {
    $firefox = "$env:FIREFOX_PATH\firefox.exe"
} else {
    $firefox = "$env:USERPROFILE\AppData\Local\Mozilla Firefox\firefox.exe"
}
if ($env:FIREFOX_PRIVATE_WINDOWS_URL) {
    $url = $env:FIREFOX_PRIVATE_WINDOWS_URL
} else {
    $url = "https://web.tabliss.io/"
}

# Launch Firefox with the temporary profile
$params = @(
    '-no-remote'
    '-profile'
    $temporaryProfile.FullName
    '-private-window'
    $url
)
& $firefox @params

# Remove old temporary profiles
Get-ChildItem -Path $temporaryProfile.Parent.FullName -Filter 'firefox.*.tmp' -Directory | Where-Object {
    $_.Name -ne $temporaryProfile.Name
} | Where-Object {
    try {
        [IO.File]::OpenWrite("$($_.FullName)\parent.lock").Close()
        $true
    } catch {
        $false
    }
} | Remove-Item -Recurse -ErrorAction Ignore
