# Firefox Private Windows

Setup to launch multiple [Firefox private windows](https://www.mozilla.org/firefox/features/private-browsing/) using temporary profiles. To use it, start by setting the following environment variables:

- `$env:FIREFOX_PATH` (optional) - Path to the Firefox installation directory, defaults to `$env:USERPROFILE\AppData\Local\Mozilla Firefox`
- `$env:FIREFOX_PRIVATE_WINDOWS_REPO_PATH` (required) - Path to the local repo, e.g. `C:\github\firefox-private-windows`
- `$env:FIREFOX_PRIVATE_WINDOWS_URL`  (optional) - The start URL for new private windows, defaults to [`https://web.tabliss.io`](https://web.tabliss.io)

With the above environment variables in place, create a shortcut (e.g. on your _Start Menu_ or _Task Bar_) using the following values:

**Target:**

```shell
C:\Windows\System32\cmd.exe /c start /min "" powershell -NoLogo -NoProfile -WindowStyle Hidden -File "%FIREFOX_PRIVATE_WINDOWS_REPO_PATH%\firefox.ps1"
```

**Start in:**

```text
"%USERPROFILE%\AppData\Local\Mozilla Firefox"
```

Or if you have Firefox installed in a non-default location:

```text
%FIREFOX_PATH%
```

**Icon:**

Click _Change Icon..._ and give it the path: `%FIREFOX_PRIVATE_WINDOWS_REPO_PATH%\firefox.ico`
