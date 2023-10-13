import sys,os,logging
# 将当前目录加入模块搜索路径
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

# 将项目根目录加入模块搜索路径
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# 设置环境变量
os.environ['PROJECT_PATH'] = os.path.dirname(os.path.abspath(__file__))

from lib.interface import server
from config.setting import SERVER_PORT
from flask_cors import CORS
from logging.handlers import RotatingFileHandler


# 允许跨域请求
CORS(server, resources={r"/*": {"origins": "*"}})

if __name__ == '__main__':
    server.run(
        host='0.0.0.0',
        port=SERVER_PORT,
        debug=True
    )