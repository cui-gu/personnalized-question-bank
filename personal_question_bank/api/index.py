"""
Vercel部署入口文件
"""
import sys
import os

# 添加项目根目录到Python路径
project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, project_root)

# 导入Flask应用
from app import app

# 确保在Vercel环境中初始化
if os.environ.get('VERCEL'):
    os.environ['FLASK_ENV'] = 'production'

# 导出app供Vercel使用
application = app
app = app  # Vercel可能需要这个名称

if __name__ == "__main__":
    app.run(debug=False)
