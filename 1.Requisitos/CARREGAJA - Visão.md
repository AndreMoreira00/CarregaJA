# Visão

**Versão 4.1**

**CARREGAJA - Sistema de Controle e Rateio de Recarga de Veículos Elétricos em Condomínio**

## Histórico de Revisões

| Data | Versão | Descrição | Autor |
|---|---|---|---|
| 20/08/2026 | 1.1 | Versão inicial registrada no repositório. | Henrique de Almeida Marangoni Inacio |
| 27/08/2026 | 2.0 | Redução do escopo para um único condomínio residencial. | Henrique de Almeida Marangoni Inacio |
| 27/08/2026 | 3.0 | Remoção do agendamento: o uso passa a ser por ordem de chegada. | Henrique de Almeida Marangoni Inacio |
| 31/08/2026 | 3.1 | Revisão geral e condensação do texto. | Henrique de Almeida Marangoni Inacio |
| 26/09/2026 | 4.0 | Documento reduzido a uma visão geral, conforme a apresentação da Iniciação. O detalhamento de problemas, restrições, riscos e limitações passou para o Documento de Requisitos. Seções 2 a 6 reescritas. | Henrique de Almeida Marangoni Inacio |
| 26/09/2026 | 4.1 | RI-08: a arquitetura passa a ser testada com o UC05 (Manter Veículo), e a previsão e a apuração vão para o início da Construção. | Henrique de Almeida Marangoni Inacio |

## 1. Introdução

### 1.1. Resumo do Negócio

Condomínios residenciais vêm instalando pontos de recarga de veículos elétricos na garagem
comum. São poucos pontos para muitos apartamentos, e a energia sai da conta de luz da área
comum, paga por todos os condôminos, inclusive por quem não tem carro elétrico.

O CARREGAJA é um sistema web, usado pelo celular, para **um condomínio específico**. O morador
vê quais vagas estão livres e quando as ocupadas serão liberadas, e registra as próprias
recargas. O síndico fecha o mês com o consumo de cada apartamento, para lançamento na cota
condominial.

### 1.2. Objetivo do Sistema

Organizar o uso compartilhado das vagas com carregador e atribuir a cada apartamento o custo da
energia que ele de fato consumiu.

### 1.3. Glossário

| Termo | Definição |
|---|---|
| Apartamento | Unidade autônoma do condomínio. É a ele que o consumo é atribuído no rateio. |
| Duração Máxima de Sessão | Tempo limite de uma sessão: 6 horas por padrão, ajustável pelo síndico. Atingido o limite, a sessão é sinalizada como excedida, mas não é encerrada. |
| Energia Estimada | Energia atribuída a uma sessão: potência efetiva × duração, limitada à energia que faltava na bateria. |
| Fechamento do Mês | Consolidação, pelo síndico, das sessões do mês por apartamento. Depois dele o período não aceita alterações. |
| kW e kWh | Unidades de potência e de energia. A concessionária cobra o condomínio em kWh. |
| Morador | Condômino ou residente autorizado, com login, vinculado a um apartamento. |
| Nível de Bateria | Percentual de carga informado pelo morador ao iniciar a sessão. |
| Painel de Vagas | Tela com a situação de cada vaga (livre, ocupada ou excedida) e a previsão de liberação das ocupadas. |
| Potência Efetiva | O menor valor entre a potência do carregador e a potência máxima aceita pelo veículo. |
| Rateio | Distribuição do custo da energia entre os apartamentos, proporcional ao consumo de cada um. |
| Sessão de Recarga | Uso de uma vaga por um veículo, do início ao encerramento declarados pelo morador. |
| Sessão Órfã | Sessão que continua aberta depois que o veículo saiu da vaga. É encerrada pelo síndico. |
| Síndico | Responsável pela administração do condomínio. Configura o sistema, trata exceções e fecha o mês. |
| Tarifa de Energia | Valor do kWh usado no rateio, definido pelo síndico a partir da conta de luz da área comum. |
| Vaga com Carregador | Vaga da área comum com ponto de recarga, identificada por código e com potência definida. |
| Veículo | Carro elétrico do morador, cadastrado uma vez, com a capacidade da bateria e a potência máxima de recarga. |

### 1.4. Referências

| Documento | Origem |
|---|---|
| SpinOff - Processo de Desenvolvimento de Sistemas | http://arum.tec.br/SpinOff/index.htm |
| CARREGAJA - Documento de Requisitos (v1.0) | 1.Requisitos/ |
| CARREGAJA - História de Usuário (v4.0) | 1.Requisitos/Casos de Uso/ |
| CARREGAJA - Modelos de Análise e Design | 2.Analise e Design/ |
| CARREGAJA - Planejamento e Controle do Projeto | 6.Gerenciamento de Projeto/ |

## 2. Problema

### 2.1. Energia de poucos rateada entre todos

|   |   |
|---|---|
| **Problema** | A energia da recarga sai da conta de luz da área comum, e não há registro de quem a consumiu. |
| **Afetados** | Condôminos, especialmente os que não têm veículo elétrico; síndico; administradora. |
| **Impacto** | A maioria paga pela minoria; atrito em assembleia; resistência a instalar novos pontos. |
| **Necessidades (Escopo)** | Como síndico, eu quero apurar o consumo de cada apartamento no mês, de modo que eu possa lançar o valor na cota condominial.<br>Como síndico, eu quero definir a tarifa do kWh, de modo que o valor cobrado acompanhe a conta de luz da área comum.<br>Como morador, eu quero acompanhar meu consumo do mês, de modo que eu saiba quanto será lançado antes de receber a conta. |

### 2.2. Disputa pelas vagas sem informação de disponibilidade

|   |   |
|---|---|
| **Problema** | Há poucas vagas para muitos apartamentos. O morador desce à garagem sem saber se há vaga livre nem quando uma ocupada será liberada. |
| **Afetados** | Moradores com veículo elétrico; síndico e porteiro, chamados para mediar conflitos. |
| **Impacto** | Descidas perdidas, conflito entre vizinhos e combinação informal por grupo de mensagens, sem registro. |
| **Necessidades (Escopo)** | Como morador, eu quero ver quais vagas estão livres e a previsão de liberação das ocupadas, de modo que eu não desça à garagem à toa.<br>Como morador, eu quero registrar o início e o fim da minha recarga, de modo que o painel reflita a garagem real para os vizinhos.<br>Como morador, eu quero cadastrar meu veículo uma única vez, de modo que a previsão considere a potência que ele realmente aceita. |

### 2.3. Vaga ocupada além do necessário

|   |   |
|---|---|
| **Problema** | O veículo permanece na vaga depois de carregado, ou é retirado sem que a sessão seja encerrada. |
| **Afetados** | Moradores que aguardam a vaga; síndico. |
| **Impacto** | Menor rotatividade de um recurso escasso; painel exibindo como ocupada uma vaga livre; apuração incorreta. |
| **Necessidades (Escopo)** | Como morador, eu quero ver no painel as sessões que passaram do limite de duração, de modo que eu saiba que aquela vaga deveria estar sendo liberada.<br>Como síndico, eu quero encerrar uma sessão cujo veículo já saiu, com o encerramento registrado, de modo que a vaga seja liberada e o morador possa contestar a apuração. |

### 2.4. Falta de dados para decidir sobre a estrutura

|   |   |
|---|---|
| **Problema** | O condomínio não sabe quanto as vagas são usadas, em que horários, nem quantas vezes faltou vaga. |
| **Afetados** | Síndico; assembleia de condôminos. |
| **Impacto** | A decisão de instalar novos pontos é tomada por impressão, e não por dado. |
| **Necessidades (Escopo)** | Como síndico, eu quero consultar o histórico de utilização e as tentativas recusadas por falta de vaga, de modo que eu leve dados à assembleia ao propor a ampliação da estrutura. |

## 3. Usuários

| Nome | Responsável/Cargo | Responsabilidades |
|---|---|---|
| Matheus Ribeiro Andrade | Product Owner | Representa o cliente: prioriza as funcionalidades, aprova o escopo e o planejamento e aceita as entregas. |
| Henrique de Almeida Marangoni Inacio | Scrum Master | Garante a aderência ao processo e mantém o planejamento e o controle do projeto. |
| André Fernandes Nascimento Moreira | Desenvolvedor | Levanta necessidades e desenvolve o sistema, dos requisitos à implantação. |
| Alex Junior Fortunato Sacramento | Desenvolvedor | Levanta necessidades e desenvolve o sistema, dos requisitos à implantação. |

O projeto não tem cliente externo: as necessidades foram levantadas pela equipe, e o Product
Owner representa o cliente (RE-16).

## 4. Restrições Impostas

| # | Restrição |
|---|---|
| RE-01 | Deve ser uma aplicação web. |
| RE-02 | Deve ser implementado em Java, integrado à disciplina Linguagem de Programação 2. |
| RE-03 | Deve ser utilizável no navegador do celular, sem aplicativo nativo. |
| RE-04 | Deve funcionar independentemente do sistema operacional do usuário. |
| RE-05 | Não se integra ao hardware dos carregadores: o estado das vagas e das sessões é declarado por pessoas. |
| RE-06 | Não processa pagamento nem emite cobrança. |
| RE-07 | Atende a um único condomínio. |
| RE-08 | Todo uso é identificado: o morador tem login e está vinculado a um apartamento. |
| RE-09 | A energia de cada sessão é estimada, e não medida. |
| RE-10 | Não se integra ao sistema da administradora do condomínio. |
| RE-11 | A sessão tem duração máxima de 6 horas. Atingido o limite, é sinalizada como excedida, mas não é encerrada. |
| RE-12 | Não há agendamento nem reserva de vagas: o uso é por ordem de chegada. |
| RE-13 | Deve ser entregue até o fim do semestre letivo 2026.2. |
| RE-14 | A equipe tem quatro estudantes, com dedicação parcial e sem orçamento. |
| RE-15 | O desenvolvimento segue o processo SpinOff. |
| RE-16 | Não há cliente externo: o Product Owner representa o cliente. |

## 5. Riscos

| # | Risco | Resposta |
|---|---|---|
| RI-01 | Dados do veículo cadastrados errado, distorcendo previsão e apuração. | Síndico confere o cadastro; energia exibida ao morador no encerramento. |
| RI-02 | Uso do carregador sem sessão registrada. | Painel conferível com a garagem; total apurado comparado com a conta de luz. |
| RI-03 | Sessão órfã: veículo retirado sem encerrar a sessão. | Sinalização no painel e encerramento administrativo pelo síndico. |
| RI-04 | Veículo continua na vaga depois de carregado. | Aceito: limite de duração e sinalização no painel. |
| RI-05 | Total apurado diferente da conta de luz da área comum. | Apuração apresentada como estimativa; ajuste proporcional, se a assembleia decidir. |
| RI-06 | Indisponibilidade da equipe por conta das outras disciplinas. | Entregas por sprint e revisão do planejamento antes de cada sprint. |
| RI-07 | Requisitos validados só internamente (RE-16). | Premissas registradas e validação pelo Product Owner. |
| RI-08 | Cálculo de previsão e de apuração mais complexo que o esperado. | Atacado no início da Construção (sprint 5), sobre a arquitetura já testada com o UC05. |
| RI-09 | Nova mudança de escopo. | Toda alteração passa por issue, com análise de impacto do Product Owner. |
| RI-10 | Limite de 6 horas insuficiente para carregadores lentos. | Limite configurável pelo síndico. |
| RI-11 | Dois moradores disputando a mesma vaga recém-liberada. | Aceito: a demanda reprimida é medida e levada à assembleia. |

## 6. Requisitos de Documentação

| Documento | Conteúdo |
|---|---|
| Manual do Usuário - Morador | Uso pelo celular, como ajuda nas próprias telas. |
| Manual do Usuário - Síndico | Cadastros, tarifa, sessões órfãs e fechamento do mês. |
| Guia de Implantação | Instalação e carga inicial de vagas, moradores e tarifa. |
