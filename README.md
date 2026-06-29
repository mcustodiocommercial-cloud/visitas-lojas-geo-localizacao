# 📍 Sistema de Visitas de Lojas

Ferramenta web para marcar visitas a lojas clientes usando geolocalização do celular.

---

## 🚀 Configuração passo a passo

### PASSO 1 — Criar conta no Supabase (banco de dados)

1. Acesse **https://app.supabase.com** e crie uma conta gratuita
2. Clique em **"New Project"**
3. Dê um nome (ex: `visitas-lojas`), escolha uma senha e selecione a região **South America (São Paulo)**
4. Aguarde o projeto ser criado (~1 min)

### PASSO 2 — Criar as tabelas no Supabase

1. No painel do Supabase, clique em **SQL Editor** (ícone de banco no menu lateral)
2. Clique em **"New query"**
3. Copie todo o conteúdo do arquivo `supabase_schema.sql` e cole no editor
4. Clique em **"Run"** (ou Ctrl+Enter)
5. Você deve ver "Success. No rows returned" — as tabelas foram criadas!

### PASSO 3 — Pegar as credenciais do Supabase

1. No painel do Supabase, vá em **Settings → API**
2. Copie:
   - **Project URL** (ex: `https://abcxyz.supabase.co`)
   - **anon public key** (chave longa começando com `eyJ...`)

### PASSO 4 — Subir o código no GitHub

1. Crie uma conta em **https://github.com** (se não tiver)
2. Clique em **"New repository"**
   - Nome: `visitas-lojas`
   - Visibilidade: Privado (recomendado) ou Público
3. Faça upload dos arquivos:
   - `index.html`
   - `netlify.toml`
   - `supabase_schema.sql`
   - `README.md`
4. Commit: **"Primeiro commit"**

### PASSO 5 — Publicar no Netlify

1. Acesse **https://netlify.com** e crie uma conta gratuita
2. Clique em **"Add new site" → "Import an existing project"**
3. Conecte com GitHub e selecione o repositório `visitas-lojas`
4. Configurações de build:
   - **Build command**: (deixe vazio)
   - **Publish directory**: `.` (ponto)
5. Clique em **"Deploy site"**
6. Aguarde o deploy (30 segundos) — você receberá uma URL como `https://seu-site.netlify.app`

### PASSO 6 — Primeira configuração do site

1. Acesse a URL do Netlify no celular
2. O site pedirá as credenciais do Supabase — cole a URL e a chave anon
3. Clique em **"Conectar"**
4. Pronto!

### PASSO 7 — Importar suas lojas

1. Vá na aba **⚙️ Painel**
2. Clique na área de upload ou arraste o arquivo `.xlsx` com as lojas
3. Confirme a importação
4. As lojas aparecerão na aba **🗺️ Rotas**

---

## 📱 Como usar no dia a dia

1. Abra o site no celular
2. Aba **Rotas** mostra todas as lojas do dia
3. Filtre por Zona (Leste, Norte, etc.)
4. Ao chegar em uma loja, clique **📍 Marcar**
5. O celular pedirá permissão de localização — aceite
6. A loja ficará marcada como visitada com o horário
7. No final do dia, confira o **Histórico**

---

## 🔄 Atualizações futuras (possível expansão)

- Login por usuário (múltiplos vendedores)
- Mapa visual com pins
- Relatório exportável por período
- Notificações de lojas não visitadas
- Geocodificação automática dos endereços

---

## 📁 Estrutura de arquivos

```
visitas-lojas/
├── index.html          ← Site completo (app)
├── netlify.toml        ← Configuração do Netlify
├── supabase_schema.sql ← SQL para criar as tabelas
└── README.md           ← Este guia
```

---

## ❓ Problemas comuns

**"Erro ao carregar lojas"** → Verifique se executou o SQL no Supabase corretamente

**"Ative a localização"** → Acesse pelo HTTPS (Netlify já fornece isso) e permita localização no browser do celular

**Lojas não aparecem após upload** → Verifique se o arquivo tem a coluna "NOME DA LOJA" ou "nome_loja"
