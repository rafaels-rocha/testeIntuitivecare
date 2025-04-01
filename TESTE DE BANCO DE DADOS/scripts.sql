
CREATE TABLE operadoras_ativas (
    registro_ans VARCHAR(20) PRIMARY KEY,
    cnpj VARCHAR(18),
    razao_social VARCHAR(255),
    nome_fantasia VARCHAR(255),
    modalidade VARCHAR(100),
    logradouro VARCHAR(255),
    numero VARCHAR(10),
    complemento VARCHAR(255),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    uf CHAR(2),
    cep VARCHAR(9),
    ddd VARCHAR(3),
    telefone VARCHAR(15),
    fax VARCHAR(15),
    endereco_eletronico VARCHAR(255),
    representante VARCHAR(255),
    cargo_representante VARCHAR(100),
    data_registro_ans DATE
);

LOAD DATA INFILE '/TESTE DE BANCO DE DADOS/relatorios/Relatorio_cadop.csv'
INTO TABLE operadoras_ativas
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE demonstracoes_contabeis (
    data DATE,
    reg_ans VARCHAR(20),
    cd_conta_contabil VARCHAR(50),
    descricao TEXT,
    vl_saldo_inicial DECIMAL(18,2),
    vl_saldo_final DECIMAL(18,2),
    FOREIGN KEY (reg_ans) REFERENCES operadoras_ativas(registro_ans)
);

LOAD DATA INFILE '/TESTE DE BANCO DE DADOS/relatorios/1T2023.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/TESTE DE BANCO DE DADOS/relatorios/2T2023.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/TESTE DE BANCO DE DADOS/relatorios/3T2023.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/TESTE DE BANCO DE DADOS/relatorios/4T2023.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/TESTE DE BANCO DE DADOS/relatorios/1T2024.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/TESTE DE BANCO DE DADOS/relatorios/2T2024.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/TESTE DE BANCO DE DADOS/relatorios/3T2024.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/TESTE DE BANCO DE DADOS/relatorios/4T2024.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


SELECT 
    o.nome_fantasia, 
    d.reg_ans, 
    SUM(d.vl_saldo_final) AS total_despesas
FROM 
    demonstracoes_contabeis d
JOIN 
    operadoras_ativas o ON d.reg_ans = o.registro_ans
WHERE 
    d.descricao LIKE '%EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MÉDICO HOSPITALAR%' 
    AND d.data BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 3 MONTH, '%Y-%m-01') AND LAST_DAY(CURRENT_DATE)
GROUP BY 
    d.reg_ans, o.nome_fantasia
ORDER BY 
    total_despesas DESC
LIMIT 10;



SELECT 
    o.nome_fantasia, 
    d.reg_ans, 
    SUM(d.vl_saldo_final) AS total_despesas
FROM 
    demonstracoes_contabeis d
JOIN 
    operadoras_ativas o ON d.reg_ans = o.registro_ans
WHERE 
    d.descricao LIKE '%EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MÉDICO HOSPITALAR%' 
    AND d.data BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 1 YEAR, '%Y-01-01') AND CURRENT_DATE
GROUP BY 
    d.reg_ans, o.nome_fantasia
ORDER BY 
    total_despesas DESC
LIMIT 10;


