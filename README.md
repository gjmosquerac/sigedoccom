# insta-automation

Proyecto **insta-automation**: automatización de generación y envío de reportes.
- Backend: Laravel
- Listener Node: node-whatsapp (recibe archivos base64)
- Storage: storage/app/public (reportes públicos)

## Desarrollo local
1. `composer install`
2. `npm install`
3. `cp .env.example .env && php artisan key:generate`
4. `php artisan migrate --force`
5. `php artisan storage:link`
6. `npm run dev` o `php artisan serve`

## Listener Node
- Archivo: `node-whatsapp/server.js`
- Carpeta recibidos: `node-whatsapp/received`
- URL por defecto: `http://localhost:3000`

