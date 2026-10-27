# Regras de Operação da Suíte ArtCraft

Estas regras são aplicadas automaticamente a qualquer agente trabalhando neste repositório ou utilizando a suíte ArtCraft.

## 1. Princípio da Especialização Estrita e Fronteiras Operacionais
Cada um dos 10 aplicativos possui escopo soberano e inviolável. É terminantemente proibido desviar tarefas para ferramentas inadequadas:

| Ferramenta | Escopo Exclusivo | Proibições Estritas |
| :--- | :--- | :--- |
| **FilmCraft** | Edição não-linear de vídeo, corte rítmico, montagem de timeline, mixagem de áudio multipista. | Não criar motion graphics complexos, vinhetas procedurais ou efeitos 3D. |
| **EffectCraft** | Motion design, vinhetas animadas, lower-thirds, tracking, partículas, composição em camadas. | Não fazer corte de narrativa longa ou edição contínua de podcast/aulas. |
| **PhotoCraft** | Manipulação raster estrutural, máscaras de recorte, montagens em camadas, smart objects, remoção de elementos. | Não fazer revelação tonal primária em lote ou calibração de balanço térmico RAW. |
| **LightCraft** | Revelação não-destrutiva de fotos, calibração EV, curvas tonais RGB, color grading cinematográfico, redução de ruído. | Não fazer fotomontagem em camadas, recortes complexos ou inserção de tipografia. |
| **VectorCraft** | Desenho vetorial de precisão, logos, ícones SVG, grafismos, ilustração plana. | Não criar layouts inteiros de telas de app/web nem diagramar páginas editoriais. |
| **FigCraft** | Design de UI/UX, frames de telas, auto-layout atômico, hierarquia de componentes. | Não desenhar ícones complexos do zero nem diagramar impressos editoriais densos. |
| **DesignCraft** | Diagramação editorial densa, styleguides com tokens CSS, catálogos, relatórios paginados. | Não montar telas com auto-layout interativo de UI nem criar apresentações de slides. |
| **DeckCraft** | Apresentações executivas 16:9, pitch decks, narrativa visual e slides para investidores. | Não diagramar relatórios densos com grids editoriais de página vertical (A4/Letter). |
| **PdfCraft** | Compilação final de PDFs, fusão, reordenação de páginas, compressão e validação PDF/A. | Não editar conteúdo vetorial ou criar apresentações do zero. |
| **GridCraft** | Modelagem financeira, projeções tabulares (DCF), análise de cohort, fórmulas estatísticas. | Não diagramar visualmente slides ou relatórios finais. |

## 2. Protocolo de Execução MCP
- Quando uma tarefa exigir manipulação de ativos (slides, vetores, fotos, vídeos, planilhas, PDFs), utilize as ferramentas de MCP correspondentes disponíveis.
- Siga rigorosamente os contratos de handoff definidos no manifesto do projeto (`project-manifest.json`).
- Sempre verifique o resultado visual (`render_slide`, `render_frame`, `render_page`, `render_photo` ou inspeção estrutural) antes de concluir a etapa.

## 3. Preservação de Qualidade e Integridade
- Todas as exportações para entrega devem obedecer aos padrões de qualidade descritos nas skills especializadas.
- Garanta contraste acessível (WCAG AA/AAA no frontend) e legibilidade impecável em slides (regra 6x6 no DeckCraft).
