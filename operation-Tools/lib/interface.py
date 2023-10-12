import flask
from datetime import date , timedelta, datetime
from decimal import Decimal
from collections import OrderedDict,defaultdict

server = flask.Flask(__name__)  #把当前py文件当做一个服务启动
from lib.tools import my_db,my_md5,my_redis


@server.route('/login',methods=['post'])
def login():
    data = flask.request.json
    username = data['username']
    passwd = data['password']
    sql = "select * from Employees where ContactInfo = '{}' and PassWord = '{}'".format(username,passwd)
    result = my_db(sql)
    if result:
        # session_id = my_md5(username + time.strftime('%Y%m%d%H%M%S'))
        # key = 'wind_session:%s'%username
        # my_redis(key,session_id,6000)
        # data = {'session_id': session_id,'error_code':0,'msg':'登陆成功','login_time': time.strftime('%Y%m%d%H%M%S')}
        data = {'error_code':0,'msg':'登陆成功','username':result[0][1],'sex':result[0][2],'position':result[0][4],'contactinfo':result[0][5],'home_address':result[0][6]}
        return flask.jsonify(data)
    else:
        res = {'error_code':1, 'msg': '用户名错误或者密码错误！'}
        return flask.jsonify(res)

@server.route('/ChangePass',methods=['post'])
def ChangePass():
    data = flask.request.json
    contactInfo = data['contactInfo']
    Passwd = data['password1']
    newPasswd = data['password2']
    ConfirmPasswd = data['password3']

    if newPasswd == ConfirmPasswd:
        select_res = my_db("select PassWord from Employees where ContactInfo = '{}'".format(contactInfo))
        if select_res == () or select_res == Passwd:
            res = {'error_code':1, 'msg':'原密码输入错误'}
            return flask.jsonify(res)
        else:
            update_sql ="update Employees set PassWord = '{}' where ContactInfo = '{}'".format(newPasswd,contactInfo)
            my_db(update_sql)
            res = {'error_code':0, 'msg':'修改成功'}
            return flask.jsonify(res)

# 销售总额接口
@server.route('/totalSales', methods=['post'])
def totalSales():
    data = flask.request.json
    start_Time = data['start_time']
    end_Time = data['end_time']
    if 'totalSales' in data:
        select_sql = """SELECT
                            SaleDate,
                            COALESCE(SUM(CASE WHEN isRefund = 0 THEN ProductPrice ELSE 0 END), 0) AS DailySales,
                            COALESCE(SUM(CASE WHEN isRefund = 1 THEN ProductPrice ELSE 0 END), 0) AS DailyRefunds
                        FROM (
                            SELECT DISTINCT DATE(TransactionTime) AS SaleDate
                            FROM Transactions
                            WHERE TransactionTime BETWEEN '{}' AND '{}'
                        ) AS Dates
                        LEFT JOIN Transactions ON DATE(Transactions.TransactionTime) = Dates.SaleDate
                        GROUP BY SaleDate
                        ORDER BY SaleDate;
                    """.format(start_Time, end_Time)
        sales_results = my_db(select_sql)
        sales_by_date = {}
        for result in sales_results:
            sale_date, daily_sales, daily_refunds = result
            # 如果日期不存在于字典中，创建一个新的字典条目
            if sale_date not in sales_by_date:
                sales_by_date[str(sale_date)] = {"sales": 0, "refunds": 0}

            # 将销售额和退款额添加到字典中的相应日期
            sales_by_date[str(sale_date)]["sales"] += daily_sales
            sales_by_date[str(sale_date)]["refunds"] += daily_refunds

        # 将数据按日期升序排列
        sorted_data = OrderedDict(sorted(sales_by_date.items()))
        start_Time = str(start_Time)
        end_Time = datetime.now().strftime('%Y-%m-%d')

        # 遍历日期范围，确保每一天都在数据中
        current_date = datetime.strptime(start_Time, '%Y-%m-%d')
        while current_date.strftime('%Y-%m-%d') <= end_Time:
            formatted_date = current_date.strftime('%Y-%m-%d')

            if formatted_date not in sorted_data:
                sorted_data[formatted_date] = {'sales': Decimal('0.00'), 'refunds': Decimal('0.00')}

            current_date += timedelta(days=1)
        res = {'error_code': 0, 'msg': '查询完成', 'data': sorted_data,}
        return res
########################################################################################################################
    elif 'Transaction_quantity' in data:
        select_sql = """SELECT DATE(TransactionTime) AS SaleDate, COUNT(*) AS TransactionCount
                        FROM Transactions
                        WHERE TransactionTime BETWEEN '{}' AND '{}'
                        GROUP BY SaleDate
                        ORDER BY SaleDate
                    """.format(start_Time, end_Time)
        results = my_db(select_sql)
        counts_by_date = {}
        for result in results:
            sale_date, count_date = result
            counts_by_date[str(sale_date)] = count_date

        year1, month1, day1 = map(int, start_Time.split('-'))
        start_Time = date(year1, month1, day1)
        end_Time = datetime.now().strftime('%Y-%m-%d')
        year2, month2, day2 = map(int, str(end_Time).split('-'))
        end_Time = date(year2, month2, day2)

        date_range = [start_Time + timedelta(days=i) for i in range((end_Time - start_Time).days + 1)]
        ordered_data = OrderedDict()
        for day in date_range:
            formatted_date = day.strftime('%Y-%m-%d')
            ordered_data[formatted_date] = counts_by_date.get(formatted_date, 0)
        res = {'error_code': 0, 'msg': '查询完成', 'data': dict(ordered_data),}
        return res
########################################################################################################################
    elif 'category_data' in data:
        select_sql = """SELECT 
                            dates.Date AS SaleDate,
                            products.ProductName,
                            COALESCE(SUM(CASE WHEN transactions.isRefund = 0 THEN transactions.ProductPrice ELSE 0 END), 0) AS DailySales
                        FROM
                            (
                                SELECT DATE(CURRENT_DATE - INTERVAL (a.a + (10 * b.a) + (100 * c.a)) DAY) AS Date
                                FROM
                                    (SELECT 0 AS a UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS a
                                    CROSS JOIN
                                    (SELECT 0 AS a UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS b
                                    CROSS JOIN
                                    (SELECT 0 AS a UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS c
                            ) AS dates
                        CROSS JOIN
                            (SELECT DISTINCT ProductName FROM operation.Transactions) AS products
                        LEFT JOIN
                            operation.Transactions AS transactions
                            ON DATE(transactions.TransactionTime) = dates.Date
                            AND products.ProductName = transactions.ProductName
                        WHERE
                            dates.Date BETWEEN '{}' AND '{}'
                        GROUP BY
                            SaleDate, ProductName
                        ORDER BY
                            SaleDate, ProductName;
                    """.format(start_Time, end_Time)
        results = my_db(select_sql)
        sales_by_date = {}
        for result in results:
            sale_date, ProductName, daily_sale = result
            # 如果日期不存在于字典中，创建一个新的字典条目
            if str(sale_date) not in sales_by_date:
                sales_by_date[str(sale_date)] = {}

            # 将产品名称和对应的销售额存储在日期的字典中
            sales_by_date[str(sale_date)][ProductName] = daily_sale

        # 收集所有日期
        dates = list(sales_by_date.keys())

        # 创建产品到数量的映射字典
        product_data = defaultdict(list)

        # 遍历原始数据
        for i, products in sales_by_date.items():
            for product, value in products.items():
                product_data[product].append(float(value))

        # 打印日期列表
        # print(dates)

        # 打印产品数据
        # for product, values in product_data.items():
        #     print(f"{product}: {values}")
        res = {'error_code': 0, 'msg': '查询完成', 'date': dates, 'sales': dict(product_data.items())}
        
        return res
########################################################################################################################
    elif 'myPie_sum' in data:
        select_sql = """SELECT ProductName , SUM(ProductPrice) AS TotalSales
                        FROM operation.Transactions
                        WHERE TransactionTime BETWEEN '{}' AND '{}'
                        GROUP BY ProductName
                        ORDER BY TotalSales DESC
                    """.format(start_Time, end_Time)
        results = my_db(select_sql)
        res = {'error_code': 0, 'msg': '查询完成', 'data': results}
        return res


########################################################################################################################
# 全局查询接口
@server.route('/total_counts', methods=['post'])
def total_counts():
    data = flask.request.json
    start_Time = data['start_time']
    end_Time = data['end_time']

    if 'totalSales_sum' in data:
        select_total = """SELECT SUM(ProductPrice)
                        FROM operation.Transactions
                        WHERE isRefund = 0;
                        """
        select_month = """SELECT SUM(ProductPrice)
                        FROM operation.Transactions
                        WHERE TransactionTime BETWEEN '{}' AND '{}'
                        AND isRefund = 0;
                        """.format(start_Time, end_Time)
        total_select_result = my_db(select_total) 
        month_select_result = my_db(select_month)
        res = {'error_code': 0, 'msg': '查询完成', 'total_select_result': total_select_result[0], 'month_select_result': month_select_result[0]}
        return res
########################################################################################################################
    elif 'Transaction_counts' in data:
        select_total = """SELECT count(ID)
                        FROM operation.Transactions
                        WHERE isRefund = 0;
                        """
        select_month = """SELECT count(ID)
                        FROM operation.Transactions
                        WHERE TransactionTime BETWEEN '{}' AND '{}'
                        AND isRefund = 0;
                        """.format(start_Time, end_Time)
        total_select_result = my_db(select_total) 
        month_select_result = my_db(select_month)
        return {'error_code': 0, 'msg': '查询完成', 'total_select_result': total_select_result[0], 'month_select_result': month_select_result[0]}
    # 如果没有匹配的条件，也要返回响应
    return {'error_code': 1, 'msg': '未匹配到条件'}

########################################################################################################################
# 添加查询产品接口
@server.route('/Product_Add_Query', methods=['post'])
def Product_Add_Query():
    data = flask.request.json
    if "SearchProduct" in data:
        ProductID = data['ProductID']
        ProductName = data['ProductName']
        ProductStatus = data['ProductStatus']
        if ProductID == None and ProductName == None and ProductStatus == None:
            select_sql = "SELECT ID, ProductName, ProductStatus, ProductPrice, on_shelf_time, off_shelf_time FROM operation.ProductTable;"
            select_result = my_db(select_sql)
            res = {'error_code': 0, 'msg': '查询完成', 'data': select_result}
            return res
        elif ProductID != None or ProductName != None or ProductStatus != None:
            # 构建查询语句
            query = "SELECT ID, ProductName, ProductStatus, ProductPrice, on_shelf_time, off_shelf_time FROM operation.ProductTable WHERE 1=1"  # 初始查询语句
            if ProductID:
                query += f" AND ID = '{ProductID}'"
            if ProductName:
                query += f" AND ProductName = '{ProductName}'"
            if ProductStatus:
                query += f" AND ProductStatus = '{ProductStatus}'"
            select_result = my_db(query)
            res = {'error_code': 0, 'msg': '查询完成', 'data': select_result}
            return res
        return {'error_code': 1, 'msg': '查询失败'}
    elif "AddProduct" in data:
        AddProductName = data['AddProductName']
        AddProductPrice = data['AddProductPrice']
        insert_sql = "INSERT INTO operation.ProductTable (ProductName, ProductStatus, ProductPrice, on_shelf_time) VALUES('{}', '已上架', {}, NOW());".format(AddProductName, AddProductPrice)
        my_db(insert_sql)
        res = {'error_code': 0, 'msg': '添加完成',}
        return res
    else:
        return {'error_code': 1, 'msg': '操作失败'}
########################################################################################################################
# 编辑删除产品接口
@server.route('/Edit_Del_Product', methods=['post'])
def Edit_Del_Product():
    data = flask.request.json
    if "EditProduct" in data:
        ProductID = data['ProductID']
        ProductName = data['ProductName']
        ProductStatus = data['ProductStatus']
        ProductPrice = data['ProductPrice']
        #先查询产品当前状态
        select_sql = "SELECT ProductStatus FROM operation.ProductTable WHERE ID = {}".format(ProductID)
        if ProductStatus in "已上架":
            if ProductStatus in my_db(select_sql)[0]:
                #更新sql
                update_sql = "UPDATE operation.ProductTable SET ProductName = '{}', ProductPrice = {} WHERE ID = {};".format(ProductName, ProductPrice, ProductID)
                my_db(update_sql)
                res = {'error_code': 0, 'msg': '更新完成'}
                return res
            else:
                
                update_sql = "UPDATE operation.ProductTable SET ProductName = '{}', ProductStatus = '已上架', ProductPrice = {}, on_shelf_time = NOW(), off_shelf_time = NULL WHERE ID = {};".format(ProductName, ProductPrice, ProductID)
                my_db(update_sql)
                res = {'error_code': 0, 'msg': '更新完成'}
                return res
        elif ProductStatus in "已下架":
            if ProductStatus in my_db(select_sql)[0]:
                #更新sql
                update_sql = "UPDATE operation.ProductTable SET ProductName = '{}', ProductPrice = {} WHERE ID = {};".format(ProductName, ProductPrice, ProductID)
                my_db(update_sql)
                res = {'error_code': 0, 'msg': '更新完成'}
                return res
            else:
                update_sql = "UPDATE operation.ProductTable SET ProductName = '{}', ProductStatus = '已下架', ProductPrice = {}, off_shelf_time = NOW() WHERE ID = {};".format(ProductName, ProductPrice, ProductID)
                my_db(update_sql)
                res = {'error_code': 0, 'msg': '更新完成'}
                return res
    elif "DeleteProduct" in data:
        ProductID = data['ProductID']
        delete_sql = "DELETE FROM ProductTable WHERE ID = {}".format(ProductID)
        if my_db(delete_sql):
            return {'error_code': 0, 'msg': '删除完成'}
        else:
            return {'error_code': 1, 'msg': '操作失败'}
    res = {'error_code': 1, 'msg': '操作失败'}
    return res
########################################################################################################################
# 
@server.route('/place_an_order', methods=['post'])
def place_an_order():
    data = flask.request.json
    if "place_an_order" in data:
        Order_Quantity = data['Order_Quantity']
        insert_sql = "INSERT INTO Transactions (ProductName, ProductPrice, isRefund, TransactionTime) VALUES ('{}', {}, 0, NOW())".format(data['ProductName'], data['ProductPrice'])
        for i in range(int(Order_Quantity)):
            my_db(insert_sql)
        return  {'error_code': 0, 'msg': '插入完成'}
    return  {'error_code': 1, 'msg': '操作失败'}

########################################################################################################################
# 订单管理接口
@server.route('/order_management', methods=['post'])
def order_management():
    data = flask.request.json
    if 'searchOrder' in data:
        OrderID = data['OrderID']
        ProductName = data['ProductName']
        if OrderID == None and ProductName == None:
            select_sql = 'SELECT ID, ProductName, isRefund, ProductPrice, TransactionTime FROM Transactions'
            select_result = my_db(select_sql)
            res = {'error_code': 0, 'msg': '查询完成', 'data': select_result}
            return res
        elif OrderID != None or ProductName != None:
            # 构建查询语句
            print('hhhh')
            query = "SELECT ID, ProductName, isRefund, ProductPrice, TransactionTime FROM Transactions WHERE 1=1"  # 初始查询语句
            if OrderID:
                query += f" AND ID = '{OrderID}'"
            if ProductName:
                query += f" AND ProductName = '{ProductName}'"
            select_result = my_db(query)
            res = {'error_code': 0, 'msg': '查询完成', 'data': select_result}
            return res
    # 退款处理逻辑
    elif 'Refund' in data:
        OrderID = data['OrderID']
        update_sql = "UPDATE Transactions SET isRefund = 1 WHERE ID = {};".format(OrderID)
        my_db(update_sql)
        return  {'error_code': 0, 'msg': '更新完成'}
    return {'error_code': 1, 'msg': '查询失败'}
