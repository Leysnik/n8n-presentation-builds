# PPTX to Video Converter

Автоматическое создание видеороликов из презентаций PowerPoint с озвучкой комментариев докладчика через TTS.

## Быстрый старт

### 1. Подготовка
Поместите вашу презентацию в корень проекта с именем `presentation_demo.pptx`

### 2. Запуск сервисов
```bash
make start_services
```
Поднимает:
- n8n (с ffmpeg) на порту 5678
- OpenTTS на порту 5500

### 3. Обработка презентации
```bash
make send_file
```
Извлекает заметки докладчика, рендерит слайды и отправляет JSON на n8n workflow.

## Доступ к сервисам

- **n8n**: http://localhost:5678
- **OpenTTS**: http://localhost:5500

## Workflow в n8n

1. Импортируйте `n8n-pptx-workflow-fixed.json` в n8n
2. Активируйте workflow
3. Тестовый URL: `http://localhost:5678/webhook-test/pptx`

## Структура проекта

```
├── presentation_demo.pptx    # Ваша презентация (обязательно!)
├── pptx_unix_min.py         # Python скрипт обработки
├── docker-compose.yml       # Docker сервисы
├── Dockerfile               # Образ для Python скрипта
├── requirements.txt         # Python зависимости
├── Makefile                 # Команды управления
└── n8n-pptx-workflow-fixed.json  # Workflow для импорта в n8n
```

## Требования

- Docker и Docker Compose
- LibreOffice (`brew install libreoffice` на macOS)
- Ghostscript (`brew install ghostscript` на macOS)
- Python пакеты: `pip install python-pptx requests`

## Как это работает

1. **pptx_unix_min.py** читает presentation_demo.pptx, извлекает заметки докладчика и рендерит слайды в PNG
2. Отправляет JSON с данными на n8n webhook
3. **n8n workflow** для каждого слайда:
   - Получает аудио от OpenTTS
   - Создает видео из PNG + аудио через ffmpeg
   - Склеивает все сегменты в финальный MP4
4. Возвращает готовое видео

## Формат входных данных

```json
{
  "slides": [
    {
      "slide_index": 1,
      "notes": "Текст заметок докладчика",
      "image_base64": "base64-encoded PNG"
    }
  ]
}
```

## Команды

- `make start_services` - запустить сервисы
- `make send_file` - обработать presentation_demo.pptx
- `docker-compose down` - остановить сервисы