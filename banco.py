import sqlite3

# Conecte ao banco de dados
connection = sqlite3.connect('hospital.db')
db = connection.cursor()

# Função para criar as tabelas (executar o script SQL)
def criar_tabelas():
    try:
        with open('tables.sql', 'r') as f:
            db.executescript(f.read())
        connection.commit()
        print("Tabelas criadas com sucesso!")
    except Exception as e:
        print(f"Erro ao criar tabelas: {e}")

# Função para consultar todos os funcionários
def consultar_funcionarios():
    try:
        db.execute("SELECT * FROM Funcionario")
        row = db.fetchall()
        if row:
            print("Funcionários cadastrados:")
            for row in row:
                print(f"ID : {row[0]}, Nome : {row[3]}, Sexo : {row[1]}, Salário  : {row[2]}, Logradouro : {row[4]}, CEP : {row[5]}, Bairro : {row[6]}" )
        else:
            print("Nenhum funcionário cadastrado.")
    except Exception as e:
        print(f"Erro ao consultar funcionários: {e}")

# Função para atualizar salário de um funcionário
def atualizar_salario():
    try:
        id_unico = input("Digite o ID único do funcionário: ")
        novo_salario = float(input("Digite o novo salário: "))
        db.execute("UPDATE Funcionario SET Salario = ? WHERE ID_Unico = ?", (novo_salario, id_unico))
        connection.commit()
        if db.rowcount:
            print(f"Salário do funcionário {id_unico} atualizado com sucesso.")
        else:
            print(f"Funcionário com ID {id_unico} não encontrado.")
    except Exception as e:
        print(f"Erro ao atualizar salário: {e}")

def atualizar_porteiro():
    try:
        id_unico = input("Digite o ID único do porteiro: ")
        Portaria_Entrada= input("Digite a nova Portaria: ")
        Turno = input("Digite o novo Turno: ")
        db.execute("UPDATE Porteiro SET Portaria_Entrada = ?, Turno = ?  WHERE ID_Unico = ?", (Portaria_Entrada, Turno, id_unico))
        connection.commit()
        if db.rowcount:
            print(f"Porteiro {id_unico} atualizado com sucesso.")
        else:
            print(f"Porteiro {id_unico} não encontrado.")
    except Exception as e:
        print(f"Erro ao atualizar Porteiro: {e}")

        
def consultar_visitante():
    try:
        db.execute("SELECT * FROM Visitante")
        row = db.fetchall()
        if row:
            print("Visitantes cadastrados:")
            for row in row:
                print(f"CPF: {row[0]}, Nome : {row[1]}, Idade : {row[2]}" )
        else:
            print("Nenhum Visitante cadastrado.")
    except Exception as e:
        print(f"Erro ao consultar Visitantes: {e}")

def consultar_paciente():
    try:
        db.execute("SELECT * FROM Paciente")
        row = db.fetchall()
        if row:
            print("Pacientes cadastrados:")
            for row in row:
                print(f"CPF : {row[0]}, Nome : {row[1]}, Sexo : {row[2]},   Bairro : {row[3]}, CEP : {row[4]}, Logradouro : {row[4]} ID_secretario  : {row[5]},, ," )
        else:
            print("Nenhum Paciente cadastrado.")
    except Exception as e:
        print(f"Erro ao consultar Pacientes: {e}")

# Função para deletar um visitante
def deletar_visitante():
    try:
        cpf = input("Digite o CPF do visitante a ser removido: ")
        db.execute("DELETE FROM Visitante WHERE CPF = ?", (cpf,))
        connection.commit()
        if db.rowcount:
            print(f"Visitante com CPF {cpf} removido com sucesso.")
        else:
            print(f"Visitante com CPF {cpf} não encontrado.")
    except Exception as e:
        print(f"Erro ao deletar visitante: {e}")

# Função para consultar um funcionário específico e exibir os dados de forma organizada
def consultar_funcionario_por_id():
    try:
        id_unico = input("Digite o ID único do funcionário: ")
        db.execute("SELECT * FROM Funcionario WHERE ID_Unico = ?", (id_unico,))
        row = db.fetchone()

        if row:
            # Formatando a saída dos dados de maneira mais amigável
            print(f" ID         : {row[0]}\n Nome       : {row[3]}\n Sexo       : {row[1]}\n Salário    : {row[2]}\n Logradouro : {row[4]}\n CEP        : {row[5]}\n Bairro     : {row[6]}" )
        else:
            print(f"Funcionário com ID {id_unico} não encontrado.")
    except Exception as e:
        print(f"Erro ao consultar o funcionário: {e}")

# Exemplo de chamada da função


# Função para adicionar um novo funcionário
def adicionar_funcionario():
    try:
        id_unico = input("Digite o ID único do funcionário: ")
        sexo = input("Digite o sexo do funcionário (M/F): ").upper()
        salario = float(input("Digite o salário do funcionário: "))
        nome = input("Digite o nome do funcionário: ")
        logradouro = input("Digite o logradouro do funcionário: ")
        cep = input("Digite o CEP do funcionário: ")
        bairro = input("Digite o bairro do funcionário: ")

        # Comando SQL para inserir os dados
        db.execute("""
            INSERT INTO Funcionario (ID_Unico, Sexo, Salario, Nome, Logradouro, CEP, Bairro)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        """, (id_unico, sexo, salario, nome, logradouro, cep, bairro))

        # Confirmar as mudanças no banco de dados
        connection.commit()
        print(f"Funcionário {nome} adicionado com sucesso!")
    except Exception as e:
        print(f"Erro ao adicionar o funcionário: {e}")

def adicionar_fornecimento():
    try:
        NMRrem = input("Digite NRM do remedio especifico: ")
        IDEnf = input("Digite o ID do enfermeiro a receber): ")
        IDFarm= input("Digite o ID do farmaceutico a fornecer: ")
      

        # Comando SQL para inserir os dados
        db.execute("""
            INSERT INTO Fornece (NRMRem, IDEnf, IDFarm)
                 VALUES (?, ?, ?)
        """, (NMRrem, IDEnf, IDFarm))
         # Confirmar as mudanças no banco de dados
        connection.commit()
        print(f"Fornecimento adicionado com sucesso!")
    except Exception as e:
        print(f"Erro ao adicionar o fornecimento: {e}")


# Menu interativo
def menu():
    while True:
        print("\nSistema de Gerenciamento de Hospital")
        print("1. Criar tabelas")
        print("2. Adicionar funcionário")
        print("3. Consultar funcionários")
        print("4. Atualizar salário de funcionário")
        print("5. Deletar visitante")
        print("6. Consultar Visitantes")
        print("7. Consultar funcionario especifico")
        print("8. Consultar Pacientes")
        print("9. Adicionar fornecimento")
        print("10. Atualiza porteiro")
        print("11. Sair")
        
        escolha = input("Escolha uma opção: ")

        if escolha == '1':
            criar_tabelas()
        elif escolha == '2':
            adicionar_funcionario()
        elif escolha == '3':
            consultar_funcionarios()
        elif escolha == '4':
            atualizar_salario()
        elif escolha == '5':
            deletar_visitante()
        elif escolha == '6':
            consultar_visitante()
        elif escolha == '7':
            consultar_funcionario_por_id()
        elif escolha == '8':
            consultar_paciente()    
        elif escolha == '9':
            adicionar_fornecimento()
        elif escolha == '10':
            atualizar_porteiro()
        elif escolha == '11':
            fechar_conexao()
            break
        else:
            print("Opção inválida! Tente novamente.")

# Fechar conexão ao final
def fechar_conexao():
    db.close()
    connection.close()
    print("Conexão com o banco de dados encerrada.")

# Início do programa
if __name__ == "__main__":
    menu()