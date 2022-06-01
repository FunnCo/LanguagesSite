from bottle import post, get, request
from datetime import datetime
import json
import re

def isPhoneValid(phone):
    regex = '^((\+7|7|8)+([0-9]){10})$' 
    return re.search(regex, phone)

@post("/post/order")
def addNewOrder():
    requestBody = json.load(request.body)
    parameters = requestBody.get('data')

    if(isPhoneValid(parameters.get('phone'))):
        with open("orders.txt", "a") as myfile:
            myfile.write(parameters.get("username") + "\n" + parameters.get("order_name") + "\n" + parameters.get("phone") + "\n" + parameters.get("content") + "\n" + datetime.now().strftime('%Y-%m-%d %H:%M:%S') + "\n----------\n")
    else:
        return {"result": False}
    
@get("/get/all")
def getAllOrders():

    orders = []
    orders_file = open('orders.txt')

    line = orders_file.readline()
    while line != '':
        username = line
        line = orders_file.readline()
        order_name = line
        line = orders_file.readline()
        phone = line
        line = orders_file.readline()
        time = line
        line = orders_file.readline()

        content = ""
        while line != "----------\n":
            content = content + "<p>" + line + "</p>"
            line = orders_file.readline()

        result_order = "<h2>" + order_name + "</h2>"
        result_order += content
        result_order += "<br><br><p>Имя пользователя: " + username + "</p>"
        result_order += "<p>Телефон: " + phone + "</p>"
        result_order += "<p>" + time + "</p>"
        result_order = result_order.replace("\n",'')
        result_order = result_order.replace("\t",'    ')

        orders.append(result_order)
        line = orders_file.readline()

    orders_file.close()
    return {"result": orders}