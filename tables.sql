-- Tabela Funcionário
CREATE TABLE Funcionario (
    ID_Unico INT PRIMARY KEY,
    Sexo VARCHAR(10),
    Salario DECIMAL(10, 2),
    Nome VARCHAR(255),
    Logradouro VARCHAR(255),
    CEP VARCHAR(20),
    Bairro VARCHAR(100)
);

-- Tabela Porteiro
CREATE TABLE Porteiro (
    ID_Unico INT PRIMARY KEY,
    Portaria_Entrada VARCHAR(255),
    Turno VARCHAR(50),
    FOREIGN KEY (ID_Unico) REFERENCES Funcionario(ID_Unico)
);

-- Tabela Administração
CREATE TABLE Administracao (
    ID_Unico INT PRIMARY KEY,
    Usuario VARCHAR(255),
    Senha VARCHAR(255),
    FOREIGN KEY (ID_Unico) REFERENCES Funcionario(ID_Unico)
);

-- Tabela Secretário
CREATE TABLE Secretario (
    ID_Unico INT PRIMARY KEY,
    UsuarioSec VARCHAR(255),
    SenhaSec VARCHAR(255),
    FOREIGN KEY (ID_Unico) REFERENCES Funcionario(ID_Unico),
    FOREIGN KEY (UsuarioSec) REFERENCES Administracao(Usuario),
    FOREIGN KEY (SenhaSec) REFERENCES Administracao(Senha)
);

-- Tabela Permissões Secretário
CREATE TABLE PermissoesSec (
    Permissoes VARCHAR(255),
    UsuarioSec VARCHAR(255),
    SenhaSec VARCHAR(255),
    PRIMARY KEY (UsuarioSec, SenhaSec),
    FOREIGN KEY (UsuarioSec) REFERENCES Secretario(UsuarioSec),
    FOREIGN KEY (SenhaSec) REFERENCES Secretario(SenhaSec)
);

-- Tabela Diretor
CREATE TABLE Diretor (
    ID_Unico INT PRIMARY KEY,
    UsuarioDir VARCHAR(255),
    SenhaDir VARCHAR(255),
    FOREIGN KEY (ID_Unico) REFERENCES Funcionario(ID_Unico),
    FOREIGN KEY (UsuarioDir) REFERENCES Administracao(Usuario),
    FOREIGN KEY (SenhaDir) REFERENCES Administracao(Senha)
);

-- Tabela Enfermeiro
CREATE TABLE Enfermeiro (
    ID_Unico INT PRIMARY KEY,
    CRE VARCHAR(255),
    IDEnfChefe INT,
    FOREIGN KEY (ID_Unico) REFERENCES Funcionario(ID_Unico),
    FOREIGN KEY (IDEnfChefe) REFERENCES Enfermeiro(ID_Unico)
);

-- Tabela Plantões Enfermeiro
CREATE TABLE PlantoesEnf (
    Plantoes VARCHAR(255),
    Data DATE,
    Hora_Inicio TIME,
    Hora_Termino TIME,
    ID_Unico INT,
    PRIMARY KEY (Data, Hora_Inicio, ID_Unico),
    FOREIGN KEY (ID_Unico) REFERENCES Enfermeiro(ID_Unico)
);

-- Tabela Enfermeiro Chefe
CREATE TABLE Enfermeiro_Chefe (
    ID_Unico INT PRIMARY KEY,
    FOREIGN KEY (ID_Unico) REFERENCES Enfermeiro(ID_Unico)
);

-- Tabela Médico
CREATE TABLE Medico (
    ID_Unico INT PRIMARY KEY,
    CRM VARCHAR(255),
    IDSupervisor INT,
    CodDep INT,
    FOREIGN KEY (ID_Unico) REFERENCES Funcionario(ID_Unico),
    FOREIGN KEY (IDSupervisor) REFERENCES Medico(ID_Unico),
    FOREIGN KEY (CodDep) REFERENCES Departamento(Codigo)
);

-- Tabela Plantões Médico
CREATE TABLE PlantoesMed (
    Plantoes VARCHAR(255),
    Data DATE,
    Hora_Inicio TIME,
    Hora_Termino TIME,
    ID_Unico INT,
    PRIMARY KEY (Data, Hora_Inicio, ID_Unico),
    FOREIGN KEY (ID_Unico) REFERENCES Medico(ID_Unico)
);

-- Tabela Departamento
CREATE TABLE Departamento (
    Codigo INT PRIMARY KEY,
    Nome VARCHAR(255),
    Especialidade VARCHAR(255)
);

-- Tabela Paciente
CREATE TABLE Paciente (
    CPF VARCHAR(20) PRIMARY KEY,
    Nome VARCHAR(255),
    Sexo VARCHAR(10),
    Bairro VARCHAR(100),
    CEP VARCHAR(20),
    Logradouro VARCHAR(255),
    UsuarioSec VARCHAR(255),
    SenhaSec VARCHAR(255),
    FOREIGN KEY (UsuarioSec) REFERENCES Secretario(UsuarioSec),
    FOREIGN KEY (SenhaSec) REFERENCES Secretario(SenhaSec)
);

-- Tabela Alergia Paciente
CREATE TABLE AlergiaPaciente (
    Alergia VARCHAR(255),
    CPF VARCHAR(20),
    PRIMARY KEY (Alergia, CPF),
    FOREIGN KEY (CPF) REFERENCES Paciente(CPF)
);

-- Tabela Visitante
CREATE TABLE Visitante (
    CPF VARCHAR(20) PRIMARY KEY,
    Nome VARCHAR(255),
    Idade INT
);

-- Tabela Farmacêutico
CREATE TABLE Farmaceutico (
    ID_Unico INT PRIMARY KEY,
    CRF VARCHAR(255),
    Area VARCHAR(255),
    FOREIGN KEY (ID_Unico) REFERENCES Funcionario(ID_Unico)
);

-- Tabela Remédio
CREATE TABLE Remedio (
    NRM INT PRIMARY KEY,
    Nome VARCHAR(255)
);

-- Tabela Consulta
CREATE TABLE Consulta (
    IDMed INT,
    CPFPac VARCHAR(20),
    Consultorio VARCHAR(255),
    Hora TIME,
    PRIMARY KEY (IDMed, CPFPac, Hora),
    FOREIGN KEY (IDMed) REFERENCES Medico(ID_Unico),
    FOREIGN KEY (CPFPac) REFERENCES Paciente(CPF)
);

-- Tabela Cirurgia
CREATE TABLE Cirurgia (
    IDMedCons INT,
    CPFPacCons VARCHAR(20),
    Codigo INT PRIMARY KEY,
    Nome VARCHAR(255),
    Duracao TIME,
    Hora_Inicio TIME,
    Hora_Termino TIME,
    FOREIGN KEY (IDMedCons) REFERENCES Medico(ID_Unico),
    FOREIGN KEY (CPFPacCons) REFERENCES Paciente(CPF)
);

-- Tabela Autoriza
CREATE TABLE Autoriza (
    PorteiroID INT,
    FuncionarioID INT,
    PRIMARY KEY (PorteiroID, FuncionarioID),
    FOREIGN KEY (PorteiroID) REFERENCES Porteiro(ID_Unico),
    FOREIGN KEY (FuncionarioID) REFERENCES Funcionario(ID_Unico)
);

-- Tabela Visita
CREATE TABLE Visita (
    CPFVis VARCHAR(20),
    CPFPac VARCHAR(20),
    PRIMARY KEY (CPFVis, CPFPac),
    FOREIGN KEY (CPFVis) REFERENCES Visitante(CPF),
    FOREIGN KEY (CPFPac) REFERENCES Paciente(CPF)
);

-- Tabela Cuida
CREATE TABLE Cuida (
    IDEnf INT,
    CPFPac VARCHAR(20),
    PRIMARY KEY (IDEnf, CPFPac),
    FOREIGN KEY (IDEnf) REFERENCES Enfermeiro(ID_Unico),
    FOREIGN KEY (CPFPac) REFERENCES Paciente(CPF)
);

-- Tabela Reporta
CREATE TABLE Reporta (
    UsuarioDir VARCHAR(255),
    SenhaDir VARCHAR(255),
    IDEnfChefe INT,
    IDMed INT,
    PRIMARY KEY (UsuarioDir, SenhaDir, IDEnfChefe, IDMed),
    FOREIGN KEY (UsuarioDir) REFERENCES Diretor(UsuarioDir),
    FOREIGN KEY (SenhaDir) REFERENCES Diretor(SenhaDir),
    FOREIGN KEY (IDEnfChefe) REFERENCES Enfermeiro_Chefe(ID_Unico),
    FOREIGN KEY (IDMed) REFERENCES Medico(ID_Unico)
);

-- Tabela Fornece
CREATE TABLE Fornece (
    NRMRem INT,
    IDEnf INT,
    IDFarm INT,
    PRIMARY KEY (NRMRem, IDEnf, IDFarm),
    FOREIGN KEY (NRMRem) REFERENCES Remedio(NRM),
    FOREIGN KEY (IDEnf) REFERENCES Enfermeiro(ID_Unico),
    FOREIGN KEY (IDFarm) REFERENCES Farmaceutico(ID_Unico)
);
