param(
    [string]$FolderPath,
    [int]$Depth = 0,
    [string]$SortBy = "size"  # "size" or "count"
)

function Get-DirectorySize {
    param (
        [string]$Path
    )
    $size = (Get-ChildItem -File -Recurse -Path $Path | Measure-Object Length -Sum).Sum
    $size / 1MB
}

try {
    # Check if the specified folder path exists
    if (-not (Test-Path -Path $FolderPath -PathType Container)) {
        throw "The specified folder path does not exist."
    }

    $extensionTableData = Get-ChildItem -File -Recurse -Path $FolderPath -ErrorAction SilentlyContinue |
        Group-Object Extension |
        ForEach-Object {
            $extension = $_.Name.TrimStart('.')
            $totalSizeBytes = ($_.Group | Measure-Object Length -Sum).Sum
            $totalSizeMB = [math]::Round($totalSizeBytes / 1MB, 2)  # Convert bytes to megabytes and round to 2 decimal places
            [PSCustomObject]@{
                Extension = $extension
                FileCount = $_.Count
                TotalSizeMB = $totalSizeMB
            }
        }

    if ($SortBy -eq "size") {
        $extensionTableData = $extensionTableData | Sort-Object TotalSizeMB -Descending
    } elseif ($SortBy -eq "count") {
        $extensionTableData = $extensionTableData | Sort-Object FileCount -Descending
    }

    $directoryTableData = Get-ChildItem -Directory -Recurse -Depth $Depth -Path $FolderPath -ErrorAction SilentlyContinue |
        Where-Object { $_.FullName -ne $FolderPath } |
        ForEach-Object {
            $dirPath = $_.FullName
            $dirSizeMB = Get-DirectorySize -Path $dirPath
            $dirSizeMB = [math]::Round($dirSizeMB, 2)  # Round directory size to 2 decimal places
            [PSCustomObject]@{
                Directory = $dirPath
                SizeMB = $dirSizeMB
            }
        } |
        Sort-Object SizeMB -Descending

    Write-Host "File Extension Sizes:"
    $extensionTableData | Format-Table -AutoSize -Property Extension, FileCount, @{Label="Total Size (MB)"; Expression={$_.TotalSizeMB}} -Wrap

    Write-Host "`nDirectory Sizes:"
    $directoryTableData | Format-Table -AutoSize -Property Directory, @{Label="Size (MB)"; Expression={$_.SizeMB}} -Wrap

} catch {
    Write-Host "An error occurred: $_" -ForegroundColor Red
}
