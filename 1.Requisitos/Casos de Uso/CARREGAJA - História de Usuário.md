# História de Usuário

**CARREGAJA — Sistema de Agendamento e Rateio de Recarga de Veículos Elétricos em Condomínio**

Versão 1.0

## Histórico de Revisões

| Data | Versão | Descrição | Autor |
|---|---|---|---|
| 27/08/2026 | 1.0 | Elaboração inicial. Dezesseis histórias, uma por caso de uso, com fluxo principal, fluxos alternativos e testes de aceitação. Derivado do Modelo de Caso de Uso v2.0 e do documento Visão v2.0. | Henrique de Almeida Marangoni Inacio |

> **Situação deste artefato.** Este documento **antecipa** a tarefa *Detalhar Requisitos*, que
> pertence à fase de Elaboração — ver `.spinoff/METODO.md`. Foi produzido na Iniciação por
> decisão da equipe, para tornar o escopo verificável antes da aprovação. As **estimativas
> ficam em aberto**: são atribuídas no Planning Poker, na Reunião de Planejamento do Projeto.

---

## 1. Como ler este documento

Cada história corresponde a um caso de uso do **CARREGAJA - Modelo de Caso de Uso (v2.0)**, na
proporção de um para um, e segue o `Template - Historia de Usuario` do SpinOff, acrescido de
duas seções que o template não prevê — **fluxo principal** e **fluxos alternativos** — incluídas
para tornar visível o que entra e o que sai a cada passo.

| Seção | O que traz |
|---|---|
| Cabeçalho | Caso de uso correspondente, número, estimativa, ator |
| Descrição | A história no formato *Como… eu quero… de modo que…* |
| Fluxo principal | O caminho feliz, passo a passo, alternando ator e sistema |
| Fluxos alternativos | Desvios e recusas, numerados a partir do passo em que divergem |
| Testes de aceitação | Pré-condição e casos de teste com **entradas** e **resultado esperado** |

Todos os exemplos usam o **mesmo cenário**, descrito na seção 2. Os números encadeiam: o que
sai de uma história entra na seguinte, e os totais do fechamento (HU-15) somam as sessões
registradas nas histórias anteriores.

---

## 2. Cenário usado nos exemplos

### 2.1. O condomínio

**Residencial Aroeira** — 96 apartamentos, duas vagas com carregador na área comum.

| Vaga | Potência do carregador |
|---|---|
| G-01 | 11,0 kW |
| G-02 | 7,4 kW |

| Parâmetro | Valor no cenário | Origem |
|---|---|---|
| Tarifa de energia | R$ 0,92 / kWh, vigente desde 01/09/2026 | Definida pela síndica (HU-12) |
| Duração máxima de sessão | 6 horas | RE-11 do documento Visão |
| Agendamentos futuros por morador | 1 | RE-12 |
| Antecedência máxima de agendamento | 7 dias | RE-12 |
| Tolerância de comparecimento | 15 minutos | **Valor de exemplo** — ainda não definido; ver seção 6 |

### 2.2. As pessoas

| Quem | Apartamento | Perfil | Veículo |
|---|---|---|---|
| Marina Duarte | 42 | Morador | Nissan Leaf — 40 kWh, potência máxima 6,6 kW |
| Rafael Nunes | 17 | Morador | BYD Dolphin — 60 kWh, potência máxima 11,0 kW |
| Cláudia Berto | 91 | Síndico (e moradora, sem veículo elétrico) | — |

### 2.3. As fórmulas que os exemplos aplicam

```
potência efetiva  = min(potência do carregador da vaga, potência máxima do veículo)
energia a repor   = capacidade da bateria × (100% − nível informado)
tempo estimado    = energia a repor ÷ potência efetiva

duração           = encerramento − início
energia estimada  = min(potência efetiva × duração, energia a repor)
valor da sessão   = energia estimada × tarifa vigente no início
```

**Repare no `min` da energia estimada.** Ele aparece nos dois exemplos completos deste
documento — a sessão de Marina (HU-06) e a sessão órfã de Rafael (HU-14) — e nos dois ele
**é acionado**, ou seja, o teto pega. É o que impede que um veículo esquecido plugado acumule
consumo indefinidamente.

### 2.4. A linha do tempo

| Quando | O que acontece | História |
|---|---|---|
| 01/09, manhã | Cláudia configura vagas, tarifa e moradores | HU-11, HU-12, HU-13 |
| 01/09, tarde | Marina cadastra o Leaf | HU-08 |
| 08/09, 14h20 | Marina consulta o painel e agenda a G-02 para 18h00–22h15 | HU-02, HU-03, HU-05 |
| 08/09, 18h10 | Marina chega e inicia a sessão | HU-04 |
| 08/09, 22h40 | Marina encerra — **28,0 kWh, R$ 25,76** | HU-06, HU-07 |
| 09/09, 07h15 | Reserva de Rafael na G-01 expira por não comparecimento | HU-10 |
| 09/09, 14h00 | Rafael inicia sessão na G-01 e esquece de encerrar | HU-04 |
| 09/09, 20h00 | A sessão atinge 6 horas e é sinalizada como **excedida** | HU-02 |
| 09/09, 21h00 | Cláudia confirma que o carro saiu e encerra — **48,0 kWh, R$ 44,16** | HU-14 |
| 30/09 | Marina confere seu consumo do mês | HU-09 |
| 01/10 | Cláudia fecha setembro — **157,0 kWh, R$ 144,44** | HU-15, HU-16 |

---

## 3. Histórias do Morador

### HU-01 — Autenticar Usuário

| | |
|---|---|
| **Caso de uso** | UC01 — Autenticar Usuário |
| **Número da história** | HU-01 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Morador · Síndico |

**Descrição da história**

Como **morador**, eu quero **entrar no sistema com minhas credenciais**, de modo que **o que eu
agendar e consumir seja registrado no meu apartamento**.

**Fluxo principal**

1. O morador acessa o endereço do sistema pelo celular.
2. O sistema apresenta a tela de acesso.
3. O morador informa e-mail e senha.
4. O sistema valida as credenciais, identifica o apartamento vinculado e determina o perfil.
5. O sistema apresenta o painel de vagas (HU-02) como tela inicial.

**Fluxos alternativos**

- **4a. Credenciais inválidas.** O sistema recusa o acesso sem informar qual dos dois campos
  está incorreto, e mantém a tela de acesso.
- **4b. Morador desativado.** O sistema recusa o acesso e orienta a procurar o síndico. Ocorre
  quando o morador foi desativado em HU-13 por ter deixado o condomínio.
- **4c. Usuário acumula os perfis Morador e Síndico.** O sistema concede ambos, e a interface
  oferece as funções de gestão além das de morador.

**Testes de aceitação**

*Pré-condição:* o morador está cadastrado e ativo (HU-13).

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Acesso com credenciais válidas | `marina.duarte@…` / senha correta | Acesso concedido, perfil Morador, apartamento 42, painel exibido |
| 02 | Acesso com senha incorreta | `marina.duarte@…` / senha errada | Acesso recusado, mensagem genérica sem indicar o campo errado |
| 03 | Acesso de morador desativado | Credenciais de morador desativado | Acesso recusado, orientação a procurar o síndico |
| 04 | Acesso da síndica, que também é moradora | `claudia.berto@…` / senha correta | Acesso concedido com os dois perfis |

**Protótipo:** não há. Pendente — ver seção 6.

---

### HU-02 — Consultar Painel de Vagas

| | |
|---|---|
| **Caso de uso** | UC02 — Consultar Painel de Vagas |
| **Número da história** | HU-02 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Morador · Síndico |

**Descrição da história**

Como **morador**, eu quero **ver a situação de todas as vagas com carregador e a previsão de
liberação das ocupadas**, de modo que **eu não desça à garagem à toa e saiba quando vale a pena
descer**.

**Fluxo principal**

1. O morador abre o painel.
2. O sistema levanta, para cada vaga, a sessão em andamento e as reservas vigentes.
3. O sistema classifica cada vaga em um dos cinco estados e calcula a previsão de liberação das
   ocupadas.
4. O sistema apresenta a lista de vagas com estado, previsão e — no caso das reservadas — o
   horário reservado.

**Os cinco estados**

| Estado | Quando aparece |
|---|---|
| **Livre** | Sem sessão ativa e sem reserva vigente |
| **Reservada** | Há agendamento para a janela corrente ou futura |
| **Ocupada** | Há sessão em andamento; exibe a previsão de conclusão |
| **Concluída, ainda ocupada** | A previsão passou e a sessão não foi encerrada |
| **Excedida** | A sessão passou da duração máxima (6 h); permanece aberta |

**Fluxos alternativos**

- **4a. O usuário é o síndico.** O sistema acrescenta, a cada vaga, o apartamento e o morador da
  sessão ou reserva, e destaca as sessões candidatas a órfãs (HU-14).
- **4b. O usuário é morador.** O sistema **não identifica** quem ocupa cada vaga. Saber *quando*
  libera resolve o problema; saber *quem* está lá expõe o vizinho sem necessidade.

**Exemplo — 08/09/2026, 14h20, Marina abre o painel**

| Vaga | Estado | O que o painel mostra |
|---|---|---|
| G-01 | Ocupada | Previsão de liberação: 16h05 |
| G-02 | Livre | — |

**Exemplo — 09/09/2026, 20h00, o painel de Cláudia**

| Vaga | Estado | O que o painel mostra |
|---|---|---|
| G-01 | **Excedida** | Apto 17 · início 14h00 · previsão era 18h22 · **6h00 de sessão** |
| G-02 | Livre | — |

**Testes de aceitação**

*Pré-condição:* usuário autenticado (HU-01); existem vagas cadastradas (HU-11).

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Vaga sem sessão nem reserva | G-02 sem registros | Estado **Livre** |
| 02 | Vaga com sessão em andamento dentro do previsto | G-01, início 14h00, previsão 18h22, agora 16h00 | Estado **Ocupada**, previsão 18h22 |
| 03 | Sessão além da previsão, dentro das 6 h | G-01, previsão 18h22, agora 19h00 | Estado **Concluída, ainda ocupada** |
| 04 | Sessão além da duração máxima | G-01, início 14h00, agora 20h00 | Estado **Excedida**; sessão **permanece aberta** |
| 05 | Painel do morador não identifica terceiros | Marina consulta com G-01 ocupada por Rafael | Estado e previsão exibidos; apartamento e nome **ausentes** |
| 06 | Painel do síndico identifica | Cláudia consulta a mesma vaga | Estado, previsão, **apto 17 e nome exibidos** |

**Protótipo:** não há. Pendente — ver seção 6.

---

### HU-03 — Manter Agendamento

| | |
|---|---|
| **Caso de uso** | UC03 — Manter Agendamento |
| **Número da história** | HU-03 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Morador |

**Descrição da história**

Como **morador**, eu quero **reservar uma vaga para uma janela de horário**, de modo que **eu
tenha a garantia de encontrá-la disponível quando chegar**.

**Fluxo principal**

1. O morador escolhe a vaga, a data e os horários de início e fim.
2. O morador informa o nível de bateria previsto para o momento da chegada.
3. O sistema valida que a vaga está livre em toda a janela pedida.
4. O sistema valida os limites de agendamento: nenhum outro agendamento futuro em aberto, e
   início dentro dos próximos 7 dias.
5. O sistema valida que a janela não excede a duração máxima de 6 horas.
6. O sistema calcula a previsão de conclusão (HU-05) e **a exibe antes da confirmação**.
7. O morador confirma.
8. O sistema registra a reserva vinculada ao morador e ao apartamento, e a vaga passa a
   **Reservada** no painel.

**Fluxos alternativos**

- **3a. Janela sobreposta.** Existe outra reserva ou uma sessão cuja previsão avança sobre a
  janela. O sistema recusa e sugere o horário livre mais próximo.
- **4a. Já existe agendamento em aberto.** O sistema recusa e informa qual é a reserva vigente.
  O morador precisa usá-la, cancelá-la ou aguardar sua expiração.
- **4b. Antecedência maior que 7 dias.** O sistema recusa e informa a data máxima aceita.
- **5a. Janela maior que 6 horas.** O sistema recusa, porque reservar mais tempo do que uma
  sessão pode durar bloquearia a vaga sem finalidade.
- **6a. A previsão ultrapassa o fim da janela.** O sistema alerta que o tempo reservado não
  cobre a recarga pretendida e oferece estender a janela, respeitado o limite de 6 horas.
- **Cancelamento.** A qualquer momento antes do início, o morador cancela. A vaga é liberada
  imediatamente e o morador recupera o direito de agendar.

**Exemplo — 08/09/2026, 14h20, Marina agenda a G-02**

| Entrada | Valor |
|---|---|
| Vaga | G-02 (7,4 kW) |
| Janela pedida | 08/09, 18h00 às 22h15 |
| Nível de bateria previsto | 30 % |
| Veículo em cadastro | Nissan Leaf — 40 kWh, 6,6 kW |

```
potência efetiva = min(7,4 ; 6,6)      = 6,6 kW
energia a repor  = 40 × (100% − 30%)   = 28,0 kWh
tempo estimado   = 28,0 ÷ 6,6          = 4,24 h  →  4h15
```

**Saída:** previsão de conclusão **22h15** — a janela pedida cobre exatamente a recarga.
Reserva confirmada. G-02 passa a **Reservada** no painel.

**Testes de aceitação**

*Pré-condição:* morador autenticado, com veículo cadastrado (HU-08) e sem agendamento em aberto.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Agendamento válido | G-02, 08/09 18h00–22h15, bateria 30 % | Reserva criada; previsão 22h15 exibida antes da confirmação |
| 02 | Janela sobreposta a outra reserva | G-02, 08/09 20h00–23h00 (já reservada 18h–22h15) | Recusado, com sugestão do horário livre mais próximo |
| 03 | Segundo agendamento em aberto | Marina, já com reserva vigente, tenta agendar outra | Recusado; sistema informa a reserva vigente |
| 04 | Antecedência acima do limite | Agendar para 20/09 estando em 08/09 | Recusado; informa a data máxima (15/09) |
| 05 | Janela maior que a duração máxima | G-01, 09/09 08h00–16h00 (8 h) | Recusado por exceder 6 horas |
| 06 | Janela menor que a recarga pretendida | G-02, 18h00–20h00, bateria 30 % | Alerta de que a previsão (22h15) ultrapassa a janela; oferece estender |
| 07 | Cancelamento libera a vaga e o direito | Marina cancela a reserva de 08/09 | G-02 volta a **Livre**; novo agendamento passa a ser aceito |

**Protótipo:** não há. Pendente — ver seção 6.

---

### HU-04 — Iniciar Sessão de Recarga

| | |
|---|---|
| **Caso de uso** | UC04 — Iniciar Sessão de Recarga |
| **Número da história** | HU-04 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Morador |

**Descrição da história**

Como **morador**, eu quero **registrar o início da recarga ao plugar o veículo**, de modo que
**o consumo seja lançado no meu apartamento e os vizinhos saibam quando a vaga será liberada**.

**Fluxo principal**

1. O morador pluga o veículo e abre o sistema na garagem.
2. O morador seleciona a vaga que ocupou e informa o nível atual da bateria.
3. O sistema valida que a vaga está disponível para ele: **livre**, ou **reservada por ele
   próprio** na janela corrente.
4. O sistema recupera os dados do veículo do cadastro — não são declarados a cada uso.
5. O sistema calcula a previsão de conclusão (HU-05).
6. O sistema registra a sessão com data, hora de início e potência efetiva apurada.
7. Se havia reserva própria, ela é consumida pela sessão, e o morador recupera o direito de
   agendar.
8. A vaga passa a **Ocupada** no painel, com a previsão visível aos demais.

**Fluxos alternativos**

- **3a. Vaga reservada por outro morador.** O sistema recusa o início e informa até quando vale
  a reserva.
- **3b. Vaga já ocupada por sessão em andamento.** O sistema recusa e mostra a previsão de
  liberação.
- **3c. Vaga desativada.** O sistema recusa; a vaga não aceita novas sessões (HU-11).
- **4a. Morador sem veículo cadastrado.** O sistema interrompe e encaminha para HU-08.

**Sujeição à duração máxima.** A partir do horário registrado no passo 6, a sessão fica sujeita
ao limite de 6 horas. Atingido o limite, ela é sinalizada como **excedida** no painel — mas
**não é encerrada** pelo sistema.

**Exemplo — 08/09/2026, 18h10, Marina chega à garagem**

| Entrada | Valor |
|---|---|
| Vaga informada | G-02 |
| Nível de bateria | 30 % |
| Situação da vaga | Reservada por ela própria, janela 18h00–22h15 |
| Chegada | 18h10 — dentro da tolerância de 15 min |

**Saída:** sessão aberta às 18h10, potência efetiva 6,6 kW, previsão de conclusão
**22h25** (18h10 + 4h15). Reserva consumida. G-02 passa a **Ocupada**. A sessão será marcada
como excedida às **00h10** se ainda estiver aberta.

> **Repare no atraso de 10 minutos.** Marina reservou até 22h15, mas chegou às 18h10 — e a
> previsão foi para 22h25, **dez minutos além da janela que ela reservou**. É o problema da
> seção 2.5 do documento Visão em miniatura: nada garante que a sessão caiba na reserva, porque
> a reserva marca quando a vaga estará disponível, não quando será devolvida. Se houvesse outra
> reserva a partir das 22h15, esses dez minutos seriam invasão. O sistema **não impede** — o que
> ele faz é sinalizar, e é por isso que a duração máxima (RE-11) existe: para que a invasão
> tenha um teto.

**Testes de aceitação**

*Pré-condição:* morador autenticado, com veículo cadastrado.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Início em vaga livre | G-01 livre, bateria 20 % | Sessão aberta; previsão calculada; vaga passa a Ocupada |
| 02 | Início em vaga reservada pelo próprio morador | G-02 reservada por Marina, ela inicia 18h10 | Sessão aberta; reserva consumida; direito de agendar recuperado |
| 03 | Início em vaga reservada por outro | G-02 reservada por Rafael, Marina tenta iniciar | Recusado; informa até quando vale a reserva |
| 04 | Início em vaga já ocupada | G-01 com sessão em andamento | Recusado; exibe previsão de liberação |
| 05 | Morador sem veículo cadastrado | Morador novo tenta iniciar | Interrompido; encaminhado ao cadastro de veículo |
| 06 | Marcação do limite de duração | Sessão iniciada 18h10, consulta às 00h10 | Sessão marcada **Excedida** e **ainda aberta** |

**Protótipo:** não há. Pendente — ver seção 6.

---

### HU-05 — Calcular Previsão de Conclusão

| | |
|---|---|
| **Caso de uso** | UC05 — Calcular Previsão de Conclusão |
| **Número da história** | HU-05 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | — (executado por inclusão a partir de HU-03 e HU-04) |

> **História técnica.** Esta história **não passa integralmente no INVEST**: falha em
> *Independente* e em *Avaliável*, porque nenhum ator a aciona diretamente e ela não entrega
> valor isolado ao morador. Está registrada em separado por concentrar, junto com HU-07, a
> regra de negócio central do sistema — o que a torna a primeira candidata à arquitetura
> executável da Elaboração (risco RI-10 do documento Visão). Deve ser estimada e desenvolvida
> **junto** com HU-03 e HU-04, nunca sozinha.

**Descrição da história**

Como **morador**, eu quero **que o sistema calcule quando minha recarga termina a partir das
características reais do meu veículo**, de modo que **a previsão que eu vejo, e que meus
vizinhos veem no painel, seja confiável**.

**Fluxo principal**

1. O sistema recebe a vaga, o veículo e o nível de bateria.
2. Calcula a **potência efetiva**: o menor valor entre a potência do carregador e a potência
   máxima que o veículo aceita.
3. Calcula a **energia a repor**: a capacidade da bateria multiplicada pelo percentual que
   falta.
4. Divide a energia a repor pela potência efetiva, obtendo o tempo estimado.
5. Devolve o horário previsto de conclusão.

**Por que a potência efetiva é o coração disto.** Um carregador de 22 kW não recarrega mais
rápido um veículo que aceita no máximo 6,6 kW. É esta regra que justifica o cadastro de veículo
existir — sem ela, toda previsão exibida no painel estaria errada para a maioria dos carros.

**Fluxos alternativos**

- **2a. Carregador mais lento que o veículo.** A potência efetiva é a do carregador. Ocorre com
  o BYD Dolphin (11 kW) na vaga G-02 (7,4 kW).
- **2b. Veículo mais lento que o carregador.** A potência efetiva é a do veículo. É o caso do
  Nissan Leaf (6,6 kW) na G-02 (7,4 kW).
- **3a. Bateria já em 100 %.** Energia a repor igual a zero; o sistema informa que não há
  recarga a fazer.

**Exemplo — os dois veículos do cenário, nas duas vagas**

| Veículo | Vaga | Pot. carregador | Pot. máx. veículo | **Pot. efetiva** | Bateria | Energia a repor | **Tempo** |
|---|---|---|---|---|---|---|---|
| Leaf (40 kWh) | G-02 | 7,4 kW | 6,6 kW | **6,6 kW** | 30 % | 28,0 kWh | **4h15** |
| Leaf (40 kWh) | G-01 | 11,0 kW | 6,6 kW | **6,6 kW** | 30 % | 28,0 kWh | **4h15** |
| Dolphin (60 kWh) | G-01 | 11,0 kW | 11,0 kW | **11,0 kW** | 20 % | 48,0 kWh | **4h22** |
| Dolphin (60 kWh) | G-02 | 7,4 kW | 11,0 kW | **7,4 kW** | 20 % | 48,0 kWh | **6h29** |

As duas primeiras linhas mostram o ponto: **trocar o Leaf para o carregador mais potente não
adianta nada** — o gargalo é o carro. A última linha mostra o inverso, e um efeito colateral
relevante: o Dolphin na vaga lenta precisa de 6h29, **acima da duração máxima de 6 horas**, e
portanto não completa a recarga em uma única sessão.

**Testes de aceitação**

*Pré-condição:* veículo cadastrado e vaga com potência definida.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Veículo limita a potência | Leaf 6,6 kW na G-02 de 7,4 kW, bateria 30 % | Pot. efetiva 6,6 kW; 28,0 kWh; 4h15 |
| 02 | Carregador limita a potência | Dolphin 11 kW na G-02 de 7,4 kW, bateria 20 % | Pot. efetiva 7,4 kW; 48,0 kWh; 6h29 |
| 03 | Potências iguais | Dolphin 11 kW na G-01 de 11 kW, bateria 20 % | Pot. efetiva 11,0 kW; 48,0 kWh; 4h22 |
| 04 | Carregador maior não acelera veículo lento | Leaf na G-01 (11 kW) contra Leaf na G-02 (7,4 kW) | **Mesmo tempo** nos dois casos: 4h15 |
| 05 | Bateria cheia | Leaf, bateria 100 % | Energia a repor 0 kWh; informa que não há recarga a fazer |

**Protótipo:** não se aplica — não tem interface própria.

---

### HU-06 — Encerrar Sessão de Recarga

| | |
|---|---|
| **Caso de uso** | UC06 — Encerrar Sessão de Recarga |
| **Número da história** | HU-06 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Morador |

**Descrição da história**

Como **morador**, eu quero **encerrar minha sessão ao retirar o veículo e ver quanto consumi**,
de modo que **a vaga fique livre para os vizinhos e eu possa conferir o valor na hora**.

**Fluxo principal**

1. O morador retira o veículo e abre sua sessão em andamento no sistema.
2. O morador confirma o encerramento.
3. O sistema registra a data e hora de encerramento.
4. O sistema apura a energia e o valor da sessão (HU-07).
5. O sistema **exibe ao morador a duração, a energia estimada e o valor**, permitindo
   contestação imediata.
6. A vaga passa a **Livre** no painel.

**Fluxos alternativos**

- **1a. O morador não tem sessão aberta.** O sistema informa que não há o que encerrar.
- **2a. O morador tenta encerrar sessão de outro.** Não é oferecido: o morador só enxerga a
  própria sessão. O encerramento de sessão alheia cabe apenas ao síndico, por HU-14.
- **4a. A energia estimada atinge o teto.** Quando a duração é maior do que a recarga precisava,
  a energia é limitada pela energia a repor. O sistema exibe o valor limitado, sem alarde — é
  o comportamento normal, não uma exceção.

**Exemplo — 08/09/2026, 22h40, Marina retira o Leaf**

| Dado da sessão | Valor |
|---|---|
| Início | 08/09, 18h10 |
| Encerramento | 08/09, 22h40 |
| Potência efetiva registrada | 6,6 kW |
| Energia a repor no início | 28,0 kWh |
| Tarifa vigente no início | R$ 0,92 / kWh |

```
duração          = 22h40 − 18h10                = 4,50 h
energia bruta    = 6,6 × 4,50                   = 29,7 kWh
energia estimada = min(29,7 ; 28,0)             = 28,0 kWh   ← teto aplicado
valor da sessão  = 28,0 × 0,92                  = R$ 25,76
```

**Saída na tela de Marina:** *4h30 de sessão · 28,0 kWh · R$ 25,76*. G-02 volta a **Livre**.

Marina ficou 15 minutos a mais do que a recarga precisava. Esses 15 minutos **não foram
cobrados**, porque o teto limitou a energia à carga que faltava — e é exatamente por isso que,
neste sistema, ocupar a vaga depois de carregado não tem custo (risco RI-04 do Visão).

**Testes de aceitação**

*Pré-condição:* o morador tem sessão em andamento.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Encerramento com teto acionado | Início 18h10, fim 22h40, 6,6 kW, repor 28,0 kWh | 28,0 kWh e R$ 25,76 exibidos; vaga liberada |
| 02 | Encerramento antes de completar a carga | Início 18h10, fim 20h10, 6,6 kW, repor 28,0 kWh | `min(13,2 ; 28,0)` = 13,2 kWh; R$ 12,14 |
| 03 | Valor apresentado ao morador na hora | Qualquer encerramento | Duração, energia e valor exibidos na própria tela |
| 04 | Sem sessão aberta | Morador sem sessão aciona encerrar | Informado que não há sessão a encerrar |
| 05 | Tarifa alterada durante a sessão | Início com R$ 0,92; tarifa muda para R$ 1,05 às 20h | Apurado com **R$ 0,92**, a vigente no início |

**Protótipo:** não há. Pendente — ver seção 6.

---

### HU-07 — Apurar Energia da Sessão

| | |
|---|---|
| **Caso de uso** | UC07 — Apurar Energia da Sessão |
| **Número da história** | HU-07 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | — (executado por inclusão a partir de HU-06, HU-14 e HU-15) |

> **História técnica.** Como HU-05, **não passa integralmente no INVEST** — falha em
> *Independente* e *Avaliável*, por não ser acionada por ator nem entregar valor isolado.
> Registrada em separado por ser o cálculo que produz o número que vai para a cota
> condominial. Estimar e desenvolver **junto** com HU-06.

**Descrição da história**

Como **síndico**, eu quero **que a energia de cada sessão seja apurada por uma regra fixa e
auditável**, de modo que **o valor lançado na cota do condômino possa ser explicado e
contestado**.

**Fluxo principal**

1. O sistema recebe a sessão encerrada, com início, encerramento e potência efetiva.
2. Calcula a duração.
3. Multiplica a potência efetiva pela duração, obtendo a energia bruta.
4. **Limita** o resultado à energia que faltava na bateria no início da sessão.
5. Multiplica pela tarifa **vigente no início** da sessão.
6. Devolve energia estimada e valor.

**As duas decisões de cálculo que merecem registro**

**O teto pela energia a repor (passo 4).** Sem ele, um veículo esquecido plugado acumularia
consumo indefinidamente, e uma sessão órfã produziria um valor arbitrariamente alto. Com ele, a
apuração converge para a carga que era fisicamente possível.

**A tarifa do início, não a atual (passo 5).** Uma alteração de tarifa durante a ocupação não
altera o valor de uma sessão já em curso — o morador é cobrado pela regra que valia quando
começou.

**Fluxos alternativos**

- **4a. Duração menor que o necessário.** A energia bruta é menor que a energia a repor; o teto
  não é acionado e vale a energia bruta.
- **4b. Duração maior que o necessário.** O teto é acionado. É o caso das duas sessões completas
  deste documento.

**Exemplo — as duas sessões do cenário, lado a lado**

| | Marina (HU-06) | Rafael (HU-14) |
|---|---|---|
| Potência efetiva | 6,6 kW | 11,0 kW |
| Energia a repor | 28,0 kWh | 48,0 kWh |
| Duração | 4,50 h | 7,00 h |
| Energia bruta | 29,7 kWh | 77,0 kWh |
| **Energia estimada** | **28,0 kWh** *(teto)* | **48,0 kWh** *(teto)* |
| Tarifa | R$ 0,92 | R$ 0,92 |
| **Valor** | **R$ 25,76** | **R$ 44,16** |

A coluna de Rafael mostra o teto fazendo o trabalho pesado: sem ele, sete horas de sessão órfã
teriam gerado 77,0 kWh e **R$ 70,84** — quase R$ 27 a mais do que o carro poderia ter
consumido.

**Testes de aceitação**

*Pré-condição:* sessão encerrada, com potência efetiva e energia a repor registradas no início.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Teto não acionado | 6,6 kW, 2,00 h, repor 28,0 kWh | 13,2 kWh; R$ 12,14 |
| 02 | Teto acionado | 6,6 kW, 4,50 h, repor 28,0 kWh | **28,0 kWh**; R$ 25,76 |
| 03 | Teto acionado em sessão órfã longa | 11,0 kW, 7,00 h, repor 48,0 kWh | **48,0 kWh**; R$ 44,16 — não 77,0 kWh |
| 04 | Tarifa vigente no início | Início 08/09 (R$ 0,92); tarifa vira R$ 1,05 em 09/09; encerra 09/09 | Apurado a R$ 0,92 |
| 05 | Duração nula | Início e encerramento no mesmo minuto | 0,0 kWh; R$ 0,00 |

**Protótipo:** não se aplica — não tem interface própria.

---

### HU-08 — Manter Veículo

| | |
|---|---|
| **Caso de uso** | UC08 — Manter Veículo |
| **Número da história** | HU-08 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Morador |

**Descrição da história**

Como **morador**, eu quero **cadastrar meu veículo uma única vez**, de modo que **eu não precise
declarar as características a cada recarga e as previsões saiam corretas**.

**Fluxo principal**

1. O morador acessa seu cadastro de veículo.
2. Informa modelo, capacidade da bateria em kWh e potência máxima de recarga em kW.
3. O sistema valida que os valores são positivos e plausíveis.
4. O sistema registra o veículo vinculado ao morador.
5. Os dados passam a alimentar HU-03, HU-04 e HU-05 sem nova digitação.

**Por que cadastro único, e não declaração por sessão.** É esta decisão que sustenta a apuração
por energia. Se as características fossem declaradas a cada uso, o morador poderia informar
valores menores para pagar menos. Cadastrando uma vez, sob vista do síndico, o dado deixa de
ser manipulável sessão a sessão — mitigação do risco RI-01 do documento Visão.

**Fluxos alternativos**

- **3a. Valores implausíveis.** O sistema recusa capacidade ou potência fora de faixas
  razoáveis, ou valores não positivos.
- **4a. Alteração de veículo.** O morador trocou de carro. O sistema atualiza o cadastro; as
  sessões já apuradas **não são recalculadas**, pois guardam a potência efetiva vigente à época.

**Exemplo — 01/09/2026, Marina cadastra o Leaf**

| Entrada | Valor |
|---|---|
| Modelo | Nissan Leaf |
| Capacidade da bateria | 40 kWh |
| Potência máxima de recarga | 6,6 kW |

**Saída:** veículo vinculado ao apartamento 42. A partir daqui, Marina informa apenas **a vaga
e o nível de bateria** ao iniciar cada sessão.

**Testes de aceitação**

*Pré-condição:* morador autenticado.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Cadastro válido | Nissan Leaf, 40 kWh, 6,6 kW | Veículo registrado no apto 42 |
| 02 | Capacidade não positiva | Modelo X, 0 kWh, 7 kW | Recusado |
| 03 | Potência não positiva | Modelo X, 40 kWh, −2 kW | Recusado |
| 04 | Reuso sem redigitação | Iniciar sessão após o cadastro | Sistema pede apenas vaga e nível de bateria |
| 05 | Troca de veículo não altera o passado | Trocar para 60 kWh após sessões apuradas | Sessões anteriores mantêm os valores originais |

**Protótipo:** não há. Pendente — ver seção 6.

---

### HU-09 — Consultar Consumo do Mês

| | |
|---|---|
| **Caso de uso** | UC09 — Consultar Consumo do Mês |
| **Número da história** | HU-09 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Morador |

**Descrição da história**

Como **morador**, eu quero **acompanhar meu consumo acumulado no mês**, de modo que **eu saiba
quanto será lançado na minha cota antes de recebê-la**.

**Fluxo principal**

1. O morador acessa seu consumo.
2. O sistema recupera as sessões encerradas do morador no período corrente.
3. O sistema apresenta cada sessão com data, vaga, duração, energia estimada e valor.
4. O sistema apresenta o total acumulado do período.

**Fluxos alternativos**

- **2a. Nenhuma sessão no período.** O sistema informa que não há consumo registrado.
- **2b. Consulta a período anterior já fechado.** O sistema apresenta o consolidado tal como
  fechado em HU-15, sem recalcular.
- **3a. Sessão encerrada administrativamente.** A linha é marcada como tal, indicando que o
  encerramento foi feito pelo síndico (HU-14) — é a informação que permite ao morador contestar.

**Exemplo — 30/09/2026, Marina consulta setembro**

| Data | Vaga | Duração | Energia | Valor | Observação |
|---|---|---|---|---|---|
| 08/09 | G-02 | 4h30 | 28,0 kWh | R$ 25,76 | — |
| 16/09 | G-02 | 3h50 | 24,5 kWh | R$ 22,54 | — |
| 24/09 | G-01 | 3h40 | 23,5 kWh | R$ 21,62 | — |
| | | | **76,0 kWh** | **R$ 69,92** | Total de setembro |

**Testes de aceitação**

*Pré-condição:* morador autenticado.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Consumo do período corrente | Marina, setembro, 3 sessões | 76,0 kWh e R$ 69,92 no total |
| 02 | Período sem sessões | Rafael, agosto | Informa ausência de consumo registrado |
| 03 | Sessão encerrada pelo síndico é sinalizada | Rafael, setembro, sessão de 09/09 | Linha marcada como encerramento administrativo |
| 04 | Morador não vê consumo alheio | Marina consulta | Apenas sessões do apto 42 |

**Protótipo:** não há. Pendente — ver seção 6.

---

## 4. História disparada pelo tempo

### HU-10 — Expirar Reserva Não Utilizada

| | |
|---|---|
| **Caso de uso** | UC10 — Expirar Reserva Não Utilizada |
| **Número da história** | HU-10 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Tempo (ator temporal) |

**Descrição da história**

Como **morador que precisa de uma vaga**, eu quero **que a reserva de quem não apareceu seja
liberada automaticamente**, de modo que **o agendamento não desperdice justamente o recurso que
ele existe para organizar**.

**Fluxo principal**

1. Decorrida a tolerância de comparecimento contada do início da janela reservada, o sistema
   verifica se há sessão iniciada para aquela reserva.
2. Não havendo, o sistema marca a reserva como **expirada**.
3. A vaga volta a **Livre** no painel.
4. O morador que reservou recupera o direito de fazer um novo agendamento.
5. A expiração fica registrada e visível ao morador e ao síndico (HU-16).

**Por que não pode depender de gente.** Liberar a vaga de quem não compareceu é a única
resposta ao risco RI-05 do documento Visão. Se dependesse de alguém lembrar de fazê-lo, a vaga
ficaria bloqueada justamente nos momentos de maior disputa.

**Fluxos alternativos**

- **1a. Sessão iniciada dentro da tolerância.** Nada acontece; a reserva foi consumida em HU-04.
- **1b. Reserva cancelada antes do início.** Nada a expirar — a vaga já foi liberada em HU-03.

**Exemplo — 09/09/2026, 07h15, a reserva de Rafael expira**

| Dado | Valor |
|---|---|
| Reserva | G-01, 09/09, 07h00 às 11h00, apto 17 |
| Tolerância de comparecimento | 15 minutos |
| Sessão iniciada até 07h15? | Não |

**Saída:** reserva marcada como **expirada** às 07h15. G-01 volta a **Livre** e fica disponível
para qualquer morador. Rafael recupera o direito de agendar — o que ele exercerá ao iniciar uma
sessão avulsa às 14h00 do mesmo dia.

**Testes de aceitação**

*Pré-condição:* existe reserva cuja janela já iniciou.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Não comparecimento | Reserva 07h00–11h00, sem início até 07h15 | Reserva expirada; vaga **Livre**; direito de agendar devolvido |
| 02 | Comparecimento dentro da tolerância | Reserva 18h00–22h15, início às 18h10 | Reserva **não** expira; é consumida pela sessão |
| 03 | Comparecimento no limite exato | Reserva 07h00, início às 07h15 em ponto | Reserva **não** expira |
| 04 | Reserva cancelada antes | Cancelada às 06h00 | Nada a expirar; vaga já estava livre |
| 05 | Registro da expiração | Após o caso 01 | Expiração visível ao morador e no histórico (HU-16) |

**Protótipo:** não se aplica — não tem interface própria.

---

## 5. Histórias do Síndico

### HU-11 — Manter Vagas com Carregador

| | |
|---|---|
| **Caso de uso** | UC11 — Manter Vagas com Carregador |
| **Número da história** | HU-11 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Síndico |

**Descrição da história**

Como **síndico**, eu quero **cadastrar as vagas com carregador e a potência de cada uma**, de
modo que **o sistema calcule previsões corretas e o painel reflita a garagem real**.

**Fluxo principal**

1. O síndico acessa o cadastro de vagas.
2. Informa o código de identificação da vaga e a potência do carregador em kW.
3. O sistema valida que o código é único e a potência é positiva.
4. O sistema registra a vaga, que passa a aparecer no painel (HU-02) e a aceitar agendamentos.

**Fluxos alternativos**

- **3a. Código duplicado.** O sistema recusa.
- **4a. Desativação.** O síndico desativa uma vaga fora de operação. Ela deixa de aceitar novos
  agendamentos e sessões, mas o histórico já apurado é preservado.
- **4b. Remoção bloqueada.** Havendo sessão em andamento ou reserva futura, a vaga não pode ser
  removida — apenas desativada.

**Exemplo — 01/09/2026, Cláudia cadastra a garagem**

| Código | Potência | Saída |
|---|---|---|
| G-01 | 11,0 kW | Vaga registrada e disponível no painel |
| G-02 | 7,4 kW | Vaga registrada e disponível no painel |

Essas duas potências são o insumo que HU-05 usa para calcular a potência efetiva de cada
sessão.

**Testes de aceitação**

*Pré-condição:* síndico autenticado.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Cadastro válido | G-01, 11,0 kW | Vaga registrada e visível no painel |
| 02 | Código duplicado | G-01 novamente | Recusado |
| 03 | Potência não positiva | G-03, 0 kW | Recusado |
| 04 | Desativação preserva histórico | Desativar G-02 com sessões apuradas | Vaga some dos agendáveis; histórico mantido |
| 05 | Remoção com reserva futura | Remover G-02 com reserva para amanhã | Recusado; oferece desativar |

**Protótipo:** não há. Pendente — ver seção 6.

---

### HU-12 — Definir Tarifa de Energia

| | |
|---|---|
| **Caso de uso** | UC12 — Definir Tarifa de Energia |
| **Número da história** | HU-12 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Síndico |

**Descrição da história**

Como **síndico**, eu quero **definir o valor por quilowatt-hora aplicado no rateio**, de modo
que **o que é cobrado dos moradores acompanhe a conta de luz da área comum**.

**Fluxo principal**

1. O síndico informa o novo valor por kWh e a data de início de vigência.
2. O sistema valida que o valor é positivo.
3. O sistema registra a tarifa **sem apagar a anterior**, mantendo o histórico de vigências.
4. Sessões iniciadas a partir da nova vigência passam a usar o novo valor; as anteriores
   permanecem com a tarifa da época.

**Por que manter o histórico.** A apuração de cada sessão usa a tarifa vigente no seu início
(HU-07). Sobrescrever a tarifa anterior tornaria impossível recalcular ou justificar uma sessão
passada — e o valor lançado na cota precisa ser explicável meses depois.

**Fluxos alternativos**

- **2a. Valor não positivo.** O sistema recusa.
- **3a. Vigência retroativa.** O síndico tenta datar a vigência para trás, sobre um período já
  fechado (HU-15). O sistema recusa: períodos fechados não aceitam alteração.

**Exemplo — 01/09/2026, Cláudia lança a tarifa de setembro**

| Entrada | Valor |
|---|---|
| Tarifa | R$ 0,92 / kWh |
| Vigência a partir de | 01/09/2026 |

**Saída:** tarifa registrada. Todas as sessões deste documento são apuradas por ela.

**Testes de aceitação**

*Pré-condição:* síndico autenticado.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Definição válida | R$ 0,92 a partir de 01/09 | Tarifa registrada e vigente |
| 02 | Valor não positivo | R$ 0,00 | Recusado |
| 03 | Histórico preservado | Lançar R$ 1,05 a partir de 01/10 | Ambas as vigências consultáveis |
| 04 | Sessão antiga não é afetada | Sessão de 08/09 após a mudança de outubro | Continua apurada a R$ 0,92 |
| 05 | Retroatividade sobre período fechado | Vigência 01/09 com setembro já fechado | Recusado |

**Protótipo:** não há. Pendente — ver seção 6.

---

### HU-13 — Manter Moradores

| | |
|---|---|
| **Caso de uso** | UC13 — Manter Moradores |
| **Número da história** | HU-13 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Síndico |

**Descrição da história**

Como **síndico**, eu quero **cadastrar os moradores e vinculá-los aos seus apartamentos**, de
modo que **o consumo seja atribuído à unidade correta no rateio**.

**Fluxo principal**

1. O síndico informa nome, e-mail e apartamento do morador.
2. O sistema valida que o e-mail ainda não está em uso.
3. O sistema registra o morador e cria suas credenciais de acesso (HU-01).
4. O morador passa a poder agendar, iniciar sessões e ter consumo atribuído ao seu apartamento.

**O vínculo com o apartamento é o que viabiliza o rateio.** A unidade de cobrança é a unidade
autônoma, não a pessoa — é ao apartamento que a cota condominial se refere.

**Fluxos alternativos**

- **2a. E-mail já cadastrado.** O sistema recusa.
- **4a. Desativação.** Morador que deixou o condomínio é desativado: o acesso é revogado e o
  histórico preservado.
- **4b. Remoção bloqueada.** Havendo sessões no período ainda não fechado, o morador não pode
  ser removido — apenas desativado.
- **4c. Mais de um morador no mesmo apartamento.** Aceito. O consumo de todos soma no
  apartamento.

**Exemplo — 01/09/2026, Cláudia cadastra os moradores**

| Nome | Apartamento | Saída |
|---|---|---|
| Marina Duarte | 42 | Morador ativo, credenciais criadas |
| Rafael Nunes | 17 | Morador ativo, credenciais criadas |

**Testes de aceitação**

*Pré-condição:* síndico autenticado.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Cadastro válido | Marina Duarte, apto 42 | Morador ativo com acesso |
| 02 | E-mail duplicado | Mesmo e-mail de Marina | Recusado |
| 03 | Dois moradores no mesmo apartamento | Segundo morador no apto 42 | Aceito; consumo soma no apto 42 |
| 04 | Desativação revoga acesso | Desativar Rafael | Acesso negado em HU-01; histórico mantido |
| 05 | Remoção com sessões em aberto no período | Remover Rafael em setembro não fechado | Recusado; oferece desativar |

**Protótipo:** não há. Pendente — ver seção 6.

---

### HU-14 — Encerrar Sessão Órfã

| | |
|---|---|
| **Caso de uso** | UC14 — Encerrar Sessão Órfã |
| **Número da história** | HU-14 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Síndico |

**Descrição da história**

Como **síndico**, eu quero **encerrar administrativamente uma sessão cujo veículo já foi
retirado**, de modo que **a vaga seja liberada e o consumo do morador seja apurado**.

**Fluxo principal**

1. O síndico identifica no painel (HU-02) uma sessão marcada como *Concluída, ainda ocupada* ou
   *Excedida*.
2. **O síndico verifica fisicamente se o veículo ainda está na vaga.**
3. Confirmando que o veículo saiu, aciona o encerramento administrativo.
4. O sistema apura a energia e o valor (HU-07).
5. O sistema registra que o encerramento foi administrativo, com o síndico responsável e o
   horário.
6. A vaga passa a **Livre** no painel.

**Sessão órfã e sessão excedida não são a mesma coisa**

| | Órfã | Excedida |
|---|---|---|
| O que é | O veículo já saiu sem encerramento | A sessão passou de 6 horas |
| O veículo está na vaga? | Não | Provavelmente sim |
| Tratamento | Encerrar por aqui | Falar com o morador |
| Encerrar resolve? | Sim | **Não** — liberaria no painel uma vaga fisicamente ocupada |

**O sistema não distingue as duas**, porque não detecta a presença do veículo (restrição RE-05
do Visão). Por isso o passo 2 é ato humano, e é a parte mais importante deste fluxo.

**Fluxos alternativos**

- **2a. O veículo ainda está na vaga.** O síndico **não** encerra. Trata a situação junto ao
  morador; a sessão segue aberta e sinalizada.
- **4a. O teto de energia é acionado.** É o caso típico das órfãs, em que a duração registrada
  supera em muito o tempo de recarga real.

**Exemplo — 09/09/2026, 21h00, Cláudia trata a sessão de Rafael**

| Dado da sessão | Valor |
|---|---|
| Início | 09/09, 14h00 (G-01) |
| Previsão de conclusão | 18h22 |
| Marcada como excedida em | 20h00 |
| Verificação física às 21h00 | **Vaga vazia — o veículo saiu** |
| Potência efetiva | 11,0 kW |
| Energia a repor no início | 48,0 kWh |

```
duração          = 21h00 − 14h00                = 7,00 h
energia bruta    = 11,0 × 7,00                  = 77,0 kWh
energia estimada = min(77,0 ; 48,0)             = 48,0 kWh   ← teto aplicado
valor da sessão  = 48,0 × 0,92                  = R$ 44,16
```

**Saída:** sessão encerrada às 21h00, marcada como **encerramento administrativo por Cláudia
Berto**. Apto 17 recebe 48,0 kWh e R$ 44,16. G-01 volta a **Livre**.

Sem o teto, Rafael teria sido cobrado por 77,0 kWh — **R$ 70,84** — mais do que seu carro
poderia ter armazenado. O registro do encerramento administrativo é o que permite a ele
contestar o lançamento e a Cláudia sustentar a resposta.

**Testes de aceitação**

*Pré-condição:* existe sessão em andamento além da previsão de conclusão.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Encerramento administrativo | Sessão 14h00–21h00, 11 kW, repor 48,0 kWh | 48,0 kWh; R$ 44,16; vaga liberada |
| 02 | Registro do responsável | Após o caso 01 | Sessão marcada como administrativa, com Cláudia e o horário |
| 03 | Teto impede apuração desproporcional | Mesmos dados do caso 01 | 48,0 kWh — **não** 77,0 kWh |
| 04 | Visibilidade ao morador | Rafael consulta HU-09 | Linha sinalizada como encerramento administrativo |
| 05 | Morador não acessa esta função | Marina tenta encerrar sessão de Rafael | Função não disponível ao perfil Morador |

**Protótipo:** não há. Pendente — ver seção 6.

---

### HU-15 — Fechar Mês e Gerar Rateio

| | |
|---|---|
| **Caso de uso** | UC15 — Fechar Mês e Gerar Rateio |
| **Número da história** | HU-15 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Síndico |

**Descrição da história**

Como **síndico**, eu quero **consolidar o consumo do mês por apartamento**, de modo que **eu
possa repassar à administradora os valores a lançar em cada cota condominial**.

**Fluxo principal**

1. O síndico seleciona o período a fechar.
2. O sistema verifica que não há sessões em aberto no período.
3. O sistema apura todas as sessões encerradas (HU-07) e agrupa por apartamento.
4. O sistema apresenta, por apartamento, a energia total estimada e o valor devido, mais o
   total geral do condomínio.
5. O síndico confirma o fechamento.
6. O período passa a não aceitar novas sessões nem alterações, e o resultado fica disponível
   para exportação.

**Fluxos alternativos**

- **2a. Há sessões em aberto.** O sistema **impede** o fechamento e lista as pendências, que
  devem ser resolvidas por HU-06 ou HU-14 antes de prosseguir.
- **4a. Divergência com a conta de luz.** O total geral serve para o síndico comparar com o
  consumo medido na área comum. A diferença é esperada e não é erro do sistema — ver adiante.

**Exemplo — 01/10/2026, Cláudia fecha setembro**

| Apartamento | Sessões | Energia estimada | Valor |
|---|---|---|---|
| 17 — Rafael Nunes | 2 | 81,0 kWh | R$ 74,52 |
| 42 — Marina Duarte | 3 | 76,0 kWh | R$ 69,92 |
| **Total do condomínio** | **5** | **157,0 kWh** | **R$ 144,44** |

**A conferência que o síndico faz em seguida**

| | |
|---|---|
| Total apurado pelo sistema | 157,0 kWh |
| Medido na área comum, atribuível aos carregadores | 178,0 kWh |
| **Diferença não apurada** | **21,0 kWh — 11,8 %** |

Essa diferença **é esperada e não é defeito**. O sistema estima a energia que entra na bateria;
a concessionária mede a energia que sai da rede, maior por causa das perdas de carga e da
climatização da bateria. Os 21 kWh continuam rateados entre todos os condôminos pela cota
ordinária. É o risco RI-07 do documento Visão, e a eliminação exige medição no carregador —
fora do escopo deste projeto.

**Testes de aceitação**

*Pré-condição:* síndico autenticado; existem sessões encerradas no período.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Fechamento válido | Setembro, 5 sessões encerradas | 157,0 kWh e R$ 144,44 no total; por apartamento conforme a tabela |
| 02 | Agrupamento por apartamento | Duas sessões do apto 17 | 81,0 kWh e R$ 74,52 numa única linha |
| 03 | Sessão em aberto impede o fechamento | Sessão de 09/09 ainda aberta | Fechamento recusado; sessão listada como pendência |
| 04 | Período fechado não aceita alteração | Tentar registrar sessão em setembro após o fechamento | Recusado |
| 05 | Exportação do resultado | Após o caso 01 | Resultado exportável para repasse à administradora |
| 06 | Total geral disponível para conferência | Após o caso 01 | 157,0 kWh apresentado como total do condomínio |

**Protótipo:** não há. Pendente — ver seção 6.

---

### HU-16 — Consultar Histórico de Utilização

| | |
|---|---|
| **Caso de uso** | UC16 — Consultar Histórico de Utilização |
| **Número da história** | HU-16 |
| **Estimativa** | *a definir no Planning Poker* |
| **Ator** | Síndico |

**Descrição da história**

Como **síndico**, eu quero **consultar como as vagas foram utilizadas ao longo do tempo**, de
modo que **eu possa levar dados à assembleia ao propor a ampliação da estrutura**.

**Fluxo principal**

1. O síndico seleciona o período.
2. O sistema apura as horas de ocupação por vaga, as faixas de horário de maior demanda, o
   consumo por apartamento e os agendamentos expirados.
3. O sistema apresenta o resultado consolidado.

**Fluxos alternativos**

- **2a. Período sem utilização.** O sistema informa a ausência de registros.
- **3a. Distribuição das reservas.** O sistema evidencia a concentração de reservas por
  apartamento, permitindo identificar padrão desproporcional — mitigação do risco RI-06 do
  documento Visão.

**Exemplo — 01/10/2026, Cláudia levanta setembro para a assembleia**

| Indicador | Setembro/2026 |
|---|---|
| Horas de ocupação — G-01 | 62 h (8,6 % do mês) |
| Horas de ocupação — G-02 | 41 h (5,7 % do mês) |
| Faixa de maior demanda | 18h–22h, concentrando 68 % das sessões |
| Apartamentos usuários | 2, de 96 |
| Agendamentos expirados por não comparecimento | 3 |
| Agendamentos recusados por vaga indisponível | 7 |

**A leitura que interessa à assembleia:** a ocupação total é baixa, mas **concentrada em quatro
horas do dia** — e foi nessa faixa que ocorreram as 7 recusas. O problema não é falta de vaga
ao longo do dia; é falta de vaga no horário em que todos chegam em casa. Sem esse recorte, o
número agregado de 8,6 % sugeriria, erradamente, que não há demanda reprimida.

**Testes de aceitação**

*Pré-condição:* síndico autenticado; existem sessões no período.

| Nr. | Funcionalidade / Comportamento | Entradas | Resultado esperado |
|---|---|---|---|
| 01 | Ocupação por vaga | Setembro | G-01 com 62 h; G-02 com 41 h |
| 02 | Faixa de maior demanda | Setembro | 18h–22h identificada como pico |
| 03 | Consumo por apartamento | Setembro | Apto 17 com 81,0 kWh; apto 42 com 76,0 kWh |
| 04 | Reservas expiradas | Setembro | 3 expirações listadas |
| 05 | Concentração de reservas | Setembro | Distribuição por apartamento evidenciada |
| 06 | Período sem utilização | Julho | Informa ausência de registros |

**Protótipo:** não há. Pendente — ver seção 6.

---

## 6. Rastreabilidade e pendências

### 6.1. História ↔ Caso de uso ↔ Necessidade

| História | Caso de uso | Necessidade no Visão v2.0 |
|---|---|---|
| HU-01 Autenticar Usuário | UC01 | RE-08 (uso identificado) |
| HU-02 Consultar Painel de Vagas | UC02 | §2.2, §2.5, §2.7 |
| HU-03 Manter Agendamento | UC03 | §2.2, §2.4, §2.6 |
| HU-04 Iniciar Sessão de Recarga | UC04 | §2.1, §2.3 |
| HU-05 Calcular Previsão de Conclusão | UC05 | §2.2, §2.3 |
| HU-06 Encerrar Sessão de Recarga | UC06 | §2.1 |
| HU-07 Apurar Energia da Sessão | UC07 | §2.1 |
| HU-08 Manter Veículo | UC08 | §2.3 |
| HU-09 Consultar Consumo do Mês | UC09 | §2.1 |
| HU-10 Expirar Reserva Não Utilizada | UC10 | §2.4 |
| HU-11 Manter Vagas com Carregador | UC11 | §2.2, §2.3 |
| HU-12 Definir Tarifa de Energia | UC12 | §2.1 |
| HU-13 Manter Moradores | UC13 | §2.1 |
| HU-14 Encerrar Sessão Órfã | UC14 | §2.7 |
| HU-15 Fechar Mês e Gerar Rateio | UC15 | §2.1 |
| HU-16 Consultar Histórico de Utilização | UC16 | §2.6, §2.8 |

### 6.2. Verificação INVEST

| Critério | Situação |
|---|---|
| **I**ndependente | Atendido em 14 histórias. **HU-05 e HU-07 falham** — existem apenas por inclusão. |
| **N**egociável | Atendido. As descrições registram intenção, não solução de implementação. |
| **A**valiável | Atendido em 14. **HU-05 e HU-07 falham** — não entregam valor isolado ao usuário. |
| **E**stimável | Prejudicado enquanto HU-05 e HU-07 não forem estimadas junto com quem as inclui. |
| **D**imensionada | A confirmar no Planning Poker. HU-03 é a candidata a desmembramento, por acumular criação, consulta e cancelamento. |
| **T**estável | Atendido. Todas as histórias têm casos de teste com entradas e resultados esperados. |

### 6.3. Pendências

| Pendência | Impacto |
|---|---|
| **Tolerância de comparecimento sem valor definido.** Os exemplos deste documento usam 15 minutos como ilustração. | Afeta HU-10 e o teste 03 de HU-10. Decidir antes do detalhamento. |
| **Estimativas em aberto.** Nenhuma história foi estimada. | Atribuídas no Planning Poker, na Reunião de Planejamento do Projeto. |
| **Protótipos não iniciados.** Nenhuma história referencia protótipo. | Item 10 do Checklist de Projeto, condicional. |
| **Possível desmembramento de HU-03.** Criar, consultar e cancelar agendamento numa só história pode ficar grande demais. | Avaliar no Planning Poker, contra o critério *Dimensionada* do INVEST. |
| **Artefato antecipado.** Este documento pertence à tarefa *Detalhar Requisitos*, da Elaboração. | Revisar ao entrar na fase, confrontando com o Modelo de Análise e Design então produzido. |

---

## 7. Referências

| Documento | Local |
|---|---|
| CARREGAJA - Visão (v2.0) | `1.Requisitos/` |
| CARREGAJA - Modelo de Caso de Uso (v2.0) | `2.Analise e Design/` |
| Template - Historia de Usuario | `.spinoff/templates/` |
| Guia - INVEST | `.spinoff/GUIAS.md` |
| Guia - Use Case e Histórias do Usuário | `.spinoff/guias/` |
| SpinOff — tarefa *Detalhar Requisitos* | `.spinoff/METODO.md` |
