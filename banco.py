import sqlite3

# Conecte ao banco de dados
connection = sqlite3.connect('hospital.db')
db = connection.cursor()

# Exemplo: Consulta todos os funcionários
def consultar_funcionarios():
    db.execute("SELECT * FROM Funcionario")
    rows = db.fetchall()
    for row in rows:
        print(row)

# Exemplo: Atualiza salário de um funcionário
def atualizar_salario(id_unico, novo_salario):
    db.execute("UPDATE Funcionario SET Salario = ? WHERE ID_Unico = ?", (novo_salario, id_unico))
    connection.commit()
    print(f"Salário atualizado para o funcionário {id_unico}")

# Exemplo: Deleta um visitante
def deletar_visitante(cpf):
    db.execute("DELETE FROM Visitante WHERE CPF = ?", (cpf,))
    connection.commit()
    print(f"Visitante com CPF {cpf} foi removido.")

def adicionar_funcionarios():
    try:
        # Solicita os dados do funcionário ao usuário
        id_unico = input("Digite o ID único do funcionário: ")
        sexo = input("Digite o sexo do funcionário (M/F): ")
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
        print(f"Ocorreu um erro ao adicionar o funcionário: {e}")

# Fechar conexão ao final (não esquecer de chamar ao finalizar o uso do banco)
def fechar_conexao():
    db.close()
    connection.close()

# Exemplo de uso:
adicionar_funcionarios()
fechar_conexao()
