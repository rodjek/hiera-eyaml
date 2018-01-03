$input = $args[0]
[regex]$pattern = "(DEC\(\d+\)::[A-Z0-9]+\[.*?\]\!)"
$tempfile = [System.IO.Path]::GetTempFileName()

Get-Content $input | ForEach-Object { $pattern.Replace($_, {$args[0].Value.ToUpper()}) } | Set-Content $tempfile
Move-Item $tempfile $input -Force
Exit 0
