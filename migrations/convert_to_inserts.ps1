
# convert_to_inserts.ps1
# Converts PostgreSQL COPY format from product_details.sql into INSERT statements
# Output: migrations/02_categories.sql, 03_templates.sql, 04_variants.sql

$sqlFile = Join-Path $PSScriptRoot "..\product_details.sql"
$outDir  = $PSScriptRoot

Write-Host "Reading $sqlFile ..."
$lines = Get-Content $sqlFile -Encoding UTF8

# ─── helpers ────────────────────────────────────────────────────────────────

function Escape-Sql([string]$val) {
    return $val.Replace("'", "''")
}

function Tab-To-Values([string]$line, [string[]]$cols) {
    $parts = $line -split "`t"
    $values = @()
    for ($i = 0; $i -lt $cols.Length; $i++) {
        $raw = if ($i -lt $parts.Length) { $parts[$i] } else { '\N' }
        if ($raw -eq '\N') {
            $values += 'NULL'
        } elseif ($raw -eq 't') {
            $values += 'TRUE'
        } elseif ($raw -eq 'f') {
            $values += 'FALSE'
        } elseif ($raw -match '^\d+(\.\d+)?$') {
            $values += $raw
        } else {
            # Escape single quotes, wrap in single quotes
            $values += "'" + (Escape-Sql $raw) + "'"
        }
    }
    return "(" + ($values -join ', ') + ")"
}

# ─── parse sections ──────────────────────────────────────────────────────────

$sections = @{
    'product_categories' = @{ cols = @('"categoryId"','code','name','"parentCategoryId"','"createdAt"'); rows = @() }
    'product_templates'  = @{ cols = @('"templateId"','"skuFamily"','name','brand','"categoryId"','"itemType"','"isConfigurable"','description','"createdAt"','"updatedAt"'); rows = @() }
    'product_variants'   = @{ cols = @('"variantId"','"templateId"','sku','"variantName"','finish','color','size','uom','"catalogPrice"','"showroomPrice"','"taxPercent"','"isSellable"','"isStockTracked"','attributes','"createdAt"','"updatedAt"','"clearancePrice"'); rows = @() }
}

$currentTable = $null
$inCopy = $false

foreach ($line in $lines) {
    if ($line -match "^COPY public\.(\w+) .* FROM stdin;") {
        $tbl = $Matches[1]
        if ($sections.ContainsKey($tbl)) {
            $currentTable = $tbl
            $inCopy = $true
        }
        continue
    }
    if ($inCopy) {
        if ($line -eq '\.') {
            $inCopy = $false
            $currentTable = $null
            continue
        }
        if ($currentTable -and $line.Trim() -ne '') {
            $sections[$currentTable].rows += $line
        }
    }
}

Write-Host "Categories: $($sections['product_categories'].rows.Count) rows"
Write-Host "Templates : $($sections['product_templates'].rows.Count) rows"
Write-Host "Variants  : $($sections['product_variants'].rows.Count) rows"

# ─── write output files ──────────────────────────────────────────────────────

function Write-SqlFile([string]$path, [string]$table, [hashtable]$section, [int]$batchSize = 200) {
    $cols    = $section.cols
    $rows    = $section.rows
    $colList = $cols -join ', '
    $out     = @()
    $out    += "-- Auto-generated INSERT statements for $table"
    $out    += "-- Total rows: $($rows.Count)"
    $out    += ""

    $batch = @()
    $batchNum = 0

    foreach ($row in $rows) {
        $vals = Tab-To-Values $row $cols
        $batch += $vals
        if ($batch.Count -ge $batchSize) {
            $out += "INSERT INTO public.$table ($colList) VALUES"
            $out += ($batch -join ",`n") + ";"
            $out += ""
            $batch = @()
            $batchNum++
            Write-Host "  Written batch $batchNum for $table"
        }
    }
    if ($batch.Count -gt 0) {
        $out += "INSERT INTO public.$table ($colList) VALUES"
        $out += ($batch -join ",`n") + ";"
        $out += ""
    }

    $out += "SELECT '$table data loaded: $($rows.Count) rows' AS status;"
    $out | Set-Content -Path $path -Encoding UTF8
    Write-Host "Written: $path"
}

# Categories
Write-SqlFile `
    (Join-Path $outDir "02_categories.sql") `
    "product_categories" `
    $sections['product_categories']

# Templates
Write-SqlFile `
    (Join-Path $outDir "03_templates.sql") `
    "product_templates" `
    $sections['product_templates']

# Variants (larger - use smaller batches)
Write-SqlFile `
    (Join-Path $outDir "04_variants.sql") `
    "product_variants" `
    $sections['product_variants'] `
    100

Write-Host ""
Write-Host "Done! Now run in Supabase SQL Editor (in order):"
Write-Host "  1. migrations/01_schema.sql"
Write-Host "  2. migrations/02_categories.sql"
Write-Host "  3. migrations/03_templates.sql"
Write-Host "  4. migrations/04_variants.sql"
