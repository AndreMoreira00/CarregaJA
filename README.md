# CarregaJá

Sistema de controle e rateio de recarga de veículos elétricos em condomínio residencial.

Projeto da disciplina **Engenharia de Software 1** — IFSP, semestre 2026.2 — desenvolvido
segundo o método [SpinOff](http://arum.tec.br/SpinOff/index.htm).

## O problema

Condomínios instalam pontos de recarga na área comum, e daí surgem dois problemas ao mesmo
tempo:

- **Rateio.** A energia sai da conta de luz da área comum, paga por todos os condôminos —
  inclusive por quem não tem carro elétrico. Sem registro de quem usou e por quanto tempo, não
  há como individualizar o custo.
- **Disputa.** São poucas vagas para muitos apartamentos. O morador desce à garagem sem saber
  se há ponto livre e, encontrando tudo ocupado, não sabe quando algum será liberado.

## O que o sistema faz

O morador consulta pelo celular quais vagas estão livres e quando as ocupadas serão liberadas.
Ao chegar, ocupa uma vaga livre e registra o início informando o nível da bateria. O sistema
calcula a previsão de conclusão e a exibe aos demais moradores. Ao final do mês, o síndico
fecha o período e obtém quanto cada apartamento consumiu, para lançamento na cota condominial.

**A regra de negócio central** é a potência efetiva:

```
potência efetiva = min(potência do carregador, potência máxima do veículo)
```

Um carregador de 22 kW não recarrega mais rápido um veículo que aceita no máximo 6,6 kW. É ela
que justifica o cadastro de veículo existir, e dela derivam a previsão de conclusão e a
apuração de energia.

## Escopo

| | |
|---|---|
| **Atores** | Morador · Síndico |
| **Alcance** | Um único condomínio |
| **Canal** | Aplicação web, usável no celular |
| **Apuração** | Energia estimada em kWh × tarifa vigente no início da sessão |
| **Duração máxima da sessão** | 6 horas (parâmetro configurável) |

**O que o sistema não faz:** não se integra ao hardware dos carregadores, não processa
pagamento, não agenda nem reserva vagas — o uso é por ordem de chegada. Os motivos estão
registrados nas restrições e riscos do Documento de Requisitos.

## Documentação

| Artefato | Onde |
|---|---|
| Visão | [1.Requisitos/](1.Requisitos/) |
| Documento de Requisitos | [1.Requisitos/](1.Requisitos/) |
| História de Usuário | [1.Requisitos/Casos de Uso/](1.Requisitos/Casos%20de%20Uso/) |
| Modelo de Casos de Uso e Modelo de Objetos | [2.Analise e Design/](2.Analise%20e%20Design/) |
| Código fonte | submódulo em [3.Implementacao/](3.Implementacao/) |

A **Visão** é o ponto de partida: a visão geral do problema, dos usuários, das restrições e dos
riscos. O **Documento de Requisitos** detalha o que o Visão resume: requisitos funcionais,
regras de negócio, a justificativa de cada restrição e a análise completa dos riscos. Como o
SpinOff não o prevê, ele tem template próprio na mesma pasta. A **História de Usuário** detalha
cada caso de uso com testes de aceitação, usando um cenário único que atravessa todas as
histórias.

## Como clonar

O código fonte vive em um submódulo:

```bash
git clone https://github.com/AndreMoreira00/CarregaJA.git
cd CarregaJA
git submodule update --init --recursive
```

## Situação em 16/11/2026

Os 12 casos de uso estão prontos, com API, testes, coleção do Postman e a situação na História de Usuário. As telas
são HTML, CSS e JS simples e ficam dentro da API (o JSF saiu). A meta é fechar o projeto e apresentar na terça, 17/11.

**Onde está o código.** O repositório do código só recebe Pull Request; o que é novo está no fork
`R1ck-dev/CarregaJA_Implementacao`, na branch **`63-feature-telas-html-css-js`** (PR #38), que já inclui as outras:

```bash
git clone -b 63-feature-telas-html-css-js https://github.com/R1ck-dev/CarregaJA_Implementacao.git
```

O ponteiro do submódulo aqui continua no commit antigo de propósito. O `README.md` do código ensina a rodar
(`scripts\iniciar-tudo.bat`, depois <http://localhost:8081>) e lista as rotas e as telas.

**Pull Requests abertas.** Código: #28, #29, #30, #32, #33 e #34 (dos colegas), #35 (encerramento e sessão órfã), #36
(Postman), #37 (correção de segurança) e #38 (telas). A #30 aponta para uma branch antiga e precisa ser redirecionada
para o `develop`. Ordem de merge: as dos colegas, depois #35, #36, #37 e #38. Artefatos: #59 e #60 (colegas), #61 e #62
(situação das histórias).

**Falta, nesta ordem:**

1. Estilização simples das telas, só em `css/estilo.css`. Cor sugerida: azul sóbrio.
2. Decidir o que fazer ao trocar o apartamento de um morador que já tem sessões (hoje isso move o rateio, o consumo e o
   histórico passados para o apartamento novo). Recomendado: recusar a troca de quem tem sessões.
3. Diagramas do Astah dos casos de uso novos, com o front-end em HTML dentro da API.
4. Documento de Arquitetura e Guia de Implementação: trocar JSF por "telas em HTML dentro da API".
5. Gerar o `.docx` das Histórias de Usuário, uma vez só, depois que as PRs #59 a #62 entrarem.
6. Planilha de Planejamento e Controle: reescrever o sprint 6 e antecipar o 7, com nota de revisão.
7. Implantação na nuvem: escolher o serviço e conferir se o pacote roda com `java -jar`.

**Cuidados.** A branch `passagem-2026-11-16` traz o `.asta` com uma alteração local do Henrique, ainda não revisada: só
uma pessoa edita o modelo por vez, com o Astah fechado ao mexer por programa. Nunca versionar o
`scripts/config.bat` do código, que tem a senha do MySQL.

## Diagramas

Os modelos são mantidos no **Astah**, em um único arquivo em
[2.Analise e Design/](2.Analise%20e%20Design/), com a mesma organização do template do
SpinOff:

```
CARREGAJA - Modelos de Análise e Design.asta
```

É o formato previsto pelo processo SpinOff e o único versionado. Para vê-lo, abra o arquivo no
Astah — ou exporte a imagem por linha de comando, usando o JRE que acompanha a ferramenta:

```bash
"C:/Program Files/astah-UML/jre/bin/java" -cp "C:/Program Files/astah-UML/astah-uml.jar" \
  com.change_vision.jude.cmdline.JudeCommandRunner \
  -image all -f "CARREGAJA - Modelos de Análise e Design.asta" -t png -o saida/
```

| Pacote | Diagrama | Conteúdo |
|---|---|---|
| `1.Analise` | Modelo de Casos de Uso | Dois atores, os doze casos de uso UC01 a UC12, cada um com descrição, e as relações `<<include>>` que ligam UC03, UC10 e UC11 a UC04 |
| `2.Design` | Modelo de Objetos | As entidades do domínio, com atributos, associações e multiplicidades |

## Equipe

| Nome | Papel |
|---|---|
| Henrique de Almeida Marangoni Inacio | Scrum Master · Desenvolvedor |
| Matheus Ribeiro Andrade | Product Owner |
| André Fernandes Nascimento Moreira | Desenvolvedor |
| Alex Junior Fortunato Sacramento | Desenvolvedor |

## Contribuindo

O fluxo é: criar issue → criar branch a partir dela → desenvolver → abrir Pull Request para
`develop`. Os templates de issue e de PR estão em [.github/](.github/).

Nome do branch: `<numero-da-issue>-<tipo>-<descrição>` — ex.: `156-feature-cadastro-vaga`.
