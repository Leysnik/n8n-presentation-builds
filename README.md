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
- Python Flask на порту 8081 для конвертации презентации в json

### 3. Отправить презентацию на конвертациюё
Для этого достаточно после запуска Workflow отправить файл на POST http://localhost:5678/webhook/pptx_to_video

Для удобства данного процесса можно
```bash
python -m venv venv
source venv/bin/activate
pip install -r requirements/local_requirements.txt

```
После чего можно будет перейти на http://localhost:8082/n8n и удобно отпралять презентации

## Доступ к сервисам

- **n8n**: http://localhost:5678
- **OpenTTS**: http://localhost:5500
- **Flask**: http://localhost:8081 (POST /convert)

## Workflow в n8n

1. Импортируйте `n8n-pptx-workflow-fixed.json` в n8n
2. Активируйте workflow
3. Тестовый WEBHOOK для отправки видео: `http://localhost:5678/webhook-test/pptx`

## Как это работает

1. **flask_pptx_converter.py** читает *.pptx, извлекает заметки докладчика и рендерит слайды в PNG
2. Отправляет JSON с данными на n8n workflow
3. **n8n workflow** для каждого слайда:
   - Получает аудио от OpenTTS
   - Создает видео из PNG + аудио через ffmpeg
   - Склеивает все сегменты в финальный MP4
4. Возвращает готовое видео

## Формат выходных данных из http://lcoalhost:8081/convert

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
- `docker-compose down` - остановить сервисы