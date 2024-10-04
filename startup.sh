#!/bin/bash

# 使用 Node.js 啟動 Marp 服務，使用 CMD 傳遞的參數
exec su-exec "$MARP_USER" node /home/marp/.cli/marp-cli.js "$@" --port 8080 &  # 在後台運行 Marp 服務

# 設定 UPLOAD_FOLDER 環境變數
export UPLOAD_FOLDER=markdown

# 設定 URL 連結
export PREVIEW_URL="http://localhost:8080"
export DOWNLOAD_URL="http://localhost:8080"

# 啟動虛擬環境
source /home/marp/venv/bin/activate

# 使用 Gunicorn 作為生產環境的 WSGI 伺服器
gunicorn --bind 0.0.0.0:8290 --timeout 90 apimain:app --access-logfile '-' --error-logfile '-' --log-level info
