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
registrados nas restrições e riscos do documento Visão.

## Documentação

| Artefato | Onde |
|---|---|
| Visão | [1.Requisitos/](1.Requisitos/) |
| História de Usuário | [1.Requisitos/Casos de Uso/](1.Requisitos/Casos%20de%20Uso/) |
| Modelo de Caso de Uso | [2.Analise e Design/](2.Analise%20e%20Design/) |
| Código fonte | submódulo em [3.Implementacao/](3.Implementacao/) |

A **Visão** é o ponto de partida: descreve o problema, o escopo, as restrições e os riscos. A
**História de Usuário** detalha cada caso de uso com fluxos e testes de aceitação, usando um
cenário único que atravessa todas as histórias.

## Como clonar

O código fonte vive em um submódulo:

```bash
git clone https://github.com/AndreMoreira00/CarregaJA.git
cd CarregaJA
git submodule update --init --recursive
```

## Diagramas

O Modelo de Caso de Uso é mantido no **Astah**, em
[2.Analise e Design/](2.Analise%20e%20Design/):

```
CARREGAJA - Modelo de Caso de Uso.asta
```

É o formato previsto pelo processo SpinOff e o único versionado. Para vê-lo, abra o arquivo no
Astah — ou exporte a imagem por linha de comando, usando o JRE que acompanha a ferramenta:

```bash
"C:/Program Files/astah-UML/jre/bin/java" -cp "C:/Program Files/astah-UML/astah-uml.jar" \
  com.change_vision.jude.cmdline.JudeCommandRunner \
  -image all -f "CARREGAJA - Modelo de Caso de Uso.asta" -t png -o saida/
```

O modelo tem dois atores, os catorze casos de uso UC01 a UC14 e as relações `<<include>>` que
ligam UC03 a UC04 e UC05, UC12 e UC13 a UC06.

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
