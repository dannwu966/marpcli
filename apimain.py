from flask import Flask, request, jsonify
import os
import time
import logging

# 初始化 Flask 應用程式
app = Flask(__name__)

# 從環境變數中讀取 UPLOAD_FOLDER 配置
app.config['UPLOAD_FOLDER'] = os.getenv('UPLOAD_FOLDER', 'markdown')

# 確保目錄存在
if not os.path.exists(app.config['UPLOAD_FOLDER']):
    os.makedirs(app.config['UPLOAD_FOLDER'])

# 設定日誌
logging.basicConfig(level=logging.INFO)

@app.route('/marpmd_upload', methods=['POST'])
def upload_markdown():
    try:
        content = request.get_data(as_text=True)
        file_name = str(int(time.time())) + ".md"
        file_path = os.path.join(app.config['UPLOAD_FOLDER'], file_name)
        
        # 將 Markdown 內容儲存成檔案
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(content)
        
        # 成功儲存則回應連結供下載, 否則回應錯誤訊息
        if not os.path.exists(file_path):
            return jsonify({'error': 'Markdown文件儲存失敗'}), 500
        else:
            return jsonify({
                'message': 'Markdown文件已儲存',
                'preview_link': f'http://localhost:8080/{file_name}',
                'download_link': f'http://localhost:8080/{file_name}?pptx'
            }), 201
    except Exception as e:
        logging.error(f"Error uploading markdown: {e}")
        return jsonify({'error': '伺服器內部錯誤'}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8290, debug=True)
