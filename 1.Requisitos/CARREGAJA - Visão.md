# Visão

**Versão 1.1**

**CARREGAJA - Sistema de Gerenciamento de Recarga de Veículos Elétricos em Estacionamentos**

## Histórico de Revisões

| Data | Versão | Descrição | Autor |
|---|---|---|---|
| 19/08/2026 | 1.0 | Elaboração inicial do documento. Seções 1 a 6. | Henrique de Almeida Marangoni Inacio |
| 19/08/2026 | 1.1 | Encerramento da sessão transferido do totem para o ponto de pagamento do estabelecimento. Inclusão do perfil Operador de Caixa. Nova seção 4.4 com as limitações decorrentes da ausência de integração com hardware. Revisão dos riscos. | Henrique de Almeida Marangoni Inacio |

## 1. Introdução

### 1.1. Resumo do Negócio

Estabelecimentos comerciais que oferecem estacionamento a seus clientes — shoppings, supermercados, restaurantes, hotéis e aeroportos — vêm instalando pontos de recarga para veículos elétricos como diferencial de atendimento e como nova fonte de receita.

A operação desses pontos, porém, é hoje conduzida sem qualquer apoio de sistema. O estabelecimento instala o carregador na vaga e passa a depender de observação visual para saber se está em uso, de anotação manual para saber quem utilizou, e de estimativa para saber quanto cobrar. O motorista, do outro lado, chega ao estacionamento sem informação sobre disponibilidade e sem previsão de quanto tempo precisará aguardar.

Esses estabelecimentos diferem quanto ao controle de saída do estacionamento. Shoppings e aeroportos operam com cancela; restaurantes, supermercados e hotéis, em geral, com estacionamento de acesso livre. Um sistema que dependesse da cancela para garantir a cobrança atenderia apenas parte desse mercado.

O CARREGAJA é um sistema destinado a esses estabelecimentos, oferecido por assinatura. Ele permite que cada um cadastre o mapa das próprias vagas com carregador, acompanhe a ocupação em tempo real e informe ao motorista a previsão de conclusão da recarga. O encerramento da sessão e a apuração do valor ocorrem no **ponto de pagamento do estabelecimento**, de modo que a recarga seja somada à conta que o cliente já iria quitar — solução que independe da existência de controle de saída.

### 1.2. Objetivo do Sistema

O objetivo do sistema é fornecer aos estabelecimentos o controle das vagas equipadas com carregador de veículos elétricos, permitindo:

- Cadastrar o mapa do estacionamento, identificando as vagas com carregador e a potência de cada uma;
- Acompanhar, em tempo real, quais vagas estão ocupadas e quais estão livres;
- Estimar o tempo restante para a conclusão de cada recarga em andamento;
- Definir a tarifa por hora de ocupação da vaga;
- Consultar relatórios de utilização e de receita por período.

Ao operador do ponto de pagamento, permitindo:

- Localizar a sessão de recarga em andamento pela placa do veículo ou pelo código de sessão;
- Encerrar a sessão e obter o valor apurado, para inclusão na conta do cliente;
- Emitir o comprovante de encerramento;
- Consultar as sessões ativas do estabelecimento.

E ao motorista, por autoatendimento em um totem instalado junto às vagas:

- A visão das vagas livres e ocupadas, com a previsão de liberação das ocupadas;
- O início da sessão de recarga, mediante informação da vaga, do modelo do veículo, do nível atual da bateria e da placa;
- A previsão de conclusão da própria recarga;
- O comprovante de início, contendo o código de sessão a ser apresentado no ponto de pagamento.

### 1.3. Glossário

| Termo | Definição |
|---|---|
| Administrador do Sistema | Perfil de usuário responsável pela operação do CARREGAJA como produto: mantém o catálogo de modelos de veículo e gerencia os estabelecimentos assinantes. |
| Catálogo de Modelos | Cadastro dos modelos de veículo elétrico conhecidos pelo sistema, com a capacidade da bateria e a potência máxima de recarga de cada um. |
| Código de Sessão | Código curto gerado no início de uma sessão de recarga e impresso no comprovante de início. É apresentado pelo motorista no ponto de pagamento para localizar a sessão. |
| Comprovante de Encerramento | Documento emitido no ponto de pagamento ao encerrar a sessão, contendo o tempo de ocupação e o valor apurado. |
| Comprovante de Início | Documento emitido pelo totem ao iniciar a sessão, contendo a vaga, a placa, o horário de início, a previsão de conclusão e o código de sessão. |
| Estabelecimento | Perfil de usuário correspondente ao gestor do cliente contratante. Cadastra o mapa do estacionamento, define a tarifa e consulta relatórios. |
| kW (quilowatt) | Unidade de potência. Indica a velocidade com que a energia é transferida ao veículo. |
| kWh (quilowatt-hora) | Unidade de energia. Corresponde à quantidade de energia transferida ao veículo. |
| Motorista | Perfil de usuário correspondente ao condutor do veículo elétrico. Utiliza o sistema de forma anônima, pelo totem. |
| OCPP | Open Charge Point Protocol. Protocolo aberto de comunicação entre carregadores de veículos elétricos e sistemas de gestão, que permite acionar, interromper e medir remotamente o fornecimento de energia. Não utilizado neste escopo. |
| Operador de Caixa | Perfil de usuário correspondente ao funcionário que atende o ponto de pagamento do estabelecimento. Localiza e encerra sessões de recarga e emite o comprovante de encerramento. |
| Painel de Vagas | Tela que exibe a situação de todas as vagas com carregador do estabelecimento, com a previsão de conclusão das ocupadas. |
| Perfil Genérico | Entrada do catálogo de modelos com valores médios por porte de veículo, utilizada quando o modelo do motorista não está cadastrado. |
| Ponto de Pagamento | Local do estabelecimento onde o cliente quita sua conta — caixa do restaurante, guichê do estacionamento, recepção do hotel. É onde a sessão de recarga é encerrada e o valor é somado à conta. |
| Potência Efetiva | Menor valor entre a potência do carregador da vaga e a potência máxima de recarga aceita pelo veículo. É a potência realmente aplicada na recarga. |
| Sessão de Recarga | Registro do uso de uma vaga com carregador por um veículo, do momento em que o motorista a inicia no totem até o momento em que o operador de caixa a encerra. |
| Sessão Órfã | Sessão de recarga que permanece aberta muito além do tempo estimado de conclusão, indicando que não foi encerrada no ponto de pagamento. |
| Tarifa | Valor por hora de ocupação da vaga, definido pelo estabelecimento. |
| Totem | Terminal de autoatendimento instalado junto às vagas com carregador, por onde o motorista consulta o painel e inicia a sessão de recarga. |
| Vaga com Carregador | Vaga do estacionamento equipada com ponto de recarga, identificada por um código e associada a uma potência. |

### 1.4. Referências

| Documento | Origem |
|---|---|
| SpinOff - Processo de Desenvolvimento de Sistemas | http://arum.tec.br/SpinOff/index.htm |
| Guia - Requisitos de Sistema de Software | SpinOff / Guidelines |
| Guia - INVEST | SpinOff / Guidelines |
| Guia - Políticas de Gerenciamento de Configuração | SpinOff / Guidelines |
| Template do Visão | SpinOff / Templates |
| CARREGAJA - Modelo de Caso de Uso | 2.Analise e Design/ |
| CARREGAJA - Planejamento e Controle do Projeto | 6.Gerenciamento de Projeto/ |

## 2. Problema

Esta seção apresenta a análise do problema: o entendimento da situação atual, a identificação dos envolvidos afetados, os impactos gerados e a delimitação do escopo em alto nível, representado pelas necessidades dos envolvidos.

### 2.1. Ausência de controle sobre o uso dos carregadores

|   |   |
|---|---|
| **Problema** | O estabelecimento não tem registro de quem utilizou cada vaga com carregador, por quanto tempo, nem em que momento. O acompanhamento depende de observação visual de um funcionário. |
| **Afetados** | Gestor do estacionamento; funcionários do estabelecimento. |
| **Impacto** | Impossibilidade de apurar receita e de justificar valores cobrados; energia consumida sem contrapartida financeira; nenhum dado para decidir se vale a pena instalar mais pontos de recarga. |
| **Necessidades (Escopo)** | Como gestor do estacionamento, eu quero registrar cada uso das vagas com carregador, de modo que eu possa apurar a receita e comprovar os valores cobrados.<br>Como gestor do estacionamento, eu quero consultar relatórios de utilização por período e por vaga, de modo que eu possa avaliar o retorno do investimento em pontos de recarga. |

### 2.2. Falta de informação ao motorista sobre disponibilidade e tempo

|   |   |
|---|---|
| **Problema** | O motorista chega ao estacionamento sem saber se há vaga com carregador disponível e, ao encontrar todas ocupadas, não tem como saber quando alguma será liberada. Também não sabe quanto tempo sua própria recarga levará. |
| **Afetados** | Motoristas de veículos elétricos; funcionários do estabelecimento, procurados para responder essas dúvidas. |
| **Impacto** | Tempo perdido circulando pelo estacionamento; permanência desnecessária junto à vaga aguardando a recarga; insatisfação com o estabelecimento; sobrecarga dos funcionários com perguntas que o sistema poderia responder. |
| **Necessidades (Escopo)** | Como motorista, eu quero ver quais vagas com carregador estão livres e ocupadas, de modo que eu não perca tempo procurando.<br>Como motorista, eu quero ver a previsão de liberação das vagas ocupadas, de modo que eu possa decidir se aguardo ou se volto em outro momento.<br>Como motorista, eu quero saber quanto tempo minha recarga levará, de modo que eu possa planejar minha permanência no estabelecimento. |

### 2.3. Vaga ocupada após a conclusão da recarga

|   |   |
|---|---|
| **Problema** | O veículo permanece estacionado na vaga com carregador depois de a recarga ter terminado, impedindo o uso por outros motoristas. O estabelecimento não dispõe de instrumento para desestimular esse comportamento. |
| **Afetados** | Motoristas que aguardam vaga; gestor do estacionamento. |
| **Impacto** | Redução da rotatividade das vagas; menor receita por vaga; fila e insatisfação entre motoristas; investimento em pontos de recarga subaproveitado. |
| **Necessidades (Escopo)** | Como gestor do estacionamento, eu quero que a cobrança seja proporcional ao tempo total de ocupação da vaga, de modo que permanecer após a conclusão da recarga tenha custo para o motorista.<br>Como gestor do estacionamento, eu quero identificar as vagas cuja recarga já concluiu e continuam ocupadas, de modo que eu possa intervir quando necessário. |

### 2.4. Impossibilidade de apurar o valor devido por uso

|   |   |
|---|---|
| **Problema** | Sem registro de início e fim de uso, o estabelecimento não consegue calcular quanto cobrar de cada motorista, nem emitir documento que sustente a cobrança. |
| **Afetados** | Gestor do estacionamento; operadores de caixa; motoristas. |
| **Impacto** | Cobrança por estimativa ou valor fixo, que penaliza uns e beneficia outros; discussão no caixa por falta de comprovação; receita perdida por uso não cobrado. |
| **Necessidades (Escopo)** | Como operador de caixa, eu quero obter o valor apurado da recarga ao encerrar a sessão, de modo que eu possa somá-lo à conta do cliente com comprovação.<br>Como gestor do estacionamento, eu quero definir a tarifa por hora de ocupação, de modo que a cobrança acompanhe minha política comercial. |

### 2.5. Risco de evasão quando encerramento e pagamento ocorrem em locais distintos

|   |   |
|---|---|
| **Problema** | Se a sessão fosse encerrada no totem, junto às vagas, o motorista precisaria sair do estabelecimento para encerrá-la e retornar para efetuar o pagamento. Em estabelecimentos sem controle de saída — restaurantes, supermercados, hotéis — nada o obrigaria a retornar. |
| **Afetados** | Gestor do estacionamento; operadores de caixa; motoristas, submetidos a deslocamento desnecessário. |
| **Impacto** | Receita perdida por evasão; experiência de uso ruim, com duas idas e vindas até o veículo; inviábilidade comercial do produto para todo o segmento de estabelecimentos com estacionamento de acesso livre. |
| **Necessidades (Escopo)** | Como operador de caixa, eu quero encerrar a sessão de recarga no próprio ponto de pagamento, de modo que a recarga seja quitada junto com a conta que o cliente já iria pagar.<br>Como motorista, eu quero pagar a recarga junto com a conta do estabelecimento, de modo que eu não precise de deslocamentos adicionais até o veículo. |

### 2.6. Estimativa de tempo dependente das características do veículo

|   |   |
|---|---|
| **Problema** | O tempo de recarga não depende apenas do carregador: depende também da capacidade da bateria do veículo e da potência máxima que ele aceita. Um carregador de 22 kW não recarrega mais rápido um veículo que aceita no máximo 6,6 kW. Sem essa informação, qualquer previsão de tempo é incorreta. |
| **Afetados** | Motoristas; gestor do estacionamento. |
| **Impacto** | Previsões de conclusão erradas, que levam o motorista a retornar no momento errado e derrubam a confiança na informação exibida pelo painel. |
| **Necessidades (Escopo)** | Como administrador do sistema, eu quero manter um catálogo de modelos de veículo com capacidade de bateria e potência máxima de recarga, de modo que as previsões de tempo sejam calculadas corretamente.<br>Como motorista, eu quero informar o modelo do meu veículo e o nível atual da bateria, de modo que o sistema calcule a previsão de conclusão da minha recarga. |

## 3. Usuários

### 3.1. Fornecedores de requisitos

| Nome | Responsável/Cargo | E-mail | Responsabilidades |
|---|---|---|---|
| Matheus Ribeiro Andrade | Product Owner | ribeiro.andrade@aluno.ifsp.edu.br | Representar os interesses do cliente perante a equipe; definir e priorizar as funcionalidades do produto; aprovar o escopo e o planejamento; aceitar ou rejeitar os resultados de trabalho. |
| Henrique de Almeida Marangoni Inacio | Scrum Master | henrique.marangoni@aluno.ifsp.edu.br | Garantir a aderência ao processo definido; manter o planejamento e o controle do projeto; conduzir os eventos do processo; remover impedimentos da equipe. |
| André Fernandes Nascimento Moreira | Desenvolvedor | andre.moreira@aluno.ifsp.edu.br | Participar da análise do domínio e do levantamento de necessidades; executar as atividades de desenvolvimento, dos requisitos à implantação. |
| Alex Junior Fortunato Sacramento | Desenvolvedor | alex.sacramento@aluno.ifsp.edu.br | Participar da análise do domínio e do levantamento de necessidades; executar as atividades de desenvolvimento, dos requisitos à implantação. |

**Nota sobre a origem dos requisitos.**

Este projeto é conduzido em contexto acadêmico e não dispõe de um cliente externo contratante. As necessidades registradas na seção 2 foram levantadas pela equipe a partir da análise do domínio, e o Product Owner atua como representante do cliente para efeito de aprovação do escopo e do planejamento, conforme previsto no processo SpinOff para o papel.

### 3.2. Perfis de usuário do sistema

| Perfil | Quem é | Responsabilidades no sistema |
|---|---|---|
| Administrador do Sistema | Responsável pela operação do CARREGAJA como produto, junto ao fornecedor do software. | Manter o catálogo de modelos de veículo e os perfis genéricos; cadastrar e gerenciar os estabelecimentos assinantes. |
| Estabelecimento | Gestor do estacionamento do estabelecimento contratante. | Cadastrar o mapa do estacionamento e as vagas com carregador; definir a tarifa por hora; gerenciar os operadores de caixa; acompanhar o painel de vagas; tratar sessões órfãs; consultar relatórios de utilização e receita. |
| Operador de Caixa | Funcionário que atende o ponto de pagamento do estabelecimento — caixa do restaurante, guichê do estacionamento, recepção do hotel. | Localizar sessão ativa por placa ou código; encerrar a sessão e obter o valor apurado; emitir o comprovante de encerramento; consultar as sessões ativas. **Não** altera tarifa, **não** acessa relatórios financeiros e **não** modifica o mapa do estacionamento. |
| Motorista | Condutor de veículo elétrico, usuário do estacionamento. Utiliza o sistema de forma anônima, sem cadastro. | Consultar o painel de vagas; iniciar sessão de recarga informando vaga, modelo, nível de bateria e placa; obter o comprovante de início com o código de sessão. |

## 4. Restrições Impostas

As restrições abaixo são impostas ao sistema ou ao processo de desenvolvimento. Elas devem ser tratadas como requisitos não funcionais e, quando aplicável, também como riscos ao projeto.

### 4.1. Restrições de tecnologia e implementação

| # | Restrição |
|---|---|
| RE-01 | O sistema deve ser desenvolvido como aplicação web. |
| RE-02 | O sistema deve ser implementado na linguagem Java, em conformidade com a disciplina Linguagem de Programação 2, com a qual este projeto é integrado. |
| RE-03 | A interface do totem deve funcionar em navegador web sobre tela sensível ao toque, sem exigir aplicativo nativo instalado. |
| RE-04 | O sistema deve funcionar independentemente do sistema operacional do cliente. |

### 4.2. Restrições de escopo funcional

| # | Restrição |
|---|---|
| RE-05 | **O sistema não se integra ao hardware dos carregadores.** O estado de ocupação das vagas, o início e o fim das sessões são determinados exclusivamente pelas informações registradas por pessoas no totem e no ponto de pagamento. O sistema não aciona, não bloqueia e não mede o equipamento de recarga. Ver seção 4.4. |
| RE-06 | **O sistema não processa pagamento.** Ele apura o valor devido e o disponibiliza ao operador de caixa, que o soma à conta do cliente e a recebe pelos meios que o estabelecimento já utiliza. |
| RE-07 | **O encerramento da sessão ocorre exclusivamente no ponto de pagamento**, pelo Operador de Caixa. O totem não encerra sessões. Consequentemente, o estabelecimento assinante deve dispor de um ponto de pagamento atendido por funcionário; estacionamentos não assistidos não são atendidos por este sistema. |
| RE-08 | **O motorista não possui cadastro no sistema.** O uso é anônimo, identificado apenas pela placa do veículo e pelo código de sessão. Não há login, senha ou armazenamento de dados pessoais do motorista além da placa. |
| RE-09 | A apuração do valor devido baseia-se no **tempo de ocupação da vaga**, e não na energia efetivamente consumida, uma vez que o sistema não dispõe de medição. Ver seção 4.4. |

### 4.3. Restrições de projeto

| # | Restrição |
|---|---|
| RE-10 | O sistema deve ser entregue até o encerramento do semestre letivo 2026.2. |
| RE-11 | A equipe é composta por quatro estudantes, com dedicação parcial, sem orçamento financeiro para aquisição de licenças, serviços ou equipamentos. |
| RE-12 | O desenvolvimento deve seguir o processo SpinOff, com os artefatos e a estrutura de repositório por ele definidos. |
| RE-13 | Não há cliente externo disponível para elicitação e validação de requisitos; o Product Owner atua como representante do cliente. |

### 4.4. Limitações decorrentes da ausência de integração com hardware

As restrições RE-05 e RE-09 determinam que o sistema conheça o mundo físico apenas por declaração de pessoas, nunca por medição. A tabela abaixo registra o que isso impede e o que seria possível com carregadores dotados de gestão remota, do tipo que implementa o protocolo OCPP. O cenário ideal descreve a solução completa do problema e está **fora do escopo deste projeto**; ele é registrado para deixar explícito que a limitação é conhecida e foi aceita conscientemente.

| Limitação atual | Cenário ideal (requer equipamento fora do escopo) |
|---|---|
| O sistema não interrompe o fornecimento de energia ao encerrar a sessão. O veículo pode permanecer carregando após o pagamento. | O encerramento da sessão no ponto de pagamento acionaria a interrupção do fornecimento no carregador, tornando impossível carregar após a quitação. |
| O sistema não impede o uso do carregador sem sessão registrada. | O carregador permaneceria desenergizado até o início de uma sessão, tornando impossível carregar sem registro e eliminando a evasão de receita. |
| O sistema não mede a energia efetivamente entregue ao veículo; apura por tempo de ocupação. | A medição viria do próprio carregador, permitindo cobrança proporcional ao consumo real e conferência entre o total medido e o total faturado. |
| O sistema não detecta a presença física do veículo na vaga; depende do que foi declarado. | Um sensor de ocupação confirmaria a chegada e a saída do veículo, eliminando sessões órfãs e vagas exibidas incorretamente no painel. |
| O sistema não conhece o nível real da bateria; depende do valor informado pelo motorista. | A leitura viria do veículo pelo próprio carregador, tornando a previsão de conclusão exata e dispensando o catálogo de modelos. |

## 5. Riscos

| # | Risco | Impacto | Resposta |
|---|---|---|---|
| RI-01 | **Dados de veículo declarados incorretamente pelo motorista** — modelo ou nível de bateria informados de forma equivocada. | Previsão de conclusão incorreta, reduzindo a confiança no painel. Não afeta o valor cobrado, que se baseia no tempo de ocupação. | **Mitigar.** O totem exibe a previsão calculada antes da confirmação, permitindo ao motorista perceber e corrigir uma estimativa incompatível. |
| RI-02 | **Uso do carregador sem registro de sessão** — o motorista pluga o veículo sem interagir com o totem. | Energia consumida sem apuração de receita; vaga exibida como livre no painel. | **Aceitar.** O sistema não controla fisicamente os carregadores (RE-05) e não dispõe de meio para detectar o uso não declarado; ver seção 4.4. Mitigação parcial: o painel do estabelecimento permite conferência visual entre as vagas exibidas como livres e as efetivamente ocupadas. |
| RI-03 | **Motorista não informa a recarga no ponto de pagamento** — deixa de apresentar o comprovante de início ao quitar a conta. | Sessão não encerrada e recarga não cobrada; vaga permanece indisponível no painel. | **Mitigar.** O Operador de Caixa consulta as sessões ativas a qualquer momento, com vaga e placa, podendo conferí-las antes do fechamento do período. Em estabelecimentos com controle de saída, o comprovante integra-se à cobrança do estacionamento. |
| RI-04 | **Recarga após o encerramento da sessão** — o motorista quita a conta e mantém o veículo plugado. | Energia consumida sem apuração; vaga exibida como livre enquanto ainda ocupada. | **Mitigar.** O encerramento ocorre no momento em que o cliente deixa o estabelecimento, o que reduz a janela a poucos minutos no uso legítimo. O painel permite ao estabelecimento identificar vagas exibidas como livres e fisicamente ocupadas. A eliminação completa exige hardware; ver seção 4.4. |
| RI-05 | **Sessão órfã** — o motorista deixa o estabelecimento sem passar pelo ponto de pagamento. | Vaga permanece indisponível no painel; valor continua sendo apurado indefinidamente. | **Mitigar.** O sistema sinaliza as sessões abertas além do tempo estimado de conclusão e as que ultrapassam um limite máximo de duração, permitindo que o Estabelecimento as encerre administrativamente. |
| RI-06 | **Encerramento indevido de sessão de terceiro** — apresentação de comprovante alheio no ponto de pagamento. | Sessão encerrada e cobrada da pessoa errada; vaga exibida incorretamente. | **Mitigar.** O encerramento exige o código de sessão e a placa, conferidos pelo Operador de Caixa, que é usuário identificado do sistema e responde pela operação. Toda ação de encerramento fica registrada com o operador que a realizou. |
| RI-07 | **Modelo de veículo ausente do catálogo** — o motorista não encontra seu veículo na lista. | Impossibilidade de iniciar a sessão, frustrando o atendimento por autoatendimento. | **Mitigar.** O catálogo mantém **perfis genéricos por porte de veículo**, sempre disponíveis como alternativa. A previsão gerada a partir de perfil genérico é identificada como aproximada. |
| RI-08 | **Indisponibilidade dos integrantes da equipe** — conciliação com as demais disciplinas do semestre. | Atraso nas entregas planejadas; comprometimento do prazo (RE-10). | **Mitigar.** Planejamento com entregas incrementais por Sprint, revisão do planejamento antes de cada Sprint e acompanhamento diário do quadro de tarefas. |
| RI-09 | **Ausência de cliente real para validação dos requisitos** (RE-13). | Requisitos validados apenas internamente, com risco de premissas incorretas sobre o domínio não serem detectadas. | **Mitigar.** Registro explícito das premissas assumidas; validação do escopo e do planejamento pelo Product Owner; revisão dos requisitos a cada Sprint. |
| RI-10 | **Complexidade subestimada do cálculo de recarga** — regras de potência efetiva e de apuração mais complexas do que o previsto. | Retrabalho na Elaboração; atraso na definição da arquitetura. | **Mitigar.** A funcionalidade de cálculo será tratada com prioridade na fase de Elaboração, como parte da arquitetura executável, por concentrar o maior risco técnico do projeto. |

## 6. Requisitos de Documentação

A documentação a seguir deverá ser desenvolvida para suportar a implantação e o uso do sistema:

| Documento | Público | Conteúdo previsto |
|---|---|---|
| Manual do Usuário - Estabelecimento | Gestor do estacionamento | Cadastro do mapa e das vagas; definição de tarifa; gestão dos operadores de caixa; uso do painel; tratamento de sessões órfãs; emissão e leitura dos relatórios. |
| Manual do Usuário - Ponto de Pagamento | Operador de caixa | Localização e encerramento de sessão; leitura do valor apurado; emissão do comprovante. Deve ser um roteiro curto e de consulta rápida, dada a alta rotatividade típica da função. |
| Manual do Usuário - Totem | Motorista | Orientação de uso do autoatendimento. Deve ser sucinto e disponibilizado como **ajuda contextual nas próprias telas do totem**, dado que o motorista não tem treinamento prévio nem tempo para consultar manual. |
| Guia de Implantação | Equipe de desenvolvimento e responsável técnico do estabelecimento | Procedimento de instalação e configuração do sistema, do totem e dos terminais de ponto de pagamento no ambiente do estabelecimento. |

