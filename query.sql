-- Active: 1721941491810@@127.0.0.1@5432@biblioteca@public
--DROP SCHEMA biblioteca CASCADE;
--use \c <nome_database> no  terminal, antes de criar as tabelas.

DISCARD ALL;

-- Letra A
EXPLAIN ANALYZE SELECT nome FROM usuario WHERE id = 1;
CREATE INDEX idx_usuario_id_btree ON usuario(id);
CREATE INDEX idx_usuario_id_hash ON usuario USING hash(id);
CREATE INDEX idx_usuario_id_brin ON usuario USING brin(id);
-- 

-- Letra B
DISCARD ALL;
EXPLAIN ANALYZE SELECT COUNT(*) FROM emprestimo WHERE id_usuario = 1;eq 
CREATE INDEX idx_emprestimo_id_usuario_btree ON emprestimo(id_usuario);
CREATE INDEX idx_emprestimo_id_usuario_hash ON emprestimo USING hash(id_usuario);
CREATE INDEX idx_emprestimo_id_usuario_brin ON emprestimo USING brin(id_usuario);
--

-- Letra C
DISCARD ALL;
EXPLAIN ANALYZE SELECT COUNT(*) FROM emprestimo WHERE id_livro = 5;
CREATE INDEX idx_emprestimo_id_livro_btree ON emprestimo(id_livro);
CREATE INDEX idx_emprestimo_id_livro_hash ON emprestimo USING hash(id_livro);
CREATE INDEX idx_emprestimo_id_livro_brin ON emprestimo USING brin(id_livro);
-- 

-- Letra D
DISCARD ALL;
EXPLAIN ANALYZE SELECT ano_publicacao FROM livro ORDER BY ano_publicacao;
CREATE INDEX idx_livro_ano_publicacao_btree ON livro(ano_publicacao);
CREATE INDEX idx_livro_ano_publicacao_hash ON livro USING hash(ano_publicacao);
CREATE INDEX idx_livro_ano_publicacao_brin ON livro USING brin(ano_publicacao);
-- 

-- Letra E
DISCARD ALL;
EXPLAIN ANALYZE 
SELECT titulo 
FROM livro 
WHERE id IN (
    SELECT id_livro 
    FROM emprestimo 
    GROUP BY id_livro 
    HAVING COUNT(id_livro) > 30
);
CREATE INDEX idx_livro_id_btree ON livro(id);
CREATE INDEX idx_livro_id_hash ON livro USING hash(id);
CREATE INDEX idx_livro_id_brin ON livro USING brin(id);
-- 

-- Letra F
DISCARD ALL;
EXPLAIN ANALYZE SELECT ano_publicacao, COUNT(*) FROM livro GROUP BY ano_publicacao;
CREATE INDEX idx_livro_ano_publicacao_group_btree ON livro(ano_publicacao);
CREATE INDEX idx_livro_ano_publicacao_group_hash ON livro USING hash(ano_publicacao);
CREATE INDEX idx_livro_ano_publicacao_group_brin ON livro USING brin(ano_publicacao);
-- 

-- Letra G
DISCARD ALL;
EXPLAIN ANALYZE 
SELECT id_livro, dtdevolucao - dtemprestimo AS dias_emprestado 
FROM emprestimo;
CREATE INDEX idx_emprestimo_id_livro_group_btree ON emprestimo(id_livro);
CREATE INDEX idx_emprestimo_id_livro_group_hash ON emprestimo USING hash(id_livro);
CREATE INDEX idx_emprestimo_id_livro_group_brin ON emprestimo USING brin(id_livro);
--

-- Letra H
DISCARD ALL;
EXPLAIN ANALYZE 
SELECT area, COUNT(*) 
FROM livro 
JOIN emprestimo ON livro.id = emprestimo.id_livro 
GROUP BY area;
CREATE INDEX idx_livro_area_btree ON livro(area);
CREATE INDEX idx_livro_area_hash ON livro USING hash(area);
CREATE INDEX idx_livro_area_brin ON livro USING brin(area);
--

-- Letra I
DISCARD ALL;
EXPLAIN ANALYZE SELECT COUNT(*) FROM emprestimo WHERE hremprestimo > '22:00:00';
CREATE INDEX idx_emprestimo_hremprestimo_btree ON emprestimo(hremprestimo);
CREATE INDEX idx_emprestimo_hremprestimo_hash ON emprestimo USING hash(hremprestimo);
CREATE INDEX idx_emprestimo_hremprestimo_brin ON emprestimo USING brin(hremprestimo);
-- 

-- Letra J
DISCARD ALL;
EXPLAIN ANALYZE 
SELECT u.nome, u.curso, l.titulo, l.isbn, e.dtdevolucao - e.dtemprestimo AS dias_emprestado
FROM emprestimo e 
JOIN usuario u ON e.id_usuario = u.id 
JOIN livro l ON e.id_livro = l.id 
WHERE e.dtdevolucao - e.dtemprestimo > 14;
CREATE INDEX idx_emprestimo_dtdevolucao_btree ON emprestimo(dtdevolucao);
CREATE INDEX idx_emprestimo_dtdevolucao_hash ON emprestimo USING hash(dtdevolucao);
CREATE INDEX idx_emprestimo_dtdevolucao_brin ON emprestimo USING brin(dtdevolucao);
--