-- Tabela Funcionário
CREATE TABLE Funcionario (
    ID_Unico INT PRIMARY KEY,
    Sexo VARCHAR(10) NOT NULL,
    Salario DECIMAL(10, 2) NOT NULL,
    Nome VARCHAR(255) NOT NULL,
    Logradouro VARCHAR(255) NOT NULL,
    CEP VARCHAR(20) NOT NULL,
    Bairro VARCHAR(100) NOT NULL
);

-- Tabela Porteiro
CREATE TABLE Porteiro (
    ID_Unico INT PRIMARY KEY,
    Portaria_Entrada VARCHAR(255) NOT NULL,
    Turno VARCHAR(50) NOT NULL,
    FOREIGN KEY (ID_Unico) REFERENCES Funcionario(ID_Unico)
);

-- Tabela Administração
CREATE TABLE Administracao (
    ID_Unico INT PRIMARY KEY,
    Usuario VARCHAR(255) NOT NULL,
    Senha VARCHAR(255) NOT NULL,
    FOREIGN KEY (ID_Unico) REFERENCES Funcionario(ID_Unico)
);

-- Tabela Secretário
CREATE TABLE Secretario (
    ID_Unico INT PRIMARY KEY,
    UsuarioSec VARCHAR(255) NOT NULL,
    SenhaSec VARCHAR(255) NOT NULL,
    FOREIGN KEY (ID_Unico) REFERENCES Funcionario(ID_Unico),
    FOREIGN KEY (UsuarioSec) REFERENCES Administracao(Usuario),
    FOREIGN KEY (SenhaSec) REFERENCES Administracao(Senha)
);

-- Tabela Permissões Secretário
CREATE TABLE PermissoesSec (
    Permissoes VARCHAR(255) NOT NULL,
    UsuarioSec VARCHAR(255) NOT NULL,
    SenhaSec VARCHAR(255) NOT NULL,
    PRIMARY KEY (UsuarioSec, SenhaSec),
    FOREIGN KEY (UsuarioSec) REFERENCES Secretario(UsuarioSec),
    FOREIGN KEY (SenhaSec) REFERENCES Secretario(SenhaSec)
);

-- Tabela Diretor
CREATE TABLE Diretor (
    ID_Unico INT PRIMARY KEY,
    UsuarioDir VARCHAR(255) NOT NULL,
    SenhaDir VARCHAR(255) NOT NULL,
    FOREIGN KEY (ID_Unico) REFERENCES Funcionario(ID_Unico),
    FOREIGN KEY (UsuarioDir) REFERENCES Administracao(Usuario),
    FOREIGN KEY (SenhaDir) REFERENCES Administracao(Senha)
);

-- Tabela Enfermeiro
CREATE TABLE Enfermeiro (
    ID_Unico INT PRIMARY KEY,
    CRE VARCHAR(255) NOT NULL,
    IDEnfChefe INT,
    FOREIGN KEY (ID_Unico) REFERENCES Funcionario(ID_Unico),
    FOREIGN KEY (IDEnfChefe) REFERENCES Enfermeiro(ID_Unico)
);

-- Tabela Enfermeiro Chefe
CREATE TABLE Enfermeiro_Chefe (
    ID_Unico INT PRIMARY KEY,
    FOREIGN KEY (ID_Unico) REFERENCES Enfermeiro(ID_Unico)
);

-- Tabela Plantões Enfermeiro
CREATE TABLE PlantoesEnf (
    Plantoes VARCHAR(255) NOT NULL,
    Data DATE NOT NULL,
    Hora_Inicio TIME NOT NULL,
    Hora_Termino TIME NOT NULL,
    ID_Unico INT NOT NULL,
    PRIMARY KEY (Data, Hora_Inicio, ID_Unico),
    FOREIGN KEY (ID_Unico) REFERENCES Enfermeiro(ID_Unico)
);

-- Tabela Departamento
CREATE TABLE Departamento (
    Codigo INT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Especialidade VARCHAR(255) NOT NULL
);

-- Tabela Médico
CREATE TABLE Medico (
    ID_Unico INT PRIMARY KEY,
    CRM VARCHAR(255) NOT NULL,
    IDSupervisor INT,
    CodDep INT,
    FOREIGN KEY (ID_Unico) REFERENCES Funcionario(ID_Unico),
    FOREIGN KEY (IDSupervisor) REFERENCES Medico(ID_Unico),
    FOREIGN KEY (CodDep) REFERENCES Departamento(Codigo)
);

-- Tabela Plantões Médico
CREATE TABLE PlantoesMed (
    Plantoes VARCHAR(255) NOT NULL,
    Data DATE NOT NULL,
    Hora_Inicio TIME NOT NULL,
    Hora_Termino TIME NOT NULL,
    ID_Unico INT NOT NULL,
    PRIMARY KEY (Data, Hora_Inicio, ID_Unico),
    FOREIGN KEY (ID_Unico) REFERENCES Medico(ID_Unico)
);


-- Tabela Paciente
CREATE TABLE Paciente (
    CPF VARCHAR(20) PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Sexo VARCHAR(10) NOT NULL,
    Bairro VARCHAR(100) NOT NULL,
    CEP VARCHAR(20) NOT NULL,
    Logradouro VARCHAR(255) NOT NULL,
    UsuarioSec VARCHAR(255) NOT NULL,
    SenhaSec VARCHAR(255) NOT NULL,
    FOREIGN KEY (UsuarioSec) REFERENCES Secretario(UsuarioSec),
    FOREIGN KEY (SenhaSec) REFERENCES Secretario(SenhaSec)
);

-- Tabela Alergia Paciente
CREATE TABLE AlergiaPaciente (
    Alergia VARCHAR(255) NOT NULL,
    CPF VARCHAR(20) NOT NULL,
    PRIMARY KEY (Alergia, CPF),
    FOREIGN KEY (CPF) REFERENCES Paciente(CPF)
);

-- Tabela Visitante
CREATE TABLE Visitante (
    CPF VARCHAR(20) PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Idade INT NOT NULL
);

-- Tabela Farmacêutico
CREATE TABLE Farmaceutico (
    ID_Unico INT PRIMARY KEY,
    CRF VARCHAR(255) NOT NULL,
    Area VARCHAR(255) NOT NULL,
    FOREIGN KEY (ID_Unico) REFERENCES Funcionario(ID_Unico)
);

-- Tabela Remédio
CREATE TABLE Remedio (
    NRM INT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL
);

-- Tabela Consulta
CREATE TABLE Consulta (
    IDMed INT NOT NULL,
    CPFPac VARCHAR(20) NOT NULL,
    Consultorio VARCHAR(255) NOT NULL,
    Hora TIME NOT NULL,
    PRIMARY KEY (IDMed, CPFPac, Hora),
    FOREIGN KEY (IDMed) REFERENCES Medico(ID_Unico),
    FOREIGN KEY (CPFPac) REFERENCES Paciente(CPF)
);

-- Tabela Cirurgia
CREATE TABLE Cirurgia (
    IDMedCons INT NOT NULL,
    CPFPacCons VARCHAR(20) NOT NULL,
    Codigo INT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Duracao TIME NOT NULL,
    Hora_Inicio TIME NOT NULL,
    Hora_Termino TIME NOT NULL,
    FOREIGN KEY (IDMedCons) REFERENCES Medico(ID_Unico),
    FOREIGN KEY (CPFPacCons) REFERENCES Paciente(CPF)
);

-- Tabela Autoriza
CREATE TABLE Autoriza (
    PorteiroID INT NOT NULL,
    FuncionarioID INT NOT NULL,
    PRIMARY KEY (PorteiroID, FuncionarioID),
    FOREIGN KEY (PorteiroID) REFERENCES Porteiro(ID_Unico),
    FOREIGN KEY (FuncionarioID) REFERENCES Funcionario(ID_Unico)
);

-- Tabela Visita
CREATE TABLE Visita (
    CPFVis VARCHAR(20) NOT NULL,
    CPFPac VARCHAR(20) NOT NULL,
    PRIMARY KEY (CPFVis, CPFPac),
    FOREIGN KEY (CPFVis) REFERENCES Visitante(CPF),
    FOREIGN KEY (CPFPac) REFERENCES Paciente(CPF)
);

-- Tabela Cuida
CREATE TABLE Cuida (
    IDEnf INT NOT NULL,
    CPFPac VARCHAR(20) NOT NULL,
    PRIMARY KEY (IDEnf, CPFPac),
    FOREIGN KEY (IDEnf) REFERENCES Enfermeiro(ID_Unico),
    FOREIGN KEY (CPFPac) REFERENCES Paciente(CPF)
);

-- Tabela Reporta
CREATE TABLE Reporta (
    UsuarioDir VARCHAR(255) NOT NULL,
    SenhaDir VARCHAR(255) NOT NULL,
    IDEnfChefe INT NOT NULL,
    IDMed INT NOT NULL,
    PRIMARY KEY (UsuarioDir, SenhaDir, IDEnfChefe, IDMed),
    FOREIGN KEY (UsuarioDir) REFERENCES Diretor(UsuarioDir),
    FOREIGN KEY (SenhaDir) REFERENCES Diretor(SenhaDir),
    FOREIGN KEY (IDEnfChefe) REFERENCES Enfermeiro_Chefe(ID_Unico),
    FOREIGN KEY (IDMed) REFERENCES Medico(ID_Unico)
);

-- Tabela Fornece
CREATE TABLE Fornece (
    NRMRem INT NOT NULL,
    IDEnf INT NOT NULL,
    IDFarm INT NOT NULL,
    PRIMARY KEY (NRMRem, IDEnf, IDFarm),
    FOREIGN KEY (NRMRem) REFERENCES Remedio(NRM),
    FOREIGN KEY (IDEnf) REFERENCES Enfermeiro(ID_Unico),
    FOREIGN KEY (IDFarm) REFERENCES Farmaceutico(ID_Unico)
);

-- Inserções na tabela Funcionario
INSERT INTO Funcionario (ID_Unico, Sexo, Salario, Nome, Logradouro, CEP, Bairro)
VALUES (1111, 'M', 45000000, 'João Silva', 'Rua A, 123', '12345-678', 'Centro'),
(2222, 'F', 52000000, 'Maria Oliveira', 'Rua B, 456', '23456-789', 'Bela Vista'),
(3333, 'M', 47000050, 'Carlos Souza', 'Rua C, 789', '34567-890', 'Vila Nova'),
(4444, 'F', 60000075, 'Ana Pereira', 'Rua D, 101', '45678-901', 'Jardim das Flores'),
(5555, 'M', 38000000, 'Pedro Lima', 'Rua E, 202', '56789-012', 'Parque Industrial'),
(6666, 'F', 55000030, 'Lucia Gomes', 'Rua F, 303', '67890-123', 'Morada do Sol');