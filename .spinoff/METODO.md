# SpinOff — referência do método

Transcrição estruturada do processo publicado em <http://arum.tec.br/SpinOff/index.htm>
(site EPF Composer, 247 páginas). Espelhado em 19/08/2026.

O SpinOff é um processo de desenvolvimento de sistemas **simplificado**, que combina o
**Processo Unificado (UP)** com o **Scrum**, destinado a micro e pequenas empresas ou
profissionais autônomos sem processo de engenharia de software definido.

## Sumário

- [Características do processo](#características-do-processo)
- [Ciclo de vida: fases e marcos](#ciclo-de-vida-fases-e-marcos)
- [Work Breakdown Structure por fase](#work-breakdown-structure-por-fase)
- [Papéis](#papéis)
- [Disciplinas](#disciplinas)
- [Tarefas](#tarefas)
- [Artefatos](#artefatos)
- [Onde cada artefato é armazenado](#onde-cada-artefato-é-armazenado)
- [Guias e templates](#guias-e-templates)

---

## Características do processo

| Característica | O que significa |
|---|---|
| **Iterativo e incremental** | Elaboração, Construção e Transição são divididas em Sprints. Cada iteração produz um incremento — uma versão do sistema com funcionalidades a mais ou melhoradas. |
| **Dirigido por casos de uso** | Casos de Uso (ou Histórias de Usuário) capturam os requisitos funcionais e definem o conteúdo de cada iteração. |
| **Centrado na arquitetura** | A arquitetura fica no centro do esforço. A entrega mais importante da Elaboração é a **arquitetura executável** — implementação parcial que valida a arquitetura e serve de base para o resto. |
| **Focado no risco** | Os riscos mais críticos são enfrentados no início do ciclo de vida. As entregas da Elaboração devem ser escolhidas para tratar os maiores riscos primeiro. |

---

## Ciclo de vida: fases e marcos

O ciclo de vida tem 4 fases (Capability Patterns), cada uma encerrada por um marco (Milestone):

| # | Fase | Objetivo | Marco de saída |
|---|---|---|---|
| 1 | **Iniciação** | Definir o escopo e planejar o projeto | Escopo definido e Plano concluído |
| 2 | **Elaboração** | Definir e testar a solução técnica (arquitetura) | Arquitetura definida e testada |
| 3 | **Construção** | Construir o sistema iterativamente, com entregas constantes | Incremento do Produto liberado |
| 4 | **Transição** | Disponibilizar o sistema completo no ambiente do cliente | Sistema testado e aceito |

> **Regra do incremento:** o primeiro e o último Sprint não precisam entregar executável —
> entregam, respectivamente, o **planejamento** e o **produto final**. Nesses casos o Sprint
> pode ter menos de 2 semanas. Nos demais, o incremento deve ser um executável gerado a
> partir de código exaustivamente testado, mais a documentação operacional das
> funcionalidades.

---

## Work Breakdown Structure por fase

Ordem exata das tarefas em cada fase, conforme a WBS publicada.

### Fase 1 — Iniciação → *Escopo definido e Plano concluído*

1. Definir o Escopo do Sistema
2. Criar Repositório do Projeto
3. Controlar Itens de Configuração (IC)
4. Reunião Diária (Daily Scrum)
5. Controlar Mudanças no Sistema
6. Reunião de Planejamento do Projeto
7. Reunião de Revisão do Planejamento
8. Reunião de Revisão do Sprint (Retrospective)

### Fase 2 — Elaboração → *Arquitetura definida e testada*

1. Reunião de Planejamento do Sprint
2. Definir Arquitetura
3. Detalhar Requisitos
4. Reunião Diária (Daily Scrum)
5. Desenvolver Solução
6. Projetar Testes
7. Executar Testes
8. Controlar Itens de Configuração (IC)
9. Controlar Mudanças no Sistema
10. Reunião de Revisão do Sprint
11. Reunião de Revisão do Planejamento

### Fase 3 — Construção → *Incremento do Produto liberado*

1. Reunião de Planejamento do Sprint
2. Reunião de Revisão do Planejamento
3. Reunião Diária (Daily Scrum)
4. Detalhar Requisitos
5. Desenvolver Solução
6. Projetar Testes
7. Executar Testes
8. Controlar Itens de Configuração (IC)
9. Controlar Mudanças no Sistema
10. Reunião de Revisão do Sprint
11. Preparar Implantação
12. Elaborar Material de Suporte
13. Implantar Produto

### Fase 4 — Transição → *Sistema testado e aceito*

1. Reunião de Planejamento do Sprint
2. Reunião Diária (Daily Scrum)
3. Projetar Testes
4. Preparar Implantação
5. Elaborar Material de Suporte
6. Executar Testes
7. Implantar Produto
8. Controlar Itens de Configuração (IC)
9. Controlar Mudanças no Sistema
10. Reunião de Revisão do Sprint

**Observação:** "Definir Arquitetura" só aparece na Elaboração. "Definir o Escopo do Sistema"
e "Criar Repositório do Projeto" só aparecem na Iniciação. As demais tarefas se repetem.

---

## Papéis

### Product Owner (PO)
Responsável pelo produto, conhece os interesses do cliente e o representa. É a **única**
pessoa responsável por gerenciar o Product Backlog.

- Definir as funcionalidades do produto
- Decidir data de liberação e conteúdo do produto
- Responder pela rentabilidade (ROI)
- Expressar claramente os itens do Backlog e ordená-los
- Aceitar ou rejeitar os resultados de trabalho

*Considerações:* uma única pessoa dedicada, disponível para tirar dúvidas do time; participa
do Sprint Planning e do Sprint Review; tipicamente alguém do Marketing, usuário-chave, ou um
representante/procurador do cliente.

### Scrum Master
Garante que o processo seja entendido e praticado por todos. **É também um desenvolvedor.**

- Esclarece o andamento do projeto
- Difunde os valores e práticas do Scrum
- Garante as Reuniões Diárias
- Remove impedimentos
- Protege o time de interferências externas
- Assegura que o time está funcional e produtivo

*Considerações:* **não é o gerente de projetos**, é um líder facilitador que gerencia o
processo. Monitora as tarefas do Sprint, mas **não cria nem atribui tarefas** — o time faz
isso. Divide responsabilidades com os outros membros.

### Desenvolvedor
Responsável pelo desenvolvimento dos incrementos, dos requisitos até a implantação.

- Executar as atividades de desenvolvimento de ponta a ponta
- Desenvolver conforme os guias e padrões do processo
- Participar dos eventos do processo

### Time de Desenvolvimento
Todos os integrantes: Scrum Master + Desenvolvedores + Product Owner.

- Auto-organizado e auto-gerido
- Multifuncional, com todas as habilidades para criar o incremento
- Compromisso conjunto com os objetivos do produto
- Apresenta os produtos de trabalho ao PO
- **Tamanho: 3 a 9 pessoas**

---

## Disciplinas

| Disciplina | Tarefas |
|---|---|
| **Requisitos** | Definir o Escopo do Sistema; Detalhar Requisitos |
| **Análise e Design** | Definir Arquitetura |
| **Implementação** | Desenvolver Solução |
| **Teste** | Projetar Testes; Executar Testes |
| **Implantação** | Preparar Implantação; Elaborar Material de Suporte; Implantar Produto |
| **Gerenciamento de Configuração e Mudanças** | Criar Repositório do Projeto; Controlar Itens de Configuração (IC); Controlar Mudanças no Sistema |
| **Gerenciamento de Projetos** | Reunião de Planejamento do Projeto; Reunião de Planejamento do Sprint; Reunião Diária; Reunião de Revisão do Planejamento; Reunião de Revisão do Sprint |

---

## Tarefas

### Definir o Escopo do Sistema
*Disciplina:* Requisitos · *Executores:* Product Owner + Time de Desenvolvimento
*Entrada:* Necessidades do Cliente · *Saídas:* **Visão**, **Modelo de Caso de Uso**, **Ata de Reunião**

**Passos**

1. **Levantar necessidades do cliente** — o Time planeja e executa as primeiras reuniões para
   identificar necessidades e problemas. Quantas reuniões forem necessárias. Prepare a
   entrevista antes (Guia - Técnica de Entrevista). Registre as questões na Ata de Reunião e
   complemente com as respostas. Boa prática: gravar as entrevistas e consolidar o
   entendimento logo depois (Guia - Workshop de Requisitos). **Toda Ata deve ser aprovada
   pelos interessados** — assinatura ou "de acordo" por e-mail. Registre problemas e
   necessidades no documento Visão.
2. **Definir o sistema (escopo)** — requisitos são "serviços que o sistema deve fornecer para
   preencher uma ou mais necessidades". Documente no Visão. Com base no Visão, elabore o
   Modelo de Caso de Uso — normalmente as Histórias mapeiam 1-para-1 com casos de uso. Boa
   prática: descrição resumida para cada caso de uso. Ferramenta sugerida: **Astah (UML)**.
3. **Aprovar o escopo do sistema** — apresente a definição ao PO e/ou cliente para validação.
   Esse é o escopo *inicial*; modificações posteriores viram aditivos, tratados pelo processo
   de Gerenciamento de Configuração e Mudanças.

### Criar Repositório do Projeto
*Disciplina:* GCM · *Executor:* Desenvolvedor (na prática, o Scrum Master) · *Saída:* **Estrutura do Projeto**

**Passos**

1. **Criar o repositório local** — baixar e descompactar a Estrutura do Projeto; renomear a
   pasta raiz com a sigla do projeto (ex.: `c:/svsa`); instalar e configurar a ferramenta de
   GCM conforme o Guia - Configuração do GitHub.
2. **Criar o repositório remoto** — conforme o mesmo guia.
3. **Comunicar demais desenvolvedores** — orientá-los sobre como controlar os ICs criados.

### Reunião de Planejamento do Projeto
*Disciplina:* Gerenciamento de Projetos · *Executor:* Scrum Master (+ PO, + Time)
*Entradas:* Visão, Modelo de Caso de Uso (opcional: TAP) · *Saídas:* **Product Backlog**, **Planilha de PCP**

**Passos**

1. **Planejar o projeto** — o Scrum Master elabora e mantém o plano na Planilha de
   Planejamento e Controle do Projeto. Primeira composição do Product Backlog com base no
   Modelo de Caso de Uso e no Visão: liste todos os Casos de Uso, que podem ser desmembrados
   em tarefas menores.
2. **Priorizar os itens do Backlog** — conduzido pelo PO, com o Time, usando o **método VRDC**.
3. **Estimar os itens do Backlog** — em horas, por **Planning Poker** (mais simples, baseado
   na experiência do time) ou **Análise de Pontos de Função — APF** (mais formal).
4. **Criar o plano de entregas** — na Planilha de PCP, o que será entregue ao fim de cada
   Sprint; define quantas entregas serão feitas com base no número de Sprints planejado.
5. **Aprovar o Plano do Projeto** — o Scrum Master apresenta ao cliente/PO e obtém aprovação.
   **Só após a aprovação (marco do primeiro Sprint) é que se inicia o desenvolvimento.**
6. **Preparar o ambiente de MCP** — registrar todas as tarefas na ferramenta de Monitoramento
   e Controle do Projeto (**GitHub Projects**).

### Detalhar Requisitos
*Disciplina:* Requisitos · *Executor:* Desenvolvedor (+ PO)
*Entrada obrigatória:* Necessidades do Cliente · *Opcionais:* Modelo de Caso de Uso, Visão
*Saídas:* **História de Usuário**, **Modelo de Análise e Design**, **Protótipo**, **Ata de Reunião**

**Propósito:** especificar os requisitos funcionais e não funcionais, analisar o problema,
criar modelos e protótipos e consolidar os requisitos detalhados.

**Passos**

1. **Levantar requisitos com o cliente** — registrados nas Histórias de Usuário. Técnica mais
   comum: Entrevista. Requisitos **não funcionais** vão na seção *restrições* do Visão quando
   afetam o sistema todo, ou na própria especificação da funcionalidade quando são locais.
2. **Criar modelos de análise** — atualize o Modelo de Caso de Uso; crie o Modelo de Análise e
   Design a partir das entidades encontradas (normalmente substantivos), com relacionamentos e
   propriedades, usando **Diagrama de Classes UML**.
3. **Criar protótipos** — para apresentar ao PO/cliente e mostrar o entendimento dos
   requisitos. Serve só para identificar informações e comportamentos. **Não perca tempo
   implementando** — use ferramentas de desenho ou rascunhe em papel. Um protótipo por caso de uso.
4. **Especificar requisitos** — documentar na forma de História de Usuário ou no próprio Modelo
   de Casos de Uso. *É fundamental que os casos de teste de cada História sejam criados com
   detalhes (casos positivos e negativos) — serão a base do Roteiro de Testes.*
5. **Normalizar requisitos** — verificar completude com a técnica **INVEST**.
6. **Aprovar requisitos** — apresentar ao PO/cliente. Use o Modelo de Caso de Uso e os
   protótipos para guiar a apresentação. Toda mudança registrada em Ata de Reunião.

### Definir Arquitetura
*Disciplina:* Análise e Design · *Executor:* Desenvolvedor
*Entradas:* Modelo de Caso de Uso, Visão · *Saídas:* **Modelo de Arquitetura**, **Código Fonte**

**Passos**

1. **Desenvolver a arquitetura** — com base no Visão, Modelo de Caso de Uso e principalmente
   nos requisitos não funcionais e restrições:
   - Visão geral da arquitetura: hipóteses de trabalho (hardware/software existente); decisões
     iniciais de arquitetura física e lógica; requisitos não-funcionais (escalabilidade,
     interoperabilidade, manutenibilidade, desempenho, portabilidade, segurança)
   - Definir estratégias de reuso
   - Identificar recursos reutilizáveis ou adquiríveis (padrões de projeto, componentes)
   - Avaliar viabilidade de implementação; modelo de implantação preliminar
   - Realizar (projetar) os cenários significativos do ponto de vista da arquitetura
   - Revisar mecanismos, subsistemas, pacotes e entidades quanto a completude e consistência
   - Registrar tudo no Modelo de Arquitetura
2. **Implementar uma funcionalidade para testar a arquitetura** — escolher a funcionalidade que
   oferece **maior risco** à solução técnica.
3. **Refinar a arquitetura** — é comum a arquitetura mudar com a implementação; documentar.
4. **Apresentar a arquitetura aos desenvolvedores** — ela é a referência para todos.

### Desenvolver Solução
*Disciplina:* Implementação · *Executor:* Desenvolvedor
*Entradas:* Modelo de Arquitetura, Protótipo · *Saída:* **Código Fonte**

**Passos**

1. **Modelar solução** — a partir das Histórias de Usuário, analisar e projetar. Criar diagrama
   de classes com as entidades efetivamente usadas pelo caso de uso. Nomeação de classes,
   métodos, atributos e empacotamento seguem os padrões definidos na arquitetura.
2. **Implementar solução** — fiel ao Modelo de Arquitetura e aos guias de Padrões de Projeto e
   Padrões de Codificação.
3. **Testar solução** — toda solução implementada deve ser testada. **É responsabilidade do
   implementador desenvolver e executar os testes unitários.** Componentes *fake* podem ser
   criados para responder pelos componentes ainda não implementados.

### Projetar Testes
*Disciplina:* Teste · *Executor:* Desenvolvedor
*Entradas:* História de Usuário, Modelo de Caso de Uso · *Saídas:* **Roteiro de Testes**, **Massa de Testes**

**Passos**

1. **Projetar testes** — elaborar o Roteiro de Testes com base na História de Usuário e no Guia
   de Abordagens de Testes. A maioria dos casos de teste já foi identificada nas
   especificações, mas novos podem ser acrescentados. Criar também a Massa de Testes.
2. **Preparar ambiente de testes** — **imprescindível que seja separado do ambiente de
   desenvolvimento**, para que a Massa de Testes não seja alterada e os resultados sejam
   consistentes.

### Executar Testes
*Disciplina:* Teste · *Executor:* Desenvolvedor
*Entradas:* Código Fonte, Roteiro de Testes · *Saídas:* **Roteiro de Testes** (atualizado), **Sprint Backlog**

**Passos**

1. **Executar testes** — conforme a abordagem escolhida, com base no Roteiro de Testes.
2. **Registrar resultados** — nos respectivos ciclos de teste do Roteiro. **Todos os defeitos
   devem ser registrados e acompanhados até a solução.**
3. **Corrigir defeitos** — se a correção for encaminhada a outro desenvolvedor, criar uma
   atividade de correção e incluí-la no Sprint Backlog.

### Preparar Implantação
*Disciplina:* Implantação · *Executor:* Desenvolvedor (com apoio do PO)
*Entrada:* Modelo de Arquitetura · *Saída:* **Guia de Implantação**

Documenta como e quando o produto será disponibilizado aos usuários. O guia **evolui ao longo
das liberações** até a implantação total. Deve prever:

- Como empacotar e distribuir o produto
- Onde e como instalar — por técnicos da equipe ou pelo próprio cliente?
- Migração de dados de sistemas antigos
- Substituição de sistema antigo, com ou sem restrição de continuidade de operações
- Conversão de dados para novo formato
- Suporte aos usuários: treinamento formal, em computador, ajuda on-line, telefone, internet

### Elaborar Material de Suporte
*Disciplina:* Implantação · *Executor:* Desenvolvedor
*Entrada:* Código Fonte · *Saída:* **Manual do Usuário**

Ensina e orienta o usuário a utilizar o produto (papel, web ou vídeo). Envolve: organizar
informações para facilitar o acesso; instruções fáceis de seguir; estrutura que facilite
verificação e atenda usuários inexperientes; diferenciar tipos de informação (conceitos,
detalhes, objetivos, feedback, ações); usar elementos gráficos; acompanhar explicações de
exemplos.

### Implantar Produto
*Disciplina:* Implantação · *Executor:* Desenvolvedor · *Entrada:* Guia de Implantação

Implantar o software no ambiente do cliente **após certificar-se de que houve a homologação**
do produto ou incremento.

### Controlar Itens de Configuração (IC)
*Disciplina:* GCM · *Executor:* Desenvolvedor

**Passos**

1. **Controlar Itens de Configuração** — todos os artefatos padronizados pelo processo e
   criados na execução do projeto são ICs. Devem ser nomeados conforme o Guia - Políticas de GC
   e armazenados conforme o Guia - Mapeamento de Produtos por Processo.
2. **Controlar Configuração Base** — a CB é o estado do software (e de todos os seus ICs) num
   momento da linha do tempo, normalmente fim de iteração/sprint ou fase, quando há entrega.

### Controlar Mudanças no Sistema
*Disciplina:* GCM · *Executor:* Desenvolvedor (+ PO)

"Mudança" = qualquer alteração no projeto que impacte **prazo ou custo** — normalmente por
alteração de escopo.

**Passos**

1. **Analisar impacto da mudança** — para mudanças que alteram o escopo, o **PO** deve analisar
   impactos (custo e prazo), atualizar a Planilha de PCP e comunicar o cliente pedindo
   aprovação. Mudanças normais de desenvolvimento (sem impacto no escopo): o Desenvolvedor cria
   uma requisição de mudança na ferramenta de MCP.
2. **Realizar a mudança** — seguir o workflow do Guia - Políticas de GC. Criar uma *issue*,
   criar um *branch a partir da issue*, e ao concluir **solicitar Pull Request para o branch
   `develop`**.

### Reunião Diária (Daily Scrum)
*Disciplina:* Gerenciamento de Projetos · *Executores:* Scrum Master + Time (+ PO)
*Entrada:* Quadro de Tarefas · *Saídas:* Sprint Backlog, Planilha de PCP, Quadro de Tarefas

**Máximo 15 minutos**, todos os dias do Sprint, mesmo local e horário — idealmente pela manhã.
Todos do time participam; outros podem assistir, **apenas como ouvintes**.

**Não é reunião para resolver problemas** — dúvidas são postergadas e tratadas pelo grupo
envolvido logo após. Cada membro responde:

1. O que você fez ontem?
2. O que você vai fazer hoje?
3. Existe algum problema te impedindo de cumprir a tarefa?

Não é reunião de atualização para um chefe: é onde os membros **se comprometem uns com os
outros**. Quando o Scrum Master não consegue remover um impedimento diretamente (questões mais
técnicas), ele assegura que alguém do time resolva rapidamente.

### Reunião de Planejamento do Sprint (Sprint Planning)
*Disciplina:* Gerenciamento de Projetos · *Executores:* PO + Scrum Master + Time
*Entradas:* Product Backlog, Planilha de PCP · *Saídas:* **Sprint Backlog**, Planilha de PCP, Quadro de Tarefas

O PO explica as funcionalidades de maior prioridade; o Time pergunta o suficiente para depois
decidir o que move do Product Backlog para o Sprint Backlog. Juntos definem o **Sprint Goal** —
breve descrição do que se pretende atingir. O sucesso do Sprint é verificado na Revisão **com
base no Sprint Goal**, não em itens específicos do Backlog.

Depois da reunião o Time se reúne separadamente para decidir com quanto se compromete. Pode
haver negociação com o PO, mas **é sempre prerrogativa do Time determinar o quanto pode se
comprometer**.

**Passos**

1. **Criar o backlog do sprint** — selecionar atividades do Product Backlog respeitando a
   prioridade do PO. Atividades que surgirem durante o Sprint: o Time decide se entram no
   Sprint Backlog ou no Product Backlog.
2. **Definir responsáveis e estimativas** — cada membro **escolhe** as tarefas que vai executar
   e reestima se for o caso. O Time é auto-gerido: **tarefas não são impostas**, são escolhidas
   em consenso. Registrar na ferramenta de MCP (GitHub Projects).

*Consideração:* o PO não precisa descrever cada item do Backlog — dependendo do tamanho e da
velocidade do Time, pode bastar descrever os de maior prioridade.

### Reunião de Revisão do Planejamento
*Disciplina:* Gerenciamento de Projetos · *Executores:* Scrum Master + Time (+ PO)
*Entradas/Saídas:* Product Backlog, Planilha de PCP

**Antes de cada Sprint**, revisar o plano: mudanças são intrínsecas ao desenvolvimento e novas
necessidades podem ter surgido, precisando ser priorizadas e estimadas. Prazos, riscos,
prioridades, entregas e custos precisam ser revistos.

### Reunião de Revisão do Sprint (Sprint Retrospective)
*Disciplina:* Gerenciamento de Projetos · *Executores:* PO + Scrum Master + Time
*Entrada:* o próprio processo SpinOff · *Saídas:* **Backlog de Melhorias do Processo**, **Checklist de Projeto**

**Passos**

1. **Revisar o produto** — o Time apresenta o que foi realizado, tipicamente demonstrando as
   novas funcionalidades. Avaliar: se os objetivos do Sprint foram atingidos; se a qualidade
   mínima prevista no Checklist de Projeto foi atingida.
2. **Revisar as não conformidades** — manter o rastreamento; relatar cada alteração feita em
   cada ponto do relatório de não conformidades.
3. **Revisar o processo** — analisar o que está dando certo e o que não está, para melhorar
   continuamente. Abordagem: o que o time gostaria de **começar a fazer**, **parar de fazer** e
   **continuar fazendo**. O Scrum Master atua como facilitador.

---

## Artefatos

| Artefato | Produzido por | Consumido por | Template |
|---|---|---|---|
| **Necessidades do Cliente** | *(entrada externa)* | Definir Escopo; Detalhar Requisitos | — |
| **Termo de Abertura do Projeto (TAP)** | *(entrada externa)* | Reunião de Planejamento do Projeto | ✅ `.dotx` |
| **Visão** | Definir Escopo | Definir Arquitetura; Planejamento do Projeto; Detalhar Requisitos | ✅ `.dotx` |
| **Modelo de Caso de Uso** | Definir Escopo | Definir Arquitetura; Projetar Testes; Planejamento do Projeto; Detalhar Requisitos | ✅ `.asta` |
| **Ata de Reunião** | Definir Escopo; Detalhar Requisitos | — | ✅ `.dotx` |
| **Estrutura do Projeto** | Criar Repositório | — | ✅ `.zip` |
| **Product Backlog** | Planejamento do Projeto; Revisão do Planejamento | Sprint Planning; Revisão do Planejamento | — |
| **Planilha de Planejamento e Controle do Projeto** | Planejamento do Projeto; Sprint Planning; Revisão do Planejamento; Daily | Sprint Planning; Revisão do Planejamento | ✅ `.xltx` |
| **Sprint Backlog** | Sprint Planning; Daily; Executar Testes | — | — |
| **Quadro de Tarefas** | Sprint Planning; Daily | Daily | — |
| **História de Usuário** | Detalhar Requisitos | Projetar Testes | ✅ `.dotx` |
| **Modelo de Análise e Design** | Detalhar Requisitos | — | ✅ `.asta` |
| **Protótipo** | Detalhar Requisitos | Desenvolver Solução | — |
| **Modelo de Arquitetura** | Definir Arquitetura | Desenvolver Solução; Preparar Implantação | ✅ `.asta` |
| **Código Fonte** | Definir Arquitetura; Desenvolver Solução | Elaborar Material de Suporte; Executar Testes | — |
| **Roteiro de Testes** | Projetar Testes; Executar Testes | Executar Testes | ✅ `.xltx` |
| **Massa de Testes** | Projetar Testes | — | — |
| **Guia de Implantação** | Preparar Implantação | Implantar Produto | ✅ `.dotx` |
| **Manual do Usuário** | Elaborar Material de Suporte | — | ✅ `.dotx` |
| **Incremento do Produto** | *(resultado de cada Sprint)* | — | — |
| **Checklist de Projeto** | Sprint Retrospective | — | ✅ `.xltx` |
| **Backlog de Melhorias do Processo** | Sprint Retrospective | — | — |

### Quadro de Tarefas — colunas

| Coluna | Conteúdo |
|---|---|
| **Itens de Backlog** | A descrição da história ("Como usuário eu quero…") |
| **A fazer** | Cartões não iniciados — histórias ou seus desmembramentos |
| **Fazendo** | Cartões em trabalho. O programador move o cartão quando começa, tipicamente durante a Daily |
| **A verificar / Em teste** | Cartões de teste correspondentes ("Testar o X", "Corrigir erros do X") |
| **Concluído** | Empilhados aqui; removidos no fim do Sprint |

---

## Onde cada artefato é armazenado

Mapeamento oficial (Guia - Mapeamento de Produtos por Processo), aplicado à estrutura de pastas
do `Estrutura-Projeto.zip` — que é exatamente a estrutura deste repositório.

| Pasta | Artefatos |
|---|---|
| `1.Requisitos/` | Visão · Glossário |
| `1.Requisitos/Casos de Uso/` | Especificação de Casos de Uso · História do Usuário |
| `1.Requisitos/Prototipo/` | Protótipo |
| `2.Analise e Design/` | Modelo de Caso de Uso · Documento de Arquitetura · Modelo de Arquitetura · Modelo de Dados · Modelo de Objetos |
| `3.Implementacao/` | Códigos Fonte · Guia de Implementação |
| `4.Teste/` | Roteiro de Teste · Massa de Teste |
| `5.Implantação/` | Guia de Implantação de Software · Manual do Usuário |
| `6.Gerenciamento de Projeto/` | Termo de Abertura do Projeto · Planejamento e Controle do Projeto · Cronograma · Checklist de Projeto · Caso de Desenvolvimento · Requisição de Mudanças |
| `6.Gerenciamento de Projeto/Atas/` | Atas de Reunião |

> **Atenção à sutileza:** o **Modelo** de Caso de Uso (o diagrama UML) vai em
> `2.Analise e Design/`, enquanto a **Especificação** de Casos de Uso e as Histórias de Usuário
> vão em `1.Requisitos/Casos de Uso/`.

### Nomeação de Itens de Configuração

Todos os ICs, **exceto código fonte**, seguem:

```
<SIGLA do projeto> - <NOME do artefato>
```

Exemplo: `CARREGAJA - Visão`

### Versionamento de Configurações Base

Versionamento semântico de 3 números: `v-<Primeiro>.<Segundo>.<Terceiro>`

- **Primeiro** — mudança significativa, sem compatibilidade com a versão anterior
- **Segundo** — inclusão de novas funcionalidades
- **Terceiro** — correção de defeitos e melhorias

Exemplo: `v-2.8.11`

### Branches

Workflow **baseado em tronco**: integrar alterações pequenas e frequentes no ramo principal.

| Branch | Papel | Criado a partir de |
|---|---|---|
| `master` | Produção; onde ficam as tags de versão | — |
| `develop` | Junção das features prontas | `master` |
| `release` | Correções finais antes de subir para produção | `master` |
| `feature` | Novas funcionalidades ou melhorias | `develop` |
| `hotfix` | Correção de bugs que impactam o uso | `develop` |

Nomeação: `<numero do issue> - <tipo de branch> - <descrição resumida>`
Exemplo: `156-feature-descrição resumida`

> O branch **deve ser criado a partir da issue** no GitHub Projects — isso gera o número
> automaticamente.

---

## Guias e templates

### Guias transcritos em texto
Ver [GUIAS.md](GUIAS.md): Requisitos de Sistema (FURPS+), Técnica de Entrevista, Workshop de
Requisitos, INVEST, Método VRDC, Políticas de GC, Abordagens de Testes de Software.

### Guias em PDF
Ver [guias/](guias/):

| Guia | Usado em |
|---|---|
| Mapeamento Produtos por Processo | Controlar IC; Criar Repositório |
| Config GitHub | Criar Repositório; Controlar IC/Mudanças; Planejamento |
| UseCase e UserHistory | Definir Escopo; Detalhar Requisitos |
| Método Planning Poker + Cartas | Planejamento do Projeto; Sprint Planning |
| Método APF | Planejamento do Projeto; Sprint Planning |
| Padrões de Projeto (Patterns) | Definir Arquitetura; Desenvolver Solução |
| Oracle Java Code Conventions | Definir Arquitetura; Desenvolver Solução |
| Abordagens de Testes de Softwares | Projetar Testes; Executar Testes |

*Não incluídos no repositório (baixe no site se precisar):* `Anexo - Padroes GoF-UFPE.pdf`,
`Anexo - Padroes GRASP-UFPE.pdf`, `Ref - Livro InfoQ - Kanban e Scrum.pdf` — juntos somam
5,4 MB de material de referência teórica.

### Templates oficiais
Ver [templates/](templates/) — 10 templates + a estrutura de pastas:

`TAP` · `Visão` · `História de Usuário` · `Ata de Reunião` · `Planejamento e Controle do Projeto`
· `Roteiro de Teste` · `Checklist de Verificação de Projeto` · `Guia de Implantação`
· `Manual do Usuário` · `Modelos de Análise e Design (Astah)` · `Estrutura-Projeto.zip`

### Ferramentas do processo

| Ferramenta | Uso |
|---|---|
| **Astah** | Modelagem UML — casos de uso, classes, arquitetura |
| **Git / GitHub** | Gerenciamento de Configuração e Mudanças |
| **GitHub Projects** | Ferramenta de MCP (Monitoramento e Controle do Projeto) |

---

## Referências do próprio SpinOff

- Scrum — <https://www.scrum.org/>
- IBM RUP — <https://pt.wikipedia.org/wiki/IBM_Rational_Unified_Process>
- OpenUP — <http://eclipse.org/epf/general/OpenUP.pdf>
- SOMMERVILLE, I. *Engenharia de Software*, 10ª ed., Pearson, 2019
- KNIBERG, H.; SKARIN, M. *Kanban e Scrum: obtendo o melhor de ambos*, C4Media/InfoQ, 2009
