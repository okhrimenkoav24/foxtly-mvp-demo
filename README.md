# Foxtly MVP Demo

Кликабельный демо-прототип Foxtly: все 15 экранов клиентского пути (лендинг,
регистрация, онбординг, Decision Center, Knowledge Base, Integrations,
Campaign Strategy, Creative Studio, Approval Queue, Settings, Billing,
Campaigns, Leads, Reports) в одном HTML-файле, с локальным состоянием и
интерактивностью (модалки, чеклисты, approve/reject).

## Структура

- `index.html` — приложение целиком (HTML + CSS + JS, без внешних зависимостей).
- `404.html` — точная копия `index.html`.
- `build.sh` — пересобирает `404.html` из `index.html`.

### Зачем нужен `404.html`

GitHub Pages — статический хостинг без серверного роутинга. Чтобы у каждого
экрана был свой URL вида `/decision-center/`, `/reports/` и т.д. (а не один
URL с хэшем), приложение использует `history.pushState` и читает
`location.pathname` при загрузке (см. `ROUTE_MAP` в `index.html`).

Когда пользователь открывает `/decision-center/` напрямую (или обновляет
страницу), на сервере такого файла нет — GitHub Pages в этом случае отдаёт
`404.html`. Так как `404.html` — это та же самая SPA, JS-роутер сам
определяет нужный экран по URL и рендерит его. Поэтому **после любого
изменения `index.html` нужно прогнать `./build.sh`** и закоммитить оба файла.

## Маршруты (URL → экран)

| URL | Экран |
|---|---|
| `/` | Landing |
| `/signup/` | Sign up |
| `/verify-email/` | Verify email |
| `/onboarding/` | Onboarding wizard |
| `/decision-center/` | Decision Center |
| `/knowledge-base/` | Knowledge Base |
| `/integrations/` | Integrations |
| `/campaign-strategy/` | Campaign Strategy |
| `/creative-studio/` | Creative Studio |
| `/approvals/` | Approval Queue |
| `/settings/` | Settings |
| `/billing/` | Billing |
| `/campaigns/` | Campaigns |
| `/leads/` | Leads & CRM |
| `/reports/` | Reports |

Базовый путь (`BASE_PATH`, например `/foxtly-mvp-demo`) определяется
автоматически из `location.pathname` — отдельно настраивать ничего не нужно,
работает и на GitHub Pages (`username.github.io/repo-name/...`), и на
кастомном домене, и локально через `file://`.

## Деплой на GitHub Pages

1. Создай новый репозиторий на GitHub (например `foxtly-mvp-demo`), без
   README/`.gitignore` (они уже есть здесь).
2. В этой папке:
   ```bash
   git init
   git add .
   git commit -m "Foxtly MVP demo"
   git branch -M main
   git remote add origin https://github.com/<USERNAME>/<REPO>.git
   git push -u origin main
   ```
3. На GitHub: Settings → Pages → Source = "Deploy from a branch",
   Branch = `main`, папка `/ (root)` → Save.
4. Через 1-2 минуты сайт будет доступен по адресу
   `https://<USERNAME>.github.io/<REPO>/`, а каждый экран — по своему URL,
   например `https://<USERNAME>.github.io/<REPO>/decision-center/`.

## Обновления

После любых правок в `index.html`:

```bash
./build.sh
git add index.html 404.html
git commit -m "update demo"
git push
```

GitHub Pages пересоберёт сайт автоматически за 1-2 минуты.
