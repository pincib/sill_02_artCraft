# Referência de Tokens de Layout, Grids e Breakpoints — ArtCraft Frontend UI

Este documento estabelece as tabelas de referência compulsórias para dimensionamento de telas, grids modulares, escalas de espaçamento e tokens de design adotados pela skill `artcraft-frontend`.

---

## 1. Breakpoints e Resoluções Padronizadas

| Dispositivo / Viewport | Resolução do Frame (FigCraft) | Margem Lateral ($padding$) | Colunas do Grid | Calha ($gutter$) |
| :--- | :--- | :--- | :--- | :--- |
| **Mobile Compact (Android)** | $360 \times 800\text{ px}$ | $16\text{ px}$ | 4 colunas | $12\text{ px}$ |
| **Mobile Standard (iPhone)** | $390 \times 844\text{ px}$ | $20\text{ px}$ | 4 colunas | $16\text{ px}$ |
| **Tablet Portrait** | $768 \times 1024\text{ px}$ | $32\text{ px}$ | 8 colunas | $20\text{ px}$ |
| **Laptop / Desktop Standard**| $1440 \times 900\text{ px}$ | $80\text{ px}$ a $120\text{ px}$ | 12 colunas | $24\text{ px}$ |
| **Desktop Widescreen (FHD)** | $1920 \times 1080\text{ px}$ | $120\text{ px}$ a $160\text{ px}$ | 12 colunas | $32\text{ px}$ |

---

## 2. Escala Modular de Espaçamento ($8\text{pt}$ Base Grid)

Todo espaçamento de Auto-Layout (`itemSpacing`, `paddingTop`, `paddingBottom`, `paddingLeft`, `paddingRight`) deve obrigatoriamente pertencer à escala modular abaixo:

| Token | Valor em Pixels | Aplicação Recomendada |
| :--- | :--- | :--- |
| `spacing-3xs` | $2\text{ px}$ | Espaçamentos subpixel e micro-alinhamentos de badges |
| `spacing-2xs` | $4\text{ px}$ | Espaçamento entre ícone e texto compacto |
| `spacing-xs` | $8\text{ px}$ | Gap padrão interno em botões e chips |
| `spacing-sm` | $12\text{ px}$ | Padding vertical em botões médios e inputs |
| `spacing-md` | $16\text{ px}$ | Padding interno de cards e gap entre itens de lista |
| `spacing-lg` | $24\text{ px}$ | Distância entre blocos de cabeçalho e parágrafos |
| `spacing-xl` | $32\text{ px}$ | Margem entre seções secundárias |
| `spacing-2xl` | $48\text{ px}$ | Gap de separação em grids e grupos de conteúdo |
| `spacing-3xl` | $64\text{ px}$ | Padding vertical de seções de página (mobile) |
| `spacing-4xl` | $80\text{ px}$ a $120\text{ px}$ | Padding vertical de seções de página (desktop) |

---

## 3. Escala Tipográfica Harmônica (Major Third - Proporção 1.250)

| Estilo de Texto | Tamanho da Fonte | Entrelinha (*Line-Height*) | Peso (*Font-Weight*) | Tracking |
| :--- | :--- | :--- | :--- | :--- |
| **Display 1** | $48\text{ px}$ | $56\text{ px}$ ($1.16\times$) | 800 (Extra Bold) | $-0.02\text{ em}$ |
| **Heading 1 (H1)** | $38\text{ px}$ | $46\text{ px}$ ($1.21\times$) | 700 (Bold) | $-0.015\text{ em}$ |
| **Heading 2 (H2)** | $30\text{ px}$ | $38\text{ px}$ ($1.26\times$) | 700 (Bold) | $-0.01\text{ em}$ |
| **Heading 3 (H3)** | $24\text{ px}$ | $32\text{ px}$ ($1.33\times$) | 600 (Semi-Bold) | $0.00\text{ em}$ |
| **Heading 4 (H4)** | $20\text{ px}$ | $28\text{ px}$ ($1.40\times$) | 600 (Semi-Bold) | $0.00\text{ em}$ |
| **Body Large** | $18\text{ px}$ | $26\text{ px}$ ($1.44\times$) | 400 (Regular) | $0.00\text{ em}$ |
| **Body Medium (Base)** | $16\text{ px}$ | $24\text{ px}$ ($1.50\times$) | 400 (Regular) | $0.00\text{ em}$ |
| **Body Small** | $14\text{ px}$ | $20\text{ px}$ ($1.42\times$) | 400 (Regular) / 500 (Medium) | $+0.01\text{ em}$ |
| **Caption / Badge** | $12\text{ px}$ | $16\text{ px}$ ($1.33\times$) | 500 (Medium) / 600 (Semi-Bold) | $+0.02\text{ em}$ |
| **Code / Monospace** | $13\text{ px}$ | $20\text{ px}$ ($1.53\times$) | 400 (Regular) | $0.00\text{ em}$ |

---

## 4. Escala de Arredondamento de Cantos (*Border Radius*)

| Token | Valor em Pixels | Aplicação |
| :--- | :--- | :--- |
| `radius-none` | $0\text{ px}$ | Imagens com cantos vivos, divisores retangulares |
| `radius-xs` | $2\text{ px}$ | Marcadores de progresso e tags ultra-compactas |
| `radius-sm` | $4\text{ px}$ | Badges, tooltips e checkboxes |
| `radius-md` | $8\text{ px}$ | Botões padrão, campos de input, selects |
| `radius-lg` | $12\text{ px}$ | Cards de conteúdo, popovers, dropdowns |
| `radius-xl` | $16\text{ px}$ | Modais, dialogs e cards de destaque |
| `radius-2xl` | $24\text{ px}$ | Painéis de onboarding e banners flutuantes |
| `radius-full` | $9999\text{ px}$ | Botões pill, avatares circulares e tags arredondadas |
