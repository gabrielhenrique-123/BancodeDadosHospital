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
        rows = db.fetchall()
        if rows:
            print("Funcionários cadastrados:")
            for row in rows:
                print(row)
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

# Menu interativo
def menu():
    while True:
        print("\nSistema de Gerenciamento de Hospital")
        print("1. Criar tabelas")
        print("2. Adicionar funcionário")
        print("3. Consultar funcionários")
        print("4. Atualizar salário de funcionário")
        print("5. Deletar visitante")
        print("6. Sair")
        
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