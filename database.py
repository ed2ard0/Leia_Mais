import mysql.connector
from datetime import date

class BibliotecaDB:
    def __init__(self, host, user, password, database="biblioteca"):
        self.conn = mysql.connector.connect(
            host=host, 
            user=user, 
            password=password, 
            database=database, 
            port=3306
        )
        self.cursor = self.conn.cursor(dictionary=True)

    def fechar_conexao(self):
        if self.conn.is_connected():
            self.cursor.close()
            self.conn.close()

    # --- Usuários ---
    def registrar_usuario(self, nome, email, telefone):
        try:
            query = "INSERT INTO tbl_usuarios (nome_usuario, email_usuario, telefone_usuario) VALUES (%s, %s, %s)"
            self.cursor.execute(query, (nome, email, telefone))
            self.conn.commit()
            return True, f"Usuário {nome} cadastrado com sucesso."
        except Exception as e:
            return False, str(e)

    def listar_usuarios(self):
        self.cursor.execute("SELECT * FROM tbl_usuarios")
        return self.cursor.fetchall()

    def get_usuario(self, id_usuario):
        self.cursor.execute("SELECT * FROM tbl_usuarios WHERE id_usuario = %s", (id_usuario,))
        return self.cursor.fetchone()

    def editar_usuario(self, id_usuario, nome, email, telefone):
        try:
            query = "UPDATE tbl_usuarios SET nome_usuario=%s, email_usuario=%s, telefone_usuario=%s WHERE id_usuario=%s"
            self.cursor.execute(query, (nome, email, telefone, id_usuario))
            self.conn.commit()
            return True, "Cadastro atualizado."
        except Exception as e:
            return False, str(e)

    def apagar_usuario(self, id_usuario):
        try:
            self.cursor.execute("DELETE FROM tbl_usuarios WHERE id_usuario = %s", (id_usuario,))
            self.conn.commit()
            return True, "Usuário removido."
        except Exception as e:
            return False, str(e)

    # --- Livros ---
    def registrar_livro(self, titulo, autor, categoria, copias):
        try:
            query = "INSERT INTO tbl_livros (titulo_livro, autor_livro, categoria_livro, copias_disponiveis_livro) VALUES (%s, %s, %s, %s)"
            self.cursor.execute(query, (titulo, autor, categoria, copias))
            self.conn.commit()
            return True, "Livro adicionado ao acervo."
        except Exception as e:
            return False, str(e)

    def buscar_livros(self, termo=""):
        if termo:
            query = "SELECT * FROM tbl_livros WHERE titulo_livro LIKE %s OR autor_livro LIKE %s OR categoria_livro LIKE %s"
            busca = f"%{termo}%"
            self.cursor.execute(query, (busca, busca, busca))
        else:
            self.cursor.execute("SELECT * FROM tbl_livros")
        return self.cursor.fetchall()

    def get_livro(self, id_livro):
        self.cursor.execute("SELECT * FROM tbl_livros WHERE id_livro = %s", (id_livro,))
        return self.cursor.fetchone()

    def editar_livro(self, id_livro, titulo, autor, categoria, copias):
        try:
            query = "UPDATE tbl_livros SET titulo_livro=%s, autor_livro=%s, categoria_livro=%s, copias_disponiveis_livro=%s WHERE id_livro=%s"
            self.cursor.execute(query, (titulo, autor, categoria, copias, id_livro))
            self.conn.commit()
            return True, "Acervo atualizado."
        except Exception as e:
            return False, str(e)

    def apagar_livro(self, id_livro):
        try:
            self.cursor.execute("DELETE FROM tbl_livros WHERE id_livro = %s", (id_livro,))
            self.conn.commit()
            return True, "Livro removido."
        except Exception as e:
            return False, str(e)

    # --- Operações de Empréstimo ---
    def realizar_emprestimo(self, id_usuario, id_livro):
        try:
            self.cursor.execute("SELECT copias_disponiveis_livro FROM tbl_livros WHERE id_livro = %s", (id_livro,))
            livro = self.cursor.fetchone()
            
            if not livro:
                return False, "Livro não localizado."
                
            if livro['copias_disponiveis_livro'] > 0:
                query_emp = "INSERT INTO tbl_emprestimos (fk_id_usuario, fk_id_livro, data_emprestimo) VALUES (%s, %s, %s)"
                self.cursor.execute(query_emp, (id_usuario, id_livro, date.today()))
                
                query_estoque = "UPDATE tbl_livros SET copias_disponiveis_livro = copias_disponiveis_livro - 1 WHERE id_livro = %s"
                self.cursor.execute(query_estoque, (id_livro,))
                
                self.conn.commit()
                return True, "Empréstimo efetivado."
            
            return False, "Estoque esgotado para este título."
        except Exception as e:
            return False, str(e)

    def devolver_livro(self, id_emprestimo, id_livro):
        try:
            self.cursor.execute("UPDATE tbl_emprestimos SET data_devolucao_emprestimo = %s WHERE id_emprestimo = %s", (date.today(), id_emprestimo))
            self.cursor.execute("UPDATE tbl_livros SET copias_disponiveis_livro = copias_disponiveis_livro + 1 WHERE id_livro = %s", (id_livro,))
            self.conn.commit()
            return True, "Devolução registrada."
        except Exception as e:
            return False, str(e)

    def listar_emprestimos_ativos(self):
        query = """
            SELECT e.id_emprestimo, u.nome_usuario, l.titulo_livro, l.id_livro, e.data_emprestimo 
            FROM tbl_emprestimos e
            JOIN tbl_usuarios u ON e.fk_id_usuario = u.id_usuario
            JOIN tbl_livros l ON e.fk_id_livro = l.id_livro
            WHERE e.data_devolucao_emprestimo IS NULL
        """
        self.cursor.execute(query)
        return self.cursor.fetchall()

    def relatorio_mais_emprestados(self):
        query = """
            SELECT l.titulo_livro, COUNT(e.id_emprestimo) as total
            FROM tbl_emprestimos e
            JOIN tbl_livros l ON e.fk_id_livro = l.id_livro
            GROUP BY l.id_livro
            ORDER BY total DESC LIMIT 5
        """
        self.cursor.execute(query)
        return self.cursor.fetchall()