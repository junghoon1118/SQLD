# src\app.html(본문)을 감싸서 배포용 index.html을 만든다.
# 사용법: powershell -ExecutionPolicy Bypass -File build.ps1
$root = $PSScriptRoot
$src  = [IO.File]::ReadAllText((Join-Path $root 'src\app.html'), [Text.Encoding]::UTF8)
$src  = $src -replace '<meta name="claude:viewport-fit-sides"[^>]*>\r?\n', ''
$cut  = $src.IndexOf('</style>') + '</style>'.Length
$head = $src.Substring(0, $cut)
$body = $src.Substring($cut)

$out = @"
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">
<meta name="description" content="학교 교실을 재현한 SQL 개발자 자격시험 모의고사장. 무작위 좌석, 감독관과 방송, 소음, 문제지와 OMR 답안지, 채점까지.">
<meta name="theme-color" content="#1d2326">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-title" content="모의시험장">
<link rel="manifest" href="manifest.webmanifest">
<link rel="icon" type="image/png" href="icons/icon-192.png">
<link rel="apple-touch-icon" href="icons/icon-192.png">
<style>
*,*::before,*::after{box-sizing:border-box}
:root{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}
body{margin:0;font:14px system-ui,sans-serif}
img{max-width:100%}
[hidden]{display:none!important}
</style>
$head
</head>
<body>
$body
<script>
if ('serviceWorker' in navigator) {
  window.addEventListener('load', function () { navigator.serviceWorker.register('sw.js').catch(function () {}); });
}
</script>
</body>
</html>
"@
[IO.File]::WriteAllText((Join-Path $root 'index.html'), $out, (New-Object Text.UTF8Encoding $false))
Write-Output "index.html 생성 완료"
