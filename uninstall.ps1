# ==============================================================================
# ArtCraft Suite - Automated Uninstaller for Antigravity (Windows)
# ==============================================================================

[CmdletBinding()]
param ()

$ErrorActionPreference = "Stop"

function Log-Step([string]$msg) {
    Write-Host "`n[ARTCRAFT] $msg" -ForegroundColor Cyan
}

function Log-OK([string]$msg) {
    Write-Host "  [OK] $msg" -ForegroundColor Green
}

function Log-Note([string]$msg) {
    Write-Host "  [INFO] $msg" -ForegroundColor Gray
}

Write-Host "=================================================================" -ForegroundColor Magenta
Write-Host "  ArtCraft Multi-Agent Suite - Desinstalador (Windows)" -ForegroundColor Magenta
Write-Host "=================================================================" -ForegroundColor Magenta

$UserHome = $HOME
$GeminiConfigDir = Join-Path $UserHome ".gemini\config"
$SkillsTargetDir = Join-Path $GeminiConfigDir "skills"
$McpConfigFile = Join-Path $GeminiConfigDir "mcp_config.json"

$SkillNames = @(
    "artcraft",
    "artcraft-frontend",
    "artcraft-image",
    "artcraft-pitchdeck",
    "artcraft-sheet",
    "artcraft-video"
)

$CraftServerNames = @(
    "deckcraft",
    "designcraft",
    "effectcraft",
    "figcraft",
    "filmcraft",
    "gridcraft",
    "lightcraft",
    "pdfcraft",
    "photocraft",
    "vectorcraft",
    "wordcraft"
)

Log-Step "1. Removendo skills instaladas..."
foreach ($skill in $SkillNames) {
    $target = Join-Path $SkillsTargetDir $skill
    if (Test-Path $target) {
        Remove-Item -Path $target -Recurse -Force
        Log-OK "Removida: $skill"
    }
}

Log-Step "2. Limpando entradas dos servidores ArtCraft em mcp_config.json..."
if (Test-Path $McpConfigFile) {
    try {
        $raw = Get-Content -Path $McpConfigFile -Raw -Encoding UTF8
        $supportsAsHashtable = (Get-Command ConvertFrom-Json).Parameters.ContainsKey("AsHashtable")
        if ($supportsAsHashtable) {
            $parsed = ConvertFrom-Json $raw -AsHashtable
        } else {
            $parsedObj = ConvertFrom-Json $raw
            $parsed = @{ "mcpServers" = @{} }
            if ($parsedObj.mcpServers) {
                foreach ($prop in $parsedObj.mcpServers.PSObject.Properties) {
                    $parsed["mcpServers"][$prop.Name] = $prop.Value
                }
            }
        }

        if ($parsed -and $parsed.ContainsKey("mcpServers")) {
            foreach ($s in $CraftServerNames) {
                if ($parsed["mcpServers"].ContainsKey($s)) {
                    $parsed["mcpServers"].Remove($s)
                    Log-OK "Removido servidor MCP: $s"
                }
            }
            $JsonOutput = ConvertTo-Json $parsed -Depth 10
            Set-Content -Path $McpConfigFile -Value $JsonOutput -Encoding UTF8
            Log-OK "Arquivo mcp_config.json atualizado!"
        }
    } catch {
        Log-Note "Nao foi possivel atualizar mcp_config.json automaticamente."
    }
}

Write-Host "`n[OK] Desinstalacao concluida." -ForegroundColor Green
