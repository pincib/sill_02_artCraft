# ==============================================================================
# ArtCraft Suite - Adiciona os CLI executáveis ao PATH do PowerShell
# ==============================================================================
# Execute este script para usar os comandos cli diretamente no seu terminal:
# . .\enable-cli.ps1
# (com ponto no início para carregar as variáveis na sessão atual)
# ==============================================================================

$CraftApps = @(
    "DeckCraft",
    "DesignCraft",
    "EffectCraft",
    "FigCraft",
    "FilmCraft",
    "GridCraft",
    "LightCraft",
    "PdfCraft",
    "PhotoCraft",
    "VectorCraft",
    "WordCraft"
)

$Added = @()
foreach ($app in $CraftApps) {
    $path = "C:\Program Files\$app"
    if (Test-Path $path) {
        if ($env:PATH -notlike "*$path*") {
            $env:PATH = "$path;" + $env:PATH
            $Added += $app
        }
    }
}

Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "  ArtCraft CLI Tools - Sessao Atual" -ForegroundColor Cyan
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "Os seguintes comandos agora estao disponiveis no seu terminal:" -ForegroundColor Green
Write-Host "  • deckcraft-cli"
Write-Host "  • designcraft-cli"
Write-Host "  • effectcraft-cli"
Write-Host "  • figcraft-cli"
Write-Host "  • filmcraft-cli"
Write-Host "  • gridcraft-cli"
Write-Host "  • lightcraft-cli"
Write-Host "  • pdfcraft-cli"
Write-Host "  • photocraft-cli"
Write-Host "  • vectorcraft-cli"
Write-Host "  • wordcraft-cli"
Write-Host "`nExemplo de uso:" -ForegroundColor Yellow
Write-Host "  deckcraft-cli --version"
Write-Host "  vectorcraft-cli info meu-arquivo.svg"
Write-Host "  gridcraft-cli info planilha.xlsx"
Write-Host "=================================================================" -ForegroundColor Cyan
