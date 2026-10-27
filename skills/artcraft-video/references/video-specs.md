# ArtCraft Video — Referência de Especificações Técnicas Audiovisuais
### Resoluções, Proporções, Taxas de Quadros, Codecs e Calibração Acústica

Este documento serve como referência técnica detalhada para a skill `artcraft-video` e seus aplicativos subordinados (`FilmCraft` e `EffectCraft`).

---

## 1. Tabela Geral de Resoluções e Proporções

| Destino / Plataforma | Formato de Exibição | Proporção (Aspect Ratio) | Resolução Padrão | Resolução 4K / Alta Def. | Safe Area Recomendada |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **YouTube / Vimeo / TV** | Widescreen Paisagem | $16:9$ ($1.77:1$) | $1920 \times 1080\text{ px}$ | $3840 \times 2160\text{ px}$ | Margem interna de $10\%$ em todas as bordas |
| **Instagram Reels** | Retrato Vertical | $9:16$ ($0.56:1$) | $1080 \times 1920\text{ px}$ | — | Topo: $150\text{ px}$, Base: $250\text{ px}$, Laterais: $80\text{ px}$ |
| **TikTok** | Retrato Vertical | $9:16$ ($0.56:1$) | $1080 \times 1920\text{ px}$ | — | Topo: $160\text{ px}$, Base: $280\text{ px}$, Lateral Direita: $120\text{ px}$ |
| **YouTube Shorts** | Retrato Vertical | $9:16$ ($0.56:1$) | $1080 \times 1920\text{ px}$ | — | Topo: $140\text{ px}$, Base: $240\text{ px}$, Laterais: $80\text{ px}$ |
| **Feed Instagram** | Quadrado Clássico | $1:1$ ($1.00:1$) | $1080 \times 1080\text{ px}$ | — | Margem interna de $8\%$ em todas as bordas |
| **Feed Instagram Vertical** | Retrato 4:5 | $4:5$ ($0.80:1$) | $1080 \times 1350\text{ px}$ | — | Margem interna de $10\%$ em todas as bordas |

---

## 2. Taxas de Quadros (Frame Rates) e Cadência Temporal

- **$23.976\text{ fps}$ / $24.0\text{ fps}$ (Padrão Cinematográfico):**
  - Utilizado em produções com apelo estético refinado, documentários e ficção.
  - Exige desfoque de movimento suave (*motion blur*) com ângulo de obturador equivalente a $180^\circ$ ($1/48\text{ s}$).
- **$29.97\text{ fps}$ / $30.0\text{ fps}$ (Padrão Web / Broadcast NTSC):**
  - Padrão oficial para web vídeos, canais de streaming, tutoriais e redes sociais.
  - Oferece equilíbrio ideal entre consumo de processamento e fluidez visual de fala humana.
- **$59.94\text{ fps}$ / $60.0\text{ fps}$ (Alta Fluidez):**
  - Obrigatório para capturas de tela técnica, animações de alta precisão de interface (UI), tutoriais de código e movimentos rápidos.

---

## 3. Matriz de Codecs, Contêineres e Taxas de Bits (Bitrates)

| Finalidade | Contêiner | Codec de Vídeo | Codec de Áudio | Perfil / Subamostragem | Taxa de Bits Alvo (1080p) | Suporte a Canal Alfa |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Entrega Web / Streaming** | `.mp4` | H.264 (AVC) | AAC Estéreo ($320\text{ kbps}$) | High Profile / YUV 4:2:0 | $14\text{ a }18\text{ Mbps}$ | Não |
| **Redes Sociais Mobile** | `.mp4` | H.264 / HEVC | AAC Estéreo ($192\text{ a }256\text{ kbps}$) | Main Profile / YUV 4:2:0 | $10\text{ a }15\text{ Mbps}$ | Não |
| **Handoff EffectCraft $\rightarrow$ FilmCraft** | `.mov` | Apple ProRes 4444 | Sem áudio / PCM | RGBA 4:4:4:4 (12-bit) | VBR alta fidelidade | **Sim (Canal Alfa 8/16-bit)** |
| **Handoff Alternativo com Alfa** | `.png` (seq) | Sequência PNG RGBA | — | 32-bit (24-bit cor + 8-bit alfa) | Lossless comprimido | **Sim (Canal Alfa 8-bit)** |
| **Arquivo Mestre (Master Archive)** | `.mov` | Apple ProRes 422 HQ | PCM 24-bit $48\text{ kHz}$ | YUV 4:2:2 (10-bit) | $\sim 220\text{ Mbps}$ | Não |

---

## 4. Engenharia e Calibração Acústica

### Parâmetros de Loudness Normalizado (EBU R128 / ITU-R BS.1770):
- **Loudness Integrado Alvo (Web/Social):** $-14.0\text{ LUFS}$ ($\pm 1.0\text{ LUFS}$).
- **Loudness Integrado Alvo (Podcasts/Fala):** $-16.0\text{ LUFS}$.
- **Teto Máximo de Pico Verdadeiro (*True Peak*):** $-1.0\text{ dBTP}$ / $-1.0\text{ dBFS}$.
- **Faixa de Tolerância de Faixas Individuais:**
  - `A1` (Voz / Locução Principal): $-6\text{ a }-12\text{ dBFS}$ (RMS) / $-14\text{ a }-18\text{ LUFS}$ integrada.
  - `A2` (Efeitos Sonoros / SFX): $-10\text{ a }-16\text{ dBFS}$ nos picos transitórios.
  - `A3` (Trilha Musical com Ducking): $-20\text{ a }-24\text{ dBFS}$ durante a fala; $-12\text{ a }-14\text{ dBFS}$ nos intervalos de silêncio vocal.

### Parâmetros de Audio Ducking:
- **Fonte de Gatilho (*Trigger / Sidechain*):** Faixa de voz `A1`.
- **Limiar de Detecção (*Threshold*):** $-26.0\text{ dBFS}$.
- **Atenuação da Trilha (*Attenuation*):** $-12.0\text{ dB}$ a $-16.0\text{ dB}$.
- **Tempo de Ataque (*Attack*):** $120\text{ a }180\text{ ms}$ (atenuação suave sem corte abrupto).
- **Tempo de Relaxamento (*Release*):** $450\text{ a }600\text{ ms}$ (retorno musical gradual e imperceptível).
