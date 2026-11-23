# Guia de Implementação

**Versão 1.6**

**CARREGAJA - Sistema de Controle e Rateio de Recarga de Veículos Elétricos em Condomínio**

## Histórico de Revisões

| Data | Versão | Descrição | Autor |
|---|---|---|---|
| 25/10/2026 | 1.0 | Criação do guia a partir do UC05 (Manter Veículo), implementado para testar a arquitetura. | Henrique de Almeida Marangoni Inacio |
| 26/10/2026 | 1.1 | Pacotes por camada, e não por caso de uso (seção 3). | Henrique de Almeida Marangoni Inacio |
| 30/10/2026 | 1.2 | Indentação como o código está hoje (seção 4) e resultado dos testes (seção 6). | Henrique de Almeida Marangoni Inacio |
| 03/11/2026 | 1.3 | Autenticação nos testes e nas telas, `ApiClient`, `BeanBase`, recusas por `RegraNegocioException` e indentação unificada em 2 espaços. | Henrique de Almeida Marangoni Inacio |
| 03/11/2026 | 1.4 | Bean e cliente REST no formato do modelo de LP2, sem `BeanBase` e sem `ApiClient` (seção 5.2), e rotas sem registro de log (seção 5.1). | Henrique de Almeida Marangoni Inacio |
| 17/11/2026 | 1.5 | Telas em HTML, CSS e JavaScript simples dentro da API, no lugar do JSF (seções 2, 3, 4, 5.2, 6 e 7). Pacotes por caso de uso dentro de cada camada (seção 3). Segurança por rota e resultado dos testes (277). | Henrique de Almeida Marangoni Inacio |
| 23/11/2026 | 1.6 | Referências aos demais documentos atualizadas (Documento de Arquitetura v1.5, História de Usuário v4.5). Sem mudança nas orientações. | Henrique de Almeida Marangoni Inacio |

## 1. Introdução

### 1.1. Propósito

Este guia diz como implementar um caso de uso do CARREGAJA de modo que o código siga o Modelo de
Arquitetura: onde cada classe fica, como se chama, o que cada camada pode fazer, como testar e
como entregar. O exemplo de referência é o **UC05 — Manter Veículo**. Na dúvida, copie o que ele faz.

O SpinOff prevê o Guia de Implementação em `3.Implementacao/`, mas não oferece template. O guia
segue o leiaute do template do Visão.

### 1.2. Referências

| Documento | Origem |
|---|---|
| CARREGAJA - Documento de Arquitetura (v1.5) | 2.Analise e Design/ |
| CARREGAJA - Modelos de Análise e Design | 2.Analise e Design/ |
| CARREGAJA - História de Usuário (v4.5) | 1.Requisitos/Casos de Uso/ |
| README do código fonte (como rodar) | 3.Implementacao/CarregaJA_Implementacao/ |
| Exercícios de API de Linguagem de Programação 2 | Disciplina integrada (RE-02) |

## 2. Ambiente

| Ferramenta | Versão |
|---|---|
| Java (JDK) | 21 |
| Maven | 3.9, ou o `mvnw` do projeto |
| MySQL | 8 (8.4 testado), local ou em contêiner |
| Navegador | Chrome ou outro atual, para as telas |
| IDE | Livre: Eclipse, IntelliJ ou VS Code com o pacote Java |

Não há servidor de aplicação: a API leva o Tomcat embutido e serve as telas.

A senha do `root` do MySQL (`MYSQL_SENHA`), o segredo do token (`CARREGAJA_JWT_SEGREDO`) e os dados do
primeiro síndico (`CARREGAJA_SINDICO_EMAIL`, `CARREGAJA_SINDICO_SENHA`, `CARREGAJA_SINDICO_APARTAMENTO`) vão em variáveis de ambiente,
nunca no `application.properties`. No Windows, a pasta `scripts/` sobe tudo (`iniciar-tudo.bat`) com os valores de
`scripts/config.bat`, que o git ignora. O passo a passo está no README do código.

## 3. Estrutura do Código

O repositório `CarregaJA_Implementacao` tem um projeto Maven, o `carregaja-api`, na porta 8081, que
serve a API REST e as telas:

```
carregaja-api/src/main/java/br/edu/ifsp/carregaja/     back-end (API REST, Spring Boot 2.7)
carregaja-api/src/main/resources/static/               front-end (telas em HTML, CSS e JavaScript)
```

**Um pacote por camada e, dentro dela, um por caso de uso**, com o nome do caso de uso do Astah em
minúsculas e sem espaço: UC05 *Manter Veículo* é `manterveiculo`; UC07 *Manter Vagas com Carregador*
é `mantervagas`; UC03 *Manter Sessão de Recarga* é `mantersessaorecarga`. Um caso de uso novo ganha
uma pasta em cada camada que usa, e não um pacote novo de camada.

| Pacote (em `br.edu.ifsp.carregaja`) | Conteúdo |
|---|---|
| `control.<caso de uso>` | Rotas REST |
| `service.<caso de uso>` | Regras de negócio |
| `repository.<caso de uso>` | Interfaces do Spring Data |
| `model.<caso de uso>` | Entidades JPA |
| `view.<caso de uso>` | Dados de entrada, com validação, e respostas que não são uma entidade |
| `compartilhado` (dentro de `repository` e `model`) | O que mais de um caso de uso usa: `Usuario`, `Vaga`, `Veiculo`, `SessaoRecarga`, `Apartamento` e os repositórios deles |
| raiz de cada camada | O que é de todos: `TratadorDeErros`, `RegraNegocioException`, `ErroResponse` |

O UC04 (*Apurar Energia da Sessão*) não tem rota: é o `service.apurarenergia.ApuracaoEnergiaService`.
O UC10 usa o `SessaoRecargaController` e o `SessaoRecargaService`, do `mantersessaorecarga`.

As telas seguem a mesma divisão, em `static`:

| Pasta ou arquivo | Conteúdo |
|---|---|
| `<caso de uso>/<tela>.html` e `<tela>.js` | A página e o script dela, lado a lado (ex.: `manterveiculo/veiculo.html` e `veiculo.js`). Só o login e a troca de senha ficam em `autenticarusuario/` |
| `js/comum.js` | O que todas as telas usam |
| `css/estilo.css` | O estilo de todas as telas |
| `index.html` | Decide para onde ir: o painel, se há login, ou o login |

No Astah, as classes ficam em `3.Arquitetura::carregaja-api`, nas mesmas camadas. Cada caso de uso tem os
diagramas de classes do front-end e do back-end em `3.Arquitetura::<caso de uso>` (o UC05, em
`manterveiculo`, também tem os de pacotes), sem os acessores do Lombok.

## 4. Nomes

| Elemento | Padrão | Exemplo no UC05 |
|---|---|---|
| Rota REST | `<Entidade>Controller` | `VeiculoController` |
| Serviço da API | `<Entidade>Service` | `VeiculoService` |
| Repositório | `<Entidade>Repository` | `VeiculoRepository` |
| Entidade | `<Entidade>` | `Veiculo` |
| Dados de entrada | `<Entidade>Request` | `VeiculoRequest` |
| Resposta que não é uma entidade | `<Entidade>Response` | `AutenticacaoResponse` |
| Página | `<caso de uso>/<tela>.html` | `manterveiculo/veiculo.html` |
| Script da página | `<caso de uso>/<tela>.js` | `manterveiculo/veiculo.js` |
| Caminho da rota | substantivo no plural, minúsculo | `/veiculos` |

Classes, métodos, atributos e mensagens em **português**, como no modelo: `criar`, `listarTodos`,
`buscarPorId`, `atualizar`, `capacidadeBateria`. As convenções de nomes da linguagem (Oracle Java
Code Conventions) valem para o resto: classes em `PascalCase`, métodos e atributos em `camelCase`,
constantes em `MAIUSCULAS_COM_SUBLINHADO`.

**Indentação.** Dois espaços em Java, XML, HTML, CSS e JavaScript, com `catch` e `else` na linha do
fecha-chaves. O `.editorconfig` na raiz do repositório avisa a IDE para Java e XML; não há verificador
automático.

## 5. O Que Cada Camada Faz

### 5.1. Back-end

**`control` — rotas.** Recebe a requisição com `@Valid @RequestBody`, chama o serviço e decide o
status: `201` com `Location` ao criar, `200` ao consultar e alterar, `204` ao remover, `404`
quando o id não existe. **Não tem regra de negócio.** O usuário logado chega por
`@AuthenticationPrincipal Usuario`. **Rota nova precisa de regra em
`SegurancaConfig`**, dizendo qual perfil a usa, e de uma linha no `PermissoesPorPerfilTest`. A regra usa
`mvcMatchers`, e não `antMatchers`, para a barra no fim do endereço não cair numa regra mais frouxa.

**`service` — regras.** Toda regra de negócio fica aqui: cálculos, verificações entre entidades,
situações da sessão. Devolve `Optional` quando o registro pode não existir, em vez de `null`. Para recusar, lança
`RegraNegocioException` com o status e a mensagem que o usuário vai ler; o `TratadorDeErros` a responde.
**A regra da potência efetiva (RN-01) e a apuração (RN-02, RN-03) ficam num serviço próprio, o
`ApuracaoEnergiaService`, com testes de unidade** (RI-08). Regra que depende de duas requisições ao mesmo
tempo (vaga ocupada, encerramento duplicado) precisa de trava e de teste com o banco: ver a seção 6.

**`repository` — banco.** Só interfaces que estendem `CrudRepository<Entidade, Long>`. Consulta
nova é método derivado do nome (`findByAtivoTrue`), sem SQL escrito à mão enquanto der.

**`model` — entidades.** `@Entity` com `@Getter` e `@Setter`, id `Long` com
`GenerationType.IDENTITY`. Os tipos seguem o Modelo de Objetos (`2.Design`).

**`view` — entrada.** Uma classe `<Entidade>Request` por formulário, com as anotações do Bean
Validation (`@NotBlank`, `@NotNull`, `@Positive`, `@Size`) e a mensagem de cada uma. O id não vem
no corpo: vem na rota.

**Injeção pelo construtor**, com o campo `private final`, como nos exercícios de LP2. Não usar
`@Autowired` em campo.

### 5.2. Front-end

**Página.** Um arquivo HTML com `viewport` para o celular, o `css/estilo.css` e o `js/comum.js`, e o
script da própria tela no fim. Campos com `required` e, nos numéricos, `min`; a API valida de novo.
O conteúdo vai dentro de `<main>`, e a cor dos botões e das situações vem das classes `secundario`,
`perigo` e `selo`.

**Script da tela.** Não usa framework nem `import`. Busca os dados com `api('GET', '/veiculos/meu')`, que já
põe o token no cabeçalho `Authorization` e transforma toda resposta fora de 2xx em erro com a mensagem que a
API mandou, e mostra o resultado com `aviso(...)`. Não tem regra de negócio: quem decide é a API. Texto vindo
da API passa por `esc(...)` antes de entrar no HTML.

**Tela nova** entra no menu, em `js/comum.js`. Se for de um perfil só, o menu a esconde, mas quem garante o
perfil é a API.

### 5.3. Regras para os dois lados

- A tela valida o que o morador pode corrigir; a API valida tudo de novo. As duas usam os mesmos
  limites da História de Usuário.
- Comentário só onde o código não se explica sozinho: uma regra de negócio, uma restrição da
  ferramenta. Não comentar o óbvio.
- Nada de senha, endereço de produção ou dado pessoal no código.

## 6. Testes

**Quem implementa testa** (SpinOff, *Desenvolver Solução*). Todo caso de uso entrega:

| Teste | Como | Exemplo |
|---|---|---|
| Controle | `@WebMvcTest(<Entidade>Controller.class)`, estendendo `ControleTesteBase`, com o serviço em `@MockBean`. Passa pelas regras de segurança de verdade: a requisição se identifica com `.with(logado(morador()))`. Uma verificação por status, por regra de validação e por perfil | `VeiculoControllerTest` |
| Serviço | JUnit com o repositório simulado (`Mockito.mock`). Uma verificação por regra de negócio | `VeiculoServiceTest` |

Os testes de aceitação da História de Usuário viram testes com o mesmo número no comentário
(`// HU-05, teste 02`). Os testes de unidade não usam banco: rodam com `mvn test` em `carregaja-api` sem o
MySQL ligado. O `PermissoesPorPerfilTest` confere, rota a rota, o que morador e síndico podem usar.

**Regra com concorrência precisa de teste com o banco.** Dois moradores abriram sessão na mesma vaga com
todos os testes de unidade passando, porque a leitura dos perfis abria a foto do `REPEATABLE_READ` antes da trava
da vaga. A correção foi `READ_COMMITTED` em `SessaoRecargaService.iniciar`. Por isso, o que a coleção e os
testes de unidade não mostram se confere com o MySQL e a API no ar.

**Resultado em 17/11/2026** (`mvn test` em `carregaja-api`, com os 12 casos de uso): **277 testes, 0 falhas,
0 erros.**

**De ponta a ponta, com MySQL, API e telas:** a coleção do Postman (`carregaja-api/CarregaJA.postman_collection.json`,
rodada depois de `scripts\zerar-banco.bat`) executou 108 requisições e 223 verificações, sem falha. Nas telas, em Chrome,
54 fluxos clicados nos 12 casos de uso, sem falha (conferência de 16/11/2026).

## 7. Como Entregar

1. Criar a issue no repositório `CarregaJA_Implementacao` com o template de feature.
2. Criar o branch a partir da issue, saindo do `develop`: `<número>-feature-<descrição>`.
3. Implementar seguindo este guia, com commits pequenos e mensagem no imperativo, em português,
   dizendo o que muda (ex.: *Recusa veículo com o modelo em branco*).
4. Rodar `mvn test` em `carregaja-api`, sem erro, e passar pela tela no navegador.
5. Abrir o Pull Request para o `develop` com o template do repositório, pedindo revisão de outro
   integrante. Quem não tem permissão de escrita entrega pelo próprio *fork*.
6. Se o caso de uso mudou um diagrama, atualizar o `.asta` no repositório `CarregaJA`, numa PR
   ligada à mesma issue.

**Antes de pedir revisão:**

- [ ] Classes nas camadas da seção 3, com a pasta do caso de uso, e nomes da seção 4
- [ ] Nenhuma regra de negócio no controle nem no script da tela
- [ ] Validação na tela e na API
- [ ] Rota nova em `SegurancaConfig` e no `PermissoesPorPerfilTest`
- [ ] Testes do controle e do serviço, passando
- [ ] README atualizado se mudou o jeito de rodar
- [ ] Diagramas de classes do caso de uso atualizados, se as classes dele mudaram
