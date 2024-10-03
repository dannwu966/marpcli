#!/bin/bash

# 設定 UPLOAD_FOLDER 環境變數
export UPLOAD_FOLDER=markdown

# 啟動虛擬環境
source /home/marp/venv/bin/activate

# 使用 Gunicorn 作為生產環境的 WSGI 伺服器
gunicorn --bind 0.0.0.0:8290 --timeout 90 apimain:app --access-logfile '-' --error-logfile '-' --log-level info
