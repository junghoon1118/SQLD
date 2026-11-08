# 앱 아이콘(192, 512 PNG)을 그린다: 칠판색 바탕 위 OMR 답안지와 칠한 답란 하나.
Add-Type -AssemblyName System.Drawing
$dir = Join-Path $PSScriptRoot 'icons'
New-Item -ItemType Directory -Force $dir | Out-Null

foreach ($size in 192, 512) {
  $bmp = New-Object System.Drawing.Bitmap $size, $size
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = 'AntiAlias'
  $k = $size / 512.0
  $g.Clear([System.Drawing.ColorTranslator]::FromHtml('#2e4a3b'))

  # 답안지 (가운데 안전 영역 안)
  $paper = [System.Drawing.ColorTranslator]::FromHtml('#fffdfa')
  $g.FillRectangle((New-Object System.Drawing.SolidBrush $paper), [float](136*$k), [float](112*$k), [float](240*$k), [float](288*$k))
  $pink = [System.Drawing.ColorTranslator]::FromHtml('#cf3f69')
  $pen = New-Object System.Drawing.Pen $pink, ([float](5*$k))
  $g.DrawRectangle($pen, [float](136*$k), [float](112*$k), [float](240*$k), [float](288*$k))
  # 타이밍 마크
  $black = New-Object System.Drawing.SolidBrush ([System.Drawing.ColorTranslator]::FromHtml('#151515'))
  for ($i = 0; $i -lt 4; $i++) { $g.FillRectangle($black, [float](148*$k), [float]((168 + $i*56)*$k), [float](14*$k), [float](10*$k)) }
  # 답란 4줄 x 4칸, 줄마다 하나씩 칠함
  $filled = @(1, 3, 0, 2)
  for ($r = 0; $r -lt 4; $r++) {
    for ($c = 0; $c -lt 4; $c++) {
      $x = (186 + $c*44) * $k; $y = (150 + $r*56) * $k; $w = 26*$k; $h = 38*$k
      if ($filled[$r] -eq $c) { $g.FillEllipse($black, [float]$x, [float]$y, [float]$w, [float]$h) }
      else { $g.DrawEllipse((New-Object System.Drawing.Pen $pink, ([float](3.5*$k))), [float]$x, [float]$y, [float]$w, [float]$h) }
    }
  }
  $bmp.Save((Join-Path $dir "icon-$size.png"), [System.Drawing.Imaging.ImageFormat]::Png)
  $g.Dispose(); $bmp.Dispose()
}
Write-Output "아이콘 생성 완료"
