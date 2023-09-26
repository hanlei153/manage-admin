from lib.tools import my_db

res=my_db("select passwd from users where username = 'hanlei' and passwd = '321.com.com'")
print(res)