import pymysql,hashlib,redis
from config.setting import MYSQL_INFO,SERVER_PORT,REDIS_INFO
def my_db(sql):
    conn = pymysql.connect(**MYSQL_INFO)
    #加**后，会写成这种格式：user=root,passwd=123456
    cur = conn.cursor() #建立游标
    cur.execute(sql) #执行sql
    if sql.strip()[:6].upper()=='SELECT':
        res = cur.fetchall()
    else:
        conn.commit()
        res = 'OK'
    cur.close()
    conn.close()
    return res

def my_redis(k,v=None,time1=None):
    r = redis.Redis(**REDIS_INFO)
    if v:
        r.set(k,v,time1)
        res = 'OK'
    else:
        res = r.get(k).decode()
    return res

def my_md5(s):
    md = hashlib.md5()
    md.update(s.encode())
    return md.hexdigest()