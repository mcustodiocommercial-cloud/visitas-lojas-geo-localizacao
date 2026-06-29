-- ============================================
-- SCHEMA SUPABASE - SISTEMA DE VISITAS DE LOJAS
-- Execute este SQL no Supabase SQL Editor
-- ============================================

-- Tabela de lojas
CREATE TABLE IF NOT EXISTS lojas (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  dn TEXT NOT NULL,
  cnpj TEXT,
  nome_loja TEXT NOT NULL,
  gcm TEXT,
  nome_responsavel TEXT,
  logradouro TEXT,
  numero TEXT,
  bairro TEXT,
  cep TEXT,
  zona TEXT,
  latitude FLOAT,
  longitude FLOAT,
  ativa BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Tabela de visitas
CREATE TABLE IF NOT EXISTS visitas (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  loja_id UUID REFERENCES lojas(id) ON DELETE CASCADE,
  visitada_em TIMESTAMPTZ DEFAULT NOW(),
  latitude_visita FLOAT,
  longitude_visita FLOAT,
  distancia_metros FLOAT,
  observacao TEXT,
  usuario TEXT DEFAULT 'vendedor'
);

-- Índices para performance
CREATE INDEX IF NOT EXISTS idx_visitas_loja_id ON visitas(loja_id);
CREATE INDEX IF NOT EXISTS idx_visitas_data ON visitas(visitada_em);
CREATE INDEX IF NOT EXISTS idx_lojas_zona ON lojas(zona);

-- Habilitar RLS (Row Level Security) - modo permissivo para começar
ALTER TABLE lojas ENABLE ROW LEVEL SECURITY;
ALTER TABLE visitas ENABLE ROW LEVEL SECURITY;

-- Políticas permissivas (ajuste depois conforme necessário)
CREATE POLICY "Permitir tudo em lojas" ON lojas FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Permitir tudo em visitas" ON visitas FOR ALL USING (true) WITH CHECK (true);

-- View útil: visitas de hoje
CREATE OR REPLACE VIEW visitas_hoje AS
SELECT 
  l.id,
  l.dn,
  l.nome_loja,
  l.bairro,
  l.zona,
  l.logradouro,
  l.numero,
  l.cep,
  l.latitude,
  l.longitude,
  MAX(v.visitada_em) AS ultima_visita,
  COUNT(v.id) AS total_visitas_hoje,
  CASE WHEN COUNT(v.id) > 0 THEN true ELSE false END AS visitada_hoje
FROM lojas l
LEFT JOIN visitas v ON v.loja_id = l.id 
  AND DATE(v.visitada_em AT TIME ZONE 'America/Sao_Paulo') = CURRENT_DATE AT TIME ZONE 'America/Sao_Paulo'
WHERE l.ativa = true
GROUP BY l.id, l.dn, l.nome_loja, l.bairro, l.zona, l.logradouro, l.numero, l.cep, l.latitude, l.longitude;
