-- CARREGAJA - Massa de Teste
-- Gerado por _ferramentas/testes/gera-teste.py. Não editar à mão: a planilha de mesmo nome sai dos mesmos dados.
--
-- Carrega a massa no banco de TESTE, separado do de desenvolvimento (tarefa Projetar Testes, passo 2).
-- Apaga tudo o que houver nele antes. Só roda num banco chamado carregaja_teste: em outro, para no primeiro
-- comando com o erro "Subquery returns more than 1 row" e não altera nada.
--
--   mysql -u root -p carregaja_teste < "CARREGAJA - Massa de Teste.sql"
--
-- As tabelas são criadas pela própria API ao subir apontando para esse banco. As sessões abertas de hoje
-- (Sofia e Júlia) são relativas ao momento da carga: recarregar a massa antes de cada aba do Roteiro.
-- Horários gravados em UTC, como a API grava (serverTimezone=UTC); os comentários estão no horário local.

SELECT IF(DATABASE() = 'carregaja_teste', 1, (SELECT 1 UNION SELECT 2)) AS banco_de_teste;
SET NAMES utf8mb4;
SET @agora = DATE_FORMAT(UTC_TIMESTAMP(), '%Y-%m-%d %H:%i:00');
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM item_rateio;
DELETE FROM fechamento_mensal;
DELETE FROM recusa_vaga;
DELETE FROM sessao_recarga;
DELETE FROM veiculo;
DELETE FROM tarifa;
DELETE FROM usuario_perfis;
DELETE FROM usuario;
DELETE FROM apartamento;
DELETE FROM vaga;
SET FOREIGN_KEY_CHECKS = 1;

-- Apartamentos
INSERT INTO apartamento (id, numero) VALUES (1, '17'), (2, '23'), (3, '30'), (4, '31'), (5, '42'), (6, '51'), (7, '52'), (8, '55');

-- Usuários: senha Teste@1234 para todos, menos o Gabriel, que tem a provisória Provisoria1
INSERT INTO usuario (id, nome, email, senha, ativo, trocar_senha, apartamento_id) VALUES (1, 'Marta Ribeiro', 'sindica@carregaja.test', '$2a$10$CarregaJAMassaDeTesteuJtyOI7pO6WKSYjq6kvwVlE6VzXUdJnS', 1, 0, 5);  -- Síndica e moradora do 42, sem veículo
INSERT INTO usuario (id, nome, email, senha, ativo, trocar_senha, apartamento_id) VALUES (2, 'Helena Prado', 'helena@carregaja.test', '$2a$10$CarregaJAMassaDeTesteuJtyOI7pO6WKSYjq6kvwVlE6VzXUdJnS', 1, 0, NULL);  -- Síndica sem apartamento (preposta da administradora)
INSERT INTO usuario (id, nome, email, senha, ativo, trocar_senha, apartamento_id) VALUES (3, 'Carlos Lima', 'carlos@carregaja.test', '$2a$10$CarregaJAMassaDeTesteuJtyOI7pO6WKSYjq6kvwVlE6VzXUdJnS', 1, 0, 5);  -- Morador do 42, com histórico em setembro e outubro
INSERT INTO usuario (id, nome, email, senha, ativo, trocar_senha, apartamento_id) VALUES (4, 'Beatriz Rocha', 'beatriz@carregaja.test', '$2a$10$CarregaJAMassaDeTesteuJtyOI7pO6WKSYjq6kvwVlE6VzXUdJnS', 1, 0, 1);  -- Moradora do 17, com histórico e recusas
INSERT INTO usuario (id, nome, email, senha, ativo, trocar_senha, apartamento_id) VALUES (5, 'Diego Alves', 'diego@carregaja.test', '$2a$10$CarregaJAMassaDeTesteuJtyOI7pO6WKSYjq6kvwVlE6VzXUdJnS', 1, 0, 3);  -- Morador do 30, uma sessão em setembro
INSERT INTO usuario (id, nome, email, senha, ativo, trocar_senha, apartamento_id) VALUES (6, 'Elisa Costa', 'elisa@carregaja.test', '$2a$10$CarregaJAMassaDeTesteuJtyOI7pO6WKSYjq6kvwVlE6VzXUdJnS', 1, 0, 4);  -- Moradora do 31, sem veículo
INSERT INTO usuario (id, nome, email, senha, ativo, trocar_senha, apartamento_id) VALUES (7, 'Fábio Nunes', 'fabio@carregaja.test', '$2a$10$CarregaJAMassaDeTesteuJtyOI7pO6WKSYjq6kvwVlE6VzXUdJnS', 0, 0, 2);  -- Morador do 23, desativado
INSERT INTO usuario (id, nome, email, senha, ativo, trocar_senha, apartamento_id) VALUES (8, 'Gabriel Souza', 'gabriel@carregaja.test', '$2a$10$CarregaJAMassaDeTesteueMebV3210LOgy3LkOiijkALjJ8imDX.', 1, 1, 4);  -- Morador do 31 que ainda não trocou a senha provisória
INSERT INTO usuario (id, nome, email, senha, ativo, trocar_senha, apartamento_id) VALUES (9, 'Rafael Torres', 'rafael@carregaja.test', '$2a$10$CarregaJAMassaDeTesteuJtyOI7pO6WKSYjq6kvwVlE6VzXUdJnS', 1, 0, 6);  -- Sessão esquecida aberta desde 31/10 na G-01
INSERT INTO usuario (id, nome, email, senha, ativo, trocar_senha, apartamento_id) VALUES (10, 'Sofia Martins', 'sofia@carregaja.test', '$2a$10$CarregaJAMassaDeTesteuJtyOI7pO6WKSYjq6kvwVlE6VzXUdJnS', 1, 0, 7);  -- Sessão aberta na G-04 há 4 h
INSERT INTO usuario (id, nome, email, senha, ativo, trocar_senha, apartamento_id) VALUES (11, 'Júlia Mendes', 'julia@carregaja.test', '$2a$10$CarregaJAMassaDeTesteuJtyOI7pO6WKSYjq6kvwVlE6VzXUdJnS', 1, 0, 8);  -- Sessão aberta na G-03 há 1 h
INSERT INTO usuario_perfis (usuario_id, perfis) VALUES (1, 'MORADOR'), (1, 'SINDICO'), (2, 'SINDICO'), (3, 'MORADOR'), (4, 'MORADOR'), (5, 'MORADOR'), (6, 'MORADOR'), (7, 'MORADOR'), (8, 'MORADOR'), (9, 'MORADOR'), (10, 'MORADOR'), (11, 'MORADOR');

-- Veículos
INSERT INTO veiculo (id, usuario_id, modelo, capacidade_bateria, potencia_maxima) VALUES (1, 3, 'Nissan Leaf', 40.0, 6.6);  -- Carlos Lima
INSERT INTO veiculo (id, usuario_id, modelo, capacidade_bateria, potencia_maxima) VALUES (2, 4, 'BYD Dolphin', 60.0, 11.0);  -- Beatriz Rocha
INSERT INTO veiculo (id, usuario_id, modelo, capacidade_bateria, potencia_maxima) VALUES (3, 5, 'Renault Zoe', 52.0, 22.0);  -- Diego Alves
INSERT INTO veiculo (id, usuario_id, modelo, capacidade_bateria, potencia_maxima) VALUES (4, 9, 'BYD Dolphin', 60.0, 11.0);  -- Rafael Torres
INSERT INTO veiculo (id, usuario_id, modelo, capacidade_bateria, potencia_maxima) VALUES (5, 10, 'Renault Kwid E-Tech', 26.8, 7.0);  -- Sofia Martins
INSERT INTO veiculo (id, usuario_id, modelo, capacidade_bateria, potencia_maxima) VALUES (6, 11, 'Nissan Leaf', 40.0, 6.6);  -- Júlia Mendes

-- Vagas
INSERT INTO vaga (id, identificacao, potencia_carregador, ativa) VALUES (1, 'G-01', 11.0, 1);
INSERT INTO vaga (id, identificacao, potencia_carregador, ativa) VALUES (2, 'G-02', 7.4, 1);
INSERT INTO vaga (id, identificacao, potencia_carregador, ativa) VALUES (3, 'G-03', 7.4, 1);
INSERT INTO vaga (id, identificacao, potencia_carregador, ativa) VALUES (4, 'G-04', 11.0, 1);
INSERT INTO vaga (id, identificacao, potencia_carregador, ativa) VALUES (5, 'G-05', 11.0, 1);
INSERT INTO vaga (id, identificacao, potencia_carregador, ativa) VALUES (6, 'G-09', 7.4, 0);

-- Tarifas
INSERT INTO tarifa (id, valor_kwh, inicio_vigencia, responsavel_id) VALUES (1, 0.9200, '2026-09-01 11:00:00', 1);  -- vigente desde 01/09/2026 08:00
INSERT INTO tarifa (id, valor_kwh, inicio_vigencia, responsavel_id) VALUES (2, 1.0500, '2026-10-15 17:00:00', 1);  -- vigente desde 15/10/2026 14:00

-- Sessões de recarga
INSERT INTO sessao_recarga (id, usuario_id, vaga_id, veiculo_id, tarifa_id, inicio, fim, nivel_bateria_inicial, potencia_efetiva, energiaarepor, previsao_conclusao, energia_estimada, valor, situacao, encerrada_por_id) VALUES (1, 3, 2, 1, 1, '2026-09-02 21:10:00', '2026-09-03 01:40:00', 30, 6.6, 28.0, '2026-09-03 01:25:00', 28.0, 25.76, 'ENCERRADA', NULL);  -- Carlos Lima, G-02, 02/09/2026 18:10 a 22:40
INSERT INTO sessao_recarga (id, usuario_id, vaga_id, veiculo_id, tarifa_id, inicio, fim, nivel_bateria_inicial, potencia_efetiva, energiaarepor, previsao_conclusao, energia_estimada, valor, situacao, encerrada_por_id) VALUES (2, 4, 1, 2, 1, '2026-09-03 17:00:00', '2026-09-04 00:00:00', 20, 11.0, 48.0, '2026-09-03 21:22:00', 48.0, 44.16, 'ENCERRADA_ADMINISTRATIVAMENTE', 1);  -- Beatriz Rocha, G-01, 03/09/2026 14:00 a 21:00
INSERT INTO sessao_recarga (id, usuario_id, vaga_id, veiculo_id, tarifa_id, inicio, fim, nivel_bateria_inicial, potencia_efetiva, energiaarepor, previsao_conclusao, energia_estimada, valor, situacao, encerrada_por_id) VALUES (3, 5, 1, 3, 1, '2026-09-05 11:00:00', '2026-09-05 13:00:00', 60, 11.0, 20.8, '2026-09-05 12:53:00', 20.8, 19.14, 'ENCERRADA', NULL);  -- Diego Alves, G-01, 05/09/2026 08:00 a 10:00
INSERT INTO sessao_recarga (id, usuario_id, vaga_id, veiculo_id, tarifa_id, inicio, fim, nivel_bateria_inicial, potencia_efetiva, energiaarepor, previsao_conclusao, energia_estimada, valor, situacao, encerrada_por_id) VALUES (4, 3, 1, 1, 1, '2026-09-09 22:00:00', '2026-09-10 00:00:00', 20, 6.6, 32.0, '2026-09-10 02:51:00', 13.2, 12.14, 'ENCERRADA', NULL);  -- Carlos Lima, G-01, 09/09/2026 19:00 a 21:00
INSERT INTO sessao_recarga (id, usuario_id, vaga_id, veiculo_id, tarifa_id, inicio, fim, nivel_bateria_inicial, potencia_efetiva, energiaarepor, previsao_conclusao, energia_estimada, valor, situacao, encerrada_por_id) VALUES (5, 4, 2, 2, 1, '2026-09-10 21:00:00', '2026-09-11 01:30:00', 45, 7.4, 33.0, '2026-09-11 01:28:00', 33.0, 30.36, 'ENCERRADA', NULL);  -- Beatriz Rocha, G-02, 10/09/2026 18:00 a 22:30
INSERT INTO sessao_recarga (id, usuario_id, vaga_id, veiculo_id, tarifa_id, inicio, fim, nivel_bateria_inicial, potencia_efetiva, energiaarepor, previsao_conclusao, energia_estimada, valor, situacao, encerrada_por_id) VALUES (6, 3, 2, 1, 1, '2026-09-12 10:30:00', '2026-09-12 14:30:00', 50, 6.6, 20.0, '2026-09-12 13:32:00', 20.0, 18.40, 'ENCERRADA', NULL);  -- Carlos Lima, G-02, 12/09/2026 07:30 a 11:30
INSERT INTO sessao_recarga (id, usuario_id, vaga_id, veiculo_id, tarifa_id, inicio, fim, nivel_bateria_inicial, potencia_efetiva, energiaarepor, previsao_conclusao, energia_estimada, valor, situacao, encerrada_por_id) VALUES (7, 3, 2, 1, 1, '2026-10-15 16:00:00', '2026-10-15 18:00:00', 30, 6.6, 28.0, '2026-10-15 20:15:00', 13.2, 12.14, 'ENCERRADA', NULL);  -- Carlos Lima, G-02, 15/10/2026 13:00 a 15:00
INSERT INTO sessao_recarga (id, usuario_id, vaga_id, veiculo_id, tarifa_id, inicio, fim, nivel_bateria_inicial, potencia_efetiva, energiaarepor, previsao_conclusao, energia_estimada, valor, situacao, encerrada_por_id) VALUES (8, 4, 1, 2, 2, '2026-10-15 18:00:00', '2026-10-15 21:00:00', 50, 11.0, 30.0, '2026-10-15 20:44:00', 30.0, 31.50, 'ENCERRADA', NULL);  -- Beatriz Rocha, G-01, 15/10/2026 15:00 a 18:00
INSERT INTO sessao_recarga (id, usuario_id, vaga_id, veiculo_id, tarifa_id, inicio, fim, nivel_bateria_inicial, potencia_efetiva, energiaarepor, previsao_conclusao, energia_estimada, valor, situacao, encerrada_por_id) VALUES (9, 9, 1, 4, 2, '2026-11-01 01:00:00', NULL, 20, 11.0, 48.0, '2026-11-01 05:22:00', NULL, NULL, 'EM_ANDAMENTO', NULL);  -- Rafael Torres, G-01, 31/10/2026 22:00, ainda aberta
INSERT INTO sessao_recarga (id, usuario_id, vaga_id, veiculo_id, tarifa_id, inicio, fim, nivel_bateria_inicial, potencia_efetiva, energiaarepor, previsao_conclusao, energia_estimada, valor, situacao, encerrada_por_id) VALUES (10, 10, 4, 5, 2, DATE_ADD(@agora, INTERVAL -240 MINUTE), NULL, 20, 7.0, 21.44, DATE_ADD(@agora, INTERVAL -56 MINUTE), NULL, NULL, 'EM_ANDAMENTO', NULL);  -- Sofia Martins, G-04, agora -4 h
INSERT INTO sessao_recarga (id, usuario_id, vaga_id, veiculo_id, tarifa_id, inicio, fim, nivel_bateria_inicial, potencia_efetiva, energiaarepor, previsao_conclusao, energia_estimada, valor, situacao, encerrada_por_id) VALUES (11, 11, 3, 6, 2, DATE_ADD(@agora, INTERVAL -60 MINUTE), NULL, 30, 6.6, 28.0, DATE_ADD(@agora, INTERVAL 195 MINUTE), NULL, NULL, 'EM_ANDAMENTO', NULL);  -- Júlia Mendes, G-03, agora -1 h

-- Tentativas recusadas por vaga ocupada (demanda reprimida, UC12)
INSERT INTO recusa_vaga (id, vaga_id, usuario_id, momento) VALUES (1, 2, 4, '2026-09-02 22:30:00');  -- Beatriz Rocha, G-02, 02/09/2026 19:30
INSERT INTO recusa_vaga (id, vaga_id, usuario_id, momento) VALUES (2, 1, 3, '2026-09-03 18:10:00');  -- Carlos Lima, G-01, 03/09/2026 15:10
INSERT INTO recusa_vaga (id, vaga_id, usuario_id, momento) VALUES (3, 1, 5, '2026-09-03 21:30:00');  -- Diego Alves, G-01, 03/09/2026 18:30
INSERT INTO recusa_vaga (id, vaga_id, usuario_id, momento) VALUES (4, 1, 3, '2026-09-03 22:05:00');  -- Carlos Lima, G-01, 03/09/2026 19:05
INSERT INTO recusa_vaga (id, vaga_id, usuario_id, momento) VALUES (5, 2, 3, '2026-09-10 22:20:00');  -- Carlos Lima, G-02, 10/09/2026 19:20
INSERT INTO recusa_vaga (id, vaga_id, usuario_id, momento) VALUES (6, 2, 5, '2026-09-10 23:00:00');  -- Diego Alves, G-02, 10/09/2026 20:00
INSERT INTO recusa_vaga (id, vaga_id, usuario_id, momento) VALUES (7, 2, 3, '2026-09-11 00:45:00');  -- Carlos Lima, G-02, 10/09/2026 21:45

SELECT 'Massa de teste carregada' AS resultado;
