# Guia de Implementação

**Versão 1.0**

**CARREGAJA - Sistema de Controle e Rateio de Recarga de Veículos Elétricos em Condomínio**

## Histórico de Revisões

| Data | Versão | Descrição | Autor |
|---|---|---|---|
| 25/10/2026 | 1.0 | Criação do guia a partir do UC05 (Manter Veículo), implementado para testar a arquitetura. | Henrique de Almeida Marangoni Inacio |

## 1. Introdução

### 1.1. Propósito

Este guia diz como implementar um caso de uso do CARREGAJA de modo que o código siga o Modelo de
Arquitetura: onde cada classe fica, como se chama, o que cada camada pode fazer, como testar e
como entregar. O exemplo de referência é o **UC05 — Manter Veículo**, já implementado. Na dúvida,
copie o que ele faz.

O SpinOff prevê o Guia de Implementação em `3.Implementacao/`, mas não oferece template. O guia
segue o leiaute do template do Visão.

### 1.2. Referências

| Documento | Origem |
|---|---|
| CARREGAJA - Documento de Arquitetura (v1.0) | 2.Analise e Design/ |
| CARREGAJA - Modelos de Análise e Design | 2.Analise e Design/ |
| CARREGAJA - História de Usuário (v4.1) | 1.Requisitos/Casos de Uso/ |
| README do código fonte (como rodar) | 3.Implementacao/CarregaJA_Implementacao/ |
| Exercícios de API e JSF de Linguagem de Programação 2 | Disciplina integrada (RE-02) |

## 2. Ambiente

| Ferramenta | Versão |
|---|---|
| Java (JDK) | 21 |
| Maven | 3.9, ou o `mvnw` de cada projeto |
| MySQL | 8 (8.4 testado), local ou em contêiner |
| Tomcat | 9 (o front-end usa a linha `javax.*`) |
| IDE | Livre: Eclipse, IntelliJ ou VS Code com o pacote Java |

A senha do usuário `root` do MySQL vai na variável de ambiente `MYSQL_SENHA`, nunca no
`application.properties`. O passo a passo para subir a API e as telas está no README do código.

## 3. Estrutura do Código

O repositório `CarregaJA_Implementacao` tem dois projetos Maven:

```
carregaja-api/   back-end: API REST (Spring Boot 2.7), porta 8081
carregaja-jsf/   front-end: telas JSF + PrimeFaces, no Tomcat 9, porta 8080
```

**Um pacote por caso de uso**, com as camadas dentro, nos dois projetos. O nome do pacote é o do
caso de uso, em minúsculas e sem espaço: UC05 *Manter Veículo* é `manterveiculo`; UC07 *Manter
Vagas com Carregador* será `mantervagas`; UC03 *Manter Sessão de Recarga* será `mantersessao`.

| Projeto | Pacote | Conteúdo |
|---|---|---|
| `carregaja-api` | `br.edu.ifsp.carregaja.<caso>.control` | Rotas REST |
| | `br.edu.ifsp.carregaja.<caso>.service` | Regras de negócio |
| | `br.edu.ifsp.carregaja.<caso>.repository` | Interfaces do Spring Data |
| | `br.edu.ifsp.carregaja.<caso>.model` | Entidades JPA |
| | `br.edu.ifsp.carregaja.<caso>.view` | Dados de entrada, com validação |
| `carregaja-jsf` | `br.edu.ifsp.carregaja.<caso>.controller` | Beans JSF |
| | `br.edu.ifsp.carregaja.<caso>.service` | Cliente REST da API |
| | `br.edu.ifsp.carregaja.<caso>.model` | Dados da tela e corpos das requisições |
| | `webapp/restricted/<caso>/` | Páginas XHTML |

Entidade usada por mais de um caso de uso (o `Veiculo` será lido pelo UC03) continua no pacote do
caso de uso que a mantém. Os outros a importam.

## 4. Nomes

| Elemento | Padrão | Exemplo no UC05 |
|---|---|---|
| Rota REST | `<Entidade>Controller` | `VeiculoController` |
| Serviço da API | `<Entidade>Service` | `VeiculoService` |
| Repositório | `<Entidade>Repository` | `VeiculoRepository` |
| Entidade | `<Entidade>` | `Veiculo` |
| Dados de entrada | `<Entidade>Request` | `VeiculoRequest` |
| Bean JSF | `Manter<Entidade>Bean` (ou o verbo do caso de uso) | `ManterVeiculoBean` |
| Página | `Manter<Entidade>View.xhtml` | `ManterVeiculoView.xhtml` |
| Cliente REST | `<Entidade>RestClient` | `VeiculoRestClient` |
| Caminho da rota | substantivo no plural, minúsculo | `/veiculos` |

Classes, métodos, atributos e mensagens em **português**, como no modelo: `criar`, `listarTodos`,
`buscarPorId`, `atualizar`, `capacidadeBateria`. As convenções de código da linguagem (Oracle Java
Code Conventions) valem para o resto: classes em `PascalCase`, métodos e atributos em `camelCase`,
constantes em `MAIUSCULAS_COM_SUBLINHADO`.

## 5. O Que Cada Camada Faz

### 5.1. Back-end

**`control` — rotas.** Recebe a requisição com `@Valid @RequestBody`, chama o serviço e decide o
status: `201` com `Location` ao criar, `200` ao consultar e alterar, `204` ao remover, `404`
quando o id não existe. **Não tem regra de negócio.** Registra cada chamada com o `log` do
`@Slf4j`.

**`service` — regras.** Toda regra de negócio fica aqui: cálculos, verificações entre entidades,
situações da sessão. Devolve `Optional` quando o registro pode não existir, em vez de `null`.
**A regra da potência efetiva (RN-01) e a apuração (RN-02, RN-03) ficam num serviço próprio, com
testes de unidade** (RI-08).

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

**Página.** Usa o leiaute `/WEB-INF/template/LayoutPadrao.xhtml` e define o bloco `corpo`. Campos
com `required="true"` e `requiredMessage`; limites numéricos com `<f:validateDoubleRange>` e
`validatorMessage`. **Não usar `minValue` do `p:inputNumber` como validação**: ele corrige o valor
em silêncio em vez de recusar (defeito encontrado no teste do UC05).

**Bean.** `@Named @ViewScoped`, `Serializable`. Carrega os dados no `inicializar()`, chamado por
`<f:event type="preRenderView">`, e não em postback. Trata a `ApiException` do cliente REST
mostrando a mensagem com `FacesMessage`. Não chama a API diretamente: passa pelo cliente REST.

**Cliente REST.** `@ApplicationScoped`, com o `HttpClient` do Java e o `ObjectMapper` do Jackson,
como o `VeiculoRestClient`. O endereço da API vem da propriedade `carregaja.api.url`, com
`http://localhost:8081` como padrão. Toda resposta fora de 2xx vira `ApiException` com uma mensagem
que o morador entenda.

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
| Controle | `@WebMvcTest(<Entidade>Controller.class)` com o serviço em `@MockBean`. Uma verificação por status e por regra de validação | `VeiculoControllerTest` |
| Serviço | JUnit com o repositório simulado (`Mockito.mock`). Uma verificação por regra de negócio | `VeiculoServiceTest` |

Os testes de aceitação da História de Usuário viram testes com o mesmo número no comentário
(`// HU-05, teste 02`). Os testes não usam banco: rodam com `mvn test` em `carregaja-api` sem o
MySQL ligado. O teste de ponta a ponta, com banco, API e telas, segue o README e, na Transição, o
Roteiro de Teste.

## 7. Como Entregar

1. Criar a issue no repositório `CarregaJA_Implementacao` com o template de feature.
2. Criar o branch a partir da issue, saindo do `develop`: `<número>-feature-<descrição>`.
3. Implementar seguindo este guia, com commits pequenos e mensagem no imperativo, em português,
   dizendo o que muda (ex.: *Recusa veículo com o modelo em branco*).
4. Rodar `mvn test` em `carregaja-api` e `mvn package` em `carregaja-jsf`: os dois sem erro.
5. Abrir o Pull Request para o `develop` com o template do repositório, pedindo revisão de outro
   integrante. Quem não tem permissão de escrita entrega pelo próprio *fork*.
6. Se o caso de uso mudou um diagrama, atualizar o `.asta` no repositório `CarregaJA`, numa PR
   ligada à mesma issue.

**Antes de pedir revisão:**

- [ ] Pacote com o nome do caso de uso e classes com os nomes da seção 4
- [ ] Nenhuma regra de negócio no controle nem no bean
- [ ] Validação na tela e na API
- [ ] Testes do controle e do serviço, passando
- [ ] README atualizado se mudou o jeito de rodar
- [ ] Diagramas de classes atualizados se surgiu classe, atributo ou operação pública
