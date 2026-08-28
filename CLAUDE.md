# CarregaJA

Sistema de controle de vagas com carregador e rateio do consumo de energia em um condomínio
residencial. Projeto da disciplina **Engenharia de Software 1**.

O que a disciplina avalia é o **processo**: como cada etapa é executada, documentada e
evidenciada. O código é meio, não fim.

## O processo é o SpinOff

Todo o trabalho segue o método **SpinOff** (<http://arum.tec.br/SpinOff/index.htm>), criado
pelo professor da disciplina. O método está espelhado em [.spinoff/](.spinoff/):

- **[.spinoff/METODO.md](.spinoff/METODO.md)** — fases, marcos, WBS, tarefas com passos,
  papéis, artefatos, convenções. **Leia antes de propor qualquer artefato ou etapa.**
- **[.spinoff/GUIAS.md](.spinoff/GUIAS.md)** — texto integral dos guias (FURPS+, INVEST, VRDC,
  Políticas de GC, Entrevista, Workshop de Requisitos, Abordagens de Teste)
- **[.spinoff/templates/](.spinoff/templates/)** — templates oficiais. Sempre partir deles,
  nunca inventar formato de documento
- **[.spinoff/guias/](.spinoff/guias/)** — guias em PDF

### Ciclo de vida

| Fase | Marco de saída |
|---|---|
| 1. Iniciação | Escopo definido e Plano concluído |
| 2. Elaboração | Arquitetura definida e testada |
| 3. Construção | Incremento do Produto liberado |
| 4. Transição | Sistema testado e aceito |

### Estado atual

**Fase 1 — Iniciação.** Entrega da fase marcada para **início de setembro de 2026**; o
professor avaliará apresentando o artefato **Checklist de Projeto** (aba `Ver-Iniciação1`).

| Tarefa da WBS | Situação |
|---|---|
| Criar Repositório do Projeto | ✅ Concluída — estrutura oficial do `Estrutura-Projeto.zip` |
| Definir o Escopo do Sistema | 🔄 Visão v2.0 e Modelo de Caso de Uso v2.0 escritos; falta aprovação do PO |
| *Detalhar Requisitos* (Fase 2) | ⏩ **Antecipada.** História de Usuário v1.0 escrita na Iniciação, por decisão da equipe, para tornar o escopo verificável antes da aprovação. Estimativas em aberto |
| Reunião de Planejamento do Projeto | ⬜ Pendente — Planilha de PCP |
| Reunião de Revisão do Planejamento | ⬜ Pendente |
| Reunião de Revisão do Sprint | ⬜ Pendente — preenche o Checklist |

**Pendências abertas do escopo reduzido (27/08/2026):**

| Pendência | Onde trava |
|---|---|
| Aprovação do escopo pelo PO | Item 11 do Checklist. O produto mudou duas vezes desde a v1.1 — ver risco RI-09 do Visão |
| Transposição dos diagramas para o Astah | Item 7 do Checklist (template atual) |
| Protótipo das telas do morador | Item 10 do Checklist, condicional |
| Planilha de PCP e Product Backlog | Tarefa *Reunião de Planejamento do Projeto*, ainda não iniciada |
| LGPD não tratada | Decisão consciente de 27/08/2026. O sistema registra entrada e saída de moradores identificados; quando for tratar, é uma restrição em 4.2 e um risco — não reescrita |

**Como regerar o `Visão.docx`** a partir do `.md`, usando o template oficial como referência de
estilos (pandoc instalado em `%LOCALAPPDATA%\Pandoc`):

```bash
cp ".spinoff/templates/Template - Visão.dotx" /tmp/ref.docx
pandoc --reference-doc=/tmp/ref.docx -f gfm -t docx \
  -o "1.Requisitos/CARREGAJA - Visão.docx" "1.Requisitos/CARREGAJA - Visão.md"
```

**Diagramas.** Os `.puml` em `2.Analise e Design/` são a fonte; os `.png`/`.svg` são gerados.
Depois de editar um `.puml`, regerar os dois formatos — os arquivos da v1.0, com os atores que
deixaram de existir, já foram removidos:

```bash
java -jar plantuml.jar -charset UTF-8 -tpng "CARREGAJA - Modelo de Caso de Uso.puml" "CARREGAJA - Modelo de Caso de Uso - por ator.puml"
java -jar plantuml.jar -charset UTF-8 -tsvg "CARREGAJA - Modelo de Caso de Uso.puml" "CARREGAJA - Modelo de Caso de Uso - por ator.puml"
```

> Manter esta seção atualizada conforme o projeto avança.

### Como o Checklist de Projeto é pontuado

A aba `Ver-Iniciação1` tem **29 itens**, cada um `Sim` / `Parcialmente` / `Não` / `NA`:

```
IAP = qtd("Sim") ÷ (total − qtd("NA"))       meta oficial: 70% a 100%
```

**"Parcialmente" pontua igual a "Não"** — sai do numerador e permanece no denominador. Só
`NA` remove o item da conta. Consequência: poucos artefatos completos valem mais que muitos
pela metade.

As abas `Indicadores` e `Detalhado` são calculadas por fórmula; preenche-se apenas a
`Ver-Iniciação1`. O **TAP não é cobrado** nesta fase (o bloco foi removido do checklist). As
**Atas são NA** — não há cliente externo para entrevistar.

## Equipe

| Nome | Papel | E-mail |
|---|---|---|
| Henrique de Almeida Marangoni Inacio | Scrum Master (+ Desenvolvedor) | henrique.marangoni@aluno.ifsp.edu.br |
| Matheus Ribeiro Andrade | Product Owner | ribeiro.andrade@aluno.ifsp.edu.br |
| André Fernandes Nascimento Moreira | Desenvolvedor | andre.moreira@aluno.ifsp.edu.br |
| Alex Junior Fortunato Sacramento | Desenvolvedor | alex.sacramento@aluno.ifsp.edu.br |

O PO atua como **representante do cliente**, aprovando escopo (item 11) e planejamento
(item 28). Por isso PO e Scrum Master são pessoas diferentes: quem aprova não pode ser quem
executa.

## Escopo do produto

**CARREGAJA** — sistema de **controle e rateio** de recarga de veículos elétricos para **um
condomínio residencial específico**. Poucas vagas com carregador na área comum, muitos
apartamentos disputando-as, e a energia saindo da conta de luz que todos pagam. O morador
consulta o painel pelo celular, ocupa uma vaga livre ao chegar e registra a recarga; o síndico
fecha o mês com o valor por apartamento.

> **Houve redução de escopo em 27/08/2026 (Visão v2.0).** A v1.1 descrevia um SaaS B2B por
> assinatura para estacionamentos comerciais, com totem, motorista anônimo e encerramento no
> caixa. Foi descartado por não caber no prazo e na capacidade da equipe. **Ao ler qualquer
> coisa anterior a essa data — commits, issues, PRs, a v1.1 do Visão — assumir que descreve o
> produto antigo.**

Decisões de escopo já fechadas — não reabrir sem motivo:

| Decisão | Definição |
|---|---|
| **Atores** | **Morador** · **Síndico**. Só isso — o ator temporal saiu junto com o agendamento |
| **Alcance** | **Um único condomínio.** Sem multiempresa, sem gestão de assinantes |
| **Canal** | Aplicação **web no celular**. Sem totem, sem app nativo |
| **Identificação** | Morador **cadastrado**, com login, vinculado a um **apartamento** — a unidade de rateio |
| **Agendamento** | **NÃO EXISTE.** Uso por ordem de chegada: consulta o painel, ocupa vaga livre, registra o início |
| **Duração da sessão** | Máximo de **6 horas** (parâmetro, não valor fixo). Atingido o limite o sistema **sinaliza como excedida e mantém a sessão aberta** — não encerra sozinho |
| **Apuração** | Por **energia estimada** (kWh) × tarifa do kWh vigente no início da sessão |
| **Cobrança** | Fora do sistema — o síndico fecha o mês e a administradora lança na cota condominial |
| **Veículo** | Cadastrado **uma vez** pelo morador (modelo, capacidade, potência máx.). Sem catálogo compartilhado |
| **Encerramento** | O **próprio morador** encerra sua sessão. O síndico só encerra sessão órfã, por via administrativa registrada |
| **Hardware** | **Sem integração** com os carregadores — tudo é declarado por pessoas |

**A regra de negócio central:** `potência efetiva = min(potência do carregador, potência máxima
do carro)`. É ela que justifica o cadastro de veículo existir e é o maior risco técnico do
projeto — deve ser atacada primeiro na Elaboração, como arquitetura executável.

**A fórmula da apuração**, que decorre dela:

```
energia a repor  = capacidade da bateria × (100% − nível informado)
energia estimada = min(potência efetiva × duração, energia a repor)
valor da sessão  = energia estimada × tarifa vigente no início
```

> **Por que a apuração é por energia, e não por tempo como na v1.1:** o argumento anterior era
> anti-fraude — o motorista anônimo poderia subdeclarar a potência para pagar menos. Aqui o
> morador é identificado, recorrente, e cadastra o veículo **uma vez só**, sob vista do síndico.
> A brecha fecha, e a energia passa a ser a unidade certa: é em kWh que a concessionária cobra
> o condomínio, e é isso que o rateio devolve.

> **Consequência aceita:** como a energia é limitada pela carga que faltava, **ocupar a vaga
> depois de carregado não custa nada**. Removido o agendamento, o **único** instrumento de
> rotatividade que resta é a duração máxima de 6h e a sinalização no painel — não o preço. Ver
> risco RI-04 do Visão.

## Onde cada artefato vai

Mapeamento oficial do SpinOff. **Nunca criar artefato fora deste mapa.**

| Pasta | Artefatos |
|---|---|
| `1.Requisitos/` | Visão · Glossário |
| `1.Requisitos/Casos de Uso/` | Especificação de Casos de Uso · História de Usuário |
| `1.Requisitos/Prototipo/` | Protótipo |
| `2.Analise e Design/` | Modelo de Caso de Uso · Documento/Modelo de Arquitetura · Modelo de Dados · Modelo de Objetos |
| `3.Implementacao/` | Código fonte (submódulo `CarregaJA_Implementacao`) · Guia de Implementação |
| `4.Teste/` | Roteiro de Teste · Massa de Teste |
| `5.Implantação/` | Guia de Implantação · Manual do Usuário |
| `6.Gerenciamento de Projeto/` | TAP · Planilha de Planejamento e Controle · Cronograma · Checklist de Projeto · Requisições de Mudança |
| `6.Gerenciamento de Projeto/Atas/` | Atas de Reunião |

O **Modelo** de Caso de Uso (diagrama UML) vai em `2.Analise e Design/`; a **Especificação** de
Casos de Uso e as Histórias de Usuário vão em `1.Requisitos/Casos de Uso/`.

## Convenções

**Nomeação de artefatos** (todos, exceto código fonte):

```
CARREGAJA - <Nome do artefato>
```

Ex.: `CARREGAJA - Visão.docx`, `CARREGAJA - Ata de Reunião 001.docx`

**Versionamento de Configuração Base:** `v-<major>.<minor>.<patch>` — major = quebra
compatibilidade, minor = novas funcionalidades, patch = correções e melhorias.

**Branches** (workflow baseado em tronco):

| Branch | Criado a partir de |
|---|---|
| `master` | — (produção, recebe as tags) |
| `develop` | `master` (junção de features prontas) |
| `release` | `master` (correções finais pré-produção) |
| `feature` | `develop` |
| `hotfix` | `develop` |

Nome do branch: `<numero-da-issue>-<tipo>-<descrição resumida>` — ex.: `156-feature-cadastro-vaga`.
**O branch deve ser criado a partir da issue no GitHub**, para o número sair automático.

**Fluxo de mudança:** criar issue → criar branch a partir dela → desenvolver → **Pull Request
para `develop`**. Mudanças que impactam prazo ou custo passam antes pelo PO, que analisa
impacto, atualiza a Planilha de PCP e pede aprovação do cliente.

**Templates de issue e PR** já existem em [.github/](.github/) — usar sempre.

## Ferramentas do processo

| Ferramenta | Uso |
|---|---|
| Astah | Modelagem UML (casos de uso, classes, arquitetura) |
| Git / GitHub | Gerenciamento de Configuração e Mudanças |
| GitHub Projects | Monitoramento e Controle do Projeto (MCP) |

## Trabalhando neste repositório

- Antes de criar qualquer documento, conferir se existe template oficial em
  `.spinoff/templates/` e partir dele
- Antes de propor um passo do processo, conferir a WBS da fase atual em `.spinoff/METODO.md`
- Toda Ata de Reunião precisa de aprovação dos interessados (assinatura ou "de acordo" por
  e-mail) para valer como evidência
- O código vive no submódulo `3.Implementacao/CarregaJA_Implementacao`
  (<https://github.com/AndreMoreira00/CarregaJA_Implementacao>) — inicializar com
  `git submodule update --init --recursive`
- `.spinoff/` é referência, não entrega: não misturar com os artefatos do projeto
