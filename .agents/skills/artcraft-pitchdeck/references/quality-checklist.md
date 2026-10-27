# Quality Gate & Checklist de Aceitação Técnica Final

Este documento contém os critérios compulsórios de validação que o agente responsável pelo pipeline `artcraft-pitchdeck` deve executar antes de dar uma entrega como concluída.

---

## 1. Verificações Visuais e Ergonômicas no DeckCraft (Slides 16:9)

- [ ] **Proporção Geométrica Widescreen:** Dimensão confirmada de $960 \times 540\text{ pt}$ em todas as lâminas.
- [ ] **Margens de Respiro:** Nenhum elemento textual ou gráfico encosta nas bordas do slide (reserva mínima de $60\text{ pt}$ nas laterais e $45\text{ pt}$ topo/rodapé).
- [ ] **Regra do 6x6:**
  - Máximo de 6 linhas ou tópicos por slide.
  - Máximo de 6 a 8 palavras por linha de tópico.
  - Ausência de blocos de parágrafos densos que configurem documento de leitura vertical.
- [ ] **Cards de Métricas (Big Numbers):**
  - Valor numérico estilizado com fonte $\ge 44\text{ pt}$ em negrito.
  - Rótulo descritivo com fonte de $12\text{--}14\text{ pt}$.
- [ ] **Gráficos Corporativos Nativos:**
  - Inseridos exclusivamente via `insert_chart` com dados estruturados.
  - Proibido usar capturas de tela rasgadas ou pixeladas de planilhas de terceiros.
- [ ] **Inspeção de Colisão Cartesiana:** Execução de `inspect_slide` confirmando que nenhuma caixa de texto colide ou sobrepõe cartões ou ilustrações.
- [ ] **Prova Visual PNG:** Renderização de prova visual via `render_slide` em ao menos 3 lâminas críticas (Capa, Tração, The Ask).

---

## 2. Verificações Editoriais e Tipográficas no DesignCraft (Anexos & One-Pagers)

- [ ] **Conformidade de Formato:** Folhas padronizadas em A4 ($595 \times 842\text{ pt}$) ou Carta ($612 \times 792\text{ pt}$).
- [ ] **Zero Overset Text (Mandatório):**
  - Chamada de `inspect_document` retornando explicitamente `overset: false` em 100% dos blocos de texto.
  - Nenhuma linha ou nota de rodapé jurídica cortada por limites de frame.
- [ ] **Alinhamento Numérico Tabular:**
  - Valores de moedas e percentuais alinhados rigidamente à direita.
  - Nomes de contas contábeis alinhados à esquerda.
- [ ] **Hierarquia Tipográfica Proporcional:**
  - Corpo de texto entre $9.5\text{ pt}$ e $11\text{ pt}$.
  - Entrelinha (*leading*) entre $135\%$ e $150\%$ do corpo da fonte.
  - Notas de rodapé entre $7.5\text{ pt}$ e $8.5\text{ pt}$.
- [ ] **Prova de Página Renderizada:** Execução de `render_page` atestando harmonia e legibilidade de leitura impressa.

---

## 3. Verificações de Engenharia e Integridade no PdfCraft (Compilação Final)

- [ ] **Sequenciamento Lógico de Páginas:**
  - Slides 16:9 na abertura do documento (Páginas 1 a $N$).
  - Anexos verticais posicionados subsequentemente como apêndices técnicos.
- [ ] **Tamanho e Peso do Arquivo Binário:**
  - Arquivo final com peso rigorosamente inferior a $10.0\text{ MB}$ (permitindo anexo em qualquer provedor de e-mail corporativo).
- [ ] **Otimização de Streams e Redundâncias:**
  - Limpeza de metadados obsoletos via salvamento com descarte de lixo binário (`garbage: 3` ou superior).
  - Compressão de fluxos raster ativa (`deflate: true`).
- [ ] **Linearização Web (Fast Web View):**
  - Documento linearizado permitindo abertura rápida em navegadores sem necessidade de download prévio completo.
- [ ] **Preservação de Camada de Texto Vetorial:**
  - O texto das lâminas e anexos permanece pesquisável e copiável (não rasterizado em imagem única chapada).
- [ ] **Prova de Folha Final:** Execução de `page_render` sobre a página 1 (capa) e sobre a página de encerramento do arquivo unificado.

---

## 4. Checklist de Entrega ao Usuário

- [ ] Arquivo mestre final em PDF disponibilizado com caminho absoluto no protocolo `file:///`.
- [ ] Arquivos-fonte editáveis preservados no diretório do projeto (`.deckcraft` ou `.pptx` e `.designcraft`).
- [ ] Sumário executivo emitido no chat detalhando as métricas de geração e a estrutura de slides entregue.
