# ArtCraft: Image — Regras Numéricas de Colorimetria e Calibração Espectral
### Catálogo Técnico de Parâmetros, Sliders, Fórmulas e Presets para LightCraft & PhotoCraft

Este documento atua como referência de apoio técnico para a skill `artcraft-image`. Ele estabelece os valores numéricos de referência, limites seguros de calibração, fórmulas de compensação de exposição e mapeamento de perfis de cor para as esteiras de produção visual.

---

## 1. Tabela Universal de Temperaturas Kelvin ($K$) e Matiz ($Tint$)

| Cenário de Iluminação | Temperatura Kelvin Alvo ($K$) | Compensação de Tint | Atmosfera Emocional / Perceptual |
| :--- | :--- | :--- | :--- |
| **Vela / Chama Aberta** | $1800\text{ K} \dots 2200\text{ K}$ | $+8 \dots +12$ (Magenta) | Íntimo, acolhedor, romance, histórico. |
| **Lâmpada Incandescente (Tungstênio)** | $2700\text{ K} \dots 3200\text{ K}$ | $+2 \dots +5$ (Magenta) | Calor doméstico, ambiente residencial noturno. |
| **Golden Hour (Nascer / Pôr do Sol)** | $6000\text{ K} \dots 6500\text{ K}$ | $+3 \dots +6$ (Magenta) | Luxo, otimismo, editorial de verão, gastronomia. |
| **Luz Natural Neutra (Sol ao Meio-Dia)** | $5500\text{ K} \dots 5600\text{ K}$ | $0 \dots -2$ (Verde leve) | Neutralidade clínica, e-commerce, lookbooks de moda. |
| **Céu Nublado / Sombra Aberta** | $6500\text{ K} \dots 7500\text{ K}$ | $-2 \dots -4$ (Verde) | Evita que tons frios de sombras fiquem excessivamente azuis. |
| **Hora Azul (Blue Hour / Crepúsculo)** | $3800\text{ K} \dots 4500\text{ K}$ | $-4 \dots -8$ (Ciano/Verde) | Mistério, melancolia, tecnologia, cyberpunk. |
| **Luz Fluorescente Comercial** | $4000\text{ K} \dots 4500\text{ K}$ | $+15 \dots +25$ (Magenta forte) | Corrige a dominante esverdeada de lâmpadas tubulares. |

---

## 2. Fórmulas de Compensação Fotométrica (Exposure Value - EV)

A escala de EV é logarítmica de base 2. Cada acréscimo de $+1.0\text{ EV}$ dobra a intensidade da luz capturada; cada redução de $-1.0\text{ EV}$ reduz a luz à metade.

$$\Delta \text{Luminância} = 2^{\Delta \text{EV}}$$

### Tabela de Compensação Recomendada por Diagnóstico de Cena:

| Sintoma Visual no Histograma | Compensação `light.exposure` | Ajuste de `light.highlights` | Ajuste de `light.shadows` |
| :--- | :--- | :--- | :--- |
| **Foto Subexposta Severa (Histograma colado à esquerda)** | $+1.2 \dots +1.8\text{ EV}$ | $-20$ | $+40 \dots +60$ |
| **Foto Subexposta Leve (Cena escura)** | $+0.4 \dots +0.8\text{ EV}$ | $-10$ | $+20 \dots +30$ |
| **Equilibrada mas com Sombras Duras** | $0.0\text{ EV}$ | $-25$ | $+35 \dots +50$ |
| **Superexposta Leve (Céus quase estourados)** | $-0.4 \dots -0.7\text{ EV}$ | $-40 \dots -70$ | $+15$ |
| **Superexposta Severa (Clipping generalizado)** | $-1.0 \dots -1.5\text{ EV}$ | $-100$ (Recuperação Máx) | $0$ |

---

## 3. Presets Paramétricos Canônicos do LightCraft

Abaixo estão os blocos de configuração prontos para injeção via endpoint `lightcraft:set_develop`:

### 3.1 Preset: `Cinematic_Teal_Orange` (Filmes de Ação / Blockbuster)
Ideal para retratos urbanos e cenas de impacto comercial.

```json
{
  "label": "Cinematic_Teal_Orange",
  "values": {
    "light.exposure": 0.15,
    "light.contrast": 22,
    "light.highlights": -30,
    "light.shadows": 25,
    "light.whites": 10,
    "light.blacks": -15,
    "color.temperature": 5800,
    "color.tint": 2,
    "color.vibrance": 28,
    "color.saturation": -8,
    "detail.sharpening": 50,
    "detail.sharpeningRadius": 0.9
  },
  "settings": {
    "toneCurve": {
      "channel": "Blue",
      "points": [
        {"in": 0.0, "out": 0.05},
        {"in": 0.5, "out": 0.48},
        {"in": 1.0, "out": 0.92}
      ]
    }
  }
}
```

---

### 3.2 Preset: `ECommerce_Clean_Studio` (Produtos, Calçados, Embalagens)
Projetado para fidelidade cromática absoluta sobre fundos brancos ou neutros.

```json
{
  "label": "ECommerce_Clean_Studio",
  "values": {
    "light.exposure": 0.20,
    "light.contrast": 10,
    "light.highlights": -15,
    "light.shadows": 20,
    "light.whites": 5,
    "light.blacks": -5,
    "color.temperature": 5500,
    "color.tint": 0,
    "color.vibrance": 12,
    "color.saturation": 0,
    "detail.sharpening": 60,
    "detail.sharpeningRadius": 0.7,
    "detail.noiseReductionLuminance": 5
  }
}
```

---

### 3.3 Preset: `Moody_Dark_Luxury` (Alta Joalheria, Destilados, Perfumaria Noturna)
Cria contraste dramático e realça reflexos metálicos especulares.

```json
{
  "label": "Moody_Dark_Luxury",
  "values": {
    "light.exposure": -0.30,
    "light.contrast": 35,
    "light.highlights": 15,
    "light.shadows": -10,
    "light.whites": 25,
    "light.blacks": -25,
    "color.temperature": 5200,
    "color.tint": -3,
    "color.vibrance": 15,
    "color.saturation": -12,
    "detail.sharpening": 65,
    "detail.sharpeningRadius": 1.0
  }
}
```

---

## 4. Tabela de Compatibilidade de Espaços de Cor e Profundidade de Bits

| Destino Final da Peça | Formato de Arquivo | Perfil ICC Recomendado | Profundidade | Resolução Recomendada |
| :--- | :--- | :--- | :--- | :--- |
| **Web / Redes Sociais** | `.webp` ou `.jpg` | sRGB | 8-bit | $72 \dots 144\text{ PPI}$ ($1080 \dots 3840\text{ px}$) |
| **Banner Transparente / UI** | `.png` | sRGB (com canal alfa) | 8-bit | $72 \dots 144\text{ PPI}$ ($1920 \times 1080\text{ px}$) |
| **Impressão Fine-Art / Catálogo** | `.tif` (sem perdas) | Adobe RGB (1998) | 16-bit | $300\text{ PPI}$ (tamanho físico em cm) |
| **Material Gráfico Offset / Gráfica** | `.pdf` ou `.tif` | CMYK (FOGRA39 / GRACoL) | 8 ou 16-bit | $300\text{ PPI}$ |
| **Handoff Intermediário na Suíte** | `.png` ou `.tif` | ProPhoto RGB | 16-bit | Resolução nativa de captura |
