# Documento de Requisitos

**Versão 1.0**

**CARREGAJA - Sistema de Controle e Rateio de Recarga de Veículos Elétricos em Condomínio**

## Histórico de Revisões

| Data | Versão | Descrição | Autor |
|---|---|---|---|
| 26/09/2026 | 1.0 | Criação do documento a partir do detalhamento retirado do Visão v3.1, conforme a apresentação da Iniciação. Inclui requisitos funcionais, regras de negócio e a classificação FURPS+ das restrições. | Henrique de Almeida Marangoni Inacio |

## 1. Introdução

### 1.1. Propósito

O Visão dá a visão geral do CARREGAJA: o problema, os usuários, as restrições e os riscos. Este
documento detalha o que o Visão resume: os requisitos funcionais, as regras de negócio, a
justificativa de cada restrição, as limitações que o projeto aceita conscientemente e a análise
completa dos riscos.

É um documento **não previsto no SpinOff**. Por isso foi criado a partir de um template próprio,
`Template - Documento de Requisitos.dotx`, versionado na mesma pasta.

### 1.2. Referências

| Documento | Origem |
|---|---|
| CARREGAJA - Visão (v4.0) | 1.Requisitos/ |
| CARREGAJA - História de Usuário (v4.0) | 1.Requisitos/Casos de Uso/ |
| CARREGAJA - Modelos de Análise e Design | 2.Analise e Design/ |
| Guia - Requisitos de Sistema de Software (FURPS+) | SpinOff / Guidelines |
| Template - Documento de Requisitos | 1.Requisitos/ |

## 2. Contexto do Negócio

Condomínios residenciais verticais vêm instalando pontos de recarga para veículos elétricos nas
áreas comuns da garagem. O número de pontos é pequeno, tipicamente de um a quatro, e é
compartilhado por dezenas de apartamentos. A energia consumida sai da conta de luz da área
comum, paga por todos os condôminos, inclusive por quem não possui veículo elétrico.

Disso decorrem dois problemas simultâneos. O primeiro é de **disputa pelo recurso**: o morador
desce à garagem sem saber se encontrará ponto livre e, quando encontra tudo ocupado, não tem
como saber quando algum será liberado. O segundo é de **rateio**: sem registro de quem usou, por
quanto tempo e com qual veículo, o condomínio não individualiza o custo, e a energia de poucos
acaba dividida entre todos. Os controles paralelos hoje usados (grupo de mensagens, planilha do
síndico, rodízio informal) não produzem número defensável para lançar na cota condominial.

**Origem dos requisitos.** O projeto é conduzido em contexto acadêmico e não dispõe de cliente
externo contratante. As necessidades foram levantadas pela equipe a partir da análise do
domínio, e o Product Owner atua como representante do cliente para aprovação do escopo e do
planejamento, conforme previsto no SpinOff para o papel (RE-16).

## 3. Perfis de Usuário

| Perfil | Quem é | Responsabilidades no sistema |
|---|---|---|
| Morador | Condômino ou residente autorizado, proprietário de veículo elétrico. Vinculado a um apartamento, que é a unidade de rateio. | Consultar o painel; registrar o início e o encerramento da própria sessão; manter o cadastro do próprio veículo; consultar o consumo do mês. **Não** altera tarifa, **não** cadastra vagas e **não** acessa dados de outros apartamentos. |
| Síndico | Responsável pela administração do condomínio, eleito em assembleia, ou preposto da administradora. | Cadastrar vagas e potências; definir a tarifa; manter o cadastro de moradores e apartamentos; acompanhar o painel; encerrar sessões órfãs; fechar o mês e obter o rateio; consultar o histórico. |

**Acumulação de perfis.** O síndico é também condômino e pode possuir veículo elétrico. Nesse
caso acumula os dois perfis: usa o sistema como morador para as próprias recargas, apuradas e
rateadas como as demais, e como síndico para a gestão. As ações de gestão ficam registradas com
o usuário que as realizou.

## 4. Requisitos Funcionais

| # | O sistema deve | Caso de uso |
|---|---|---|
| RF-01 | Autenticar morador e síndico por e-mail e senha e identificar o apartamento do morador. | UC01 |
| RF-02 | Exibir a situação de cada vaga (livre, ocupada, concluída e ainda ocupada, ou excedida) e a previsão de liberação das ocupadas. | UC02 |
| RF-03 | Ocultar do morador quem ocupa uma vaga e exibir essa identificação ao síndico. | UC02 |
| RF-04 | Permitir ao morador iniciar uma sessão em vaga livre, informando a vaga e o nível atual da bateria. | UC03 |
| RF-05 | Calcular e exibir, no início da sessão, a previsão de conclusão da recarga (RN-01, RN-02). | UC03 |
| RF-06 | Recusar o início em vaga ocupada ou desativada, por morador que já tem sessão aberta ou por morador sem veículo cadastrado; registrar a recusa por vaga ocupada. | UC03 |
| RF-07 | Permitir ao morador encerrar a própria sessão e exibir a duração, a energia e o valor apurados. | UC03 |
| RF-08 | Sinalizar como excedida a sessão que atinge a duração máxima, sem encerrá-la (RN-05). | UC02, UC03 |
| RF-09 | Apurar a energia estimada e o valor de cada sessão encerrada (RN-03, RN-04). | UC04 |
| RF-10 | Permitir ao morador cadastrar e alterar o próprio veículo. | UC05 |
| RF-11 | Mostrar ao morador o consumo do mês do seu apartamento, sessão a sessão e acumulado. | UC06 |
| RF-12 | Permitir ao síndico cadastrar, alterar e desativar vagas com carregador e suas potências. | UC07 |
| RF-13 | Permitir ao síndico definir a tarifa do kWh com início de vigência, preservando as anteriores. | UC08 |
| RF-14 | Permitir ao síndico cadastrar, alterar e desativar moradores, vinculando-os ao apartamento. | UC09 |
| RF-15 | Permitir ao síndico encerrar administrativamente uma sessão órfã, registrando quem encerrou e quando. | UC10 |
| RF-16 | Fechar o mês, consolidando energia e valor por apartamento, e exportar o resultado (RN-08). | UC11 |
| RF-17 | Exibir o histórico de utilização por vaga, apartamento e período, com as tentativas recusadas por falta de vaga. | UC12 |
| RF-18 | Permitir ajustar a duração máxima da sessão (RN-05). | — |

> **RF-18 ainda não tem caso de uso.** O Visão e a análise de riscos (RI-10) tratam a duração
> máxima como parâmetro ajustável pelo síndico, mas nenhum caso de uso do modelo cobre essa
> configuração. Fica registrado como pendência para a Elaboração.

### 4.1. Limites da solução

O sistema resolve a falta de informação, não a falta de vagas. Dois limites decorrem das
restrições e foram aceitos:

| Necessidade | O que o sistema entrega | O que não entrega |
|---|---|---|
| Saber quando descer à garagem | Situação de cada vaga e previsão de liberação. | Garantia de vaga: o uso é por ordem de chegada (RE-12). Ver RI-11. |
| Liberar a vaga ocupada além do necessário | Limite de duração declarado, sinalização no painel e registro. | Impedimento físico da permanência (RE-05). Eliminar o problema exige controle do carregador (seção 7). |

## 5. Regras de Negócio

| # | Regra |
|---|---|
| RN-01 | **Potência efetiva** = min(potência do carregador, potência máxima do veículo). Um carregador de 22 kW não recarrega mais rápido um veículo que aceita no máximo 6,6 kW. |
| RN-02 | **Energia a repor** = capacidade da bateria × (100% − nível informado). **Tempo estimado** = energia a repor ÷ potência efetiva. A previsão de conclusão é o início da sessão somado ao tempo estimado. |
| RN-03 | **Energia estimada** = min(potência efetiva × duração, energia a repor). **Valor da sessão** = energia estimada × tarifa vigente no início da sessão. |
| RN-04 | A potência efetiva, a energia a repor e a tarifa são fixadas no início e gravadas na sessão. Alterar o veículo ou a tarifa depois não muda sessões já iniciadas. |
| RN-05 | A duração máxima da sessão é de 6 horas, como parâmetro. Atingido o limite, a sessão é sinalizada como excedida e permanece aberta. |
| RN-06 | Cada vaga e cada morador têm no máximo uma sessão aberta. Havendo dois registros simultâneos para a mesma vaga, prevalece o primeiro. |
| RN-07 | O encerramento da sessão é do próprio morador. O síndico só encerra sessão órfã, depois de confirmar na garagem que o veículo saiu, e o encerramento fica registrado com o responsável e o horário. |
| RN-08 | O mês só pode ser fechado sem sessões abertas no período. Depois de fechado, não aceita sessões, alterações nem tarifa retroativa. |
| RN-09 | Vaga ou morador com histórico é desativado, e não removido. |

> **Por que a apuração é por energia, e não por tempo.** Na versão 1.1 do Visão, com motorista
> anônimo, cobrar por tempo evitava que se subdeclarasse a potência para pagar menos. Aqui o
> morador é identificado, recorrente, e cadastra o veículo uma única vez, sob vista do síndico.
> A brecha fecha, e a energia passa a ser a unidade certa: é em kWh que a concessionária cobra o
> condomínio, e é isso que o rateio devolve.
>
> **Consequência aceita:** como a energia é limitada pela carga que faltava (RN-03), ocupar a
> vaga depois de carregado não custa nada. O único instrumento de rotatividade que resta é a
> duração máxima e a sinalização no painel, e não o preço. Ver RI-04.

## 6. Restrições

As restrições são impostas ao sistema ou ao processo de desenvolvimento e são tratadas como
requisitos não funcionais. A coluna **FURPS+** as classifica conforme o Guia de Requisitos do
SpinOff: Funcionalidade, Usabilidade, Confiabilidade (*Reliability*), Desempenho
(*Performance*), Suportabilidade e, no "+", requisitos de design, de implementação, de
interface e físicos. As restrições de prazo, equipe e processo não pertencem a nenhuma dessas
categorias e aparecem como **Projeto**.

### 6.1. Restrições de tecnologia e implementação

| # | Restrição | FURPS+ |
|---|---|---|
| RE-01 | O sistema deve ser desenvolvido como aplicação web. | Design |
| RE-02 | O sistema deve ser implementado na linguagem Java, em conformidade com a disciplina Linguagem de Programação 2, com a qual este projeto é integrado. | Implementação |
| RE-03 | A interface deve ser utilizável em navegador de celular, sem exigir aplicativo nativo instalado, uma vez que o morador a acessa da garagem e de dentro do apartamento. | Usabilidade |
| RE-04 | O sistema deve funcionar independentemente do sistema operacional do cliente. | Suportabilidade |

### 6.2. Restrições de escopo funcional

| # | Restrição | FURPS+ |
|---|---|---|
| RE-05 | **O sistema não se integra ao hardware dos carregadores.** O estado das vagas, o início e o fim das sessões são determinados exclusivamente pelo que os moradores registram. O sistema não aciona, não bloqueia e não mede o equipamento. Ver seção 7. | Interface |
| RE-06 | **O sistema não processa pagamento e não emite cobrança.** Apura o consumo e o valor por apartamento no período e os disponibiliza ao síndico, que os repassa à administradora para lançamento na cota condominial. | Funcionalidade |
| RE-07 | **O sistema atende a um único condomínio.** Não há multiempresa, gestão de assinantes nem separação de dados por cliente contratante. Instalação em outro condomínio é nova implantação, com base própria. | Funcionalidade |
| RE-08 | **O morador possui cadastro e credenciais.** Todo uso é identificado e vinculado a um apartamento; não há uso anônimo. O cadastro de moradores é mantido pelo síndico. | Funcionalidade |
| RE-09 | A energia atribuída a cada sessão é **estimada** a partir da potência efetiva e da duração, e não medida, uma vez que não há medição no carregador. Ver seção 7. | Confiabilidade |
| RE-10 | **O sistema não se integra ao sistema da administradora do condomínio.** O resultado do fechamento é obtido em tela e exportável, e o lançamento na cota é feito fora do sistema. | Interface |
| RE-11 | **A duração máxima de uma sessão de recarga é de 6 horas.** Atingido o limite, o sistema **sinaliza a sessão como excedida** no painel e a mantém aberta, **sem encerrá-la automaticamente**. O encerramento continua sendo do morador ou, na sua ausência, do síndico pela via administrativa. | Funcionalidade |
| RE-12 | **Não há agendamento nem reserva de vagas.** O uso é por ordem de chegada: o morador consulta o painel, ocupa uma vaga livre e registra o início. O sistema informa a disponibilidade e a previsão de liberação, mas não garante vaga a ninguém. | Funcionalidade |

**Sobre RE-11.** As 6 horas cobrem uma recarga completa na maioria dos carregadores
residenciais: uma bateria de 55 kWh, de 20% a 100%, leva cerca de 6 horas em um carregador de
7,4 kW e 4 horas em um de 11 kW. Em carregadores de 3,7 kW a carga não se completa dentro do
limite, e a recarga é concluída em mais de uma sessão. O sistema **sinaliza em vez de encerrar**
porque o encerramento automático exibiria como livre uma vaga fisicamente ocupada, o mesmo
defeito que o sistema combate; o custo dessa escolha é depender de intervenção humana. Sem o
agendamento, RE-11 e a sinalização no painel são o **único** instrumento de rotatividade que
resta.

### 6.3. Restrições de projeto

| # | Restrição | FURPS+ |
|---|---|---|
| RE-13 | O sistema deve ser entregue até o encerramento do semestre letivo 2026.2. | Projeto |
| RE-14 | A equipe é composta por quatro estudantes, com dedicação parcial, sem orçamento financeiro para aquisição de licenças, serviços ou equipamentos. | Projeto |
| RE-15 | O desenvolvimento deve seguir o processo SpinOff, com os artefatos e a estrutura de repositório por ele definidos. | Projeto |
| RE-16 | Não há cliente externo disponível para elicitação e validação de requisitos; o Product Owner atua como representante do cliente. | Projeto |

### 6.4. Requisitos não funcionais além das restrições

| Categoria | Requisito |
|---|---|
| Usabilidade | A ajuda ao morador deve estar nas próprias telas, dado que ele usa o sistema pelo celular e sem treinamento prévio. |
| Usabilidade | Mensagens de recusa de acesso não devem indicar qual campo está errado (HU-01). |
| Confiabilidade | A apuração deve ser apresentada como estimativa, com o total do período disponível para conferência contra a conta de luz (RI-05). |
| Confiabilidade | Toda ação administrativa (encerramento de sessão órfã, alteração de tarifa, fechamento do mês) deve ficar registrada com o responsável e o horário. |
| Desempenho | Não há requisito de desempenho definido. O volume é de um condomínio: poucas vagas e dezenas de apartamentos. |
| Suportabilidade | A duração máxima da sessão e a tarifa devem ser parâmetros, e não valores fixos no código (RI-10). |
| Físico | Não há: o sistema não usa hardware próprio (RE-05). |

## 7. Limitações Decorrentes da Ausência de Integração com Hardware

RE-05 e RE-09 determinam que o sistema conheça o mundo físico apenas pela declaração dos
moradores, nunca por medição. A tabela registra o que isso impede e o que seria possível com
carregadores dotados de gestão remota, do tipo que implementa o protocolo OCPP. O cenário ideal
descreve a solução completa do problema e está **fora do escopo deste projeto**. Está registrado
para deixar explícito que a limitação é conhecida e foi aceita conscientemente.

| Limitação atual | Cenário ideal (requer equipamento fora do escopo) |
|---|---|
| Não mede a energia entregue ao veículo; estima a partir de potência e tempo. | A medição viria do carregador, tornando o rateio exato e conferível contra a conta de luz da área comum. |
| Não impede o uso do carregador sem sessão registrada. | O carregador permaneceria desenergizado até o início de uma sessão, tornando impossível recarregar sem registro e sem rateio. |
| Não detecta a presença do veículo na vaga; depende do que foi declarado. | Um sensor de ocupação confirmaria chegada e saída, eliminando sessões órfãs e vagas exibidas incorretamente. |
| Não conhece o nível real da bateria; depende do valor informado. | A leitura viria do veículo pelo carregador, tornando a previsão exata e dispensando o cadastro de capacidade e potência. |
| Não interrompe o fornecimento ao concluir a recarga. | O fornecimento cessaria automaticamente, e a vaga poderia sinalizar fisicamente que está liberada para o próximo. |
| Não organiza a ordem de uso quando há mais interessados que vagas. | Com identificação no carregador, o ponto seria liberado apenas ao morador da vez, viabilizando fila ou rodízio com garantia real. |

## 8. Análise de Riscos

| # | Risco | Impacto | Resposta |
|---|---|---|---|
| RI-01 | **Dados de veículo cadastrados incorretamente**: capacidade de bateria ou potência máxima informadas de forma equivocada. | Previsão de conclusão **e apuração de energia** incorretas: o dado declarado afeta o valor rateado. | **Mitigar.** O cadastro é feito uma vez e fica visível ao síndico, que o confere contra o documento do veículo. A energia estimada é exibida ao morador ao encerrar a sessão, permitindo contestação. Divergência sistemática contra a conta de luz denuncia dado incorreto. |
| RI-02 | **Uso do carregador sem registro de sessão**: o morador pluga o veículo sem abrir sessão. | Energia consumida sem rateio, recaindo sobre todos; vaga exibida como livre. | **Mitigar.** O sistema não controla os carregadores (RE-05). Restam o painel, conferível contra a garagem real, e o confronto do total apurado com a conta de luz. Em comunidade fechada e identificada, o controle social é instrumento relevante. |
| RI-03 | **Sessão órfã**: o morador retira o veículo sem encerrar a sessão. | Vaga indisponível no painel; energia continua sendo estimada indevidamente. | **Mitigar.** O sistema sinaliza as sessões abertas além do tempo previsto, e o síndico as encerra administrativamente. A energia é limitada pela carga que faltava, o que impede a apuração de crescer indefinidamente. |
| RI-04 | **Ocupação da vaga após a conclusão da recarga**: o veículo permanece plugado depois de carregado. | Menor rotatividade; morador que desce confiando na previsão encontra a vaga ocupada. | **Aceitar, com mitigação parcial.** Como a energia é limitada pela carga que faltava, permanecer na vaga depois de carregado **não tem custo**. Sem agendamento, restam apenas RE-11 e a sinalização. Eliminar o problema exige instrumento de convivência do condomínio, fora do sistema. |
| RI-05 | **Divergência entre o total apurado e a conta de luz da área comum.** | Rateio contestável em assembleia; perda de confiança no sistema. | **Mitigar.** A apuração é estimativa e assim deve ser apresentada. O fechamento exibe o total do período, que o síndico compara com a conta e ajusta proporcionalmente, se a assembleia deliberar. Eliminar a divergência exige medição (seção 7). |
| RI-06 | **Indisponibilidade dos integrantes da equipe** pela conciliação com as demais disciplinas do semestre. | Atraso nas entregas planejadas; prazo comprometido (RE-13). | **Mitigar.** Entregas incrementais por sprint, revisão do planejamento antes de cada sprint e acompanhamento diário do quadro de tarefas. |
| RI-07 | **Ausência de cliente real para validar os requisitos** (RE-16). | Requisitos validados apenas internamente; premissas incorretas sobre o domínio podem passar despercebidas. | **Mitigar.** Registro explícito das premissas assumidas; validação do escopo e do planejamento pelo Product Owner; revisão dos requisitos a cada sprint. |
| RI-08 | **Complexidade subestimada do cálculo de previsão e de apuração**: potência efetiva e limite de energia mais complexos que o previsto. | Retrabalho na Elaboração; atraso na definição da arquitetura. | **Mitigar.** Previsão de conclusão e apuração são atacadas primeiro na Elaboração, como arquitetura executável, por concentrarem o maior risco técnico do projeto. |
| RI-09 | **Nova mudança de escopo**: o escopo já foi alterado nas versões 2.0 e 3.0 do Visão, e os casos de uso foram revistos na apresentação da Iniciação. | Retrabalho nos artefatos de requisitos e de análise; consumo de um prazo já restrito (RE-13). | **Mitigar.** As alterações decorreram de defeitos achados em revisão, e não de mudança de opinião. Toda alteração passa por issue no GitHub, com análise de impacto do Product Owner. |
| RI-10 | **Limite de duração inadequado ao parque de carregadores**: 6 horas não bastam para carregadores de 3,7 kW, em que a carga completa passa de 11 horas. | Recarga dividida em várias sessões; percepção de que o sistema atrapalha em vez de organizar. | **Mitigar.** O limite é parâmetro de configuração, e não valor fixo no código: o síndico o ajusta se o parque exigir. As 6 horas são o padrão inicial, dimensionado para 7,4 kW e 11 kW. |
| RI-11 | **Disputa não mediada pelo sistema**: sem agendamento (RE-12), dois moradores podem descer ao ver a mesma vaga livre, e quem perde a corrida desce à toa. | Conflito entre vizinhos; volta à combinação informal que o sistema pretendia substituir; morador com rotina menos flexível sistematicamente preterido. | **Aceitar, com mitigação parcial.** O painel evita a maior parte das descidas inúteis, mas não a corrida pela vaga recém-liberada. A demanda reprimida é medida (UC12) e levada à assembleia: havendo disputa frequente, a resposta é **ampliar a estrutura**, e não acrescentar regra de software. Fila poderá ser avaliada em versão futura. |

## 9. Requisitos de Documentação

| Documento | Público | Conteúdo previsto |
|---|---|---|
| Manual do Usuário - Morador | Condôminos com veículo elétrico | Cadastro do veículo; consulta ao painel; registro de início e encerramento da recarga; consulta ao consumo do mês. Deve ser sucinto e disponibilizado como **ajuda contextual nas próprias telas**, dado que o morador o acessa pelo celular e sem treinamento prévio. |
| Manual do Usuário - Síndico | Síndico e preposto da administradora | Cadastro de vagas e potências; definição da tarifa; manutenção do cadastro de moradores; tratamento de sessões órfãs; fechamento do mês e leitura do rateio; consulta ao histórico. |
| Guia de Implantação | Equipe de desenvolvimento e responsável técnico do condomínio | Procedimento de instalação e configuração do sistema no ambiente do condomínio; carga inicial de vagas, moradores e tarifa. |
