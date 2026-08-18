# Controle de Pacientes

App web local desenvolvido para psicólogos gerenciarem seus atendimentos de forma simples e organizada.
Roda no navegador (Safari, Chrome, Firefox) e os dados ficam salvos localmente no computador — sem necessidade de internet ou servidores externos.

## Visão Geral

Este projeto nasceu da necessidade de uma psicóloga recém-formada ter uma ferramenta prática para controlar seus pacientes, sessões e finanças sem depender de planilhas ou sistemas pagos.

### Principais Funcionalidades

- **Painel (Dashboard)** — Visão geral com pacientes ativos, sessões do mês, receita e valores pendentes
- **Cadastro de Pacientes** — Nome, contato, modalidade (presencial/online/híbrido), frequência, valor, status
- **Registro de Sessões** — Data, horário, presença, pagamento, numeração automática, anotações administrativas
- **Controle Financeiro** — Resumo mensal com receita recebida, valores pendentes e faltas
- **Busca e Filtros** — Busca por nome e filtros por status (ativo, pausado, alta, desistência)
- **Exportação** — Exporte pacientes e sessões em CSV ou Excel
- **Privacidade** — Oculte/exiba valores financeiros com um clique
- **Interface Responsiva** — Funciona bem em desktop e tablet

### Stack Tecnológica

| Componente | Tecnologia |
|-----------|-----------|
| Backend | Python 3 + Flask |
| Banco de Dados | SQLite (arquivo local) |
| Frontend | HTML5 + CSS3 + JavaScript (sem frameworks) |
| ORM | Flask-SQLAlchemy |
| Export Excel | openpyxl |

## Instalação

### Pré-requisitos

- Python 3.9 ou superior
- pip (gerenciador de pacotes Python)

### macOS

```bash
# 1. Clone o repositório
git clone https://github.com/PauloMoura81/controle-pacientes.git
cd controle-pacientes

# 2. Crie um ambiente virtual (recomendado)
python3 -m venv venv
source venv/bin/activate

# 3. Instale as dependências
pip install -r requirements.txt

# 4. Execute o app
python3 app.py
```

### Windows

```bash
# 1. Clone o repositório
git clone https://github.com/PauloMoura81/controle-pacientes.git
cd controle-pacientes

# 2. Crie um ambiente virtual (recomendado)
python -m venv venv
venv\Scripts\activate

# 3. Instale as dependências
pip install -r requirements.txt

# 4. Execute o app
python app.py
```

### Linux

```bash
git clone https://github.com/PauloMoura81/controle-pacientes.git
cd controle-pacientes
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python3 app.py
```

Após executar, acesse no navegador: **http://localhost:5000**

## Uso

### Iniciar o app

```bash
cd controle-pacientes
source venv/bin/activate   # macOS/Linux
python3 app.py
```

Para parar, pressione `Ctrl + C` no Terminal.

### Atalho rápido (macOS)

Dê duplo clique no arquivo `IniciarApp.command` para iniciar o app sem precisar abrir o Terminal manualmente.

### Onde ficam os dados?

Os dados são armazenados em `controle-pacientes/dados/pacientes.db` (arquivo SQLite).
Para fazer backup, basta copiar esse arquivo para outro local.

## Estrutura do Projeto

```
controle-pacientes/
├── app.py                  # Aplicação principal (rotas, modelos, lógica)
├── requirements.txt        # Dependências Python
├── IniciarApp.command      # Script de inicialização rápida (macOS)
├── README.md               # Este arquivo
├── static/
│   ├── css/
│   │   └── style.css       # Estilos da interface
│   └── js/
│       └── app.js          # JavaScript (ordenação, toggle, confirmações)
├── templates/
│   ├── base.html           # Template base (navbar, footer)
│   ├── index.html          # Dashboard
│   ├── pacientes.html      # Lista de pacientes (com busca)
│   ├── paciente_form.html  # Formulário cadastro/edição
│   ├── paciente_detalhe.html # Detalhe do paciente + sessões
│   ├── sessoes.html        # Lista de sessões
│   ├── sessao_form.html    # Formulário de sessão (com anotações)
│   ├── financeiro.html     # Resumo financeiro
│   └── exportar.html       # Página de exportação (CSV/Excel)
└── dados/                  # Criado automaticamente na primeira execução
    └── pacientes.db        # Banco de dados SQLite
```

## Screenshots

*(Em breve)*

## Changelog

### v1.1.0 (2026-08-18)

**Melhorias de Usabilidade e Cadastro**

- Ocultar/exibir valores financeiros (Receita e A Receber) com botão toggle — preferência salva no navegador
- Busca de pacientes por nome (parcial, case-insensitive)
- Ordenação de colunas nas tabelas (clique no cabeçalho para ordenar asc/desc)
- Confirmação antes de excluir pacientes e sessões
- Exportar dados para CSV e Excel (pacientes e sessões separadamente)
- Campo de anotações administrativas por sessão (sem conteúdo clínico)
- Adicionada opção "PsyMeet" no campo Convênio/Particular e nas formas de pagamento

#### Atualização da v1.0.0 para v1.1.0

Se você já tem o app rodando com dados da v1.0.0, siga estes passos para atualizar:

```bash
# 1. Pare o app (Ctrl+C no terminal)

# 2. Atualize o código
cd controle-pacientes
git pull

# 3. Ative o ambiente virtual
source venv/bin/activate        # macOS/Linux
# venv\Scripts\activate         # Windows

# 4. Instale as novas dependências (openpyxl)
pip install -r requirements.txt

# 5. Migre o banco de dados (adiciona a coluna 'anotacoes' à tabela de sessões)
python3 -c "from app import app, db; app.app_context().push(); db.create_all()"

# 6. Inicie o app normalmente
python3 app.py
```

> **Nota:** O comando `db.create_all()` no passo 5 adiciona a nova coluna `anotacoes` à tabela de sessões sem perder nenhum dado existente. Seus pacientes e sessões serão preservados. Recomenda-se fazer um backup do arquivo `dados/pacientes.db` antes de atualizar.

### v1.0.0 (2026-08-17)

**Lançamento inicial**

- Cadastro completo de pacientes (nome, contato, modalidade, frequência, valor, status)
- Registro de sessões com controle de presença e pagamento
- Numeração automática de sessões por paciente
- Dashboard com métricas do mês (pacientes ativos, sessões, receita, pendências)
- Resumo financeiro mensal
- Filtros por status de paciente
- Interface responsiva (desktop e tablet)
- Armazenamento local em SQLite
- Script de inicialização rápida para macOS

## Roadmap

### v1.2.0 — Integração Google Drive (Documentos Clínicos)

- [ ] Campo de link para Prontuário da Sessão (Google Drive) no registro de sessão
- [ ] Campo de link para Evolução do Paciente (Google Drive) no registro de sessão
- [ ] Abertura dos documentos diretamente pelo app (link externo)
- [ ] Validação de URLs do Google Drive
- [ ] Logging em arquivo para análise e troubleshooting (com rotação automática)

### v1.3.0 — Integração Gmail e Agendamento

- [ ] Integração com Gmail API para envio de e-mails
- [ ] Envio automático de confirmação de sessão por e-mail ao paciente
- [ ] Envio de lembrete de sessão (configurável: 24h antes, 1h antes)
- [ ] Template de e-mail personalizável (nome do paciente, data, horário, modalidade)
- [ ] Calendário visual com sessões agendadas
- [ ] Agendamento recorrente automático (baseado na frequência)
- [ ] Indicador visual de conflitos de horário
- [ ] Geração de recibos em PDF para pacientes

### v1.4.0 — Financeiro Avançado

- [ ] Gráficos de receita mensal (chart.js)
- [ ] Controle de despesas do consultório
- [ ] Relatório de inadimplência
- [ ] Previsão de receita baseada na agenda
- [ ] Filtro financeiro por período customizado

### v2.0.0 — Multi-dispositivo

- [ ] Autenticação com senha local
- [ ] Sincronização via arquivo (iCloud/Google Drive)
- [ ] Modo escuro (dark mode)
- [ ] PWA (Progressive Web App) — instalar como app no celular
- [ ] Backup automático programado

### Futuro (ideias)

- [ ] Integração com Google Calendar (sincronização bidirecional)
- [ ] Envio de lembretes por WhatsApp/SMS (via API)
- [ ] Dashboard com gráficos de evolução do consultório
- [ ] Suporte a múltiplos profissionais (clínica)
- [ ] Prontuário eletrônico simplificado (com criptografia)
- [ ] Importação de dados de planilhas Excel existentes
- [ ] Integração com Google Workspace (Docs, Sheets) para geração automática de documentos

## Contribuição

Contribuições são bem-vindas! Para contribuir:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/minha-feature`)
3. Commit suas mudanças (`git commit -m 'Adiciona minha feature'`)
4. Push para a branch (`git push origin feature/minha-feature`)
5. Abra um Pull Request

## Licença

Este projeto é de uso pessoal/educacional. Sinta-se livre para usar e adaptar.

## Autor

Desenvolvido por [Paulo Moura](https://github.com/PauloMoura81)
