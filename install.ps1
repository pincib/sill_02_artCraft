# ==============================================================================
# ArtCraft Suite - Automated Installer for Antigravity (Windows)
# ==============================================================================

[CmdletBinding()]
param (
    [switch]$Force,
    [string]$CustomProgramFiles = ""
)

$ErrorActionPreference = "Stop"

function Log-Step([string]$msg) {
    Write-Host "`n[ARTCRAFT] $msg" -ForegroundColor Cyan
}

function Log-OK([string]$msg) {
    Write-Host "  [OK] $msg" -ForegroundColor Green
}

function Log-Warn([string]$msg) {
    Write-Host "  [AVISO] $msg" -ForegroundColor Yellow
}

function Log-Note([string]$msg) {
    Write-Host "  [INFO] $msg" -ForegroundColor Gray
}

Write-Host "=================================================================" -ForegroundColor Magenta
Write-Host "  ArtCraft Multi-Agent Suite - Instalador Automatico (Antigravity)" -ForegroundColor Magenta
Write-Host "=================================================================" -ForegroundColor Magenta

# 1. Definir caminhos base
$ScriptRoot = $PSScriptRoot
if (-not $ScriptRoot) { $ScriptRoot = (Get-Location).Path }

$UserHome = $HOME
$HomeFormatted = $UserHome.Replace("\", "/")
$GeminiConfigDir = Join-Path $UserHome ".gemini\config"
$SkillsTargetDir = Join-Path $GeminiConfigDir "skills"
$McpConfigFile = Join-Path $GeminiConfigDir "mcp_config.json"

Log-Step "1. Verificando ambiente e diretorios do Antigravity..."
if (-not (Test-Path $GeminiConfigDir)) {
    New-Item -ItemType Directory -Path $GeminiConfigDir -Force | Out-Null
    Log-OK "Criado diretorio de configuracao: $GeminiConfigDir"
} else {
    Log-OK "Diretorio de configuracao encontrado: $GeminiConfigDir"
}

if (-not (Test-Path $SkillsTargetDir)) {
    New-Item -ItemType Directory -Path $SkillsTargetDir -Force | Out-Null
    Log-OK "Criado diretorio de skills: $SkillsTargetDir"
}

# 2. Instalacao das Skills
Log-Step "2. Instalando as 6 Skills da Suite ArtCraft..."

$SourceSkillsDir = Join-Path $ScriptRoot "skills"
if (-not (Test-Path $SourceSkillsDir)) {
    $SourceSkillsDir = $ScriptRoot
}

$SkillNames = @(
    "artcraft",
    "artcraft-frontend",
    "artcraft-image",
    "artcraft-pitchdeck",
    "artcraft-sheet",
    "artcraft-video"
)

$InstalledCount = 0
foreach ($skill in $SkillNames) {
    $srcPath = Join-Path $SourceSkillsDir $skill
    if (-not (Test-Path $srcPath)) {
        $srcPath = Join-Path $ScriptRoot $skill
    }

    if (Test-Path $srcPath) {
        $destPath = Join-Path $SkillsTargetDir $skill
        Copy-Item -Path $srcPath -Destination $destPath -Recurse -Force
        Log-OK "Skill instalada: $skill -> $destPath"
        $InstalledCount++
    } else {
        Log-Warn "Origem da skill nao encontrada: $skill"
    }
}
Log-Note "Total de skills instaladas com sucesso: $InstalledCount/6"

# 3. Mapeamento e deteccao de executaveis dos Aplicativos ArtCraft
Log-Step "3. Detectando e configurando servidores MCP dos Aplicativos..."

$PF = if ($CustomProgramFiles) { $CustomProgramFiles } else { "C:/Program Files" }

$McpDefinitions = @{
    "deckcraft" = @{
        "command" = "$PF/DeckCraft/deckcraft-cli.exe"
        "args"    = @("mcp", "--automation-read-root", $HomeFormatted, "--automation-write-root", $HomeFormatted)
    }
    "designcraft" = @{
        "command" = "$PF/DesignCraft/designcraft-cli.exe"
        "args"    = @("mcp", "--automation-read-root", $HomeFormatted, "--automation-write-root", $HomeFormatted)
    }
    "effectcraft" = @{
        "command" = "$PF/EffectCraft/effectcraft-cli.exe"
        "args"    = @("mcp", "--automation-read-root", $HomeFormatted, "--automation-write-root", $HomeFormatted)
    }
    "figcraft" = @{
        "command" = "$PF/FigCraft/figcraft-cli.exe"
        "args"    = @("mcp", "--automation-read-root", $HomeFormatted, "--automation-write-root", $HomeFormatted)
    }
    "filmcraft" = @{
        "command" = "$PF/FilmCraft/filmcraft-cli.exe"
        "args"    = @("mcp", "--compact")
    }
    "gridcraft" = @{
        "command" = "$PF/GridCraft/gridcraft-cli.exe"
        "args"    = @("mcp")
    }
    "lightcraft" = @{
        "command" = "$PF/LightCraft/lightcraft-cli.exe"
        "args"    = @("mcp", "--compact")
    }
    "pdfcraft" = @{
        "command" = "$PF/PdfCraft/pdfcraft-cli.exe"
        "args"    = @("mcp", "--compact", "--automation-read-root", $HomeFormatted, "--automation-write-root", $HomeFormatted)
    }
    "photocraft" = @{
        "command" = "$PF/PhotoCraft/photocraft-cli.exe"
        "args"    = @("mcp", "--automation-read-root", $HomeFormatted, "--automation-write-root", $HomeFormatted)
    }
    "vectorcraft" = @{
        "command" = "$PF/VectorCraft/vectorcraft-cli.exe"
        "args"    = @("mcp", "--headless", "--automation-read-root", $HomeFormatted, "--automation-write-root", $HomeFormatted)
    }
    "wordcraft" = @{
        "command" = "$PF/WordCraft/wordcraft-cli.exe"
        "args"    = @("mcp", "--automation-read-root", $HomeFormatted, "--automation-write-root", $HomeFormatted)
    }
}

# 4. Leitura e Mesclagem com mcp_config.json existente
$ExistingConfig = @{ "mcpServers" = @{} }
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
            $ExistingConfig = $parsed
            Log-Note "Preservando servidores existentes em mcp_config.json"
        }
    } catch {
        Log-Warn "Nao foi possivel analisar $McpConfigFile. Criando backup..."
        Copy-Item -Path $McpConfigFile -Destination "$McpConfigFile.bak" -Force
    }
}

$DetectedApps = 0
foreach ($serverName in $McpDefinitions.Keys) {
    $def = $McpDefinitions[$serverName]
    $exePath = $def["command"]
    $winPath = $exePath.Replace("/", "\")
    
    $exists = Test-Path $winPath
    if ($exists) {
        $DetectedApps++
        Log-OK "App detectado: $serverName ($winPath)"
    } else {
        Log-Note "App ausente no caminho padrao: $serverName"
    }

    $ExistingConfig["mcpServers"][$serverName] = $def
}

# 5. Salvar mcp_config.json atualizado
$JsonOutput = ConvertTo-Json $ExistingConfig -Depth 10
Set-Content -Path $McpConfigFile -Value $JsonOutput -Encoding UTF8
Log-OK "Arquivo mcp_config.json atualizado com sucesso!"

Write-Host "`n=================================================================" -ForegroundColor Green
Write-Host "  INSTALACAO CONCLUIDA COM SUCESSO!" -ForegroundColor Green
Write-Host "=================================================================" -ForegroundColor Green
Write-Host "  * Skills instaladas em: $SkillsTargetDir"
Write-Host "  * Servidores MCP registrados em: $McpConfigFile"
Write-Host "  * Aplicativos ArtCraft detectados: $DetectedApps/11"
Write-Host "`nComo comecar:" -ForegroundColor Cyan
Write-Host "  1. Reinicie sua sessao do Antigravity (ou abra um novo chat)."
Write-Host "  2. Experimente no chat:"
Write-Host "     'ArtCraft: Planeje o lancamento de um produto SaaS com video e pitch deck'"
Write-Host "  3. Ou use qualquer skill especializada diretamente (/artcraft-frontend, etc.)"
Write-Host "=================================================================`n" -ForegroundColor Green
