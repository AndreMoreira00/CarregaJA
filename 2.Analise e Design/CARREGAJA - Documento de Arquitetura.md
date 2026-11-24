# Documento de Arquitetura

**Versão 1.6**

**CARREGAJA - Sistema de Controle e Rateio de Recarga de Veículos Elétricos em Condomínio**

## Histórico de Revisões

| Data | Versão | Descrição | Autor |
|---|---|---|---|
| 25/10/2026 | 1.0 | Criação do documento. Registra a arquitetura definida e testada com o UC05 (Manter Veículo): API Spring Boot e telas JSF em projetos separados, conforme o modelo das aulas de Linguagem de Programação 2, e o modelo de implantação. | Henrique de Almeida Marangoni Inacio |
| 26/10/2026 | 1.1 | Pacotes organizados por camada, e não por caso de uso (seções 2.2, 3 e 8). Diagramas do UC05 no pacote `3.Arquitetura::manterveiculo` e implantação em `3.Arquitetura::implantação`. | Henrique de Almeida Marangoni Inacio |
| 03/11/2026 | 1.2 | Autenticação e perfis (UC01): token assinado na API, sessão nas telas e recusas com mensagem. Diagramas de classes do UC01 e veículo ligado ao morador. Por enquanto, o sistema tem só o UC01 e o UC05. | Henrique de Almeida Marangoni Inacio |
| 03/11/2026 | 1.3 | Telas simplificadas no modelo de LP2: cada cliente REST faz as próprias chamadas e cada bean mostra as próprias mensagens (seções 4, 5.1 e 8). | Henrique de Almeida Marangoni Inacio |
| 17/11/2026 | 1.4 | Telas em HTML, CSS e JavaScript simples, servidas pela própria API: saem o JSF, o PrimeFaces e o Tomcat 9, e o sistema passa a ser um projeto só (seções 2, 3, 5, 6 e 8). Os 12 casos de uso implementados. Pacotes por caso de uso dentro de cada camada. Resultado dos testes atualizado (seção 7). | Henrique de Almeida Marangoni Inacio |
| 23/11/2026 | 1.5 | Referências aos demais documentos atualizadas (Visão v4.3, Documento de Requisitos v1.5, História de Usuário v4.5, Guia de Implementação v1.6). Sem mudança na arquitetura. | Henrique de Almeida Marangoni Inacio |
| 23/11/2026 | 1.6 | Nuvem escolhida: Render com Supabase (seções 3, 6, 8 e 9). Restrição de mês único no fechamento e tokens invalidados pela troca de senha (seção 9). | Henrique de Almeida Marangoni Inacio |

## 1. Introdução

### 1.1. Propósito

Este documento descreve a arquitetura do CARREGAJA: as decisões técnicas, os requisitos não
funcionais que as motivaram, a organização em camadas e pacotes, a implantação e o resultado do
teste da arquitetura com o caso de uso escolhido. É a referência para quem mantém o código, junto
com o Guia de Implementação.

Os diagramas ficam no Modelo de Arquitetura, pacote `3.Arquitetura` do arquivo
`CARREGAJA - Modelos de Análise e Design.asta`. Este documento os explica e não os repete.

O SpinOff prevê o Documento de Arquitetura em `2.Analise e Design/`, mas não oferece template.
O documento segue a estrutura dos passos da tarefa *Definir Arquitetura* e o leiaute do template do
Visão.

### 1.2. Escopo

A arquitetura foi definida e testada com o **UC05 — Manter Veículo**, escolhido pela equipe em
26/09/2026. Não é o caso de uso de maior risco: a regra da potência efetiva (RI-08) entrou no
sprint 5, o primeiro da Construção, já sobre a arquitetura testada. O UC05 foi escolhido por
atravessar todas as camadas (tela, API, banco) com regras simples, o que isola o risco tecnológico
do risco de negócio.

Os diagramas de pacotes são só do UC05, o caso de uso que testou a arquitetura. Os outros onze casos
de uso, UC01 a UC12, foram implementados no mesmo desenho e têm diagramas de classes do front-end e
do back-end (seção 3.2).

### 1.3. Referências

| Documento | Origem |
|---|---|
| CARREGAJA - Visão (v4.3) | 1.Requisitos/ |
| CARREGAJA - Documento de Requisitos (v1.5) | 1.Requisitos/ |
| CARREGAJA - História de Usuário (v4.5) | 1.Requisitos/Casos de Uso/ |
| CARREGAJA - Modelos de Análise e Design | 2.Analise e Design/ |
| CARREGAJA - Guia de Implementação (v1.6) | 3.Implementacao/ |
| Código fonte (submódulo `CarregaJA_Implementacao`) | 3.Implementacao/ |

## 2. Visão Geral da Arquitetura

### 2.1. Hipóteses de trabalho

| Hipótese | Consequência para a arquitetura |
|---|---|
| O condomínio dispõe de um computador ou servidor ligado à rede, onde o sistema roda. | Um único nó de servidor hospeda a aplicação e o banco (seção 6). |
| O morador usa o navegador do celular, na garagem e no apartamento. | Aplicação web, sem aplicativo nativo; páginas com *viewport* para celular. |
| Os carregadores não têm interface de comunicação utilizável. | Não há integração com equipamento: tudo é declarado por pessoas (RE-05). |
| O volume é de um condomínio: poucas vagas e dezenas de apartamentos. | Sem requisito de desempenho; um banco relacional único basta. |

### 2.2. Decisões de arquitetura

| Decisão | Motivo |
|---|---|
| **Um projeto Maven, `carregaja-api`, que serve a API REST e as telas.** Front-end e back-end continuam separados no código: as telas só conversam com a API por HTTP e JSON, e os diagramas os mostram em separado | O professor pediu, na apresentação do sprint 3 (06/10/2026), front-end e back-end separados. Em 25/10 eles eram dois projetos (`carregaja-api` e `carregaja-jsf`). Em 16/11/2026 as telas passaram para dentro da API, para o sistema ser um programa só para subir e para explicar. Como as telas e a API ficam no mesmo endereço, não há configuração de acesso entre endereços (CORS) |
| **API REST em Spring Boot 2.7**, com Spring Data JPA, Bean Validation, Spring Security e Lombok | Mesma pilha dos exercícios de LP2. A linha 2.7 é a última com `javax.*` |
| **Telas em HTML, CSS e JavaScript simples**, sem framework e sem passo de compilação, em `src/main/resources/static` | Decisão de 16/11/2026: o JSF com PrimeFaces e o Tomcat 9 exigiam um segundo projeto, um servidor à parte e componentes difíceis de explicar. Cada tela é um arquivo HTML e um script, que chama a API com `fetch` |
| **MySQL 8** | Banco relacional usado na disciplina. As tabelas são geradas pelo JPA (`ddl-auto=update`). O driver do PostgreSQL também está no pacote: na nuvem, o banco é um PostgreSQL no Supabase, e o banco usado sai do endereço configurado |
| **Pacotes por camada e, dentro de cada camada, por caso de uso** (`br.edu.ifsp.carregaja.control.manterveiculo`, `service.fecharmes` e assim por diante), com o nome do caso de uso do Astah. O que mais de um caso de uso usa fica em `compartilhado` | Em 26/10/2026 os pacotes eram só por camada. A PR #40 do código passou a ter uma pasta por caso de uso dentro de cada camada, com o nome do caso de uso no Astah, e as pastas das telas seguem o mesmo nome. A separação em camadas, que é a dos exercícios de LP2, continua; nenhuma regra de negócio mudou |
| **Autenticação por token na API**, com Spring Security e JWT. A API confere e-mail e senha (BCrypt), devolve um token assinado e, a cada requisição, lê do banco o usuário do token | É a API que garante as regras, qualquer que seja o cliente: mesmo chamada sem passar pela tela, ela não deixa um morador agir como síndico nem em nome de outro. Ler o usuário do banco a cada requisição faz a desativação valer na hora (HU-09, teste 04), sem esperar o token vencer |
| **Validação nos dois lados** | A tela valida para orientar o morador na hora (`required`, `min` nos campos). A API valida de novo porque é ela que garante a regra, qualquer que seja o cliente |
| **Regra de negócio isolada em serviços, com teste de unidade** | A potência efetiva, a energia e o valor (RN-01 a RN-05) ficam no `ApuracaoEnergiaService`, sem banco nem tela (RI-08). O rateio fica no `RateioService` |

### 2.3. Requisitos não funcionais que guiam a arquitetura

| Requisito | Como a arquitetura atende |
|---|---|
| RE-01 — aplicação web (Design) | Telas HTML servidas pela própria API; nada é instalado no cliente. |
| RE-02 — Java, integrado a LP2 (Implementação) | API em Java 21 e Spring Boot, na organização dos exercícios de LP2. As telas são HTML e JavaScript, por decisão de 16/11/2026. |
| RE-03 — utilizável no navegador do celular (Usabilidade) | Páginas com `viewport` e leiaute que se ajusta à largura da tela. |
| RE-04 — independente do sistema operacional do cliente (Suportabilidade) | O cliente é só o navegador. |
| RE-05 — sem integração com os carregadores (Interface) | Não há componente de comunicação com equipamento. |
| RE-07 — um único condomínio (Funcionalidade) | Um banco e uma implantação por condomínio, sem separação de dados por cliente. |
| RE-08 — uso identificado (Funcionalidade) | Toda rota da API, menos a de login, exige o token. O perfil decide o que cada rota aceita (`SegurancaConfig`). As páginas são públicas: quem protege os dados é a API. |
| RE-14 — sem orçamento (Projeto) | Só software livre ou gratuito: Spring, MySQL Community. |
| Suportabilidade — parâmetros e não valores fixos (RI-10) | A tarifa fica no banco, mantida pelo síndico. A duração máxima da sessão é uma propriedade da API (`carregaja.sessao.duracao-maxima-horas`), alterada na configuração; não há tela para ela (RF-18). |
| Confiabilidade — ações administrativas registradas | A tarifa, o fechamento do mês e o encerramento administrativo gravam o síndico responsável e o horário. |

## 3. Visão Lógica: Camadas e Pacotes

Os pacotes Java ficam em `br.edu.ifsp.carregaja`, um por camada e, dentro dela, um por caso de uso.
Diagramas, no pacote `3.Arquitetura::manterveiculo`: **Pacotes do Front-end — UC05** e **Pacotes do
Back-end — UC05**. Em cada diagrama, o que pertence ao outro lado aparece em cinza, só com o nome.

### 3.1. Front-end (telas)

As telas ficam em `carregaja-api/src/main/resources/static`. Não há framework, e a mesma estrutura
serve a todos os casos de uso:

| Pasta ou arquivo | Responsabilidade | No UC05 |
|---|---|---|
| `<caso de uso>/<tela>.html` | A página do caso de uso, com o formulário e as tabelas | `manterveiculo/veiculo.html` |
| `<caso de uso>/<tela>.js` | O script da tela: busca os dados com `api(...)`, monta as linhas e trata o formulário | `manterveiculo/veiculo.js` |
| `js/comum.js` | O que todas as telas usam: guarda o login no navegador, chama a API com o token (`api('GET', '/vagas')`), desenha o menu do perfil, mostra os avisos de erro e formata datas, reais e kWh | — |
| `css/estilo.css` | O estilo de todas as telas | — |
| `index.html` | Só decide para onde ir: o painel, se há login, ou o login | — |

O menu mostra só os links do perfil de quem entrou, mas isso é organização: a segurança está na
API, que responde 403 a quem não tem o perfil.

### 3.2. Back-end (`carregaja-api`)

| Pacote | Responsabilidade | No UC05 |
|---|---|---|
| `control.<caso de uso>` | Rotas REST: recebem a requisição validada, chamam o serviço e escolhem o status HTTP | `control.manterveiculo.VeiculoController` |
| `service.<caso de uso>` | Regras de negócio do caso de uso | `service.manterveiculo.VeiculoService` |
| `repository` | Acesso ao banco, por interfaces do Spring Data | `repository.compartilhado.VeiculoRepository` |
| `model` | Entidades JPA | `model.compartilhado.Veiculo` |
| `view.<caso de uso>` | Dados de entrada da API, com as regras de validação, e as respostas que não são uma entidade | `view.manterveiculo.VeiculoRequest` |

O que mais de um caso de uso usa (`Usuario`, `Vaga`, `Veiculo`, `SessaoRecarga` e os repositórios
deles) fica em `compartilhado`. O que é de todos (`TratadorDeErros`, `RegraNegocioException`,
`ErroResponse`) fica na raiz da camada. O UC04 é o `service.apurarenergia.ApuracaoEnergiaService`,
sem controle, porque o UC03, o UC10 e o UC11 o incluem. O UC10 não tem classe própria: o back
dele está no `SessaoRecargaController` e no `SessaoRecargaService`, do pacote `mantersessaorecarga`.

**Dependências permitidas.** Na API, o controle conhece o serviço, o serviço conhece o repositório,
e todos conhecem o modelo e a view. Nenhuma camada chama a de cima. As telas conhecem a API só pelo
endereço e pelo JSON.

Diagramas de classes: **Classes do Front-end — UC05** e **Classes do Back-end — UC05**, com os
atributos e as operações públicas de cada classe, nos nomes e tipos do código, sem os acessores que
o Lombok gera. As entidades de negócio do UC05 estão em **Classes de Negócio — UC05**, e todas as
do sistema no **Modelo de Objetos**, pacote `2.Design`. Por decisão de 02/11/2026, o Modelo de
Arquitetura era só o do UC05; em 17/11/2026 os outros casos de uso ganharam os diagramas de classes do
front-end e do back-end, cada um no pacote `3.Arquitetura::<caso de uso>` (ex.: `fecharmes`), e as classes
do código estão todas em `3.Arquitetura::carregaja-api`, nos mesmos pacotes do código.

## 4. Recursos Reutilizados e Padrões

| Recurso ou padrão | Onde | O que evita escrever |
|---|---|---|
| Spring Data (`CrudRepository`) | Repositórios | Todo o SQL de gravação e consulta |
| Bean Validation (`@NotBlank`, `@Positive`, `@Valid`) | `*Request` da API | Os `if` de validação e a resposta 400 |
| Spring Security e JWT | `SegurancaConfig`, `TokenFiltro`, `TokenService` | Controle de acesso por perfil em cada rota |
| Lombok (`@Getter`, `@Setter`) | Entidades e requisições | Acessores |
| Jackson | API | Conversão entre objeto e JSON |
| `fetch` do navegador | `js/comum.js` | Biblioteca de requisição nas telas |
| MVC, *Service Layer*, *Repository* e objeto de requisição (DTO) | Toda a organização em pacotes | Mistura de regra, tela e banco na mesma classe |
| Injeção de dependência pelo construtor | Classes da API | Acoplamento a implementações concretas |

## 5. Cenário Significativo: UC05 — Manter Veículo

**Abrir a tela.** O morador abre *Meu veículo* (`manterveiculo/veiculo.html`). O `veiculo.js` pede o
veículo à API, com `GET /veiculos/meu`. Se já há veículo, os campos vêm preenchidos; se não, vazios.

**Salvar.** O morador informa modelo, capacidade da bateria (kWh) e potência máxima (kW) e clica
em *Salvar*:

1. A página valida: os três campos são obrigatórios, e capacidade e potência devem ser maiores que
   zero. Se não forem, o navegador mostra a mensagem e nada é enviado.
2. O `veiculo.js` chama `api('POST', '/veiculos', ...)` ou `api('PUT', '/veiculos/{id}', ...)`, com
   os dados em JSON e o token no cabeçalho `Authorization`.
3. Na API, o `@Valid` confere o `VeiculoRequest` de novo. Inválido, a resposta é **400** sem chegar
   ao serviço.
4. O `VeiculoController` chama o `VeiculoService`, que copia os dados para a entidade e a grava pelo
   `VeiculoRepository`. A resposta é **201** com o endereço do novo veículo, ou **200** na
   alteração, ou **404** se o id não existe.
5. A tela mostra o aviso de sucesso. Se a API responder erro, mostra a mensagem que ela mandou.

**Veículo do morador.** `GET /veiculos/meu` devolve o veículo de quem chama, e a API liga o
veículo ao usuário do token (HU-05, teste 01): o corpo da requisição não diz de quem é o veículo.

### 5.1. Autenticação (UC01)

**Entrar.** A página `autenticarusuario/login.html` envia `POST /autenticacao`. O
`AutenticacaoService` confere a senha pelo hash BCrypt e o `TokenService` assina o token. E-mail
desconhecido e senha errada têm a mesma resposta (HU-01, teste 02). O `comum.js` guarda o token e o
usuário no navegador.

**Cada chamada.** A função `api` põe o token no cabeçalho `Authorization`. Na API, o `TokenFiltro`
valida a assinatura e lê o usuário do banco; o `SegurancaConfig` decide pela rota e pelo perfil.
Sem token válido a resposta é 401; com perfil errado, 403, com ou sem a barra no fim do endereço.

**Senha provisória (RN-11).** Enquanto `trocarSenha` for verdadeiro, o `TokenFiltro` não concede nenhum
perfil, e só a rota de troca responde. As telas levam quem tem senha provisória a
`autenticarusuario/trocar-senha.html`, mas é só orientação: quem garante é a API.

**Primeiro síndico.** Quem cadastra moradores é o síndico, então o primeiro nasce da configuração: o
`PrimeiroSindicoService` o cria ao subir a API, se ainda não houver nenhum. Com
`CARREGAJA_SINDICO_APARTAMENTO`, ele também é morador, com os dois perfis (HU-01, teste 04), e pode ter veículo.

**Recusas.** Toda regra recusada lança `RegraNegocioException`, e o `TratadorDeErros` a devolve como
`{"mensagem": "..."}`, que a função `api` lê e a tela mostra.

## 6. Visão de Implantação

Diagrama: **Modelo de Implantação**, pacote `3.Arquitetura::implantação`.

| Nó | O que roda | Porta |
|---|---|---|
| Celular do morador e computador do síndico | Navegador | — |
| Servidor do condomínio → Spring Boot 2.7, com Tomcat embutido | `carregaja-api.war`: a API e as telas | 8081 |
| Servidor do condomínio → MySQL 8.4 | banco `carregaja` | 3306 |

Os dois rodam sobre o JRE 21, no mesmo servidor (RE-07). O pacote é um `war` com o Tomcat embutido,
sem servidor de aplicação à parte. O `Dockerfile` o empacota, com as telas, num contêiner só, que roda
com `java -jar`, para a nuvem. A API lê de variáveis de ambiente a senha do banco, o segredo
do token e os dados do primeiro síndico; nenhum deles fica no versionamento. O navegador fala só com
a API, e o banco não precisa ficar exposto à rede do condomínio. O passo a passo de instalação vai
para o Guia de Implantação, na Transição.

Na nuvem, escolhida em 23/11/2026, o servidor vira um serviço web do **Render**, que constrói a imagem
pelo `Dockerfile`, e o MySQL vira um **PostgreSQL no Supabase**, ligado pelo *Session pooler* (IPv4). O
pacote é o mesmo. O passo a passo e a simulação feita com a imagem e um PostgreSQL 16 estão no
`CARREGAJA - Guia de Implantação`, em `5.Implantação/`.

## 7. Teste da Arquitetura

O UC05 foi implementado e testado em 25/10/2026, quando as telas ainda eram JSF; as telas foram
refeitas em HTML em 16/11/2026, e os mesmos testes de aceitação valem para elas.

**Testes de unidade** (`mvn test` em `carregaja-api`), sem banco. Em 17/11/2026: **277 testes, todos
aprovados**, dos 12 casos de uso. Para o UC05:

| Classe | O que verifica |
|---|---|
| `VeiculoControllerTest` | As rotas com o serviço simulado: cadastro válido (201 com `Location`), modelo em branco ou nulo, capacidade zero ou ausente, potência negativa ou zero (400), veículo inexistente (404), listagem e alteração (200), e o que cada perfil pode |
| `VeiculoServiceTest` | Cópia dos dados para a entidade, ligação do veículo ao morador, alteração do existente e alteração de inexistente sem gravar |

Há ainda o `PermissoesPorPerfilTest`, que confere rota a rota o que morador e síndico podem usar.

**Teste de ponta a ponta**, com MySQL, a API no ar e as telas no Chrome, e a coleção do Postman com
as requisições dos 12 casos de uso:

| Teste de aceitação (HU-05) | Pela API | Pela tela |
|---|---|---|
| 01 — Cadastro válido (Nissan Leaf, 40 kWh, 6,6 kW) | 201, gravado no banco | Veículo cadastrado, gravado no banco |
| 02 — Capacidade não positiva (0 kWh) | 400 | O navegador recusa o 0 e nada é enviado |
| 03 — Potência não positiva (−2 kW) | 400 | O navegador recusa o valor e nada é enviado |
| 04 — Reuso sem redigitação | O início da sessão pede só a vaga e o nível | idem |
| 05 — Troca de veículo não altera o passado | A apuração usa o que a sessão gravou | idem |

**Defeitos que só o banco mostra.** Duas regras com concorrência passaram nos testes de unidade e
falharam com o MySQL: dois moradores abriam sessão na mesma vaga (a leitura dos perfis abria a foto
do `REPEATABLE_READ` antes da trava da vaga; corrigido com `READ_COMMITTED` em
`SessaoRecargaService.iniciar`), e o morador e o síndico encerrando a mesma sessão a apuravam duas
vezes (a sessão passou a ser lida já com a trava). Regra com concorrência precisa de teste com banco.

**Defeito do JSF, de 25/10 (histórico).** Com `minValue="0.1"` no campo numérico, o PrimeFaces
trocava em silêncio o 0 digitado por 0,1 e gravava. Com as telas em HTML o campo `type="number"`
com `min` recusa o valor, e a API recusa de novo.

## 8. Refinamento da Arquitetura

| Data | Mudança | Motivo |
|---|---|---|
| 28/09/2026 | Primeira versão executável: um projeto Spring Boot com as telas JSF embutidas (JoinFaces), em `controller → service → dao → model` | Implementação do UC05 no sprint 3 |
| 11/10/2026 | Pacote `cadastro` renomeado para `manterveiculo`; diagramas separados em front-end e back-end; classes com os nomes e tipos do código | Apontamentos do professor na apresentação do sprint 3 |
| 25/10/2026 | Projeto dividido em `carregaja-api` e `carregaja-jsf`, no modelo dos exercícios de LP2: camadas `control`, `service`, `repository`, `model` e `view` na API e cliente REST na tela; Modelo de Implantação | A separação de front-end e back-end, antes só nos diagramas, passou a existir no código. A organização segue a da disciplina integrada (RE-02) |
| 26/10/2026 | Pacotes por camada, direto em cada projeto (`br.edu.ifsp.carregaja.control` em vez de `br.edu.ifsp.carregaja.manterveiculo.control`); no Astah, `3.Arquitetura` reduzido a `carregaja-jsf`, `carregaja-api`, `manterveiculo` (diagramas do UC05) e `implantação` | Por caso de uso, cada um dos 12 casos de uso repetiria as cinco camadas. O nome do caso de uso ficou na pasta da página e no pacote dos diagramas |
| 02/11/2026 | Autenticação na API; `ApiClient` e `BeanBase` concentram o que todo cliente REST e todo bean repetiriam; `TratadorDeErros` leva à tela o motivo das recusas | O UC01 e as regras que só a API conhece, como e-mail repetido e vaga ocupada |
| 03/11/2026 | `ApiClient` e `BeanBase` retirados: cada cliente REST faz as próprias chamadas e cada bean mostra as próprias mensagens; `AutenticacaoFilter` reduzido ao login e à senha provisória | Deixar as telas no formato do modelo de LP2 |
| 16/11/2026 | Telas em HTML, CSS e JavaScript simples dentro da `carregaja-api`; saem o `carregaja-jsf`, o PrimeFaces e o Tomcat 9. As telas dos 12 casos de uso | Telas fáceis de explicar, um programa só para subir e sem CORS. O ganho de explicação pesou mais que o modelo de LP2 para a tela |
| 17/11/2026 | Pacotes Java e pastas de telas por caso de uso dentro de cada camada, com `compartilhado` para o que vários usam | Organização do código da PR #40 do `CarregaJA_Implementacao`, aguardando o merge; a camada continua sendo a divisão principal e nenhuma regra de negócio mudou. O motivo da equipe ainda não está registrado |
| 17/11/2026 | Pacote pronto para a nuvem: `Dockerfile`, porta pela variável `PORT` e driver do PostgreSQL | Publicação na nuvem (PR #39 do código) |
| 23/11/2026 | Nuvem: Render (API e telas) e Supabase (PostgreSQL), na mesma região | Plano gratuito suficiente para um condomínio, sem servidor no prédio. Conferido numa simulação com a imagem e um PostgreSQL 16 (Guia de Implantação, seção 4.9) |

## 9. Pendências da Arquitetura

| Pendência | Quando |
|---|---|
| Conferir a execução no Render e no Supabase de verdade. A imagem com um PostgreSQL 16 foi conferida numa simulação em 23/11/2026 | Implantação (issue #80) |
| Duração máxima da sessão sem tela (RF-18) | Fica como propriedade da API |
| Pontos da revisão: dois síndicos desativando um ao outro ao mesmo tempo, soma de energia em `double`, sessões antigas mostrando o modelo atual do veículo. O token válido depois da troca de senha e o fechamento duplicado foram corrigidos no sprint 7 (issues #81 e #82) | Pós-entrega |
