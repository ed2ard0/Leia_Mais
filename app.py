from flask import Flask, render_template, request, redirect, flash
from database import BibliotecaDB

app = Flask(__name__)
app.secret_key = "sterling_dev_key"

db = BibliotecaDB(host="localhost", user="root", password="1234")

@app.route('/')
def index():
    termo = request.args.get('busca', '')
    
    context = {
        'livros': db.buscar_livros(termo),
        'usuarios': db.listar_usuarios(),
        'emprestimos': db.listar_emprestimos_ativos(),
        'top_livros': db.relatorio_mais_emprestados(),
        'termo_busca': termo
    }
    
    return render_template('index.html', **context)

@app.route('/cadastrar_livro', methods=['POST'])
def cadastrar_livro():
    data = request.form
    sucesso, msg = db.registrar_livro(data['titulo'], data['autor'], data['categoria'], int(data['copias']))
    flash(msg, 'success' if sucesso else 'error')
    return redirect('/')

@app.route('/cadastrar_usuario', methods=['POST'])
def cadastrar_usuario():
    data = request.form
    sucesso, msg = db.registrar_usuario(data['nome'], data['email'], data['telefone'])
    flash(msg, 'success' if sucesso else 'error')
    return redirect('/')

@app.route('/editar_livro/<int:id_livro>', methods=['GET', 'POST'])
def editar_livro(id_livro):
    if request.method == 'POST':
        data = request.form
        sucesso, msg = db.editar_livro(id_livro, data['titulo'], data['autor'], data['categoria'], int(data['copias']))
        flash(msg, 'success' if sucesso else 'error')
        return redirect('/')
    
    return render_template('editar.html', tipo='livro', dados=db.get_livro(id_livro))

@app.route('/editar_usuario/<int:id_usuario>', methods=['GET', 'POST'])
def editar_usuario(id_usuario):
    if request.method == 'POST':
        data = request.form
        sucesso, msg = db.editar_usuario(id_usuario, data['nome'], data['email'], data['telefone'])
        flash(msg, 'success' if sucesso else 'error')
        return redirect('/')
    
    return render_template('editar.html', tipo='usuario', dados=db.get_usuario(id_usuario))

@app.route('/apagar_livro/<int:id_livro>')
def apagar_livro(id_livro):
    sucesso, msg = db.apagar_livro(id_livro)
    flash(msg, 'success' if sucesso else 'error')
    return redirect('/')

@app.route('/apagar_usuario/<int:id_usuario>')
def apagar_usuario(id_usuario):
    sucesso, msg = db.apagar_usuario(id_usuario)
    flash(msg, 'success' if sucesso else 'error')
    return redirect('/')

@app.route('/emprestar', methods=['POST'])
def emprestar():
    sucesso, msg = db.realizar_emprestimo(request.form['id_usuario'], request.form['id_livro'])
    flash(msg, 'success' if sucesso else 'error')
    return redirect('/')

@app.route('/devolver/<int:id_emprestimo>/<int:id_livro>')
def devolver(id_emprestimo, id_livro):
    sucesso, msg = db.devolver_livro(id_emprestimo, id_livro)
    flash(msg, 'success' if sucesso else 'error')
    return redirect('/')

if __name__ == '__main__':
    app.run(debug=True)