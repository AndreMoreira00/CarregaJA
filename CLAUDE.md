# CarregaJA

Sistema de gerenciamento de vagas de estacionamento e gasto de energia para carregar carros
elétricos. Projeto da disciplina **Engenharia de Software 1**.

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
| Definir o Escopo do Sistema | 🔄 Visão escrita; falta o Modelo de Caso de Uso |
| Reunião de Planejamento do Projeto | ⬜ Pendente — Planilha de PCP |
| Reunião de Revisão do Planejamento | ⬜ Pendente |
| Reunião de Revisão do Sprint | ⬜ Pendente — preenche o Checklist |

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

**CARREGAJA** — SaaS B2B para gestão de vagas com carregador de veículos elétricos em
estacionamentos comerciais. O **estabelecimento** é o cliente contratante; o **motorista** é o
usuário final, atendido por um **totem** de autoatendimento.

Decisões de escopo já fechadas — não reabrir sem motivo:

| Decisão | Definição |
|---|---|
| **Atores** | Administrador do Sistema · Estabelecimento · **Operador de Caixa** · Motorista |
| **Cobrança** | Por **tempo de ocupação** da vaga × tarifa/hora do estabelecimento |
| **Início da sessão** | No **totem**, junto às vagas: vaga, modelo, bateria, placa → comprovante com código |
| **Encerramento** | **Exclusivamente no ponto de pagamento**, pelo Operador de Caixa. O totem não encerra |
| **Pagamento** | Fora do sistema — a recarga é somada à conta que o cliente já iria quitar |
| **Identificação** | Motorista **anônimo**: placa + código de sessão impresso no comprovante de início |
| **Hardware** | **Sem integração** com os carregadores — tudo é declarado por pessoas |
| **Catálogo de modelos** | Mantido pelo Administrador; perfis genéricos por porte como fallback |

**Por que o encerramento é no caixa, e não no totem:** o totem fica junto às vagas, fora do
estabelecimento. Encerrar ali obrigaria o cliente a sair, encerrar e voltar para pagar — e em
restaurante, supermercado ou hotel, que não têm cancela, nada o obrigaria a voltar. Encerrando
no ponto de pagamento, a recarga entra numa conta que ele já ia quitar. Funciona igual para
estabelecimento com e sem controle de saída.

**A regra de negócio central:** `potência efetiva = min(potência do carregador, potência máxima
do carro)`. É ela que justifica o catálogo de modelos existir e é o maior risco técnico do
projeto — deve ser atacada primeiro na Elaboração, como arquitetura executável.

> **Por que a cobrança é por tempo e não por energia:** a energia seria calculada a partir da
> potência do carro, que o motorista declara — permitindo subdeclarar para pagar menos.
> Cobrando por tempo, nenhum campo declarado afeta o preço, e ocupar a vaga após concluir a
> recarga passa a ter custo.

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
