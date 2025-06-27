# 🥦 Organic Food App

Aplicativo mobile para entrega de comida orgânica, com API backend em Django e frontend mobile desenvolvido em Flutter. Este projeto foi desenvolvido como parte de um trabalho acadêmico.

---

## 📄 Descrição

O objetivo do projeto é oferecer uma solução prática e moderna para conectar produtores e consumidores de alimentos orgânicos. A aplicação permite a visualização de produtos, cadastro de pedidos e integração com um painel administrativo.

📘 Artigo acadêmico:  
📦 Um_Aplicativo_Mobile_para_entrega_de_comida_organica.zip

---

## 🧰 Tecnologias Utilizadas

### 🔧 Backend (API)
- Python 3.9+
- Django 4.x
- Django REST Framework
- SQLite (banco de dados local)
- JWT (autenticação)
- pip (gerenciador de pacotes)

### 📱 Frontend Mobile
- Flutter 3+
- Dart
- HTTP Client
- Provider (gerenciamento de estado)

---

## 🚀 Como Executar o Backend (Django)

Acesse a pasta do backend:

```bash
cd back
```

Crie um ambiente virtual (opcional, mas recomendado):

Linux/macOS:
```bash
python -m venv venv
source venv/bin/activate
```

Windows:
```bash
python -m venv venv
venv\Scripts\activate
```

Instale as dependências:

```bash
pip install -r requirements.txt
```

Inicie o servidor Django:

```bash
python manage.py runserver
```

O servidor estará disponível em: http://127.0.0.1:8000/

---

## 📲 Como Executar o App Flutter (opcional)

Acesse a pasta do app:

```bash
cd flutter_app
```

Instale os pacotes do Flutter:

```bash
flutter pub get
```

Conecte um emululador ou dispositivo físico e execute o aplicativo:

```bash
flutter run
```

---

## 🗃️ Banco de Dados

Para que o backend funcione com os dados corretos, baixe o arquivo do banco de dados no link abaixo:

🔗 [Download do banco de dados (MEGA)](https://mega.nz/file/57ZixIKb#WRaHmc5jcSLVO7XiPlsJ5d2A21TU5mRhHgk-MvqJONA)

Após o download, coloque o arquivo no local indicado no arquivo settings.py (por padrão, pode ser na raiz do projeto ou pasta db/).

---

## 📁 Estrutura Sugerida do Projeto

```
Organic_Food_app/
├── back/                   # Backend Django
│   ├── manage.py
│   ├── app/                # Aplicação principal
│   ├── db.sqlite3          # Banco de dados (após restauração)
│   └── requirements.txt
├── flutter_app/            # Aplicativo Flutter (se incluso)
├── Um_Aplicativo_Mobile_para_entrega_de_comida_organica.zip
└── README.md
```

## 📬 Contato

Gabriel Oliveira Moura Lima  
📧 gabrieloliveiramouralima2001@gmail.com  
🔗 GitHub: [Gabriel-O-M-L](https://github.com/Gabriel-O-M-L)

---

📝 Este projeto foi desenvolvido para fins acadêmicos e pode servir como base para soluções reais voltadas ao consumo consciente, e-commerce local e sustentabilidade.

⭐ Se este projeto foi útil, deixe uma estrela no repositório!
