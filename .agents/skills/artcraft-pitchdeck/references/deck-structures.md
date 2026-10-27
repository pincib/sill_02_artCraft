# Modelos e Roteiros Canônicos de Apresentação (Pitch Deck Structures)

Este documento técnico de referência detalha a arquitetura de conteúdo, distribuição de pesos cognitivos e especificações de lâminas para cada um dos quatro arquétipos suportados pela skill `artcraft-pitchdeck`.

---

## 1. Arquétipo A: Pitch Deck de Venture Capital (Seed & Series A)

### Objetivo Primário:
Convencer investidores institucionais de risco de que a oportunidade aborda um mercado trilionário, possui um produto comprovadamente 10x superior, tração com crescimento exponencial e uma equipe com capacidade singular de execução (*founder-market fit*).

### Roteiro Canônico Lâmina a Lâmina (12 Slides):

```text
[Slide 1: Capa & Tese de Abertura]
  ├── Elementos: Logo em alta definição, Nome da Startup, Tagline de 1 linha, Contato do CEO, Aviso "Strictly Confidential".
  └── Objetivo: Criar autoridade visual instantânea em 2 segundos.

[Slide 2: A Dor Crítica do Mercado (O Problema)]
  ├── Elementos: 3 pontos de dor concretos com métricas de perda de tempo ou dinheiro do cliente.
  └── Erro a evitar: Listar problemas genéricos sem impacto financeiro comprovado.

[Slide 3: A Solução & Proposição de Valor Única]
  ├── Elementos: Declaração de solução em frase afirmativa, 3 pilares de resolução (mais rápido, mais barato, mais inteligente).
  └── Erro a evitar: Detalhar arquitetura técnica neste momento; foque no benefício real.

[Slide 4: Demonstração do Produto (Show, Don't Tell)]
  ├── Elementos: Print/Mockup de alta fidelidade da tela principal com 3 callouts descritivos.
  └── Erro a evitar: Encher o slide com múltiplos prints minúsculos ilegíveis.

[Slide 5: Tamanho de Mercado (TAM, SAM, SOM)]
  ├── Elementos: Diagrama de 3 círculos concêntricos com números em bilhões e fontes de dados de renome (Gartner, IDC, McKinsey).
  └── Erro a evitar: Colocar TAM trilionário desconectado da vertical real da empresa.

[Slide 6: Modelo de Negócios & Mecanismo de Monetização]
  ├── Elementos: Descrição do modelo (SaaS, Take-rate, Marketplace fee), ACV (Annual Contract Value), pricing tiers.
  └── Objetivo: Mostrar como cada dólar entra na conta da empresa com clareza cristalina.

[Slide 7: Tração & Velocidade de Crescimento (O Slide Mais Crítico)]
  ├── Elementos: Gráfico nativo de colunas/linhas com evolução de ARR ou MRR nos últimos 12 a 24 meses.
  └── Destaque: Big Number no topo com crescimento ano contra ano (ex.: "+310% YoY").

[Slide 8: Economia Unitária (Unit Economics)]
  ├── Elementos: 4 cards de métricas (CAC, LTV, Payback em meses, Taxa de Churn líquida/NDR).
  └── Padrão VC: LTV/CAC > 3x, Payback < 12 meses, NDR > 115%.

[Slide 9: Go-to-Market (GTM) & Canais de Aquisição]
  ├── Elementos: Canais primários comprovados (Inbound SEO, Outbound SDRs, Parcerias de Ecossistema) e custo marginal.
  └── Objetivo: Provar que o crescimento não é sorte, mas um motor replicável.

[Slide 10: Cenário Competitivo & Vantagem Estrutural (Moat)]
  ├── Elementos: Matriz 2x2 com a startup no quadrante superior direito, ou tabela de diferenciais proprietários.
  └── Moat: Efeitos de rede, barreiras regulatórias, algoritmos proprietários ou dados proprietários.

[Slide 11: Equipe Fundadora & Histórico de Realizações]
  ├── Elementos: 3 a 4 fotos de perfil profissionais, cargos, logos de empresas anteriores e conquistas passadas de relevância.
  └── Pergunta do VC: "Por que estas pessoas específicas vencerão nesta corrida?"

[Slide 12: The Ask (Valor da Rodada, Alocação & Milestones)]
  ├── Elementos: Valor em destaque (ex.: "$3.0M Seed Round"), gráfico de pizza/barras com uso dos recursos (Engenharia, Vendas, Jurídico) e marcos para os próximos 18 meses.
  └── Fechamento: "Próximo Marco: Atingir US$ 5M de ARR em 18 meses com expansão para os EUA."
```

---

## 2. Arquétipo B: Proposta Comercial Corporativa B2B (Enterprise Sales)

### Objetivo Primário:
Eliminar o risco percebido de contratação para diretores corporativos e equipes de compras, provando conformidade técnica, segurança de dados e retorno sobre investimento acelerado.

### Roteiro Canônico (8 Slides + Anexo de SLA):
1. **Slide 1: Capa Personalizada:** Co-branding com o logo da startup e o logo do cliente corporativo.
2. **Slide 2: O Desafio Identificado no Diagnóstico:** Validação da dor levantada durante as reuniões de descoberta.
3. **Slide 3: Arquitetura da Solução:** Como a plataforma se acopla ao ecossistema existente da empresa sem interromper operações.
4. **Slide 4: Segurança, Privacidade e Conformidade:** Certificações (SOC 2 Type II, ISO 27001, LGPD, GDPR) e criptografia ponta a ponta.
5. **Slide 5: Casos de Sucesso com Clientes do Mesmo Porte:** Métricas tangíveis alcançadas por empresas parceiras.
6. **Slide 6: Cronograma de Implementação (Roadmap de Onboarding):** 4 fases de implantação em semanas (Setup, Integração de APIs, Treinamento, Go-Live).
7. **Slide 7: Matriz de Retorno sobre Investimento (ROI):** Tabela demonstrando a economia líquida gerada em 12 meses.
8. **Slide 8: Próximos Passos & Equipe de Suporte Dedicada:** Kick-off do projeto e contatos do Customer Success Manager.
- **Anexo DesignCraft:** Minuta de Acordo de Nível de Serviço (SLA de 99.9% de uptime) e detalhamento de suporte 24/7.

---

## 3. Arquétipo C: Relatório de Diretoria / Reunião de Conselho (Board Deck)

### Objetivo Primário:
Manter conselheiros e acionistas alinhados sobre o pulso operacional real, sem maquiagem promocional, destacando desafios, consumo de capital e metas trimestrais.

### Roteiro Canônico (5 Slides + DRE Analítica):
1. **Slide 1: Abertura & Visão Geral Executiva:** Síntese em 3 tópicos do fechamento do trimestre.
2. **Slide 2: Vitórias Operacionais & Metas Batidas:** Conquistas comerciais e de produto no período.
3. **Slide 3: Principais Desafios, Gargalos & Planos de Mitigação:** Transparência radical sobre o que não funcionou e correções de rota.
4. **Slide 4: Saúde Financeira, Queima de Caixa (Burn Rate) & Runway:** Gráfico de consumo de capital e meses restantes de operação no caixa atual.
5. **Slide 5: Prioridades Estratégicas e OKRs para o Próximo Trimestre:** 3 a 5 objetivos essenciais da empresa.
- **Anexo DesignCraft:** Demonstração do Resultado do Exercício (DRE) completa com 40 linhas, balanço patrimonial e notas contábeis.
