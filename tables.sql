-- Tabela Funcionário
CREATE TABLE Funcionario (
    ID_Unico INT ,
    Sexo VARCHAR(10) NOT NULL,
    Salario DECIMAL(10, 2) NOT NULL,
    Nome VARCHAR(255) NOT NULL,
    Logradouro VARCHAR(255) NOT NULL,
    CEP VARCHAR(20) NOT NULL,
    Bairro VARCHAR(100) NOT NULL,
    CONSTRAINT pk_funcionario PRIMARY KEY (ID_Unico),
    CONSTRAINT ck_sexo_func CHECK (Sexo='M' or Sexo='F')
);

-- Tabela Porteiro
CREATE TABLE Porteiro (
    ID_Unico INT,
    Portaria_Entrada VARCHAR(255) NOT NULL,
    Turno VARCHAR(50) NOT NULL,
    CONSTRAINT pk_porteiro PRIMARY KEY (ID_Unico),
    CONSTRAINT fk_porteiro_funcionario FOREIGN KEY (ID_Unico) REFERENCES Funcionario(ID_Unico) ON DELETE CASCADE
);

-- Tabela Administração
CREATE TABLE Administracao (
    ID_Unico INT ,
    Usuario VARCHAR(255) NOT NULL,
    Senha VARCHAR(255) NOT NULL,
    CONSTRAINT pk_administracao PRIMARY KEY(ID_Unico),
    CONSTRAINT fk_administracao_funcionario FOREIGN KEY (ID_Unico) REFERENCES Funcionario(ID_Unico) ON DELETE CASCADE
);

-- Tabela Secretário
CREATE TABLE Secretario (
    ID_Unico INT,
    UsuarioSec VARCHAR(255) NOT NULL,
    SenhaSec VARCHAR(255) NOT NULL,
    CONSTRAINT pk_secretario PRIMARY KEY(ID_Unico),
    CONSTRAINT fk_secretario_funcionario FOREIGN KEY (ID_Unico) REFERENCES Funcionario(ID_Unico) ON DELETE CASCADE,
    CONSTRAINT fk_secretario_usuario FOREIGN KEY (UsuarioSec) REFERENCES Administracao(Usuario) ON DELETE CASCADE,
    CONSTRAINT fk_secretario_senha FOREIGN KEY (SenhaSec) REFERENCES Administracao(Senha) ON DELETE CASCADE
);

-- Tabela Permissões Secretário
CREATE TABLE PermissoesSec (
    Permissoes VARCHAR(255) NOT NULL,
    UsuarioSec VARCHAR(255) NOT NULL,
    SenhaSec VARCHAR(255) NOT NULL,
    CONSTRAINT pk_permissoes PRIMARY KEY (UsuarioSec, SenhaSec),
    CONSTRAINT fk_permissoes_usuario FOREIGN KEY (UsuarioSec) REFERENCES Secretario(UsuarioSec) ON DELETE CASCADE,
    CONSTRAINT fk_permissoes_senha FOREIGN KEY (SenhaSec) REFERENCES Secretario(SenhaSec) ON DELETE CASCADE
);

-- Tabela Diretor
CREATE TABLE Diretor (
    ID_Unico INT ,
    UsuarioDir VARCHAR(255) NOT NULL,
    SenhaDir VARCHAR(255) NOT NULL,
    CONSTRAINT pk_diretor PRIMARY KEY(ID_Unico),
    CONSTRAINT fk_diretor_funcionario FOREIGN KEY (ID_Unico) REFERENCES Funcionario(ID_Unico) ON DELETE CASCADE,
    CONSTRAINT fk_diretor_usuario FOREIGN KEY (UsuarioDir) REFERENCES Administracao(Usuario) ON DELETE CASCADE,
    CONSTRAINT fk_diretor_senha FOREIGN KEY (SenhaDir) REFERENCES Administracao(Senha) ON DELETE CASCADE
);

-- Tabela Enfermeiro
CREATE TABLE Enfermeiro (
    ID_Unico INT,
    CRE VARCHAR(255) NOT NULL,
    IDEnfChefe INT NOT NULL,
    CONSTRAINT pk_enfermeiro PRIMARY KEY(ID_Unico),
    CONSTRAINT fk_enfermeiro_funcionario FOREIGN KEY (ID_Unico) REFERENCES Funcionario(ID_Unico) ON DELETE CASCADE,
    CONSTRAINT fk_enfermeiro_chefe FOREIGN KEY (IDEnfChefe) REFERENCES Enfermeiro(ID_Unico) ON DELETE CASCADE
);

-- Tabela Enfermeiro Chefe
CREATE TABLE Enfermeiro_Chefe (
    ID_Unico INT ,
    CONSTRAINT pk_enfermeiro_chefe PRIMARY KEY(ID_Unico),
    CONSTRAINT fk_enfermeiro_chefe_enfermeiro FOREIGN KEY (ID_Unico) REFERENCES Enfermeiro(ID_Unico) ON DELETE CASCADE
);

-- Tabela Plantões Enfermeiro
CREATE TABLE PlantoesEnf (
    Plantoes VARCHAR(255) NOT NULL,
    Data DATE NOT NULL,
    Hora_Inicio TIME NOT NULL,
    Hora_Termino TIME NOT NULL,
    ID_Unico INT NOT NULL,
    CONSTRAINT pk_plantoes_enf PRIMARY KEY (Data, Hora_Inicio, ID_Unico),
    CONSTRAINT fk_plantoes_enf_enfermeiro FOREIGN KEY (ID_Unico) REFERENCES Enfermeiro(ID_Unico) ON DELETE CASCADE
);

-- Tabela Departamento
CREATE TABLE Departamento (
    Codigodep INT NOT NULL ,
    Nome VARCHAR(255) NOT NULL,
    Especialidade VARCHAR(255) NOT NULL,
    CONSTRAINT pk_departamento PRIMARY KEY (Codigodep) 
);

-- Tabela Médico
CREATE TABLE Medico (
    ID_Unico INT,
    CRM VARCHAR(255) NOT NULL,
    IDSupervisor INT NOT NULL,
    CodDep INT NOT NULL,
    CONSTRAINT pk_medico PRIMARY KEY(ID_Unico),
    CONSTRAINT fk_medico_funcionario FOREIGN KEY (ID_Unico) REFERENCES Funcionario(ID_Unico) ON DELETE CASCADE,
    CONSTRAINT fk_medico_supervisor FOREIGN KEY (IDSupervisor) REFERENCES Medico(ID_Unico) ON DELETE CASCADE,
    CONSTRAINT fk_medico_departamento FOREIGN KEY (CodDep) REFERENCES Departamento(Codigodep) ON DELETE CASCADE
);

-- Tabela Plantões Médico
CREATE TABLE PlantoesMed (
    Plantoes VARCHAR(255) NOT NULL,
    Data DATE NOT NULL,
    Hora_Inicio TIME NOT NULL,
    Hora_Termino TIME NOT NULL,
    ID_Unico INT NOT NULL,
    CONSTRAINT pk_plantoes_med PRIMARY KEY (Data, Hora_Inicio, ID_Unico),
    CONSTRAINT fk_plantoes_med_medico FOREIGN KEY (ID_Unico) REFERENCES Medico(ID_Unico) ON DELETE CASCADE
);

-- Tabela Paciente
CREATE TABLE Paciente (
    CPF VARCHAR(20) ,
    Nome VARCHAR(255) NOT NULL,
    Sexo VARCHAR(10) NOT NULL,
    Bairro VARCHAR(100) NOT NULL,
    CEP VARCHAR(20) NOT NULL,
    Logradouro VARCHAR(255) NOT NULL,
    ID_Secretario INT NOT NULL,  
    Datacadastro DATE NOT NULL,
    CONSTRAINT pk_paciente PRIMARY KEY(CPF),
    FOREIGN KEY (ID_Secretario) REFERENCES Secretario(ID_Unico)
);

-- Tabela Alergia Paciente
CREATE TABLE AlergiaPaciente (
    Alergia VARCHAR(255) NOT NULL,
    CPF VARCHAR(20) NOT NULL,
    CONSTRAINT pk_alergia_paciente PRIMARY KEY (Alergia, CPF),
    CONSTRAINT fk_alergia_paciente FOREIGN KEY (CPF) REFERENCES Paciente(CPF) ON DELETE CASCADE
);

-- Tabela Visitante
CREATE TABLE Visitante (
    CPF VARCHAR(20) ,
    Nome VARCHAR(255) NOT NULL,
    Datanascimento DATE NOT NULL,
    CONSTRAINT pk_visitante PRIMARY KEY (CPF)
);

-- Tabela Farmacêutico
CREATE TABLE Farmaceutico (
    ID_Unico INT ,
    CRF VARCHAR(255) NOT NULL,
    Area VARCHAR(255) NOT NULL,
    CONSTRAINT pk_farmaceutico PRIMARY KEY(ID_Unico),
    CONSTRAINT fk_farmaceutico_funcionario FOREIGN KEY (ID_Unico) REFERENCES Funcionario(ID_Unico) ON DELETE CASCADE
);

-- Tabela Remédio
CREATE TABLE Remedio (
    NRM INT,
    Nome VARCHAR(255) NOT NULL,
    CONSTRAINT pk_remedio PRIMARY KEY(NRM)
);

-- Tabela Consulta
CREATE TABLE Consulta (
    IDMed INT NOT NULL,
    CPFPac VARCHAR(20) NOT NULL,
    Consultorio VARCHAR(255) NOT NULL,
    Hora TIME NOT NULL,
    DataConsulta DATE NOT NULL,
    CONSTRAINT pk_consulta PRIMARY KEY (IDMed, CPFPac, Hora),
    CONSTRAINT fk_consulta_medico FOREIGN KEY (IDMed) REFERENCES Medico(ID_Unico) ON DELETE CASCADE,
    CONSTRAINT fk_consulta_paciente FOREIGN KEY (CPFPac) REFERENCES Paciente(CPF) ON DELETE CASCADE
);

-- Tabela Cirurgia
CREATE TABLE Cirurgia (
    IDMedCons INT NOT NULL,
    CPFPacCons VARCHAR(20) NOT NULL,
    Codigo INT ,
    Nome VARCHAR(255) NOT NULL,
    Duracao TIME NOT NULL,
    Hora_Inicio TIME NOT NULL,
    Hora_Termino TIME NOT NULL,
    CONSTRAINT pk_cirurgia PRIMARY KEY(Codigo),
    CONSTRAINT fk_cirurgia_medico FOREIGN KEY (IDMedCons) REFERENCES Medico(ID_Unico) ON DELETE CASCADE,
    CONSTRAINT fk_cirurgia_paciente FOREIGN KEY (CPFPacCons) REFERENCES Paciente(CPF) ON DELETE CASCADE
);

-- Tabela Autoriza
CREATE TABLE Autoriza (
    PorteiroID INT NOT NULL,
    FuncionarioID INT NOT NULL,
    Dataautoriza DATE NOT NULL,
    Horaautoriza TIME NOT NULL,
    CONSTRAINT pk_autoriza PRIMARY KEY (PorteiroID, FuncionarioID),
    CONSTRAINT fk_autoriza_porteiro FOREIGN KEY (PorteiroID) REFERENCES Porteiro(ID_Unico) ON DELETE CASCADE,
    CONSTRAINT fk_autoriza_funcionario FOREIGN KEY (FuncionarioID) REFERENCES Funcionario(ID_Unico) ON DELETE CASCADE
);

-- Tabela Visita
CREATE TABLE Visita (
    CPFVis VARCHAR(20) NOT NULL,
    CPFPac VARCHAR(20) NOT NULL,
    CONSTRAINT pk_visita PRIMARY KEY (CPFVis, CPFPac),
    CONSTRAINT fk_visita_visitante FOREIGN KEY (CPFVis) REFERENCES Visitante(CPF) ON DELETE CASCADE,
    CONSTRAINT fk_visita_paciente FOREIGN KEY (CPFPac) REFERENCES Paciente(CPF) ON DELETE CASCADE
);

-- Tabela Cuida
CREATE TABLE Cuida (
    IDEnf INT NOT NULL,
    CPFPac VARCHAR(20) NOT NULL,
    CONSTRAINT pk_cuida PRIMARY KEY (IDEnf, CPFPac),
    CONSTRAINT fk_cuida_enfermeiro FOREIGN KEY (IDEnf) REFERENCES Enfermeiro(ID_Unico) ON DELETE CASCADE,
    CONSTRAINT fk_cuida_paciente FOREIGN KEY (CPFPac) REFERENCES Paciente(CPF) ON DELETE CASCADE
);

-- Tabela Reporta
CREATE TABLE Reporta (
    IDDir INT NOT NULL,
    IDEnfChefe INT NOT NULL,
    IDMed INT NOT NULL,
    CONSTRAINT pk_reporta PRIMARY KEY (IDDir, IDEnfChefe, IDMed),
    CONSTRAINT fk_reporta_senha_dir FOREIGN KEY (IDDir) REFERENCES Diretor(ID_Unico) ON DELETE CASCADE,
    CONSTRAINT fk_reporta_enf_chefe FOREIGN KEY (IDEnfChefe) REFERENCES Enfermeiro_Chefe(ID_Unico) ON DELETE CASCADE,
    CONSTRAINT fk_reporta_medico FOREIGN KEY (IDMed) REFERENCES Medico(ID_Unico) ON DELETE CASCADE
);

-- Tabela Fornece
CREATE TABLE Fornece (
    NRMRem INT NOT NULL,
    IDEnf INT NOT NULL,
    IDFarm INT NOT NULL,
    CONSTRAINT pk_fornece PRIMARY KEY (NRMRem, IDEnf, IDFarm),
    CONSTRAINT fk_fornece_remedio FOREIGN KEY (NRMRem) REFERENCES Remedio(NRM) ON DELETE CASCADE,
    CONSTRAINT fk_fornece_enfermeiro FOREIGN KEY (IDEnf) REFERENCES Enfermeiro(ID_Unico) ON DELETE CASCADE,
    CONSTRAINT fk_fornece_farmaceutico FOREIGN KEY (IDFarm) REFERENCES Farmaceutico(ID_Unico) ON DELETE CASCADE
);

-- Inserções na tabela Funcionario
INSERT INTO Funcionario (ID_Unico, Sexo, Salario, Nome, Logradouro, CEP, Bairro)
VALUES 
(1111, 'M', 4504, 'João Silva', 'Rua A, 123', '12345-678', 'Centro'),
(2222, 'F', 5200, 'Maria Oliveira', 'Rua B, 456', '23456-789', 'Bela Vista'),
(3333, 'M', 4750, 'Carlos Souza', 'Rua C, 789', '34567-890', 'Vila Nova'),
(4444, 'F', 6000, 'Ana Pereira', 'Rua D, 101', '45678-901', 'Jardim das Flores'),
(5555, 'M', 3800, 'Pedro Lima', 'Rua E, 202', '56789-012', 'Parque Industrial'),
(6666, 'F', 5500, 'Lucia Gomes', 'Rua F, 303', '67890-123', 'Morada do Sol'),
(7777, 'M', 4100, 'Ricardo Alves', 'Rua G, 404', '78901-234', 'Jardim América'),
(8888, 'F', 3900, 'Fernanda Costa', 'Rua H, 505', '89012-345', 'Alto da Glória'),
(9999, 'M', 4300, 'Eduardo Ribeiro', 'Rua I, 606', '90123-456', 'Santa Cecília'),
(1010, 'F', 4600, 'Patrícia Mendes', 'Rua J, 707', '01234-567', 'Centro Histórico'),
(1112, 'M', 4200, 'Gustavo Neves', 'Rua K, 808', '12345-678', 'Jardim Paulista'),
(1212, 'F', 4400, 'Camila Ferreira', 'Rua L, 909', '23456-789', 'Vila Mariana'),
(1313, 'M', 4000, 'Felipe Carvalho', 'Rua M, 101', '34567-890', 'Moema'),
(1414, 'F', 3700, 'Juliana Lima', 'Rua N, 202', '45678-901', 'Tatuapé'),
(1515, 'M', 3800, 'Vinícius Barbosa', 'Rua O, 303', '56789-012', 'Pinheiros'),
(1616, 'F', 4500, 'Isabela Rocha', 'Rua P, 404', '67890-123', 'Vila Madalena'),
(1717, 'M', 4700, 'Thiago Martins', 'Rua X, 100', '98765-432', 'Jardim Europa'),
(1818, 'F', 4900, 'Gabriela Souza', 'Rua Y, 200', '87654-321', 'Vila Nova'),
(1919, 'M', 4500, 'Rodrigo Almeida', 'Rua Z, 300', '76543-210', 'Centro Histórico'),
(2020, 'M', 7000, 'Dr. Roberto Costa', 'Rua X, 123', '12345-678', 'Centro'),
(2021, 'F', 6800, 'Dra. Ana Martins', 'Rua Y, 234', '23456-789', 'Vila Olímpia'),
(2022, 'M', 6900, 'Dr. Felipe Almeida', 'Rua Z, 345', '34567-890', 'Jardim das Flores'),
(2023, 'F', 7200, 'Dra. Beatriz Lima', 'Rua W, 456', '45678-901', 'Vila Mariana'),
(2024, 'M', 7100, 'Dr. Lucas Ferreira', 'Rua V, 567', '56789-012', 'Bela Vista'),
(2232, 'M', 4800, 'Lucas Andrade', 'Rua Q, 212', '98765-432', 'Centro'),
(2323, 'F', 5000, 'Ana Costa', 'Rua R, 323', '87654-321', 'Jardim das Flores'),
(2424, 'M', 4900, 'Roberto Lima', 'Rua S, 434', '76543-210', 'Vila Nova'),
(2525, 'F', 5100, 'Juliana Almeida', 'Rua T, 545', '65432-109', 'Bela Vista'),
(2626, 'M', 4700, 'Felipe Pereira', 'Rua U, 656', '54321-098', 'Alto da Glória');

-- Inserções na tabela Porteiro
INSERT INTO Porteiro (ID_Unico, Portaria_Entrada, Turno)
VALUES
(1111, 'Portaria Principal', 'Noturno'),
(2222, 'Portaria Secundária', 'Diurno'),
(3333, 'Portaria Emergencial', 'Diurno');

-- Inserções na tabela Administracao
INSERT INTO Administracao (ID_Unico, Usuario, Senha)
VALUES 
(4444, 'ana.pereira', 'senhaSegura123'),
(5555, 'pedro.lima', 'senhaForte456'),
(6666, 'lucia.gomes', 'senhaConfidencial789');

-- Inserções na tabela Secretario com funcionários diferentes dos já usados
INSERT INTO Secretario (ID_Unico, UsuarioSec, SenhaSec)
VALUES
(7777, 'marcos.oliveira', 'senhaMarcosOliveira404'),
(8888, 'fernanda.costa', 'senhafernanda404');
;

INSERT INTO PermissoesSec (Permissoes, UsuarioSec, SenhaSec)
VALUES 
('Acessar registros médicos', 'marcos.oliveira', 'senhaMarcosOliveira404'),
('Gerar relatórios de consultas', 'fernanda.costa', 'senhafernanda404');

-- Inserções na tabela Diretor
INSERT INTO Diretor (ID_Unico, UsuarioDir, SenhaDir)
VALUES 
(1212, 'camila.ferreira', 'senhaCamilaFerreira909'),
(1313, 'felipe.carvalho', 'senhaFelipeCarvalho101'),
(1414, 'juliana.lima', 'senhaJulianaLima202');

-- Inserções na tabela Enfermeiro
INSERT INTO Enfermeiro (ID_Unico, CRE, IDEnfChefe)
VALUES 
(1515, 'CRE123456', 1515), 
(1616, 'CRE654321', 1515);

INSERT INTO Enfermeiro_Chefe (ID_Unico)
VALUES (1515);

-- Inserções de plantões 
INSERT INTO PlantoesEnf (Plantoes, Data, Hora_Inicio, Hora_Termino, ID_Unico)
VALUES 
('Plantão Noturno', '2024-09-20', '20:00:00', '08:00:00', 1515),
('Plantão Diurno', '2024-09-22', '08:00:00', '20:00:00', 1515),
('Plantão Diurno', '2024-09-21', '08:00:00', '20:00:00', 1616),
('Plantão Noturno', '2024-09-23', '20:00:00', '08:00:00', 1616);

INSERT INTO Paciente (CPF, Nome, Sexo, Bairro, CEP, Logradouro, ID_Secretario, Datacadastro)
VALUES
('12345678901', 'João Paulo', 'M', 'Centro', '12345-678', 'Rua A, 100', 7777,'2024-09-25'),
('98765432109', 'Ana Carolina', 'F', 'Bela Vista', '23456-789', 'Rua B, 200', 8888,'2024-09-19'),
('45678901234', 'Carlos Alberto', 'M', 'Vila Nova', '34567-890', 'Rua C, 300', 7777, '2024-09-17'),
('78901234567', 'Maria Fernanda', 'F', 'Jardim América', '45678-901', 'Rua D, 400', 8888, '2024-09-15'),
('56789012345', 'Bruno Henrique', 'M', 'Parque Industrial', '56789-012', 'Rua E, 500', 7777,'2024-09-05');

-- Inserções na tabela Departamento
INSERT INTO Departamento (Codigodep, Nome, Especialidade)
VALUES
(1, 'Cardiologia', 'Tratamento de doenças do coração e sistema cardiovascular'),
(2, 'Neurologia', 'Tratamento de doenças do sistema nervoso'),
(3, 'Ortopedia', 'Tratamento de doenças e lesões do sistema musculoesquelético'),
(4, 'Pediatria', 'Tratamento de doenças e condições de crianças'),
(5, 'Oncologia', 'Tratamento de câncer e tumores');

-- Inserções na tabela Medico
INSERT INTO Medico (ID_Unico, CRM, IDSupervisor, CodDep)
VALUES
(2020, 'CRM123456', 2020, 1), 
(2021, 'CRM234567', 2020, 2), 
(2022, 'CRM345678', 2024, 3),
(2023, 'CRM456789', 2022, 4),
(2024, 'CRM567890', 2024, 5);

-- Inserções na tabela PlantoesMed
INSERT INTO PlantoesMed (Plantoes, Data, Hora_Inicio, Hora_Termino, ID_Unico)
VALUES
('Plantão Regular', '2024-09-25', '08:00:00', '16:00:00', 2020),
('Plantão Noturno', '2024-09-26', '20:00:00', '04:00:00', 2020),
('Plantão Emergencial', '2024-09-27', '08:00:00', '16:00:00', 2021),
('Plantão Regular', '2024-09-28', '08:00:00', '16:00:00', 2021),
('Plantão Noturno', '2024-09-29', '20:00:00', '04:00:00', 2022),
('Plantão Regular', '2024-09-30', '08:00:00', '16:00:00', 2022),
('Plantão Emergencial', '2024-10-01', '08:00:00', '16:00:00', 2023),
('Plantão Regular', '2024-10-02', '08:00:00', '16:00:00', 2023),
('Plantão Noturno', '2024-10-03', '20:00:00', '04:00:00', 2024),
('Plantão Regular', '2024-10-04', '08:00:00', '16:00:00', 2024);

-- Inserções na tabela AlergiaPaciente
INSERT INTO AlergiaPaciente (Alergia, CPF)
VALUES
('Penicilina', '12345678901'),
('Látex', '23456789012'),
('Amendoim', '34567890123'),
('Poeira', '45678901234'),
('Pelo de Animal', '56789012345');

-- Inserções na tabela Visitante
INSERT INTO Visitante (CPF, Nome, Datanascimento)
VALUES
('23456789012', 'Mariana Lima', '2011-10-22'),
('34567890123', 'Fernando Costa', '1976-02-03'),
('45678901234', 'Patrícia Almeida', '1974-09-24'),
('56789012345', 'Thiago Martins', '2002-03-26'),
('67890123456', 'Camila Rocha', '2003-02-27');


-- Inserções na tabela Farmacêutico
INSERT INTO Farmaceutico (ID_Unico, CRF, Area)
VALUES
(2222, 'CRF54321', 'Clínica Geral'),
(2323, 'CRF98765', 'Oncologia'),
(2424, 'CRF33445', 'Pediatria'),
(2525, 'CRF55667', 'Cardiologia'),
(2626, 'CRF77889', 'Dermatologia');

-- Inserções na tabela Remédio
INSERT INTO Remedio (NRM, Nome)
VALUES
(1001, 'Paracetamol'),
(1002, 'Ibuprofeno'),
(1003, 'Amoxicilina'),
(1004, 'Losartana'),
(1005, 'Dipirona');

-- Inserções na tabela Consulta
INSERT INTO Consulta (IDMed, CPFPac, Consultorio, Hora, DataConsulta)
VALUES
(2020, '12345678901', 'Consultório 1', '09:00:00','2024-03-25'),
(2020, '9876543210', 'Consultório 2', '11:00:00', '2024-09-27'),
(2022, '12345678901', 'Consultório 3', '14:00:00', '2024-09-22'),
(2022, '98765432100', 'Consultório 4', '16:00:00','2024-08-25');

-- Inserir cirurgias relacionadas à consulta com IDMed 2020 e 2022
INSERT INTO Cirurgia (IDMedCons, CPFPacCons, Codigo, Nome, Duracao, Hora_Inicio, Hora_Termino)
VALUES
(2020, '12345678901', 301, 'Cirurgia de Apendicite', '01:30:00', '08:00:00', '09:30:00'),
(2022, '98765432100', 302, 'Cirurgia de Catarata', '02:00:00', '10:00:00', '12:00:00');

-- Inserir autorizações
INSERT INTO Autoriza (PorteiroID, FuncionarioID, Dataautoriza, Horaautoriza)
VALUES
(1111, 1717,'2024-09-25','08:30:00'),
(2222, 1818,'2024-09-25','12:30:00'),
(3333, 1919,'2024-09-25','03:50:00'),
(1111, 2020, '2024-09-25','01:45:00'),
(2222, 2022, '2024-09-25','10:30:00');

-- Inserir visitas
INSERT INTO Visita (CPFVis, CPFPac)
VALUES
('23456789012', '12345678901'), 
('34567890123', '98765432109'),
('45678901234', '45678901234'), 
('56789012345', '78901234567'), 
('67890123456', '56789012345');

-- Inserir cuidados de enfermeiros com pacientes
INSERT INTO Cuida (IDEnf, CPFPac)
VALUES
(1515, '12345678901'), 
(1515, '45678901234'), 
(1616, '78901234567'),
(1616, '56789012345');

-- Inserir fornecimento de remédios
INSERT INTO Fornece (NRMRem, IDEnf, IDFarm)
VALUES
(1, 1515, 2222),  
(2, 1515, 2222), 
(3, 1616, 2323),  
(4, 1616, 2323); 

-- Inserir dados na tabela Reporta
INSERT INTO Reporta ( IDDir, IDEnfChefe, IDMed)
VALUES
(1212, 1515, 2020), 
(1313, 1515, 2022); 