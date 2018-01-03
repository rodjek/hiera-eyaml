[regex]$pattern = $args[0]
$replacement = $args[1]
$input = $args[2]
$tempfile = [System.IO.Path]::GetTempFileName()

Get-Content $input | ForEach-Object { $pattern.Replace($_, {$replacement}) } | Set-Content $tempfile
Move-Item $tempfile $input -Force
Exit 0
