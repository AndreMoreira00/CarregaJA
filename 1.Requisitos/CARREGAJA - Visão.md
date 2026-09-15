# Visão

**Versão 3.1**

**CARREGAJA - Sistema de Controle e Rateio de Recarga de Veículos Elétricos em Condomínio**

## 1. Introdução

### 1.1. Resumo do Negócio

Condomínios residenciais verticais vêm instalando pontos de recarga para veículos elétricos nas
áreas comuns da garagem. O número de pontos é pequeno — tipicamente de um a quatro — e é
compartilhado por dezenas de apartamentos. A energia consumida sai da conta de luz da área
comum, paga por todos os condôminos, inclusive por quem não possui veículo elétrico.

Disso decorrem dois problemas simultâneos. O primeiro é de **disputa pelo recurso**: o morador
desce à garagem sem saber se encontrará ponto livre e, quando encontra tudo ocupado, não tem
como saber quando algum será liberado. O segundo é de **rateio**: sem registro de quem usou, por
quanto tempo e com qual veículo, o condomínio não individualiza o custo, e a energia de poucos
acaba dividida entre todos. Os controles paralelos hoje usados — grupo de mensagens, planilha do
síndico, rodízio informal — não produzem número defensável para lançar na cota condominial.

O CARREGAJA é um sistema destinado a **um condomínio específico**, usado pelos moradores como
aplicação web pelo celular. Ele permite consultar quais vagas estão livres e quando as ocupadas
serão liberadas, registrar a recarga realizada e apurar mensalmente quanto cada apartamento
consumiu.

### 1.2. Objetivo do Sistema

Dar visibilidade ao uso compartilhado das vagas com carregador e individualizar o custo da
energia.

Ao **morador**, pela aplicação web no celular: consultar as vagas livres e ocupadas, com a
previsão de liberação destas; registrar o início da recarga ao chegar, informando a vaga e o
nível atual da bateria; consultar a previsão de conclusão da própria recarga; encerrar a própria
sessão; manter o cadastro do próprio veículo; acompanhar o consumo acumulado do mês e o valor
correspondente.

Ao **síndico**: cadastrar as vagas com carregador e a potência de cada uma; definir a tarifa por
quilowatt-hora do rateio; manter o cadastro de moradores e apartamentos; acompanhar o painel e
tratar sessões não encerradas; fechar o mês, obtendo o consumo e o valor por apartamento para
lançamento na cota condominial; consultar o histórico de utilização por vaga, apartamento e
período.

### 1.3. Glossário

| Termo | Definição |
|---|---|
| Apartamento | Unidade autônoma do condomínio. É a ele, e não à pessoa, que o consumo é atribuído no rateio. |
| Capacidade da Bateria | Energia total que a bateria armazena quando cheia, em kWh. Informada no cadastro do veículo. |
| Duração Máxima de Sessão | Tempo limite de uma sessão, contado do início. Atingido o limite, a sessão é sinalizada como excedida, mas **não é encerrada automaticamente**. Padrão inicial de 6 horas, ajustável pelo síndico. |
| Energia Estimada | Energia atribuída a uma sessão, calculada a partir da potência efetiva e da duração, limitada pela energia que faltava na bateria. Base do rateio. |
| Fechamento do Mês | Operação pela qual o síndico consolida as sessões encerradas do período e obtém o valor devido por apartamento. Depois dele, o período não aceita novas sessões nem alterações. |
| kW (quilowatt) | Unidade de potência. Indica a velocidade com que a energia é transferida ao veículo. |
| kWh (quilowatt-hora) | Unidade de energia. É a unidade em que a concessionária cobra o condomínio. |
| Morador | Condômino ou residente autorizado. Identifica-se por login e está vinculado a um apartamento. |
| Nível de Bateria | Percentual de carga no momento em que o morador inicia a sessão. Informado por ele. |
| Painel de Vagas | Tela que exibe a situação de todas as vagas — livre, ocupada ou excedida — com a previsão de liberação das ocupadas. |
| Potência Efetiva | Menor valor entre a potência do carregador da vaga e a potência máxima aceita pelo veículo. É a potência realmente aplicada. |
| Rateio | Distribuição do custo da energia da área comum entre os apartamentos, proporcional ao consumo apurado de cada um. |
| Sessão de Recarga | Registro do uso de uma vaga por um veículo, do início ao encerramento declarados pelo morador. |
| Sessão Excedida | Sessão que ultrapassou a duração máxima. Permanece aberta e é sinalizada no painel. Distingue-se da Sessão Órfã, cujo veículo já foi retirado. |
| Sessão Órfã | Sessão que permanece aberta muito além do tempo estimado de conclusão, indicando que o veículo foi retirado sem encerramento no sistema. |
| Síndico | Responsável pela administração do condomínio. Configura o sistema, trata exceções e fecha o mês. |
| Tarifa de Energia | Valor por quilowatt-hora aplicado no rateio, definido pelo síndico a partir da conta de luz da área comum. |
| Vaga com Carregador | Vaga da área comum equipada com ponto de recarga, identificada por um código e associada a uma potência. |
| Veículo | Automóvel elétrico cadastrado por um morador, com modelo, capacidade de bateria e potência máxima de recarga. |

### 1.4. Referências

| Documento | Origem |
|---|---|
| SpinOff - Processo de Desenvolvimento de Sistemas | http://arum.tec.br/SpinOff/index.htm |
| Guia - Requisitos de Sistema de Software | SpinOff / Guidelines |
| Guia - Políticas de Gerenciamento de Configuração | SpinOff / Guidelines |
| Template do Visão | SpinOff / Templates |
| CARREGAJA - Modelo de Caso de Uso (v3.0) | 2.Analise e Design/ |
| CARREGAJA - História de Usuário (v3.0) | 1.Requisitos/Casos de Uso/ |
| CARREGAJA - Planejamento e Controle do Projeto | 6.Gerenciamento de Projeto/ |

## 2. Problema

Esta seção apresenta a análise do problema: o entendimento da situação atual, os envolvidos
afetados, os impactos gerados e a delimitação do escopo em alto nível, representado pelas
necessidades dos envolvidos.

### 2.1. Energia de poucos rateada entre todos

|   |   |
|---|---|
| **Problema** | A energia da recarga sai da conta de luz da área comum, paga por todos os condôminos. Sem registro individualizado, não há como atribuir o custo a quem o gerou. |
| **Afetados** | Todos os condôminos, especialmente os que não possuem veículo elétrico; síndico; administradora. |
| **Impacto** | Subsídio involuntário de uma minoria por uma maioria; atrito em assembleia; resistência à instalação de novos pontos, já que ampliar a estrutura amplia o custo dividido. |
| **Necessidades (Escopo)** | Como síndico, eu quero apurar o consumo de energia de cada apartamento no período, de modo que eu possa lançar o valor na cota condominial.<br>Como síndico, eu quero definir a tarifa por quilowatt-hora do rateio, de modo que o valor cobrado acompanhe a conta de luz da área comum.<br>Como morador, eu quero acompanhar meu consumo acumulado no mês, de modo que eu saiba quanto será lançado antes de receber a conta. |

### 2.2. Disputa por um recurso escasso, sem informação de disponibilidade

|   |   |
|---|---|
| **Problema** | Poucas vagas com carregador para muitos apartamentos. O morador desce à garagem sem saber se há vaga livre e, ao encontrá-las ocupadas, não sabe quando alguma será liberada. |
| **Afetados** | Moradores com veículo elétrico; síndico e porteiro, procurados para mediar conflitos. |
| **Impacto** | Descidas perdidas à garagem; conflito entre vizinhos; combinação informal por grupo de mensagens, que não deixa registro nem garante nada; veículo sem carga por falta de previsibilidade. |
| **Necessidades (Escopo)** | Como morador, eu quero ver quais vagas estão livres e quais estão ocupadas, de modo que eu não desça à garagem à toa.<br>Como morador, eu quero ver a previsão de liberação das vagas ocupadas, de modo que eu possa decidir quando descer.<br>Como morador, eu quero ocupar uma vaga livre e registrar o uso na hora em que chego, de modo que o painel reflita a garagem real para os demais. |
| **Limite da solução** | O sistema entrega **informação para decidir quando descer**, não garantia de vaga: o uso é por ordem de chegada (RE-12). Ver risco RI-11. |

### 2.3. Ausência de previsão de quanto tempo a recarga levará

|   |   |
|---|---|
| **Problema** | O tempo de recarga depende também da capacidade da bateria e da potência máxima aceita pelo veículo. Um carregador de 22 kW não recarrega mais rápido um veículo que aceita no máximo 6,6 kW. Sem essa informação, nem o morador sabe quando sua recarga termina, nem os demais sabem quando a vaga será liberada. |
| **Afetados** | Moradores com veículo elétrico. |
| **Impacto** | Previsões erradas no painel, que derrubam a confiança na informação e levam o morador de volta ao combinado informal; permanência desnecessária junto ao veículo. |
| **Necessidades (Escopo)** | Como morador, eu quero cadastrar meu veículo com a capacidade da bateria e a potência máxima de recarga, de modo que o sistema calcule previsões corretas para mim.<br>Como morador, eu quero informar o nível atual da bateria ao iniciar a recarga, de modo que o sistema estime quando ela será concluída.<br>Como morador, eu quero que a previsão da minha recarga fique visível aos demais, de modo que quem espera saiba quando a vaga será liberada. |

### 2.4. Ocupação da vaga além do tempo necessário

|   |   |
|---|---|
| **Problema** | O veículo permanece na vaga depois de concluída a recarga, ou por tempo indefinidamente longo. Como o sistema não controla o carregador, ele **não tem como liberar a vaga** — só sinalizar a situação. |
| **Afetados** | Moradores que aguardam a vaga; síndico, acionado para mediar. |
| **Impacto** | Redução da rotatividade de um recurso escasso; morador que desce confiando na previsão e encontra a vaga ocupada; conflito entre vizinhos. |
| **Necessidades (Escopo)** | Como morador, eu quero que exista um limite máximo de duração para qualquer sessão, de modo que nenhuma ocupação se estenda indefinidamente.<br>Como morador, eu quero ver no painel que uma sessão já concluiu a recarga ou ultrapassou o limite, de modo que eu saiba que a vaga deveria estar sendo liberada.<br>Como síndico, eu quero identificar as sessões que ultrapassaram o limite, de modo que eu possa intervir junto ao morador. |
| **Limite da solução** | O sistema **não impede** fisicamente a permanência (RE-05). Oferece limite declarado, sinalização e registro: instrumentos de convivência, não de bloqueio. Eliminar o problema exige controle do carregador — ver seção 4.4. |

### 2.5. Veículo retirado sem encerramento da sessão

|   |   |
|---|---|
| **Problema** | O morador retira o veículo e vai embora sem registrar o encerramento. A vaga continua constando como ocupada e a sessão segue aberta indefinidamente. |
| **Afetados** | Moradores que aguardam a vaga; síndico; o próprio morador, cujo consumo seria apurado a maior. |
| **Impacto** | Vaga exibida como ocupada enquanto está livre, anulando a utilidade do painel; apuração incorreta no fechamento; intervenção manual do síndico. |
| **Necessidades (Escopo)** | Como síndico, eu quero identificar as sessões abertas muito além do tempo previsto de conclusão, de modo que eu possa encerrá-las e liberar a vaga.<br>Como síndico, eu quero que o encerramento administrativo fique registrado, de modo que o morador possa contestar a apuração. |

### 2.6. Falta de histórico para decidir sobre a estrutura

|   |   |
|---|---|
| **Problema** | O condomínio não dispõe de dados sobre a utilização das vagas: horas ocupadas por dia, faixas de horário, quantos apartamentos as usam e quanta demanda fica reprimida. |
| **Afetados** | Síndico; assembleia de condôminos. |
| **Impacto** | Decisão sobre instalar novos pontos tomada por impressão, e não por dado; investimento superdimensionado ou insuficiente; discussão em assembleia sem base objetiva. |
| **Necessidades (Escopo)** | Como síndico, eu quero consultar o histórico de utilização por vaga, apartamento e período, de modo que eu possa levar dados à assembleia ao propor a ampliação da estrutura.<br>Como síndico, eu quero saber quantas vezes um morador tentou iniciar uma recarga e não encontrou vaga, de modo que eu possa dimensionar a demanda reprimida. |

## 3. Usuários

### 3.1. Fornecedores de requisitos

| Nome | Responsável/Cargo | E-mail | Responsabilidades |
|---|---|---|---|
| Matheus Ribeiro Andrade | Product Owner | ribeiro.andrade@aluno.ifsp.edu.br | Representar os interesses do cliente perante a equipe; definir e priorizar as funcionalidades; aprovar o escopo e o planejamento; aceitar ou rejeitar os resultados de trabalho. |
| Henrique de Almeida Marangoni Inacio | Scrum Master | henrique.marangoni@aluno.ifsp.edu.br | Garantir a aderência ao processo definido; manter o planejamento e o controle do projeto; conduzir os eventos do processo; remover impedimentos. |
| André Fernandes Nascimento Moreira | Desenvolvedor | andre.moreira@aluno.ifsp.edu.br | Participar da análise do domínio e do levantamento de necessidades; executar as atividades de desenvolvimento, dos requisitos à implantação. |
| Alex Junior Fortunato Sacramento | Desenvolvedor | alex.sacramento@aluno.ifsp.edu.br | Participar da análise do domínio e do levantamento de necessidades; executar as atividades de desenvolvimento, dos requisitos à implantação. |

**Origem dos requisitos.** O projeto é conduzido em contexto acadêmico e não dispõe de cliente
externo contratante. As necessidades da seção 2 foram levantadas pela equipe a partir da análise
do domínio, e o Product Owner atua como representante do cliente para aprovação do escopo e do
planejamento, conforme previsto no SpinOff para o papel.

### 3.2. Perfis de usuário do sistema

| Perfil | Quem é | Responsabilidades no sistema |
|---|---|---|
| Morador | Condômino ou residente autorizado, proprietário de veículo elétrico. Vinculado a um apartamento, que é a unidade de rateio. | Consultar o painel; registrar início e encerramento da própria sessão; manter o cadastro do próprio veículo; consultar o consumo do mês. **Não** altera tarifa, **não** cadastra vagas e **não** acessa dados de outros apartamentos. |
| Síndico | Responsável pela administração do condomínio, eleito em assembleia, ou preposto da administradora. | Cadastrar vagas e potências; definir a tarifa; manter o cadastro de moradores e apartamentos; acompanhar o painel; encerrar sessões órfãs; fechar o mês e obter o rateio; consultar o histórico. |

**Acumulação de perfis.** O síndico é também condômino e pode possuir veículo elétrico. Nesse
caso acumula os dois perfis: usa o sistema como morador para suas próprias recargas — apuradas e
rateadas como as demais — e como síndico para a gestão. As ações de gestão ficam registradas com
o usuário que as realizou.

## 4. Restrições Impostas

As restrições abaixo são impostas ao sistema ou ao processo de desenvolvimento. Devem ser
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
| RE-05 | **O sistema não se integra ao hardware dos carregadores.** O estado das vagas, o início e o fim das sessões são determinados exclusivamente pelo que os moradores registram. O sistema não aciona, não bloqueia e não mede o equipamento. Ver seção 4.4. |
| RE-06 | **O sistema não processa pagamento e não emite cobrança.** Apura o consumo e o valor por apartamento no período e os disponibiliza ao síndico, que os repassa à administradora para lançamento na cota condominial. |
| RE-07 | **O sistema atende a um único condomínio.** Não há multiempresa, gestão de assinantes nem separação de dados por cliente contratante. Instalação em outro condomínio é nova implantação, com sua própria base. |
| RE-08 | **O morador possui cadastro e credenciais.** Todo uso é identificado e vinculado a um apartamento; não há uso anônimo. O cadastro de moradores é mantido pelo síndico. |
| RE-09 | A energia atribuída a cada sessão é **estimada** a partir da potência efetiva e da duração, não medida, uma vez que não há medição no carregador. Ver seção 4.4. |
| RE-10 | **O sistema não integra com o sistema da administradora do condomínio.** O resultado do fechamento é obtido em tela e exportável, e o lançamento na cota é feito fora do sistema. |
| RE-11 | **A duração máxima de uma sessão de recarga é de 6 horas.** Atingido o limite, o sistema **sinaliza a sessão como excedida** no painel e a mantém aberta — **não a encerra automaticamente**. O encerramento continua sendo do morador ou, na sua ausência, do síndico pela via administrativa. |
| RE-12 | **Não há agendamento nem reserva de vagas.** O uso é por ordem de chegada: o morador consulta o painel, ocupa uma vaga livre e registra o início. O sistema informa disponibilidade e previsão de liberação, mas não garante vaga a ninguém. Ver seção 1.1. |

**Sobre RE-11.** As 6 horas cobrem uma recarga completa na maioria dos carregadores
residenciais: uma bateria de 55 kWh, de 20% a 100%, leva cerca de 6 horas em um carregador de
7,4 kW e 4 horas em um de 11 kW. Em carregadores de 3,7 kW a carga não se completa dentro do
limite, e a recarga é concluída em mais de uma sessão. O sistema **sinaliza em vez de encerrar**
porque o encerramento automático exibiria como livre uma vaga fisicamente ocupada — o mesmo
defeito que o sistema combate; o custo dessa escolha é depender de intervenção humana. Removido
o agendamento, RE-11 e a sinalização no painel são o **único** instrumento de rotatividade que
resta.

### 4.3. Restrições de projeto

| # | Restrição |
|---|---|
| RE-13 | O sistema deve ser entregue até o encerramento do semestre letivo 2026.2. |
| RE-14 | A equipe é composta por quatro estudantes, com dedicação parcial, sem orçamento financeiro para aquisição de licenças, serviços ou equipamentos. |
| RE-15 | O desenvolvimento deve seguir o processo SpinOff, com os artefatos e a estrutura de repositório por ele definidos. |
| RE-16 | Não há cliente externo disponível para elicitação e validação de requisitos; o Product Owner atua como representante do cliente. |

### 4.4. Limitações decorrentes da ausência de integração com hardware

RE-05 e RE-09 determinam que o sistema conheça o mundo físico apenas por declaração dos
moradores, nunca por medição. A tabela registra o que isso impede e o que seria possível com
carregadores dotados de gestão remota, do tipo que implementa o protocolo OCPP. O cenário ideal
descreve a solução completa do problema e está **fora do escopo deste projeto**; é registrado
para deixar explícito que a limitação é conhecida e foi aceita conscientemente.

| Limitação atual | Cenário ideal (requer equipamento fora do escopo) |
|---|---|
| Não mede a energia entregue ao veículo; estima a partir de potência e tempo. | A medição viria do carregador, tornando o rateio exato e conferível contra a conta de luz da área comum. |
| Não impede o uso do carregador sem sessão registrada. | O carregador permaneceria desenergizado até o início de uma sessão, tornando impossível recarregar sem registro e sem rateio. |
| Não detecta a presença do veículo na vaga; depende do que foi declarado. | Um sensor de ocupação confirmaria chegada e saída, eliminando sessões órfãs e vagas exibidas incorretamente. |
| Não conhece o nível real da bateria; depende do valor informado. | A leitura viria do veículo pelo carregador, tornando a previsão exata e dispensando o cadastro de capacidade e potência. |
| Não interrompe o fornecimento ao concluir a recarga. | O fornecimento cessaria automaticamente, e a vaga poderia sinalizar fisicamente que está liberada para o próximo. |
| Não organiza a ordem de uso quando há mais interessados que vagas. | Com identificação no carregador, o ponto seria liberado apenas ao morador da vez, viabilizando fila ou rodízio com garantia real. |

## 5. Riscos

| # | Risco | Impacto | Resposta |
|---|---|---|---|
| RI-01 | **Dados de veículo cadastrados incorretamente** — capacidade de bateria ou potência máxima informadas de forma equivocada. | Previsão de conclusão **e apuração de energia** incorretas: o dado declarado afeta o valor rateado. | **Mitigar.** O cadastro é feito uma vez e fica visível ao síndico, que o confere contra o documento do veículo. A energia estimada é exibida ao morador ao encerrar a sessão, permitindo contestação. Divergência sistemática contra a conta de luz denuncia dado incorreto. |
| RI-02 | **Uso do carregador sem registro de sessão** — o morador pluga o veículo sem abrir sessão. | Energia consumida sem rateio, recaindo sobre todos; vaga exibida como livre. | **Mitigar.** O sistema não controla os carregadores (RE-05). Restam o painel, conferível contra a garagem real, e o confronto do total apurado com a conta de luz. Em comunidade fechada e identificada, o controle social é instrumento relevante — ao contrário do motorista anônimo da versão 1.1. |
| RI-03 | **Sessão órfã** — o morador retira o veículo sem encerrar a sessão. | Vaga permanece indisponível no painel; energia continua sendo estimada indevidamente. | **Mitigar.** O sistema sinaliza as sessões abertas além do tempo previsto, e o síndico as encerra administrativamente. A energia é limitada pela carga que faltava, o que impede a apuração de crescer indefinidamente. |
| RI-04 | **Ocupação da vaga após a conclusão da recarga** — o veículo permanece plugado depois de carregado. | Redução da rotatividade; morador que desce confiando na previsão encontra a vaga ocupada. | **Aceitar, com mitigação parcial.** Como a energia é limitada pela carga que faltava, permanecer na vaga depois de carregado **não tem custo** — ao contrário da versão 1.1, que cobrava por tempo. Removido o agendamento, restam apenas RE-11 e a sinalização. Eliminar o problema exige instrumento de convivência do condomínio, fora do sistema. |
| RI-05 | **Divergência entre o total apurado e a conta de luz da área comum.** | Rateio contestável em assembleia; perda de confiança no sistema. | **Mitigar.** A apuração é estimativa e assim deve ser apresentada. O fechamento exibe o total do período, que o síndico compara com a conta e ajusta proporcionalmente, se a assembleia deliberar. Eliminar a divergência exige medição — seção 4.4. |
| RI-06 | **Indisponibilidade dos integrantes da equipe** — conciliação com as demais disciplinas do semestre. | Atraso nas entregas planejadas; comprometimento do prazo (RE-13). | **Mitigar.** Entregas incrementais por Sprint, revisão do planejamento antes de cada Sprint e acompanhamento diário do quadro de tarefas. |
| RI-07 | **Ausência de cliente real para validação dos requisitos** (RE-16). | Requisitos validados apenas internamente; premissas incorretas sobre o domínio podem não ser detectadas. | **Mitigar.** Registro explícito das premissas assumidas; validação do escopo e do planejamento pelo Product Owner; revisão dos requisitos a cada Sprint. |
| RI-08 | **Complexidade subestimada do cálculo de previsão e de apuração** — potência efetiva e limite de energia mais complexos do que o previsto. | Retrabalho na Elaboração; atraso na definição da arquitetura. | **Mitigar.** Previsão de conclusão e apuração serão atacadas primeiro na Elaboração, como arquitetura executável, por concentrarem o maior risco técnico do projeto. |
| RI-09 | **Nova mudança de escopo** — o escopo já foi alterado duas vezes: reduzido na versão 2.0 e de novo na 3.0. | Retrabalho nos artefatos de requisitos e análise; consumo de prazo já restrito (RE-13); risco de o escopo não estabilizar a tempo da aprovação. | **Mitigar.** As duas alterações decorreram de defeitos achados em revisão, não de mudança de opinião — sinal de que revisar antes de aprovar funciona. Daqui em diante, alteração passa por Requisição de Mudança, com análise de impacto do Product Owner. |
| RI-10 | **Limite de duração inadequado ao parque de carregadores** — 6 horas não bastam para carregadores de 3,7 kW, em que a carga completa passa de 11 horas. | Recarga dividida em várias sessões; percepção de que o sistema atrapalha em vez de organizar. | **Mitigar.** O limite é parâmetro de configuração, não valor fixo em código: o síndico o ajusta se o parque exigir. As 6 horas são o padrão inicial, dimensionado para 7,4 kW e 11 kW. |
| RI-11 | **Disputa não mediada pelo sistema** — removido o agendamento (RE-12), o uso é por ordem de chegada: dois moradores podem descer ao ver a mesma vaga livre, e quem perde a corrida desce à toa. | Conflito entre vizinhos; retorno à combinação informal que o sistema pretendia substituir; morador com rotina menos flexível sistematicamente preterido. | **Aceitar, com mitigação parcial.** O painel evita a maior parte das descidas inúteis, mas não a corrida pela vaga recém-liberada. A demanda reprimida é medida (seção 2.6) e levada à assembleia: havendo disputa frequente, a resposta é **ampliar a estrutura**, não acrescentar regra de software. Fila poderá ser avaliada em versão futura, via Requisição de Mudança. |

## 6. Requisitos de Documentação

A documentação a seguir deverá ser desenvolvida para suportar a implantação e o uso do sistema:

| Documento | Público | Conteúdo previsto |
|---|---|---|
| Manual do Usuário - Morador | Condôminos com veículo elétrico | Cadastro do veículo; consulta ao painel; registro de início e encerramento da recarga; consulta ao consumo do mês. Deve ser sucinto e disponibilizado como **ajuda contextual nas próprias telas**, dado que o morador o acessa pelo celular e sem treinamento prévio. |
| Manual do Usuário - Síndico | Síndico e preposto da administradora | Cadastro de vagas e potências; definição da tarifa; manutenção do cadastro de moradores; tratamento de sessões órfãs; fechamento do mês e leitura do rateio; consulta ao histórico. |
| Guia de Implantação | Equipe de desenvolvimento e responsável técnico do condomínio | Procedimento de instalação e configuração do sistema no ambiente do condomínio; carga inicial de vagas, moradores e tarifa. |
