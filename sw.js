// Service Worker — Visitas LM Consig
const CACHE = 'visitas-v1';
const ASSETS = ['./index.html', './manifest.json'];

// Instala e faz cache dos assets principais
self.addEventListener('install', e => {
  e.waitUntil(caches.open(CACHE).then(c => c.addAll(ASSETS)));
  self.skipWaiting();
});

// Ativa e limpa caches antigos
self.addEventListener('activate', e => {
  e.waitUntil(
    caches.keys().then(keys =>
      Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)))
    )
  );
  self.clients.claim();
});

// Intercepta requisições: serve cache se offline
self.addEventListener('fetch', e => {
  // Não intercepta chamadas Supabase/Google — sempre precisa de rede
  if (e.request.url.includes('supabase.co') ||
      e.request.url.includes('googleapis.com')) return;

  e.respondWith(
    fetch(e.request).catch(() => caches.match(e.request))
  );
});

// Mantém o SW "vivo" com um ping periódico para ajudar no background
self.addEventListener('message', e => {
  if (e.data === 'ping') e.ports[0]?.postMessage('pong');
});
