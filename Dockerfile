# 使用 marpteam/marp-cli 作為基礎映像
FROM marpteam/marp-cli:v3.4.0

# 設定工作目錄
WORKDIR /home/marp/app

# 複製當前目錄的內容到容器中
COPY . .

# 安裝 Python 及其依賴項
RUN apk update && apk add python3 py3-pip

# 建立虛擬環境並安裝依賴項
RUN python3 -m venv /home/marp/venv
RUN /home/marp/venv/bin/pip install flask requests gunicorn

# 設定環境變數
ENV PATH="/home/marp/venv/bin:$PATH"
ENV LANG=ZH-TW.UTF-8

# 暴露 Flask API 的埠
EXPOSE 8290
EXPOSE 8080
EXPOSE 37717

# 設定 ENTRYPOINT
ENTRYPOINT ["sh", "./startup.sh"]

# CMD 可以指定 marp 的參數
CMD ["-s", "./markdown"]
