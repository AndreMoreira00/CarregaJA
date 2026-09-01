# História de Usuário

**CARREGAJA — Sistema de Controle e Rateio de Recarga de Veículos Elétricos em Condomínio**

Versão 3.0

## Dados usados nos testes de aceitação

| Elemento | Valor |
|---|---|
| Vaga G-01 | carregador de 11,0 kW |
| Vaga G-02 | carregador de 7,4 kW |
| Veículo do apto 42 | Nissan Leaf — 40 kWh, potência máxima 6,6 kW |
| Veículo do apto 17 | BYD Dolphin — 60 kWh, potência máxima 11,0 kW |
| Tarifa de energia | R$ 0,92 / kWh |
| Duração máxima de sessão | 6 horas (RE-11 do Visão) |

```
potência efetiva  = min(potência do carregador, potência máxima do veículo)
energia a repor   = capacidade da bateria × (100% − nível informado)
tempo estimado    = energia a repor ÷ potência efetiva
energia estimada  = min(potência efetiva × duração, energia a repor)
valor da sessão   = energia estimada × tarifa vigente no início
```

---

## HU-01 — Autenticar Usuário

| | |
|---|---|
| **Caso de uso** | UC01 — Autenticar Usuário |
| **Número da história** | HU-01 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Morador · Síndico |

**Descrição da história**

Como **morador**, eu quero **entrar no sistema com minhas credenciais**, de modo que **o que eu
consumir seja registrado no meu apartamento**.

**Testes de aceitação**

*Pré-condição:* o morador está cadastrado e ativo (HU-11).

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Acesso com credenciais válidas | E-mail e senha corretos do apto 42 | Acesso concedido, perfil Morador, apartamento 42 |
| 02 | Acesso com senha incorreta | E-mail correto, senha errada | Recusado, com mensagem genérica que não indica o campo errado |
| 03 | Acesso de morador desativado | Credenciais de morador desativado em HU-11 | Recusado, com orientação a procurar o síndico |
| 04 | Usuário com os dois perfis | Credenciais da síndica, que também é moradora | Acesso concedido com os perfis Morador e Síndico |

**Tem protótipo?** Não.

---

## HU-02 — Consultar Painel de Vagas

| | |
|---|---|
| **Caso de uso** | UC02 — Consultar Painel de Vagas |
| **Número da história** | HU-02 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Morador · Síndico |

**Descrição da história**

Como **morador**, eu quero **ver quais vagas estão livres e a previsão de liberação das
ocupadas**, de modo que **eu decida se desço agora ou mais tarde, em vez de descer à toa**.

**Testes de aceitação**

*Pré-condição:* usuário autenticado (HU-01); existem vagas cadastradas (HU-09).

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Vaga sem sessão | G-02 sem registros | Estado **Livre** |
| 02 | Vaga com sessão dentro do previsto | G-01, início 14h00, previsão 18h22, consulta às 16h00 | Estado **Ocupada**, previsão 18h22 |
| 03 | Sessão além da previsão, dentro das 6 h | G-01, previsão 18h22, consulta às 19h00 | Estado **Concluída, ainda ocupada** |
| 04 | Sessão além da duração máxima | G-01, início 14h00, consulta às 20h00 | Estado **Excedida**; a sessão permanece aberta |
| 05 | Morador não vê identificação alheia | Morador do apto 42 consulta G-01, ocupada pelo apto 17 | Estado e previsão exibidos; apartamento e nome ausentes |
| 06 | Síndico vê a identificação | Síndica consulta a mesma vaga | Estado, previsão, apartamento 17 e nome exibidos |
| 07 | Nenhuma vaga livre | G-01 e G-02 ocupadas, previsões 19h30 e 21h00 | Informa ausência de vaga e destaca a liberação mais próxima: 19h30 |

**Tem protótipo?** Não.

---

## HU-03 — Iniciar Sessão de Recarga

| | |
|---|---|
| **Caso de uso** | UC03 — Iniciar Sessão de Recarga |
| **Número da história** | HU-03 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Morador |

**Descrição da história**

Como **morador**, eu quero **registrar o início da recarga ao plugar o veículo**, de modo que
**o consumo seja lançado no meu apartamento e os vizinhos saibam quando a vaga será liberada**.

**Testes de aceitação**

*Pré-condição:* morador autenticado, com veículo cadastrado (HU-07).

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Início em vaga livre | G-02 livre, Leaf, bateria 30 %, às 18h10 | Sessão aberta; potência efetiva 6,6 kW; previsão 22h25; vaga passa a Ocupada |
| 02 | Início em vaga já ocupada | G-01 com sessão em andamento | Recusado, exibindo a previsão de liberação; recusa contabilizada para HU-14 |
| 03 | Corrida pela vaga | Dois moradores registram início na G-02 quase ao mesmo tempo | O primeiro abre a sessão; o segundo é recusado |
| 04 | Vaga desativada | G-02 desativada em HU-09 | Recusado |
| 05 | Morador sem veículo cadastrado | Morador recém-cadastrado tenta iniciar | Interrompido, com encaminhamento ao cadastro de veículo |
| 06 | Morador já com sessão aberta | Morador com sessão na G-02 tenta iniciar na G-01 | Recusado |
| 07 | Marcação da duração máxima | Sessão iniciada às 18h10, consulta às 00h10 | Sessão marcada **Excedida** e ainda aberta |

**Tem protótipo?** Não.

---

## HU-04 — Calcular Previsão de Conclusão

| | |
|---|---|
| **Caso de uso** | UC04 — Calcular Previsão de Conclusão |
| **Número da história** | HU-04 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | — (executado por inclusão a partir de HU-03) |

**Descrição da história**

Como **morador**, eu quero **que o sistema calcule quando minha recarga termina a partir das
características reais do meu veículo**, de modo que **a previsão que eu vejo, e que meus
vizinhos veem no painel, seja confiável**.

**Testes de aceitação**

*Pré-condição:* veículo cadastrado e vaga com potência definida.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Veículo limita a potência | Leaf (6,6 kW) na G-02 (7,4 kW), bateria 30 % | Potência efetiva 6,6 kW; 28,0 kWh a repor; 4h15 |
| 02 | Carregador limita a potência | Dolphin (11 kW) na G-02 (7,4 kW), bateria 20 % | Potência efetiva 7,4 kW; 48,0 kWh a repor; 6h29 |
| 03 | Potências iguais | Dolphin (11 kW) na G-01 (11 kW), bateria 20 % | Potência efetiva 11,0 kW; 48,0 kWh a repor; 4h22 |
| 04 | Carregador maior não acelera veículo lento | Leaf na G-01 (11 kW) comparado ao Leaf na G-02 (7,4 kW) | Mesmo tempo nos dois casos: 4h15 |
| 05 | Bateria cheia | Leaf, bateria 100 % | 0 kWh a repor; informa que não há recarga a fazer |

**Tem protótipo?** Não se aplica — não possui interface própria.

---

## HU-05 — Encerrar Sessão de Recarga

| | |
|---|---|
| **Caso de uso** | UC05 — Encerrar Sessão de Recarga |
| **Número da história** | HU-05 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Morador |

**Descrição da história**

Como **morador**, eu quero **encerrar minha sessão ao retirar o veículo e ver quanto consumi**,
de modo que **a vaga fique livre para os vizinhos e eu possa conferir o valor na hora**.

**Testes de aceitação**

*Pré-condição:* o morador tem sessão em andamento.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Encerramento com teto de energia acionado | Início 18h10, fim 22h40, 6,6 kW, 28,0 kWh a repor | 28,0 kWh e R$ 25,76; vaga liberada |
| 02 | Encerramento antes de completar a carga | Início 18h10, fim 20h10, 6,6 kW, 28,0 kWh a repor | 13,2 kWh e R$ 12,14 |
| 03 | Valor apresentado ao morador na hora | Qualquer encerramento | Duração, energia e valor exibidos na própria tela |
| 04 | Sem sessão aberta | Morador sem sessão aciona o encerramento | Informado que não há sessão a encerrar |
| 05 | Tarifa alterada durante a sessão | Início com R$ 0,92; tarifa passa a R$ 1,05 às 20h | Apurado a R$ 0,92, a vigente no início |

**Tem protótipo?** Não.

---

## HU-06 — Apurar Energia da Sessão

| | |
|---|---|
| **Caso de uso** | UC06 — Apurar Energia da Sessão |
| **Número da história** | HU-06 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | — (executado por inclusão a partir de HU-05, HU-12 e HU-13) |

**Descrição da história**

Como **síndico**, eu quero **que a energia de cada sessão seja apurada por uma regra fixa e
auditável**, de modo que **o valor lançado na cota do condômino possa ser explicado e
contestado**.

**Testes de aceitação**

*Pré-condição:* sessão encerrada, com potência efetiva e energia a repor registradas no início.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Teto de energia não acionado | 6,6 kW, 2,00 h, 28,0 kWh a repor | 13,2 kWh; R$ 12,14 |
| 02 | Teto de energia acionado | 6,6 kW, 4,50 h, 28,0 kWh a repor | 28,0 kWh — não 29,7 kWh; R$ 25,76 |
| 03 | Teto acionado em sessão órfã longa | 11,0 kW, 7,00 h, 48,0 kWh a repor | 48,0 kWh — não 77,0 kWh; R$ 44,16 |
| 04 | Tarifa vigente no início | Início em 08/09 a R$ 0,92; tarifa muda em 09/09; encerra em 09/09 | Apurado a R$ 0,92 |
| 05 | Duração nula | Início e encerramento no mesmo minuto | 0,0 kWh; R$ 0,00 |

**Tem protótipo?** Não se aplica — não possui interface própria.

---

## HU-07 — Manter Veículo

| | |
|---|---|
| **Caso de uso** | UC07 — Manter Veículo |
| **Número da história** | HU-07 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Morador |

**Descrição da história**

Como **morador**, eu quero **cadastrar meu veículo uma única vez**, de modo que **eu não precise
declarar as características a cada recarga e as previsões saiam corretas**.

**Testes de aceitação**

*Pré-condição:* morador autenticado.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Cadastro válido | Nissan Leaf, 40 kWh, 6,6 kW | Veículo registrado e vinculado ao apartamento |
| 02 | Capacidade não positiva | Modelo qualquer, 0 kWh, 7 kW | Recusado |
| 03 | Potência não positiva | Modelo qualquer, 40 kWh, −2 kW | Recusado |
| 04 | Reuso sem redigitação | Iniciar sessão após o cadastro | O sistema pede apenas a vaga e o nível de bateria |
| 05 | Troca de veículo não altera o passado | Alterar para 60 kWh após sessões já apuradas | As sessões anteriores mantêm os valores originais |

**Tem protótipo?** Não.

---

## HU-08 — Consultar Consumo do Mês

| | |
|---|---|
| **Caso de uso** | UC08 — Consultar Consumo do Mês |
| **Número da história** | HU-08 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Morador |

**Descrição da história**

Como **morador**, eu quero **acompanhar meu consumo acumulado no mês**, de modo que **eu saiba
quanto será lançado na minha cota antes de recebê-la**.

**Testes de aceitação**

*Pré-condição:* morador autenticado.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Consumo do período corrente | Apto 42, setembro, sessões de 28,0 + 24,5 + 23,5 kWh | Total de 76,0 kWh e R$ 69,92 |
| 02 | Período sem sessões | Apto 17, agosto | Informa ausência de consumo registrado |
| 03 | Sessão encerrada pelo síndico é sinalizada | Apto 17, setembro, sessão encerrada em HU-12 | Linha marcada como encerramento administrativo |
| 04 | Morador não vê consumo alheio | Morador do apto 42 consulta | Apenas as sessões do apartamento 42 |

**Tem protótipo?** Não.

---

## HU-09 — Manter Vagas com Carregador

| | |
|---|---|
| **Caso de uso** | UC09 — Manter Vagas com Carregador |
| **Número da história** | HU-09 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Síndico |

**Descrição da história**

Como **síndico**, eu quero **cadastrar as vagas com carregador e a potência de cada uma**, de
modo que **o sistema calcule previsões corretas e o painel reflita a garagem real**.

**Testes de aceitação**

*Pré-condição:* síndico autenticado.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Cadastro válido | G-01, 11,0 kW | Vaga registrada e visível no painel |
| 02 | Código duplicado | G-01 novamente | Recusado |
| 03 | Potência não positiva | G-03, 0 kW | Recusado |
| 04 | Desativação preserva histórico | Desativar G-02, que tem sessões apuradas | Vaga não aceita novas sessões; histórico mantido |
| 05 | Remoção com sessão em andamento | Remover G-02 ocupada | Recusado, com oferta de desativar |

**Tem protótipo?** Não.

---

## HU-10 — Definir Tarifa de Energia

| | |
|---|---|
| **Caso de uso** | UC10 — Definir Tarifa de Energia |
| **Número da história** | HU-10 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Síndico |

**Descrição da história**

Como **síndico**, eu quero **definir o valor por quilowatt-hora aplicado no rateio**, de modo
que **o que é cobrado dos moradores acompanhe a conta de luz da área comum**.

**Testes de aceitação**

*Pré-condição:* síndico autenticado.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Definição válida | R$ 0,92 a partir de 01/09 | Tarifa registrada e vigente |
| 02 | Valor não positivo | R$ 0,00 | Recusado |
| 03 | Histórico de vigências preservado | Lançar R$ 1,05 a partir de 01/10 | Ambas as vigências permanecem consultáveis |
| 04 | Sessão antiga não é afetada | Sessão de 08/09, após a mudança de outubro | Continua apurada a R$ 0,92 |
| 05 | Retroatividade sobre período fechado | Vigência em 01/09 com setembro já fechado | Recusado |

**Tem protótipo?** Não.

---

## HU-11 — Manter Moradores

| | |
|---|---|
| **Caso de uso** | UC11 — Manter Moradores |
| **Número da história** | HU-11 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Síndico |

**Descrição da história**

Como **síndico**, eu quero **cadastrar os moradores e vinculá-los aos seus apartamentos**, de
modo que **o consumo seja atribuído à unidade correta no rateio**.

**Testes de aceitação**

*Pré-condição:* síndico autenticado.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Cadastro válido | Nome, e-mail e apartamento 42 | Morador ativo, com credenciais criadas |
| 02 | E-mail duplicado | E-mail já cadastrado | Recusado |
| 03 | Dois moradores no mesmo apartamento | Segundo morador no apartamento 42 | Aceito; o consumo dos dois soma no apartamento |
| 04 | Desativação revoga o acesso | Desativar morador do apto 17 | Acesso negado em HU-01; histórico mantido |
| 05 | Remoção com sessões no período aberto | Remover morador com sessões em setembro não fechado | Recusado, com oferta de desativar |

**Tem protótipo?** Não.

---

## HU-12 — Encerrar Sessão Órfã

| | |
|---|---|
| **Caso de uso** | UC12 — Encerrar Sessão Órfã |
| **Número da história** | HU-12 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Síndico |

**Descrição da história**

Como **síndico**, eu quero **encerrar administrativamente uma sessão cujo veículo já foi
retirado**, de modo que **a vaga seja liberada e o consumo do morador seja apurado**.

> **O sistema não distingue sessão órfã de sessão excedida**, porque não detecta a presença do
> veículo (RE-05 do Visão). A verificação física é ato humano, e é pré-condição desta história.

**Testes de aceitação**

*Pré-condição:* existe sessão em andamento além da previsão de conclusão, e o síndico **confirmou
fisicamente** que o veículo já não está na vaga.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Encerramento administrativo | Sessão de 14h00 a 21h00, 11,0 kW, 48,0 kWh a repor | 48,0 kWh e R$ 44,16; vaga liberada |
| 02 | Registro do responsável | Após o caso 01 | Sessão marcada como administrativa, com o síndico e o horário |
| 03 | Teto impede apuração desproporcional | Mesmos dados do caso 01 | 48,0 kWh — não os 77,0 kWh da energia bruta |
| 04 | Visibilidade ao morador | Morador consulta HU-08 | Linha sinalizada como encerramento administrativo |
| 05 | Morador não acessa a função | Morador tenta encerrar sessão de terceiro | Função indisponível ao perfil Morador |

**Tem protótipo?** Não.

---

## HU-13 — Fechar Mês e Gerar Rateio

| | |
|---|---|
| **Caso de uso** | UC13 — Fechar Mês e Gerar Rateio |
| **Número da história** | HU-13 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Síndico |

**Descrição da história**

Como **síndico**, eu quero **consolidar o consumo do mês por apartamento**, de modo que **eu
possa repassar à administradora os valores a lançar em cada cota condominial**.

**Testes de aceitação**

*Pré-condição:* síndico autenticado; existem sessões encerradas no período.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Fechamento válido | Setembro, com 5 sessões encerradas | Total de 157,0 kWh e R$ 144,44 |
| 02 | Agrupamento por apartamento | Duas sessões do apto 17, de 48,0 e 33,0 kWh | Linha única com 81,0 kWh e R$ 74,52 |
| 03 | Sessão em aberto impede o fechamento | Uma sessão do período ainda aberta | Fechamento recusado; a sessão é listada como pendência |
| 04 | Período fechado não aceita alteração | Registrar sessão em setembro após o fechamento | Recusado |
| 05 | Exportação do resultado | Após o caso 01 | Resultado exportável para repasse à administradora |
| 06 | Total geral para conferência | Após o caso 01 | 157,0 kWh apresentado como total do condomínio |

**Tem protótipo?** Não.

---

## HU-14 — Consultar Histórico de Utilização

| | |
|---|---|
| **Caso de uso** | UC14 — Consultar Histórico de Utilização |
| **Número da história** | HU-14 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Síndico |

**Descrição da história**

Como **síndico**, eu quero **consultar como as vagas foram utilizadas e quantas vezes faltou
vaga**, de modo que **eu possa levar dados à assembleia ao propor a ampliação da estrutura**.

**Testes de aceitação**

*Pré-condição:* síndico autenticado; existem sessões no período.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Ocupação por vaga | Setembro | Horas de ocupação de cada vaga, com o percentual do período |
| 02 | Faixa de maior demanda | Setembro | Faixa horária de pico identificada |
| 03 | Consumo por apartamento | Setembro | Apto 17 com 81,0 kWh; apto 42 com 76,0 kWh |
| 04 | Demanda reprimida | Setembro, com 7 recusas registradas em HU-03 | 7 tentativas recusadas por vaga ocupada |
| 05 | Recusas cruzadas com a faixa horária | Setembro | Recusas distribuídas por faixa de horário |
| 06 | Período sem utilização | Julho | Informa ausência de registros |

**Tem protótipo?** Não.

---

## Rastreabilidade

| História | Caso de uso | Necessidade no Visão v3.0 |
|---|---|---|
| HU-01 Autenticar Usuário | UC01 | RE-08 (uso identificado) |
| HU-02 Consultar Painel de Vagas | UC02 | §2.2, §2.3, §2.4, §2.5 |
| HU-03 Iniciar Sessão de Recarga | UC03 | §2.1, §2.2, §2.3, §2.4 |
| HU-04 Calcular Previsão de Conclusão | UC04 | §2.2, §2.3 |
| HU-05 Encerrar Sessão de Recarga | UC05 | §2.1 |
| HU-06 Apurar Energia da Sessão | UC06 | §2.1 |
| HU-07 Manter Veículo | UC07 | §2.3 |
| HU-08 Consultar Consumo do Mês | UC08 | §2.1 |
| HU-09 Manter Vagas com Carregador | UC09 | §2.2, §2.3 |
| HU-10 Definir Tarifa de Energia | UC10 | §2.1 |
| HU-11 Manter Moradores | UC11 | §2.1 |
| HU-12 Encerrar Sessão Órfã | UC12 | §2.5 |
| HU-13 Fechar Mês e Gerar Rateio | UC13 | §2.1 |
| HU-14 Consultar Histórico de Utilização | UC14 | §2.6 |
