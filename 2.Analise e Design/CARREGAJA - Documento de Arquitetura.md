# Documento de Arquitetura

**Versão 1.2**

**CARREGAJA - Sistema de Controle e Rateio de Recarga de Veículos Elétricos em Condomínio**

## Histórico de Revisões

| Data | Versão | Descrição | Autor |
|---|---|---|---|
| 25/10/2026 | 1.0 | Criação do documento. Registra a arquitetura definida e testada com o UC05 (Manter Veículo): API Spring Boot e telas JSF em projetos separados, conforme o modelo das aulas de Linguagem de Programação 2, e o modelo de implantação. | Henrique de Almeida Marangoni Inacio |
| 26/10/2026 | 1.1 | Pacotes organizados por camada, e não por caso de uso (seções 2.2, 3 e 8). Diagramas do UC05 no pacote `3.Arquitetura::manterveiculo` e implantação em `3.Arquitetura::implantação`. | Henrique de Almeida Marangoni Inacio |
| 02/11/2026 | 1.2 | Autenticação e perfis (UC01): token assinado na API, sessão nas telas e recusas com mensagem. Diagramas de classes do UC01 e veículo ligado ao morador. Por enquanto, a única tela é a de login. | Henrique de Almeida Marangoni Inacio |

## 1. Introdução

### 1.1. Propósito

Este documento descreve a arquitetura do CARREGAJA: as decisões técnicas, os requisitos não
funcionais que as motivaram, a organização em camadas e pacotes, a implantação e o resultado do
teste da arquitetura com o caso de uso escolhido. É a referência para quem implementa os casos de
uso da Construção, junto com o Guia de Implementação.

Os diagramas ficam no Modelo de Arquitetura, pacote `3.Arquitetura` do arquivo
`CARREGAJA - Modelos de Análise e Design.asta`. Este documento os explica e não os repete.

O SpinOff prevê o Documento de Arquitetura em `2.Analise e Design/`, mas não oferece template.
O documento segue a estrutura dos passos da tarefa *Definir Arquitetura* e o leiaute do template do
Visão.

### 1.2. Escopo

A arquitetura foi definida e testada com o **UC05 — Manter Veículo**, escolhido pela equipe em
26/09/2026. Não é o caso de uso de maior risco: a regra da potência efetiva (RI-08) entra no sprint
5, o primeiro da Construção, já sobre a arquitetura testada. O UC05 foi escolhido por atravessar
todas as camadas (tela, API, banco) com regras simples, o que isola o risco tecnológico do risco de
negócio.

### 1.3. Referências

| Documento | Origem |
|---|---|
| CARREGAJA - Visão (v4.1) | 1.Requisitos/ |
| CARREGAJA - Documento de Requisitos (v1.2) | 1.Requisitos/ |
| CARREGAJA - História de Usuário (v4.3) | 1.Requisitos/Casos de Uso/ |
| CARREGAJA - Modelos de Análise e Design | 2.Analise e Design/ |
| CARREGAJA - Guia de Implementação | 3.Implementacao/ |
| Código fonte (submódulo `CarregaJA_Implementacao`) | 3.Implementacao/ |

## 2. Visão Geral da Arquitetura

### 2.1. Hipóteses de trabalho

| Hipótese | Consequência para a arquitetura |
|---|---|
| O condomínio dispõe de um computador ou servidor ligado à rede, onde o sistema roda. | Um único nó de servidor hospeda as telas, a API e o banco (seção 6). |
| O morador usa o navegador do celular, na garagem e no apartamento. | Aplicação web, sem aplicativo nativo; páginas com *viewport* para celular. |
| Os carregadores não têm interface de comunicação utilizável. | Não há integração com equipamento: tudo é declarado por pessoas (RE-05). |
| O volume é de um condomínio: poucas vagas e dezenas de apartamentos. | Sem requisito de desempenho; um banco relacional único basta. |

### 2.2. Decisões de arquitetura

| Decisão | Motivo |
|---|---|
| **Dois projetos: `carregaja-api` (back-end) e `carregaja-jsf` (front-end)**, que conversam por HTTP com JSON | Pedido do professor na apresentação do sprint 3 (06/10/2026): front-end e back-end separados. É também o modelo dos exercícios de LP2 (a API e a tela JSF da prova), ao qual o projeto está integrado (RE-02). |
| **API REST em Spring Boot 2.7**, com Spring Data JPA, Bean Validation e Lombok | Mesma pilha dos exercícios de LP2. A linha 2.7 é a última com `javax.*`, compatível com o Tomcat 9. |
| **Telas em JSF com PrimeFaces 12**, num Tomcat 9 | Componentes prontos de formulário, mensagem e validação. O Tomcat 9 é o servidor usado na disciplina. |
| **MySQL 8** | Banco relacional usado na disciplina. As tabelas são geradas pelo JPA (`ddl-auto=update`). |
| **Pacotes organizados por camada** (`br.edu.ifsp.carregaja.control`, `.service`, `.repository`, `.model`, `.view`), com o nome do caso de uso na pasta da página (`webapp/restricted/manterveiculo`) e no pacote dos diagramas (`3.Arquitetura::manterveiculo`) | Organizar por caso de uso repetiria as mesmas camadas em cada um dos 12 casos de uso. Por camada é a organização dos exercícios de LP2 e do exemplo de arquitetura do professor. O pedido do professor no sprint 3, de o pacote da arquitetura ter o nome do caso de uso, continua atendido na pasta da página e nos diagramas. |
| **Por enquanto, a única tela é a de login**, com a troca de senha. Os demais casos de uso são usados pelas rotas da API | Decisão do Scrum Master em 02/11/2026. As telas dos outros casos, inclusive a do veículo, testada no sprint 4, estão guardadas na branch `telas-sprint-5` do fork `R1ck-dev` |
| **Autenticação por token na API**, com Spring Security e JWT. A API confere e-mail e senha (BCrypt), devolve um token assinado e, a cada requisição, lê do banco o usuário do token | É a API que garante as regras, qualquer que seja o cliente: mesmo chamada sem passar pela tela, ela não deixa um morador agir como síndico nem em nome de outro. Ler o usuário do banco a cada requisição faz a desativação valer na hora (HU-09, teste 04), sem esperar o token vencer |
| **Validação nos dois lados** | A tela valida para orientar o morador na hora. A API valida de novo porque é ela que garante a regra, qualquer que seja o cliente. |

### 2.3. Requisitos não funcionais que guiam a arquitetura

| Requisito | Como a arquitetura atende |
|---|---|
| RE-01 — aplicação web (Design) | Telas JSF servidas pelo Tomcat; nada é instalado no cliente. |
| RE-02 — Java, integrado a LP2 (Implementação) | Java 21, Spring Boot e JSF, na mesma organização dos exercícios de LP2. |
| RE-03 — utilizável no navegador do celular (Usabilidade) | Páginas com `viewport` e componentes PrimeFaces responsivos. |
| RE-04 — independente do sistema operacional do cliente (Suportabilidade) | O cliente é só o navegador. |
| RE-05 — sem integração com os carregadores (Interface) | Não há componente de comunicação com equipamento. |
| RE-07 — um único condomínio (Funcionalidade) | Um banco e uma implantação por condomínio, sem separação de dados por cliente. |
| RE-08 — uso identificado (Funcionalidade) | Toda rota, menos a de login, exige o token. O perfil decide o que cada rota aceita (`SegurancaConfig`). |
| RE-14 — sem orçamento (Projeto) | Só software livre ou gratuito: Spring, PrimeFaces, Tomcat, MySQL Community. |
| Suportabilidade — parâmetros e não valores fixos (RI-10) | A tarifa e a duração máxima ficam no banco, mantidas pelo síndico, e não no código. Entram na Construção. |
| Confiabilidade — ações administrativas registradas | Cada entidade administrativa terá responsável e horário gravados, na camada de serviço. Entra na Construção. |

## 3. Visão Lógica: Camadas e Pacotes

Os pacotes Java ficam em `br.edu.ifsp.carregaja`, um por camada. Diagramas: **Pacotes do Front-end — UC01**, em
`3.Arquitetura::autenticarusuario`, e **Pacotes do Back-end — UC05**, em `3.Arquitetura::manterveiculo`. Em cada diagrama, o
que pertence ao outro projeto aparece em cinza, só com o nome.

### 3.1. Front-end (`carregaja-jsf`)

| Pacote | Responsabilidade | No UC01 |
|---|---|---|
| `webapp/autenticarusuario` e `webapp/restricted/autenticarusuario` | Páginas XHTML do caso de uso, no leiaute comum (`WEB-INF/template`) | `AutenticarUsuarioView.xhtml`, `TrocarSenhaView.xhtml` |
| `controller` | Beans JSF: carregam a tela, recebem as ações e mostram as mensagens | `AutenticarUsuarioBean`, `TrocarSenhaBean`, `AutenticacaoFilter` |
| `service` | Cliente HTTP da API: monta as chamadas e traduz as falhas em mensagem | `AutenticacaoRestClient`, `ApiClient`, `UsuarioLogado` |
| `model` | Os dados como a API os devolve e os corpos das requisições | `Usuario`, `LoginRequest`, `TrocarSenhaRequest` |

### 3.2. Back-end (`carregaja-api`)

| Pacote | Responsabilidade | No UC05 |
|---|---|---|
| `control` | Rotas REST: recebem a requisição validada, chamam o serviço e escolhem o status HTTP | `VeiculoController` |
| `service` | Regras de negócio do caso de uso | `VeiculoService` |
| `repository` | Acesso ao banco, por interfaces do Spring Data | `VeiculoRepository` |
| `model` | Entidades JPA | `Veiculo` |
| `view` | Dados de entrada da API, com as regras de validação | `VeiculoRequest` |

**Dependências permitidas.** Cada camada só conhece a de baixo: a página conhece o bean, o bean
conhece o cliente REST, o cliente REST conhece a API apenas pelo endereço e pelo JSON. Na API, o
controle conhece o serviço, o serviço conhece o repositório, e todos conhecem o modelo e a view.
Nenhuma camada chama a de cima.

Um caso de uso novo acrescenta classes às camadas que já existem, sem criar pacote novo. Só a
página ganha uma pasta com o nome do caso de uso.

Diagramas de classes: **Classes do Back-end — UC05**, o caso de uso que testou a arquitetura, e **Classes do Front-end — UC01**,
a única tela que existe, com todos os atributos e as operações públicas de cada classe, nos nomes e tipos do código. As entidades
de negócio do UC05 estão em **Classes de Negócio — UC05**, e todas as do sistema no **Modelo de Objetos**, pacote `2.Design`.
Por decisão de 02/11/2026, os demais casos de uso seguem o mesmo desenho e não têm diagrama próprio; as classes deles estão em
`3.Arquitetura::carregaja-api`.

## 4. Recursos Reutilizados e Padrões

| Recurso ou padrão | Onde | O que evita escrever |
|---|---|---|
| Spring Data (`CrudRepository`) | `VeiculoRepository` | Todo o SQL de gravação e consulta |
| Bean Validation (`@NotBlank`, `@Positive`, `@Valid`) | `VeiculoRequest` da API | Os `if` de validação e a resposta 400 |
| Lombok (`@Getter`, `@Setter`, `@Slf4j`) | Entidades, requisições e controle | Acessores e declaração de log |
| Jackson | API e `ApiClient` | Conversão entre objeto e JSON |
| PrimeFaces | Páginas | Campos numéricos, mensagens e botões com AJAX |
| MVC, *Service Layer*, *Repository* e objeto de requisição (DTO) | Toda a organização em pacotes | Mistura de regra, tela e banco na mesma classe |
| Injeção de dependência pelo construtor | Classes da API | Acoplamento a implementações concretas |

## 5. Cenário Significativo: UC05 — Manter Veículo

> **A tela deste cenário saiu em 02/11/2026** (seção 2.2) e está guardada na branch `telas-sprint-5`. O caminho a
> partir de `POST /veiculos` segue igual, agora chamado direto.

**Abrir a tela.** O morador abre *Meu veículo*. O `ManterVeiculoBean` pede a lista ao
`VeiculoRestClient`, que faz `GET /veiculos`. Se já há veículo, os campos vêm preenchidos; se não,
vazios.

**Salvar.** O morador informa modelo, capacidade da bateria (kWh) e potência máxima (kW) e clica
em *Salvar*:

1. A página valida: os três campos são obrigatórios, e capacidade e potência devem ser maiores que
   zero. Se não forem, a mensagem aparece e nada é enviado.
2. O bean chama `criar` (veículo sem id) ou `atualizar` (com id) no `VeiculoRestClient`, que envia
   `POST /veiculos` ou `PUT /veiculos/{id}` com o `VeiculoRequest` em JSON.
3. Na API, o `@Valid` confere o `VeiculoRequest` de novo. Inválido, a resposta é **400** sem chegar
   ao serviço.
4. O `VeiculoController` chama o `VeiculoService`, que copia os dados para a entidade e a grava pelo
   `VeiculoRepository`. A resposta é **201** com o endereço do novo veículo, ou **200** na
   alteração, ou **404** se o id não existe.
5. O bean mostra *Veículo cadastrado com sucesso* ou *Veículo alterado com sucesso*. Se a API
   estiver fora do ar ou responder erro, mostra a mensagem do `VeiculoRestClient`.

**Veículo do morador.** Desde o UC01, `GET /veiculos/meu` devolve o veículo de quem chama, e a API liga o
veículo ao usuário do token (HU-05, teste 01): o corpo da requisição não diz de quem é o veículo.

### 5.1. Autenticação (UC01)

**Entrar.** A página `AutenticarUsuarioView` chama o `AutenticarUsuarioBean`, que pede ao
`AutenticacaoRestClient` um `POST /autenticacao`. O `AutenticacaoService` confere a senha pelo hash
BCrypt e o `TokenService` assina o token. E-mail desconhecido e senha errada têm a mesma resposta
(HU-01, teste 02). O bean guarda o token e o usuário no `UsuarioLogado`, de escopo de sessão.

**Cada chamada.** O `ApiClient` põe o token no cabeçalho `Authorization`. Na API, o `TokenFiltro`
valida a assinatura e lê o usuário do banco; o `SegurancaConfig` decide pela rota e pelo perfil.
Sem token válido a resposta é 401; com perfil errado, 403.

**Senha provisória (RN-11).** Enquanto `trocarSenha` for verdadeiro, o `TokenFiltro` não concede nenhum
perfil, e só a rota de troca responde. Nas telas, o `AutenticacaoFilter` leva quem não entrou ao
login e quem tem senha provisória à `TrocarSenhaView`, mas é só orientação: quem garante é a API.

**Primeiro síndico.** Quem cadastra moradores é o síndico, então o primeiro nasce da configuração: o
`PrimeiroSindicoService` o cria ao subir a API, se ainda não houver nenhum.

**Recusas.** Toda regra recusada lança `RegraNegocioException`, e o `TratadorDeErros` a devolve como
`{"mensagem": "..."}`, que o `ApiClient` mostra na tela.

## 6. Visão de Implantação

Diagrama: **Modelo de Implantação**, pacote `3.Arquitetura::implantação`.

| Nó | O que roda | Porta |
|---|---|---|
| Celular do morador e computador do síndico | Navegador | — |
| Servidor do condomínio → Tomcat 9 | `carregaja.war` (telas) | 8080 |
| Servidor do condomínio → Spring Boot 2.7, com Tomcat embutido | `carregaja-api.war` (API) | 8081 |
| Servidor do condomínio → MySQL 8.4 | banco `carregaja` | 3306 |

Os três rodam sobre o JRE 21, no mesmo servidor (RE-07). A API lê de variáveis de ambiente a senha do
banco, o segredo do token e os dados do primeiro síndico; nenhum deles fica no código. O navegador só fala com o Tomcat 9; a
API e o banco não precisam ficar expostos à rede do condomínio. O passo a passo de instalação vai
para o Guia de Implantação, na Transição.

## 7. Teste da Arquitetura

O UC05 foi implementado nos dois projetos e testado em 25/10/2026, quando a tela dele ainda existia.

**Testes de unidade** (`mvn test` em `carregaja-api`), 14 testes, todos aprovados, sem banco:

| Classe | Testes | O que verificam |
|---|---|---|
| `VeiculoControllerTest` | 11 | As rotas com o serviço simulado: cadastro válido (201 com `Location`), modelo em branco ou nulo, capacidade zero ou ausente, potência negativa ou zero (400), veículo inexistente (404), listagem e alteração (200) |
| `VeiculoServiceTest` | 3 | Cópia dos dados para a entidade, alteração do existente e alteração de inexistente sem gravar |

**Teste de ponta a ponta**, com MySQL 8.4 em contêiner, a API pelo `spring-boot:run` e as telas no
Tomcat 9:

| Teste de aceitação (HU-05) | Pela API | Pela tela |
|---|---|---|
| 01 — Cadastro válido (Nissan Leaf, 40 kWh, 6,6 kW) | 201, gravado no banco | *Veículo cadastrado com sucesso*, gravado no banco |
| 02 — Capacidade não positiva (0 kWh) | 400 | *A capacidade da bateria deve ser maior que zero*, nada gravado |
| 03 — Potência não positiva (−2 kW) | 400 | *A potência máxima deve ser maior que zero*, nada gravado |
| Alteração (60 kWh) | 200, alterado no banco | *Veículo alterado com sucesso* |

Os testes 04 (reuso na sessão) e 05 (troca não altera o passado) dependem do UC03 e entram com ele
no sprint 5.

**Defeito encontrado no teste.** Com `minValue="0.1"` no campo numérico, o PrimeFaces trocava em
silêncio o 0 digitado por 0,1 e gravava. A HU-05 pede recusa, não correção: o limite passou para um
validador com mensagem.

## 8. Refinamento da Arquitetura

| Data | Mudança | Motivo |
|---|---|---|
| 28/09/2026 | Primeira versão executável: um projeto Spring Boot com as telas JSF embutidas (JoinFaces), em `controller → service → dao → model` | Implementação do UC05 no sprint 3 |
| 11/10/2026 | Pacote `cadastro` renomeado para `manterveiculo`; diagramas separados em front-end e back-end; classes com os nomes e tipos do código | Apontamentos do professor na apresentação do sprint 3 |
| 25/10/2026 | Projeto dividido em `carregaja-api` e `carregaja-jsf`, no modelo dos exercícios de LP2: camadas `control`, `service`, `repository`, `model` e `view` na API e cliente REST na tela; Modelo de Implantação | A separação de front-end e back-end, antes só nos diagramas, passou a existir no código. A organização segue a da disciplina integrada (RE-02) |
| 02/11/2026 | Autenticação na API; `ApiClient` e `BeanBase` concentram o que todo cliente REST e todo bean repetiriam; `TratadorDeErros` leva à tela o motivo das recusas | O UC01 e as regras que só a API conhece, como e-mail repetido e vaga ocupada |
| 26/10/2026 | Pacotes por camada, direto em cada projeto (`br.edu.ifsp.carregaja.control` em vez de `br.edu.ifsp.carregaja.manterveiculo.control`); no Astah, `3.Arquitetura` reduzido a `carregaja-jsf`, `carregaja-api`, `manterveiculo` (diagramas do UC05) e `implantação` | Por caso de uso, cada um dos 12 casos de uso repetiria as cinco camadas. O nome do caso de uso ficou na pasta da página e no pacote dos diagramas |

## 9. Pendências da Arquitetura

| Pendência | Quando |
|---|---|
| Telas dos casos de uso além do login, hoje na branch `telas-sprint-5` | A decidir |
| Regra da potência efetiva, previsão e apuração (RI-08), isoladas num serviço da API com testes de unidade | Sprint 5 |
