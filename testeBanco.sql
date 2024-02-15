CREATE DATABASE EMPRESAXYZ;

CREATE TABLE USUARIO
(
	CD_USUARIO INT PRIMARY KEY IDENTITY NOT NULL,
	NM_NOME VARCHAR(50) NOT NULL,
	NM_SOBRE_NOME VARCHAR(100),
	CPF VARCHAR(11) NOT NULL,
	EMAIL VARCHAR(100) NOT NULL,
	DH_NASCIMENTO DATE NOT NULL,
	CD_STATUS INT NOT NULL,
	DH_TIMESTAMP DATETIME DEFAULT GETDATE()
)

CREATE TABLE USUARIO_TELEFONE
(
	CD_USUARIO_TELEFONE INT PRIMARY KEY IDENTITY NOT NULL,
	CD_USUARIO INT NOT NULL,
	FOREIGN KEY (CD_USUARIO) REFERENCES USUARIO(CD_USUARIO),
	DDD VARCHAR(2) NOT NULL,
	TELEFONE VARCHAR(9) NOT NULL,
	CD_STATUS INT NOT NULL,
	DH_TIMESTAMP DATETIME DEFAULT GETDATE()
)

CREATE PROCEDURE INSERIR_USUARIO
@NM_NOME VARCHAR(50),
	@NM_SOBRE_NOME VARCHAR(100),
    @CPF VARCHAR(11),
	@EMAIL VARCHAR(100),
    @DH_NASCIMENTO DATE
AS
BEGIN

    IF DATEDIFF(YEAR, @DH_NASCIMENTO, GETDATE()) < 18
    BEGIN
        PRINT 'Usuário deve ter pelo menos 18 anos.';
        RETURN;
    END
    
    IF EXISTS (SELECT 1 FROM USUARIO WHERE CPF = @CPF)
    BEGIN
        PRINT 'CPF já cadastrado.';
        RETURN;
    END

    INSERT INTO USUARIO (NM_NOME, NM_SOBRE_NOME, CPF, EMAIL, DH_NASCIMENTO, CD_STATUS)
    VALUES (@NM_NOME, @NM_SOBRE_NOME, @CPF, @EMAIL, @DH_NASCIMENTO, 1);

	 DECLARE @IDUsuario INT;
    SET @IDUsuario = SCOPE_IDENTITY(); -- Obtém o ID do usuário inserido

    INSERT INTO USUARIO_TELEFONE (CD_USUARIO, DDD, TELEFONE, CD_STATUS)
    VALUES (@IDUsuario, 'SN', 'SN', 1);


END;


CREATE PROCEDURE CONSULTAR_TODOS_USUARIOS_COM_TELEFONE
AS
BEGIN 

	SELECT US.CD_USUARIO, NM_NOME, NM_SOBRE_NOME, CPF, DDD, TELEFONE, EMAIL, DH_NASCIMENTO, US.CD_STATUS FROM USUARIO AS US
	INNER JOIN USUARIO_TELEFONE AS UT ON UT.CD_USUARIO = US.CD_USUARIO WHERE US.CD_STATUS = 1 ORDER BY US.DH_TIMESTAMP DESC;
END;


CREATE PROCEDURE CONSULTAR_USUARIO_COM_TELEFONE

@CD_USUARIO INT
AS

BEGIN 

	SELECT US.CD_USUARIO, NM_NOME, NM_SOBRE_NOME, CPF, DDD, TELEFONE, EMAIL, DH_NASCIMENTO, US.CD_STATUS FROM USUARIO AS US
	INNER JOIN USUARIO_TELEFONE AS UT ON UT.CD_USUARIO = @CD_USUARIO
	WHERE US.CD_USUARIO = @CD_USUARIO;
END;


CREATE PROCEDURE ATUALIZAR_USUARIO
	@CD_USUARIO INT,
	@NM_NOME VARCHAR(50),
	@NM_SOBRE_NOME VARCHAR(100),
	@CPF VARCHAR(11),
	@EMAIL VARCHAR(100),
	@DH_NASCIMENTO DATE,
	@DDD VARCHAR(2),
	@TELEFONE VARCHAR(9)

AS

BEGIN
	UPDATE USUARIO
	SET NM_NOME = @NM_NOME, NM_SOBRE_NOME = @NM_SOBRE_NOME, CPF = @CPF, EMAIL = @EMAIL, DH_NASCIMENTO = @DH_NASCIMENTO
	WHERE CD_USUARIO = @CD_USUARIO;

	UPDATE USUARIO_TELEFONE
	SET DDD = @DDD, TELEFONE = @TELEFONE
	WHERE CD_USUARIO = @CD_USUARIO
END;

CREATE PROCEDURE ATUALIZAR_TELEFONE
	@CD_USUARIO INT,
	@DDD VARCHAR (2),
	@TELEFONE VARCHAR (9)

	AS
		UPDATE USUARIO_TELEFONE
		SET DDD = @DDD, TELEFONE = @TELEFONE
		WHERE CD_USUARIO = @CD_USUARIO;

CREATE PROCEDURE DESATIVAR_USUARIO

 @CD_USUARIO INT
AS
BEGIN

    UPDATE USUARIO
    SET CD_STATUS = 0
    WHERE CD_USUARIO = @CD_USUARIO;


    UPDATE USUARIO_TELEFONE
    SET CD_STATUS = 0
    WHERE CD_USUARIO = @CD_USUARIO;
END;

CREATE PROCEDURE EXCLUIR_USUARIO_E_TELEFONE

@CD_USUARIO INT

AS

BEGIN

	DELETE FROM USUARIO_TELEFONE
    WHERE CD_USUARIO = @CD_USUARIO;

    DELETE FROM USUARIO
    WHERE CD_USUARIO = @CD_USUARIO;
END;


EXEC [dbo].[INSERIR_USUARIO] 'João', 'Silva', '12345678901', 'joao@example.com', '1980-05-15'
EXEC [dbo].[INSERIR_USUARIO] 'Maria', 'Santos', '23456789012', 'maria@example.com', '1975-10-20'
EXEC [dbo].[INSERIR_USUARIO] 'Pedro', 'Ferreira', '34567890123', 'pedro@example.com', '1990-12-03'
EXEC [dbo].[INSERIR_USUARIO] 'Ana', 'Oliveira', '45678901234', 'ana@example.com', '1988-07-29'
EXEC [dbo].[INSERIR_USUARIO] 'Lucas', 'Costa', '56789012345', 'lucas@example.com', '1983-03-08'
EXEC [dbo].[INSERIR_USUARIO] 'Carla', 'Ribeiro', '67890123456', 'carla@example.com', '1979-09-12'
EXEC [dbo].[INSERIR_USUARIO] 'Gabriel', 'Martins', '78901234567', 'gabriel@example.com', '1995-02-18'
EXEC [dbo].[INSERIR_USUARIO] 'Juliana', 'Almeida', '89012345678', 'juliana@example.com', '1986-11-25'
EXEC [dbo].[INSERIR_USUARIO] 'Rafael', 'Souza', '90123456789', 'rafael@example.com', '1970-08-02'
EXEC [dbo].[INSERIR_USUARIO] 'Fernanda', 'Gomes', '01234567890', 'fernanda@example.com', '1982-04-17'
EXEC [dbo].[INSERIR_USUARIO] 'Anderson', 'Pereira', '12345678901', 'anderson@example.com', '1977-01-30'
EXEC [dbo].[INSERIR_USUARIO] 'Patrícia', 'Cardoso', '23456789012', 'patricia@example.com', '1993-06-23'
EXEC [dbo].[INSERIR_USUARIO] 'Roberto', 'Mendes', '34567890123', 'roberto@example.com', '1984-09-05'
EXEC [dbo].[INSERIR_USUARIO] 'Cristina', 'Lima', '45678901234', 'cristina@example.com', '1974-12-11'
EXEC [dbo].[INSERIR_USUARIO] 'Tiago', 'Rodrigues', '56789012345', 'tiago@example.com', '1991-07-07'
EXEC [dbo].[INSERIR_USUARIO] 'Aline', 'Nascimento', '67890123456', 'aline@example.com', '1981-02-22'
EXEC [dbo].[INSERIR_USUARIO] 'Marcelo', 'Araújo', '78901234567', 'marcelo@example.com', '1976-05-14'
EXEC [dbo].[INSERIR_USUARIO] 'Camila', 'Dias', '89012345678', 'camila@example.com', '1997-10-10'
EXEC [dbo].[INSERIR_USUARIO] 'Hugo', 'Barbosa', '90123456789', 'hugo@example.com', '1989-08-27'
EXEC [dbo].[INSERIR_USUARIO] 'Beatriz', 'Oliveira', '01234567890', 'beatriz@example.com', '1978-03-03'
