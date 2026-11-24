# Guia de Implantação

**Versão 1.1**

**CARREGAJA - Sistema de Controle e Rateio de Recarga de Veículos Elétricos em Condomínio**

## Histórico de Revisões

| Data | Versão | Descrição | Autor |
|---|---|---|---|
| 23/11/2026 | 1.0 | Criação do guia para a implantação da v-4.0.0 na nuvem: API e telas no Render, banco PostgreSQL no Supabase. Roteiro conferido numa simulação local, com a imagem do sistema e um PostgreSQL 16. | Henrique de Almeida Marangoni Inacio |
| 24/11/2026 | 1.1 | Implantação feita: endereço do sistema, servidor do *Session pooler*, Data API desligada e plano Free escolhido no formulário (seções 4.2, 4.3 e 4.10); situação do cronograma (seção 2.2). | Henrique de Almeida Marangoni Inacio |

## 1. Introdução

Este guia diz como o CARREGAJA chega ao condomínio: o que é instalado, onde, por quem, em que ordem e
como os usuários são preparados para usá-lo. Ele cobre a primeira implantação, a da versão v-4.0.0,
e as atualizações seguintes.

O sistema é **um serviço web só**: a API e as telas vão no mesmo pacote, e o morador e o síndico usam
o navegador do celular ou do computador. Na nuvem, esse serviço roda no **Render**, e o banco de dados
é um **PostgreSQL no Supabase**. Os dois serviços foram escolhidos em 23/11/2026 por terem plano
gratuito suficiente para um condomínio e por não exigirem servidor no prédio.

O Modelo de Implantação do Documento de Arquitetura mostra a outra forma prevista, um servidor no
próprio condomínio com MySQL. Na nuvem, o nó do servidor vira o serviço web do Render, e o MySQL vira
o PostgreSQL do Supabase. O pacote é o mesmo: o driver dos dois bancos está nele, e o banco usado sai
do endereço configurado.

**Não há sistema antigo a substituir nem dados a migrar ou converter.** Hoje o condomínio não tem
controle das recargas. O sistema começa vazio, com o primeiro síndico, e o síndico faz o cadastro
inicial (seção 4.6).

### 1.1. Definições

| Termo | Significado |
|---|---|
| Render | Serviço de hospedagem que constrói a imagem do sistema a partir do código no GitHub e a mantém no ar |
| Supabase | Serviço que fornece o banco PostgreSQL gerenciado |
| Imagem | O pacote do sistema pronto para rodar, gerado pelo `Dockerfile` do código: o Java 21 e o `carregaja-api.war` |
| Session pooler | Endereço do Supabase que aceita conexões IPv4, como as do Render. A conexão direta do Supabase só aceita IPv6 |
| Variável de ambiente | Configuração informada ao Render, fora do código: endereço e senha do banco, segredo do token e dados do primeiro síndico |
| Homologação | Aceite do sistema pelo PO, representante do cliente, no ambiente da nuvem, antes da entrega ao síndico |

### 1.2. Referências

| Documento | Origem |
|---|---|
| CARREGAJA - Documento de Arquitetura (v1.6), seção 6 e Modelo de Implantação | 2.Analise e Design/ |
| CARREGAJA - Guia de Implementação (v1.6) | 3.Implementacao/ |
| CARREGAJA - Roteiro de Teste e Massa de Teste | 4.Teste/ |
| CARREGAJA - Manual do Usuário | 5.Implantação/ |
| README e `Dockerfile` do código fonte | 3.Implementacao/CarregaJA_Implementacao/ |
| Supabase: conectar ao banco e usar com Spring Boot | <https://supabase.com/docs/guides/database/connecting-to-postgres> |
| Render: primeiro deploy e planos | <https://render.com/docs/your-first-deploy> |

## 2. Planejamento de Implantação

A implantação segue estas atividades, nesta ordem:

| # | Atividade | O que sai dela |
|---|---|---|
| 1 | **Testes de sistema** no ambiente de teste, com o Roteiro e a Massa de Teste | Roteiro com os ciclos registrados e os defeitos corrigidos |
| 2 | **Preparação da versão**: PRs mescladas, `develop` levado ao `main` e tag `v-4.0.0` no código | A versão que será implantada, identificada |
| 3 | **Empacotamento**: o Render constrói a imagem a partir do `Dockerfile`, do `main` do código | Imagem do sistema |
| 4 | **Instalação**: banco no Supabase, serviço no Render e variáveis de ambiente (seção 4) | Sistema no ar, com o primeiro síndico |
| 5 | **Conferência** logo após a instalação (seção 4.5) | Percurso de fumaça sem falha |
| 6 | **Homologação** pelo PO no ambiente da nuvem | Aceite do PO, ou discrepâncias registradas como issues |
| 7 | **Limpeza** dos dados da homologação (seção 4.7) | Banco vazio, só com o primeiro síndico |
| 8 | **Entrega** ao síndico, com o Manual do Usuário, e **carga inicial** feita por ele | Vagas, tarifa e moradores cadastrados |
| 9 | **Suporte** durante o uso (seção 5) | Dúvidas respondidas e defeitos registrados |

### 2.1. Responsabilidades

| Quem | Responsabilidade |
|---|---|
| Equipe de desenvolvimento (Henrique, André, Alex) | Corrigir os defeitos dos testes; mesclar e marcar a versão; criar o banco e o serviço; configurar as variáveis; fazer a conferência; limpar os dados da homologação; corrigir as discrepâncias da homologação e reimplantar; dar o suporte de segundo nível |
| PO, representante do cliente (Matheus) | Homologar: percorrer no ambiente da nuvem os cenários principais do Roteiro de Teste, com o Manual do Usuário em mãos, e dar o aceite. Cada discrepância vira uma issue `[BUGFIX]` no repositório CarregaJA, com o cenário e o que apareceu na tela |
| Síndico do condomínio | Trocar a senha provisória no primeiro acesso; cadastrar as vagas, a tarifa e os moradores; passar a cada morador o e-mail e a senha provisória; dar o suporte de primeiro nível aos moradores |
| André (dono dos repositórios no GitHub) | Mesclar as PRs no repositório do código, que é a origem da imagem |

**Tratamento das discrepâncias da homologação.** O PO registra a issue, a equipe corrige numa branch a
partir dela, com PR para o `develop`, e leva a correção ao `main`. O Render reconstrói a imagem, e o
PO repete só o cenário que tinha falhado. A homologação termina quando o PO der o aceite sem issue
aberta.

### 2.2. Cronograma

Dentro do sprint 7, a Transição (23/11 a 04/12/2026):

| Atividade | Responsável | Prazo | Situação em 24/11 |
|---|---|---|---|
| Testes de sistema, ciclos 1 e 2 (issue #77) | Henrique | 23/11 | Feito: 82 de 82 no ciclo 2 |
| Correção dos defeitos #81, #82 e #84 | Henrique | 23/11 | Feito: PRs #44, #45 e #46 do código |
| Simulação local da implantação (seção 4.9) | Henrique | 23/11 | Feito |
| Guia de Implantação (#78) e Manual do Usuário (#79) | Henrique | 24/11 | Feito |
| Mesclar as PRs, levar o código ao `main` e marcar a v-4.0.0 | André e PO | 26/11 | Feito em 24/11 (PR #47 do código) |
| Banco no Supabase, serviço no Render e conferência (#80) | Henrique | 27/11 | Feito em 24/11: <https://carregaja.onrender.com> (seção 4.10) |
| Homologação pelo PO | Matheus | 28/11 a 01/12 | Dada como feita pela equipe em 24/11 |
| Limpeza dos dados e entrega ao síndico | Henrique | 02/12 | A fazer, na entrega ao síndico do condomínio |
| Tag v-4.0.0 nos artefatos e fechamento do sprint | Henrique e PO | 04/12 | Feito em 24/11 (issue #89) |

## 3. Recursos Necessários para Implantar o Produto

### 3.1. Ambiente

Nenhum espaço físico nem equipamento no condomínio. O sistema fica em dois serviços na internet:

| Serviço | Uso | Região |
|---|---|---|
| Render, *Web Service* com Docker | API e telas | Virginia (US East) |
| Supabase, projeto com PostgreSQL | Banco de dados | East US (North Virginia) |

Os dois ficam **na mesma região** de propósito: cada tela faz várias consultas ao banco, e com o banco
em outro continente cada consulta somaria cerca de um décimo de segundo. O Render não tem região na
América do Sul; com os dois nos Estados Unidos, só a ida e volta do navegador cruza o continente.

O síndico e os moradores precisam de acesso à internet no celular ou no computador.

### 3.2. Hardware

| Recurso | Configuração | Observação |
|---|---|---|
| Instância do Render, plano Free | 512 MB de memória, 0,1 CPU | Dorme depois de 15 minutos sem acesso. Na simulação (seção 4.9), a subida a frio levou cerca de 2,5 minutos, e a primeira chamada de cada tela, alguns segundos. O plano Starter (US$ 7 por mês, 0,5 CPU) não dorme e é o recomendado se o condomínio passar a depender do sistema |
| Banco do Supabase, plano Free | 500 MB de dados | O projeto é pausado depois de 7 dias sem acesso; o síndico o reativa no painel do Supabase. O plano Free não tem backup automático (seção 4.8) |
| Celular ou computador do usuário | Qualquer um com navegador atual | As telas foram feitas primeiro para o celular |

As condições dos planos são as publicadas pelo Render e pelo Supabase em novembro de 2026. Conferir
na página de preços de cada um antes de implantar.

### 3.3. Software

| Software | Versão | Fornecedor e licença |
|---|---|---|
| CARREGAJA (`carregaja-api.war`) | v-4.0.0 | Equipe do projeto |
| Java (imagem `eclipse-temurin:21-jre`) | 21 | Eclipse Adoptium, licença GPLv2 com Classpath Exception, gratuita |
| Spring Boot, com Tomcat embutido | 2.7 | VMware, Apache 2.0, gratuita. Vem dentro do `war` |
| Driver PostgreSQL (JDBC) | 42.7.4 | PostgreSQL Global Development Group, licença BSD, gratuita. Vem dentro do `war` |
| PostgreSQL | O que o Supabase oferecer (15 ou mais novo) | Supabase, plano Free |
| Navegador | Chrome, Edge, Firefox ou Safari atuais | — |

Ninguém instala nada no condomínio: o Render baixa o Java e compila o código ao construir a imagem.

### 3.4. Pessoas

| Papel | Quem | Tempo estimado |
|---|---|---|
| Implantador: cria o banco e o serviço, configura e confere | Henrique | 2 h |
| Homologador: percorre os cenários e dá o aceite | Matheus (PO) | 3 h |
| Síndico: troca a senha e faz a carga inicial | Síndico do condomínio | 1 h, mais 5 minutos por morador |

## 4. Roteiro de Implantação

### 4.1. Preparar a versão

1. Conferir que as PRs do sprint estão mescladas no `develop` do código
   (<https://github.com/AndreMoreira00/CarregaJA_Implementacao>) e que `mvn test` passa.
2. Levar o `develop` ao `main` por PR e criar a tag `v-4.0.0` no `main`.
3. O Render constrói a imagem a partir do `main`. Para implantar outra versão, trocar a branch no
   serviço (seção 4.3).

### 4.2. Criar o banco no Supabase

1. Em <https://supabase.com>, criar a conta e um projeto **carregaja**, na região **East US (North
   Virginia)**, plano Free.
2. Definir a senha do banco e guardá-la num gerenciador de senhas. Ela vai para o Render no passo 4.3.
   Em **Data access**, desmarcar **Enable Data API**: a aplicação não usa essa API, e com ela ligada as tabelas
   criadas pela API do CARREGAJA, inclusive a de usuários, ficariam expostas pela interface pública do Supabase.
3. No painel do projeto, clicar em **Connect** e escolher **Session pooler**. O endereço tem a forma
   `postgresql://postgres.<ref>:[SENHA]@aws-0-us-east-1.pooler.supabase.com:5432/postgres`. Anotar:
   - o **servidor**: `aws-0-us-east-1.pooler.supabase.com` (o do painel, que pode ser diferente);
   - o **usuário**: `postgres.<ref>`, em que `<ref>` é o identificador do projeto.
4. **Usar a porta 5432 (Session pooler).** A conexão direta (`db.<ref>.supabase.co`) só aceita IPv6, e o
   Render só conecta por IPv4. O *Transaction pooler*, na porta 6543, não serve ao Hibernate, que usa
   *prepared statements*.

As tabelas não são criadas à mão: a API as cria na primeira subida (`ddl-auto=update`).

### 4.3. Criar o serviço no Render

1. Em <https://render.com>, criar a conta e escolher **New > Web Service**.
2. Em **Public Git Repository**, informar `https://github.com/AndreMoreira00/CarregaJA_Implementacao`.
   Para o Render reimplantar sozinho a cada merge no `main`, conectar a conta do GitHub do dono do
   repositório no lugar do endereço público.
3. Preencher:

   | Campo | Valor |
   |---|---|
   | Name | `carregaja` (o endereço será `https://carregaja.onrender.com`, ou com um sufixo, se o nome já existir) |
   | Language | Docker (o Render acha o `Dockerfile` na raiz) |
   | Branch | `main` |
   | Region | Virginia (US East) |
   | Instance Type | Free |
   | Health Check Path (em *Advanced*) | `/autenticarusuario/login.html` |

4. Em **Environment Variables**, cadastrar:

   | Variável | Valor |
   |---|---|
   | `SPRING_DATASOURCE_URL` | `jdbc:postgresql://<servidor do passo 4.2>:5432/postgres?sslmode=require` |
   | `SPRING_DATASOURCE_USERNAME` | `postgres.<ref>` |
   | `SPRING_DATASOURCE_PASSWORD` | A senha do banco, do passo 4.2 |
   | `CARREGAJA_JWT_SEGREDO` | Um texto aleatório com pelo menos 32 caracteres, que assina os tokens de acesso. Gerar com `openssl rand -base64 48` no Git Bash. Sem ele a API não sobe |
   | `CARREGAJA_SINDICO_EMAIL` | E-mail do primeiro síndico |
   | `CARREGAJA_SINDICO_SENHA` | Senha provisória dele, que ele troca no primeiro acesso |
   | `CARREGAJA_SINDICO_NOME` | Nome dele |
   | `CARREGAJA_SINDICO_APARTAMENTO` | Apartamento dele, se ele também for morador. Deixar sem a variável se ele for preposto da administradora |
   | `SPRING_JPA_SHOW_SQL` | `false`, para o registro do Render não listar cada consulta |

   A porta não é configurada: o Render informa a variável `PORT`, e a imagem a usa. A senha do banco
   vai em variável própria, e não dentro do endereço, para não precisar codificar caracteres especiais.
   Em **Compute**, conferir que o plano escolhido é o **Free** ($0/month): o formulário pode vir com o plano
   pago Starter selecionado.
5. Clicar em **Deploy Web Service**. O Render constrói a imagem (alguns minutos) e sobe o sistema.

### 4.4. Acompanhar a primeira subida

No **Logs** do serviço, a subida terminou quando aparecer
`Started CarregajaApiApplication`. Nesse momento a API criou as tabelas no Supabase e o primeiro
síndico. Avisos `constraint ... does not exist, skipping` são normais na primeira subida: o Hibernate
tenta apagar restrições que ainda não existem.

Se a subida falhar:

| Mensagem no registro | Causa provável |
|---|---|
| `Could not resolve placeholder 'CARREGAJA_JWT_SEGREDO'` | Variável do segredo ausente |
| `The specified key byte array is ... bits` | Segredo com menos de 32 caracteres |
| `Network is unreachable` ou `UnknownHostException` | Endereço da conexão direta (IPv6) no lugar do *Session pooler* |
| `password authentication failed` | Usuário sem o `.<ref>` ou senha errada |
| `prepared statement "S_1" already exists` | Porta 6543 (*Transaction pooler*) no lugar da 5432 |

### 4.5. Conferir a instalação

Com o endereço do serviço (ex.: `https://carregaja.onrender.com`), conferir, nesta ordem:

1. A página abre na tela de login.
2. O primeiro síndico entra com a senha provisória e é levado à troca de senha. Ele troca a senha.
3. O síndico cadastra uma vaga e a tarifa, e cadastra um morador de teste com veículo.
4. O morador de teste entra, troca a senha, inicia uma recarga na vaga e a encerra. O painel mostra a
   vaga ocupada durante a sessão, e o consumo do mês mostra a sessão.
5. Os horários mostrados estão no horário de Brasília. O serviço roda em UTC, e a API converte pelo
   fuso do condomínio (`carregaja.fuso=America/Sao_Paulo`).

Esses dados de teste saem na limpeza (seção 4.7), depois da homologação.

### 4.6. Carga inicial pelo síndico

Depois da limpeza, o síndico entra e segue o Manual do Usuário:

1. Troca a senha provisória.
2. Cadastra as vagas com carregador, com a potência de cada um (UC07).
3. Cadastra a tarifa do kWh, que vale a partir do cadastro (UC08).
4. Cadastra os moradores, cada um com e-mail, apartamento e senha provisória (UC09), e entrega a cada
   um o e-mail e a senha. No primeiro acesso, o morador troca a senha e cadastra o veículo (UC05).

### 4.7. Limpar os dados da homologação

No Supabase, em **SQL Editor**, executar:

```sql
DROP TABLE IF EXISTS item_rateio, fechamento_mensal, recusa_vaga, sessao_recarga, tarifa, veiculo,
  usuario_perfis, usuario, vaga, apartamento CASCADE;
```

Depois, reiniciar o serviço no Render (**Restart service**): a API recria as tabelas vazias e o primeiro
síndico, com a senha provisória das variáveis. **Nunca executar isto depois da entrega ao síndico**: o
comando apaga todo o histórico do condomínio. A Massa de Teste (`4.Teste/`) é só do ambiente de teste,
em MySQL, e nunca deve ser carregada na nuvem.

### 4.8. Atualizar a versão, voltar atrás e guardar cópia

- **Atualizar.** Mesclar a correção no `main` do código. Com o GitHub conectado, o Render reconstrói
  sozinho; com o endereço público, usar **Manual Deploy > Deploy latest commit**. As tabelas são
  atualizadas na subida, só com acréscimos (`ddl-auto=update`): os dados ficam.
- **Voltar atrás.** Em **Events**, escolher a implantação anterior e **Rollback**. Como as mudanças de
  tabela só acrescentam, a versão anterior continua funcionando com o banco atualizado.
- **Cópia do banco.** O plano Free do Supabase não tem backup automático. Antes de cada atualização e
  no fim de cada mês fechado, gerar uma cópia pelo *Session pooler*:
  `pg_dump "postgresql://postgres.<ref>@<servidor>:5432/postgres" -Fc -f carregaja-aaaa-mm-dd.dump`
  (pede a senha), e guardá-la fora do Supabase. O rateio exportado em CSV pelo fechamento do mês (UC11)
  também serve de registro do que foi repassado à administradora.

### 4.9. Simulação local do roteiro (23/11/2026)

Antes de haver as contas, o roteiro foi conferido numa simulação nesta máquina de desenvolvimento,
com Docker:

- **Imagem:** a etapa de execução do `Dockerfile`, com o `carregaja-api.war` da versão com as correções
  #81, #82 e #84, limitada a **512 MB e 0,1 CPU**, como o plano Free do Render, e com a variável
  `PORT=10000`, que o Render usa.
- **Banco:** PostgreSQL 16 em contêiner, no lugar do Supabase, informado pelas mesmas variáveis
  `SPRING_DATASOURCE_*` da seção 4.3.

| Conferência | Resultado |
|---|---|
| Primeira subida, com o banco vazio | 163 s; dialeto PostgreSQL; tabelas, restrição de mês único (#82) e primeiro síndico criados |
| Percurso da seção 4.5, pela API | Sem falha: troca de senha, token anterior recusado (#81), vaga, tarifa, morador, veículo, recarga, painel, consumo e histórico |
| Horários | No fuso de Brasília, com o contêiner em UTC |
| Reinício do serviço | 143 s para subir; dados mantidos e síndico não duplicado |
| Tempo de resposta | Primeira chamada de cada tela: de 2 a 10 s; as seguintes: 0,2 s |

A etapa de compilação do `Dockerfile` (`mvn package` dentro do contêiner) não foi repetida aqui,
porque o Docker desta máquina caiu no meio dela por falta de recursos; ela é a mesma compilação que
roda nos testes (`mvn package`, 287 testes sem falha) e é feita pelo Render na seção 4.3. A
conferência da seção 4.5 no Render e no Supabase de verdade é parte da issue #80.

### 4.10. Implantação de 24/11/2026

| Item | Como ficou |
|---|---|
| Endereço | <https://carregaja.onrender.com> |
| Serviço | Render, Web Service `carregaja`, Docker, plano Free, Virginia (US East), branch `main` do código (commit `05c0fce`), health check `/autenticarusuario/login.html` |
| Banco | Supabase, projeto `carregaja`, PostgreSQL 17, East US (North Virginia), *Session pooler* em `aws-1-us-east-1.pooler.supabase.com:5432`, Data API desligada |
| Primeiro síndico | `sindica@carregaja.test`, com a senha provisória já trocada; as senhas ficam com o implantador, fora do repositório |
| Construção | A imagem foi construída pelo `Dockerfile`, inclusive a etapa de compilação, e o sistema ficou no ar em cerca de 3 minutos |
| Conferência da seção 4.5 | 15 verificações pela API pública, sem falha; horários no fuso de Brasília; restrição de mês único (#82) criada no banco; painel aberto no navegador |

Os dados criados pela conferência (uma vaga, a tarifa e um morador de teste) ficam até a entrega ao síndico, quando
saem pela seção 4.7.

## 5. Treinamento e Suporte

**Treinamento.** Não há treinamento formal. O **Manual do Usuário** (`5.Implantação/`) tem uma parte
para o morador e outra para o síndico, com as telas. O síndico o recebe na entrega e o repassa aos
moradores junto com o e-mail e a senha provisória de cada um. A equipe acompanha o síndico no primeiro
acesso e na carga inicial (seção 4.6).

**Suporte**, em dois níveis:

| Nível | Quem | Atende |
|---|---|---|
| 1 | Síndico | Esqueci a senha: o síndico define uma nova senha provisória na tela de moradores, e o morador a troca ao entrar. Morador que saiu do condomínio: desativar, e não remover. Sessão esquecida aberta na vaga: encerrar pela tela de sessões abertas (UC10) |
| 2 | Equipe de desenvolvimento, pelas issues do repositório CarregaJA no GitHub ou pelos e-mails da equipe | Defeitos, sistema fora do ar, banco pausado, dúvidas que o Manual não responde |

**Sistema fora do ar.** No plano Free, a primeira abertura depois de 15 minutos sem uso leva cerca de
2,5 minutos, e não é defeito: basta esperar e recarregar a página. Se o Supabase pausar o projeto
(7 dias sem acesso), o síndico ou a equipe o reativa no painel do Supabase.

**Limitações conhecidas** da v-4.0.0, registradas na aba Defeitos do Roteiro de Teste: dois síndicos
desativando um ao outro no mesmo instante podem deixar o condomínio sem síndico ativo; a soma da
energia pode diferir na última casa decimal em meses com muitas sessões; e, se o morador altera o modelo
do veículo, as sessões já registradas passam a mostrar o modelo novo (energia e valor não mudam).
