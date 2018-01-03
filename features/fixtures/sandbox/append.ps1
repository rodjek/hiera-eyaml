$tempfile = [System.IO.Path]::GetTempFileName()
$old_content = $args[1]
$new_content = $args[0]
Get-Content $old_content, $new_content | Set-Content $tempfile
Move-Item $tempfile $old_content -Force
Exit 0
