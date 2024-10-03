#!/bin/bash

# 設定 UPLOAD_FOLDER 環境變數
export UPLOAD_FOLDER=markdown

export FLASK_APP=apimain.py
# 註解掉原本的 Flask 開發伺服器啟動指令
# python3 -m flask run --host=0.0.0.0 --port=8290

# 使用 Gunicorn 作為生產環境的 WSGI 伺服器
gunicorn --bind 0.0.0.0:8290 --timeout 90 apimain:app --access-logfile '-' --error-logfile '-' --log-level info
