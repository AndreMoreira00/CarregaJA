# Visão

**Versão 3.0**

**CARREGAJA - Sistema de Controle e Rateio de Recarga de Veículos Elétricos em Condomínio**

## Histórico de Revisões

| Data | Versão | Descrição | Autor |
|---|---|---|---|
| 19/08/2026 | 1.0 | Elaboração inicial do documento. Seções 1 a 6. | Henrique de Almeida Marangoni Inacio |
| 19/08/2026 | 1.1 | Encerramento da sessão transferido do totem para o ponto de pagamento do estabelecimento. Inclusão do perfil Operador de Caixa. Nova seção 4.4 com as limitações decorrentes da ausência de integração com hardware. Revisão dos riscos. | Henrique de Almeida Marangoni Inacio |
| 27/08/2026 | 2.0 | **Redução de escopo.** O produto deixa de ser um SaaS por assinatura para estacionamentos comerciais e passa a ser um sistema para um condomínio residencial específico. Eliminados os perfis Estabelecimento, Operador de Caixa e Administrador do Sistema, o totem, o uso anônimo e o ponto de pagamento. Incluído o **agendamento de vagas**. A apuração passa de tempo de ocupação para **energia estimada rateada na conta do condômino**. Seções 1 a 6 reescritas. | Henrique de Almeida Marangoni Inacio |
| 27/08/2026 | 3.0 | **Remoção do agendamento.** O uso passa a ser exclusivamente por chegada: o morador consulta o painel, ocupa uma vaga livre e registra o início. Eliminados o agendamento, a reserva, a tolerância de comparecimento e o ator temporal. A **duração máxima de sessão** passa a ser o único instrumento de rotatividade. Removidos os problemas de reserva não utilizada e de concentração de reservas, e os riscos correspondentes. Incluído o risco da disputa não mediada. | Henrique de Almeida Marangoni Inacio |

> **Nota sobre a versão 3.0.** O agendamento foi removido por um defeito de concepção
> identificado em revisão: ele exigia que o morador informasse, no momento de reservar, o nível
> de bateria que teria horas depois — um dado que ninguém pode saber. A correção óbvia, reservar
> um bloco fixo do tamanho do pior caso, criava fragmentação: reservava-se seis horas, usavam-se
> quatro, e as duas restantes ficavam presas entre duas reservas. Antecipar a reserva seguinte
> deslocaria a próxima, e a próxima, em cascata. A equipe optou por remover o mecanismo em vez
> de acumular regras para contorná-lo. O registro completo do raciocínio está na seção 1.1.

## 1. Introdução

### 1.1. Resumo do Negócio

Condomínios residenciais verticais vêm instalando pontos de recarga para veículos elétricos nas
áreas comuns da garagem. O número de pontos é pequeno — tipicamente um a quatro — e é
compartilhado por dezenas de apartamentos. A energia consumida sai da conta de luz da área
comum, ou seja, é paga por todos os condôminos, inclusive por quem não possui veículo elétrico.

Disso decorrem dois problemas simultâneos. O primeiro é de **disputa pelo recurso**: com poucos
pontos para muitos moradores, o morador desce à garagem sem saber se encontrará ponto livre, e
quando encontra tudo ocupado não tem como saber quando algum será liberado. O segundo é de
**rateio**: sem registro de quem usou, por quanto tempo e com qual veículo, o condomínio não
consegue individualizar o custo, e a energia de poucos acaba dividida entre todos — situação
que gera atrito em assembleia e desestimula o próprio investimento em novos pontos.

Na prática, os condomínios hoje recorrem a controles paralelos: grupo de mensagens para
combinar o uso, planilha do síndico, ou simplesmente rodízio informal. Nenhum desses controles
produz um número defensável para lançar na cota condominial.

O CARREGAJA é um sistema destinado a **um condomínio específico**, utilizado pelos moradores
como aplicação web pelo celular. Ele permite consultar quais vagas estão livres e quando as
ocupadas serão liberadas, registrar a recarga realizada, e apurar mensalmente quanto cada
apartamento consumiu — produzindo o valor a ser lançado na conta do condômino.

> **Redução de escopo em relação à versão 1.1.** A versão anterior descrevia um SaaS por
> assinatura para estacionamentos comerciais — shoppings, supermercados, restaurantes, hotéis —
> com quatro perfis de usuário, totem de autoatendimento, motorista anônimo e encerramento no
> ponto de pagamento. A equipe avaliou que aquele escopo era **incompatível com o prazo e a
> capacidade disponíveis** (restrições RE-13 e RE-14): exigia multiempresa, gestão de
> assinantes, dois canais de interface distintos e um perfil operacional adicional. O domínio
> do condomínio preserva o mesmo núcleo técnico — previsão de conclusão a partir das
> características do veículo — em um recorte executável no semestre.

#### Por que não há agendamento

A versão 2.0 deste documento previa o agendamento de vagas. Ele foi removido na versão 3.0, e o
motivo importa para que não seja reintroduzido sem tratar o que o inviabilizou.

**O agendamento exigia um dado que não existe no momento de agendar.** Para calcular quanto
tempo a vaga ficaria ocupada, o sistema precisa do nível da bateria. Mas quem reserva às
quatorze horas para chegar às dezoito não sabe com quanta carga chegará — depende do trânsito,
de um desvio, de um trajeto a mais. Qualquer valor informado ali é chute, e era sobre esse chute
que a janela reservada seria dimensionada.

**Corrigir isso criava fragmentação.** A alternativa era reservar sempre um bloco do tamanho do
pior caso — seis horas — e deixar o cálculo real para a chegada. Só que aí o morador que
precisava de quatro horas prendia seis, e as duas restantes ficavam encravadas entre a saída
dele e a reserva seguinte, inutilizáveis.

**E resolver a fragmentação criava cascata.** Antecipar a reserva seguinte para ocupar o buraco
deslocaria a que vem depois, que deslocaria a seguinte. Cada ajuste propagaria por toda a
agenda do dia, e um morador que reservou as vinte horas poderia ver seu horário mudar várias
vezes sem ter feito nada.

A equipe optou por **remover o mecanismo em vez de acumular regras para contorná-lo**. O uso
passa a ser por ordem de chegada, e o painel de vagas — com a previsão de liberação de cada
vaga ocupada — é o que permite ao morador decidir quando descer. É menos do que uma garantia de
horário, e essa perda está registrada como risco RI-11.

### 1.2. Objetivo do Sistema

O objetivo do sistema é dar visibilidade ao uso compartilhado das vagas com carregador do
condomínio e individualizar o custo da energia.

Ao morador, pela aplicação web no celular:

- Consultar quais vagas com carregador estão livres e quais estão ocupadas, com a previsão de
  liberação das ocupadas;
- Registrar o início da recarga ao chegar à garagem, informando a vaga utilizada e o nível
  atual da bateria;
- Consultar a previsão de conclusão da própria recarga;
- Encerrar a própria sessão ao retirar o veículo;
- Manter o cadastro do próprio veículo;
- Acompanhar o consumo acumulado do mês e o valor correspondente.

Ao síndico:

- Cadastrar as vagas com carregador e a potência de cada uma;
- Definir a tarifa por quilowatt-hora praticada no rateio;
- Manter o cadastro dos moradores e dos apartamentos com acesso ao sistema;
- Acompanhar o painel de vagas e tratar sessões não encerradas;
- Fechar o mês, obtendo o consumo e o valor apurado por apartamento para lançamento na cota
  condominial;
- Consultar o histórico de utilização por vaga, por apartamento e por período.

### 1.3. Glossário

| Termo | Definição |
|---|---|
| Apartamento | Unidade autônoma do condomínio. É a ele, e não à pessoa, que o consumo é atribuído para efeito de rateio. |
| Capacidade da Bateria | Energia total que a bateria do veículo armazena quando cheia, em kWh. Informada no cadastro do veículo. |
| Duração Máxima de Sessão | Tempo limite de uma sessão de recarga, contado do início. Atingido o limite, a sessão é sinalizada como excedida, mas **não é encerrada automaticamente**. Padrão inicial de 6 horas, ajustável pelo síndico conforme o parque de carregadores. |
| Energia Estimada | Quantidade de energia atribuída a uma sessão de recarga, calculada a partir da potência efetiva e da duração, limitada pela energia que faltava na bateria. Base do rateio. |
| Fechamento do Mês | Operação pela qual o síndico consolida as sessões encerradas do período e obtém o valor devido por apartamento. Após o fechamento, o período não aceita novas sessões nem alterações. |
| kW (quilowatt) | Unidade de potência. Indica a velocidade com que a energia é transferida ao veículo. |
| kWh (quilowatt-hora) | Unidade de energia. Corresponde à quantidade de energia transferida ao veículo, e é a unidade em que a concessionária cobra o condomínio. |
| Morador | Perfil de usuário correspondente ao condômino ou residente autorizado. Identifica-se por login e está vinculado a um apartamento. |
| Nível de Bateria | Percentual de carga da bateria no momento em que o morador inicia a sessão. Informado por ele. |
| Painel de Vagas | Tela que exibe a situação de todas as vagas com carregador do condomínio — livre, ocupada ou excedida — com a previsão de liberação das ocupadas. |
| Potência Efetiva | Menor valor entre a potência do carregador da vaga e a potência máxima de recarga aceita pelo veículo. É a potência realmente aplicada na recarga. |
| Rateio | Distribuição do custo da energia das áreas comuns entre os apartamentos, proporcional ao consumo apurado de cada um. |
| Sessão de Recarga | Registro do uso de uma vaga com carregador por um veículo, do momento em que o morador registra o início até o momento em que registra o encerramento. |
| Sessão Excedida | Sessão de recarga que ultrapassou a duração máxima. Permanece aberta e é sinalizada no painel. Distingue-se da Sessão Órfã, que é aquela cujo veículo já foi retirado. |
| Sessão Órfã | Sessão de recarga que permanece aberta muito além do tempo estimado de conclusão, indicando que o morador retirou o veículo sem encerrá-la no sistema. |
| Síndico | Perfil de usuário correspondente ao responsável pela administração do condomínio. Configura o sistema, trata exceções e fecha o mês. |
| Tarifa de Energia | Valor por quilowatt-hora aplicado no rateio, definido pelo síndico a partir da conta de luz da área comum. |
| Vaga com Carregador | Vaga da área comum equipada com ponto de recarga, identificada por um código e associada a uma potência. |
| Veículo | Automóvel elétrico cadastrado por um morador, com modelo, capacidade de bateria e potência máxima de recarga. |

### 1.4. Referências

| Documento | Origem |
|---|---|
| SpinOff - Processo de Desenvolvimento de Sistemas | http://arum.tec.br/SpinOff/index.htm |
| Guia - Requisitos de Sistema de Software | SpinOff / Guidelines |
| Guia - INVEST | SpinOff / Guidelines |
| Guia - Políticas de Gerenciamento de Configuração | SpinOff / Guidelines |
| Template do Visão | SpinOff / Templates |
| CARREGAJA - Modelo de Caso de Uso (v3.0) | 2.Analise e Design/ |
| CARREGAJA - História de Usuário (v2.0) | 1.Requisitos/Casos de Uso/ |
| CARREGAJA - Planejamento e Controle do Projeto | 6.Gerenciamento de Projeto/ |

## 2. Problema

Esta seção apresenta a análise do problema: o entendimento da situação atual, a identificação
dos envolvidos afetados, os impactos gerados e a delimitação do escopo em alto nível,
representado pelas necessidades dos envolvidos.

### 2.1. Energia de poucos rateada entre todos

|   |   |
|---|---|
| **Problema** | A energia consumida na recarga sai da conta de luz da área comum, paga por todos os condôminos. Sem registro individualizado de uso, não há como atribuir o custo a quem o gerou. |
| **Afetados** | Todos os condôminos, especialmente os que não possuem veículo elétrico; síndico; administradora do condomínio. |
| **Impacto** | Subsídio involuntário de uma minoria por uma maioria; atrito em assembleia; resistência à instalação de novos pontos de recarga, já que ampliar a estrutura amplia o custo dividido. |
| **Necessidades (Escopo)** | Como síndico, eu quero apurar o consumo de energia de cada apartamento no período, de modo que eu possa lançar o valor correspondente na cota condominial.<br>Como síndico, eu quero definir a tarifa por quilowatt-hora aplicada no rateio, de modo que o valor cobrado acompanhe a conta de luz da área comum.<br>Como morador, eu quero acompanhar meu consumo acumulado no mês, de modo que eu saiba quanto será lançado na minha conta antes de recebê-la. |

### 2.2. Disputa por um recurso escasso, sem informação de disponibilidade

|   |   |
|---|---|
| **Problema** | O condomínio tem poucas vagas com carregador para muitos apartamentos. O morador desce à garagem sem saber se há vaga livre e, ao encontrá-las ocupadas, não tem como saber quando alguma será liberada. |
| **Afetados** | Moradores com veículo elétrico; síndico e porteiro, procurados para mediar conflitos. |
| **Impacto** | Descidas perdidas à garagem; conflito entre vizinhos pelo uso; combinação informal por grupo de mensagens, que não deixa registro nem garante nada; veículo que fica sem carga porque o morador não conseguiu prever a disponibilidade. |
| **Necessidades (Escopo)** | Como morador, eu quero ver quais vagas com carregador estão livres e quais estão ocupadas, de modo que eu não desça à garagem à toa.<br>Como morador, eu quero ver a previsão de liberação das vagas ocupadas, de modo que eu possa decidir quando descer.<br>Como morador, eu quero ocupar uma vaga livre e registrar o uso na hora em que chego, de modo que o painel reflita a garagem real para os demais. |

> **O que o sistema entrega aqui, e o que não entrega.** Ele entrega **informação para decidir
> quando descer** — não garantia de vaga. O uso é por ordem de chegada: dois moradores podem
> descer ao ver a mesma vaga livre, e quem chegar primeiro a ocupa. A alternativa seria o
> agendamento, removido na versão 3.0 pelos motivos da seção 1.1. A consequência está
> registrada como risco RI-11.

### 2.3. Ausência de previsão de quanto tempo a recarga levará

|   |   |
|---|---|
| **Problema** | O tempo de recarga não depende apenas do carregador: depende também da capacidade da bateria do veículo e da potência máxima que ele aceita. Um carregador de 22 kW não recarrega mais rápido um veículo que aceita no máximo 6,6 kW. Sem essa informação, nem o morador sabe quando sua recarga termina, nem os demais sabem quando a vaga será liberada. |
| **Afetados** | Moradores com veículo elétrico. |
| **Impacto** | Previsões de liberação erradas no painel, que derrubam a confiança na informação e levam o morador de volta ao combinado informal; permanência desnecessária junto ao veículo por não saber quando a recarga termina. |
| **Necessidades (Escopo)** | Como morador, eu quero cadastrar meu veículo com a capacidade da bateria e a potência máxima de recarga, de modo que o sistema calcule previsões corretas para mim.<br>Como morador, eu quero informar o nível atual da bateria ao iniciar a recarga, de modo que o sistema estime quando ela será concluída.<br>Como morador, eu quero que a previsão da minha recarga fique visível aos demais, de modo que quem espera saiba quando a vaga será liberada. |

### 2.4. Ocupação da vaga além do tempo necessário

|   |   |
|---|---|
| **Problema** | O veículo permanece na vaga depois de a recarga ter concluído, ou por tempo indefinidamente longo. Como o sistema não controla o carregador, ele **não tem como liberar a vaga** — só como sinalizar a situação a quem espera e ao síndico. |
| **Afetados** | Moradores que aguardam a vaga; síndico, acionado para mediar. |
| **Impacto** | Redução da rotatividade de um recurso escasso; morador que desce à garagem confiando na previsão do painel e encontra a vaga ainda ocupada; conflito entre vizinhos. |
| **Necessidades (Escopo)** | Como morador, eu quero que exista um limite máximo de duração para qualquer sessão, de modo que nenhuma ocupação se estenda indefinidamente.<br>Como morador, eu quero ver no painel que uma sessão já concluiu a recarga ou ultrapassou o limite máximo, de modo que eu saiba que a vaga deveria estar sendo liberada.<br>Como síndico, eu quero identificar as sessões que ultrapassaram o limite máximo, de modo que eu possa intervir junto ao morador. |

> **Limitação assumida.** O sistema **não impede** fisicamente a permanência — a restrição RE-05
> vale aqui integralmente. O que ele oferece é limite declarado, sinalização e registro:
> instrumentos de convivência, não de bloqueio. A eliminação do problema exige controle do
> carregador; ver seção 4.4.

### 2.5. Veículo retirado sem encerramento da sessão

|   |   |
|---|---|
| **Problema** | O morador retira o veículo e vai embora sem registrar o encerramento no sistema. A vaga continua constando como ocupada e a sessão segue aberta indefinidamente. |
| **Afetados** | Moradores que aguardam a vaga; síndico; o próprio morador, cujo consumo seria apurado a maior. |
| **Impacto** | Vaga exibida como ocupada enquanto está livre, anulando a utilidade do painel; apuração incorreta no fechamento do mês; necessidade de intervenção manual do síndico. |
| **Necessidades (Escopo)** | Como síndico, eu quero identificar as sessões abertas muito além do tempo previsto de conclusão, de modo que eu possa encerrá-las e liberar a vaga.<br>Como síndico, eu quero que o encerramento administrativo fique registrado, de modo que o morador possa contestar a apuração com base no que foi lançado. |

### 2.6. Falta de histórico para decidir sobre a estrutura

|   |   |
|---|---|
| **Problema** | O condomínio não dispõe de dados sobre a utilização das vagas: quantas horas por dia ficam ocupadas, em que faixas de horário, quantos apartamentos as utilizam e quanta demanda fica reprimida. |
| **Afetados** | Síndico; assembleia de condôminos. |
| **Impacto** | Decisão sobre instalar novos pontos tomada por impressão, e não por dado; investimento superdimensionado ou insuficiente; discussão em assembleia sem base objetiva. |
| **Necessidades (Escopo)** | Como síndico, eu quero consultar o histórico de utilização por vaga, por apartamento e por período, de modo que eu possa levar dados à assembleia ao propor a ampliação da estrutura.<br>Como síndico, eu quero saber quantas vezes um morador tentou iniciar uma recarga e não encontrou vaga, de modo que eu possa dimensionar a demanda reprimida. |

## 3. Usuários

### 3.1. Fornecedores de requisitos

| Nome | Responsável/Cargo | E-mail | Responsabilidades |
|---|---|---|---|
| Matheus Ribeiro Andrade | Product Owner | ribeiro.andrade@aluno.ifsp.edu.br | Representar os interesses do cliente perante a equipe; definir e priorizar as funcionalidades do produto; aprovar o escopo e o planejamento; aceitar ou rejeitar os resultados de trabalho. |
| Henrique de Almeida Marangoni Inacio | Scrum Master | henrique.marangoni@aluno.ifsp.edu.br | Garantir a aderência ao processo definido; manter o planejamento e o controle do projeto; conduzir os eventos do processo; remover impedimentos da equipe. |
| André Fernandes Nascimento Moreira | Desenvolvedor | andre.moreira@aluno.ifsp.edu.br | Participar da análise do domínio e do levantamento de necessidades; executar as atividades de desenvolvimento, dos requisitos à implantação. |
| Alex Junior Fortunato Sacramento | Desenvolvedor | alex.sacramento@aluno.ifsp.edu.br | Participar da análise do domínio e do levantamento de necessidades; executar as atividades de desenvolvimento, dos requisitos à implantação. |

**Nota sobre a origem dos requisitos.**

Este projeto é conduzido em contexto acadêmico e não dispõe de um cliente externo contratante.
As necessidades registradas na seção 2 foram levantadas pela equipe a partir da análise do
domínio, e o Product Owner atua como representante do cliente para efeito de aprovação do
escopo e do planejamento, conforme previsto no processo SpinOff para o papel.

### 3.2. Perfis de usuário do sistema

| Perfil | Quem é | Responsabilidades no sistema |
|---|---|---|
| Morador | Condômino ou residente autorizado, proprietário de veículo elétrico. Vinculado a um apartamento, que é a unidade de rateio. | Consultar o painel de vagas; registrar início e encerramento da própria sessão de recarga; manter o cadastro do próprio veículo; consultar o consumo acumulado do mês. **Não** altera tarifa, **não** cadastra vagas e **não** acessa dados de outros apartamentos. |
| Síndico | Responsável pela administração do condomínio, eleito em assembleia, ou preposto da administradora. | Cadastrar vagas com carregador e respectivas potências; definir a tarifa de energia; manter o cadastro de moradores e apartamentos; acompanhar o painel; encerrar sessões órfãs; fechar o mês e obter o rateio; consultar o histórico de utilização. |

**Nota sobre a acumulação de perfis.** O síndico é também um condômino e pode possuir veículo
elétrico. Nesse caso ele acumula os dois perfis: usa o sistema como morador para suas próprias
recargas — que são apuradas e rateadas como as demais — e como síndico para a gestão. As ações
de gestão ficam registradas com o usuário que as realizou.

## 4. Restrições Impostas

As restrições abaixo são impostas ao sistema ou ao processo de desenvolvimento. Elas devem ser
tratadas como requisitos não funcionais e, quando aplicável, também como riscos ao projeto.

### 4.1. Restrições de tecnologia e implementação

| # | Restrição |
|---|---|
| RE-01 | O sistema deve ser desenvolvido como aplicação web. |
| RE-02 | O sistema deve ser implementado na linguagem Java, em conformidade com a disciplina Linguagem de Programação 2, com a qual este projeto é integrado. |
| RE-03 | A interface deve ser utilizável em navegador de celular, sem exigir aplicativo nativo instalado, uma vez que o morador a acessa da garagem e de dentro do apartamento. |
| RE-04 | O sistema deve funcionar independentemente do sistema operacional do cliente. |

### 4.2. Restrições de escopo funcional

| # | Restrição |
|---|---|
| RE-05 | **O sistema não se integra ao hardware dos carregadores.** O estado de ocupação das vagas, o início e o fim das sessões são determinados exclusivamente pelas informações registradas pelos moradores. O sistema não aciona, não bloqueia e não mede o equipamento de recarga. Ver seção 4.4. |
| RE-06 | **O sistema não processa pagamento e não emite cobrança.** Ele apura o consumo e o valor por apartamento no período e os disponibiliza ao síndico, que os repassa à administradora para lançamento na cota condominial pelos meios já utilizados pelo condomínio. |
| RE-07 | **O sistema atende a um único condomínio.** Não há multiempresa, gestão de assinantes nem separação de dados por cliente contratante. Uma eventual instalação em outro condomínio é uma nova implantação, com sua própria base. |
| RE-08 | **O morador possui cadastro e credenciais.** Todo uso do sistema é identificado e vinculado a um apartamento; não há uso anônimo. O cadastro de moradores é mantido pelo síndico. |
| RE-09 | A energia atribuída a cada sessão é **estimada** a partir da potência efetiva e da duração, não medida, uma vez que o sistema não dispõe de medição no carregador. Ver seção 4.4. |
| RE-10 | **O sistema não integra com o sistema da administradora do condomínio.** O resultado do fechamento do mês é obtido em tela e exportável, e o lançamento na cota é feito fora do sistema. |
| RE-11 | **A duração máxima de uma sessão de recarga é de 6 horas.** Atingido o limite, o sistema **sinaliza a sessão como excedida** no painel e a mantém aberta — **não a encerra automaticamente**. O encerramento continua sendo do morador ou, na sua ausência, do síndico pela via administrativa. |
| RE-12 | **Não há agendamento nem reserva de vagas.** O uso é por ordem de chegada: o morador consulta o painel, ocupa uma vaga livre e registra o início. O sistema informa disponibilidade e previsão de liberação, mas não garante vaga a ninguém. Ver seção 1.1. |

**Sobre o limite de 6 horas (RE-11).** O valor cobre uma recarga completa na maioria dos
carregadores residenciais — uma bateria de 55 kWh, de 20% a 100%, leva cerca de 6 horas em um
carregador de 7,4 kW e 4 horas em um de 11 kW. Carregadores mais lentos, de 3,7 kW, não
completam a carga dentro do limite; nesses casos a recarga é concluída em mais de uma sessão.

**Por que sinalizar e não encerrar automaticamente.** O encerramento automático liberaria a
vaga no painel enquanto o veículo ainda estivesse fisicamente plugado, exibindo como livre uma
vaga ocupada — o mesmo defeito que o sistema tenta combater. Mantendo a sessão aberta e
sinalizada, o painel continua refletindo a realidade física, e a decisão de encerrar fica com
quem pode verificá-la. O custo dessa escolha é depender de intervenção humana.

**Com a remoção do agendamento, RE-11 passa a ser o único instrumento de rotatividade do
sistema.** Não há mais reserva que force a liberação nem fila que organize a ordem: o que
limita a ocupação é o teto de duração e a sinalização no painel.

### 4.3. Restrições de projeto

| # | Restrição |
|---|---|
| RE-13 | O sistema deve ser entregue até o encerramento do semestre letivo 2026.2. |
| RE-14 | A equipe é composta por quatro estudantes, com dedicação parcial, sem orçamento financeiro para aquisição de licenças, serviços ou equipamentos. |
| RE-15 | O desenvolvimento deve seguir o processo SpinOff, com os artefatos e a estrutura de repositório por ele definidos. |
| RE-16 | Não há cliente externo disponível para elicitação e validação de requisitos; o Product Owner atua como representante do cliente. |

### 4.4. Limitações decorrentes da ausência de integração com hardware

As restrições RE-05 e RE-09 determinam que o sistema conheça o mundo físico apenas por
declaração dos moradores, nunca por medição. A tabela abaixo registra o que isso impede e o que
seria possível com carregadores dotados de gestão remota, do tipo que implementa o protocolo
OCPP. O cenário ideal descreve a solução completa do problema e está **fora do escopo deste
projeto**; ele é registrado para deixar explícito que a limitação é conhecida e foi aceita
conscientemente.

| Limitação atual | Cenário ideal (requer equipamento fora do escopo) |
|---|---|
| O sistema não mede a energia entregue ao veículo; estima a partir de potência e tempo. | A medição viria do carregador, tornando o rateio exato e conferível contra a conta de luz da área comum. |
| O sistema não impede o uso do carregador sem sessão registrada. | O carregador permaneceria desenergizado até o início de uma sessão, tornando impossível recarregar sem registro e sem rateio. |
| O sistema não detecta a presença do veículo na vaga; depende do que foi declarado. | Um sensor de ocupação confirmaria chegada e saída, eliminando sessões órfãs e vagas exibidas incorretamente. |
| O sistema não conhece o nível real da bateria; depende do valor informado. | A leitura viria do veículo pelo carregador, tornando a previsão exata e dispensando o cadastro de capacidade e potência. |
| O sistema não interrompe o fornecimento ao concluir a recarga. | O fornecimento cessaria automaticamente, e a vaga poderia sinalizar fisicamente que está liberada para o próximo. |
| O sistema não organiza a ordem de uso quando há mais interessados que vagas. | Com identificação no carregador, seria possível liberar o ponto apenas para o morador da vez, viabilizando fila ou rodízio com garantia real. |

## 5. Riscos

| # | Risco | Impacto | Resposta |
|---|---|---|---|
| RI-01 | **Dados de veículo cadastrados incorretamente** — capacidade de bateria ou potência máxima informadas de forma equivocada pelo morador. | Previsão de conclusão incorreta **e apuração de energia incorreta** — o dado declarado afeta o valor rateado. | **Mitigar.** O cadastro do veículo é feito uma única vez e fica visível ao síndico, que pode conferi-lo contra o documento do veículo. O sistema exibe a energia estimada ao morador ao encerrar cada sessão, permitindo contestação imediata. Divergência sistemática entre o total apurado e a conta de luz da área comum é sinal de dado incorreto. |
| RI-02 | **Uso do carregador sem registro de sessão** — o morador pluga o veículo sem abrir sessão no sistema. | Energia consumida sem rateio, recaindo sobre todos os condôminos; vaga exibida como livre no painel. | **Mitigar.** O sistema não controla fisicamente os carregadores (RE-05). Mitigação: o painel permite conferência visual entre as vagas exibidas como livres e as efetivamente ocupadas, e o confronto entre o total apurado no fechamento e a conta de luz da área comum revela consumo não registrado. Por ser comunidade fechada e identificada, o controle social é instrumento relevante — situação distinta da do motorista anônimo da versão 1.1. |
| RI-03 | **Sessão órfã** — o morador retira o veículo sem encerrar a sessão. | Vaga permanece indisponível no painel; energia continua sendo estimada indevidamente. | **Mitigar.** O sistema sinaliza as sessões abertas além do tempo estimado de conclusão. O síndico as encerra administrativamente, e a energia estimada é limitada pela energia que faltava na bateria, o que impede que a apuração cresça indefinidamente. |
| RI-04 | **Ocupação da vaga após a conclusão da recarga** — o veículo permanece plugado depois de carregado. | Redução da rotatividade de um recurso escasso; morador que desce confiando na previsão encontra a vaga ocupada. | **Aceitar, com mitigação parcial.** Como a apuração é por energia e esta é limitada pela carga que faltava, permanecer na vaga após a conclusão **não tem custo** — ao contrário da versão 1.1, em que a cobrança por tempo desestimulava a permanência. Removido o agendamento, o instrumento de rotatividade passa a ser **apenas** a duração máxima (RE-11) e a sinalização no painel. A eliminação completa exige instrumento de convivência do condomínio, fora do sistema. |
| RI-05 | **Divergência entre o total apurado e a conta de luz da área comum** — a soma das estimativas não fecha com o consumo real medido pela concessionária. | Rateio contestável em assembleia; perda de confiança no sistema. | **Mitigar.** A apuração é por estimativa e assim deve ser apresentada. O fechamento do mês exibe o total estimado do período, permitindo ao síndico compará-lo com a conta e aplicar critério de ajuste proporcional, se a assembleia assim deliberar. A eliminação da divergência exige medição — ver seção 4.4. |
| RI-06 | **Indisponibilidade dos integrantes da equipe** — conciliação com as demais disciplinas do semestre. | Atraso nas entregas planejadas; comprometimento do prazo (RE-13). | **Mitigar.** Planejamento com entregas incrementais por Sprint, revisão do planejamento antes de cada Sprint e acompanhamento diário do quadro de tarefas. |
| RI-07 | **Ausência de cliente real para validação dos requisitos** (RE-16). | Requisitos validados apenas internamente, com risco de premissas incorretas sobre o domínio não serem detectadas. | **Mitigar.** Registro explícito das premissas assumidas; validação do escopo e do planejamento pelo Product Owner; revisão dos requisitos a cada Sprint. |
| RI-08 | **Complexidade subestimada do cálculo de previsão e de apuração** — regras de potência efetiva e de limite de energia mais complexas do que o previsto. | Retrabalho na Elaboração; atraso na definição da arquitetura. | **Mitigar.** As funcionalidades de previsão de conclusão e de apuração de energia serão tratadas com prioridade na fase de Elaboração, como parte da arquitetura executável, por concentrarem o maior risco técnico do projeto. |
| RI-09 | **Nova mudança de escopo** — o escopo já foi alterado duas vezes: reduzido na versão 2.0 e novamente na 3.0, com a remoção do agendamento. | Retrabalho nos artefatos de requisitos e análise; consumo de prazo já restrito (RE-13); risco de o escopo não estabilizar a tempo da aprovação. | **Mitigar.** As duas alterações decorreram de defeitos identificados em revisão, não de mudança de opinião — o que sugere que revisar antes de aprovar está funcionando. Daqui em diante, novas alterações passam por Requisição de Mudança, com análise de impacto pelo Product Owner, conforme o processo de controle de mudanças do SpinOff. |
| RI-10 | **Limite de duração inadequado ao parque de carregadores** — 6 horas não bastam se o condomínio instalar carregadores lentos, de 3,7 kW, em que uma carga completa passa de 11 horas. | Moradores obrigados a dividir a recarga em várias sessões; percepção de que o sistema atrapalha em vez de organizar. | **Mitigar.** O limite é **parâmetro de configuração**, não valor fixo em código: o síndico o ajusta se o parque de carregadores exigir. O valor de 6 horas é o padrão inicial, dimensionado para carregadores de 7,4 kW e 11 kW. |
| RI-11 | **Disputa não mediada pelo sistema** — removido o agendamento (RE-12), o uso é por ordem de chegada. Dois moradores podem descer ao ver a mesma vaga livre, e quem perde a corrida desce à toa. | Frustração e conflito entre vizinhos; retorno à combinação informal por grupo de mensagens, que o sistema pretendia substituir; morador com rotina menos flexível sistematicamente preterido. | **Aceitar, com mitigação parcial.** O painel reduz o problema ao informar a previsão de liberação, o que evita a maior parte das descidas inúteis, mas não elimina a corrida pela vaga recém-liberada. A demanda reprimida é medida (seção 2.6) e levada à assembleia: se o dado mostrar disputa frequente, a resposta correta é **ampliar a estrutura**, não acrescentar regra de software. Um mecanismo de fila poderá ser avaliado em versão futura, mediante Requisição de Mudança. |

## 6. Requisitos de Documentação

A documentação a seguir deverá ser desenvolvida para suportar a implantação e o uso do sistema:

| Documento | Público | Conteúdo previsto |
|---|---|---|
| Manual do Usuário - Morador | Condôminos com veículo elétrico | Cadastro do veículo; consulta ao painel; registro de início e encerramento da recarga; consulta ao consumo do mês. Deve ser sucinto e disponibilizado como **ajuda contextual nas próprias telas**, dado que o morador o acessa pelo celular e sem treinamento prévio. |
| Manual do Usuário - Síndico | Síndico e preposto da administradora | Cadastro de vagas e potências; definição da tarifa; manutenção do cadastro de moradores; tratamento de sessões órfãs; fechamento do mês e leitura do rateio; consulta ao histórico. |
| Guia de Implantação | Equipe de desenvolvimento e responsável técnico do condomínio | Procedimento de instalação e configuração do sistema no ambiente do condomínio; carga inicial de vagas, moradores e tarifa. |
