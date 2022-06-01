from bottle import post, get, request
import json
import re

def isPhoneValid(phone):
    regex = '^((\+7|7|8)+([0-9]){10})$' 
    return re.search(regex, phone)

@post("/post/order")
def addOrder():
    requestBody = json.load(request.body)
    parameters = requestBody.get('data')
    if(isPhoneValid(parameters.get('phone'))):
        with open("orders.txt", "a") as outputFile:
            outputFile.write(parameters.get("username") + "\n" + parameters.get("orderName") + "\n" + parameters.get("phone") + "\n" + parameters.get("content") + "\n\n\n\n")
    else:
        return {"result": False}
 
@get("/get/all")
def getOrders():
    orders = []
    ordersFile = open('orders.txt')
    line = ordersFile.readline()
    while line != '':
        username = line
        line = ordersFile.readline()
        orderName = line
        line = ordersFile.readline()
        phone = line
        line = ordersFile.readline()

        content = ""
        while line != "\n\n\n\n":
            content = content + "<p>" + line + "</p>"
            line = ordersFile.readline()

        orderOutput = "<h2>" + orderName + "</h2>"
        orderOutput += content
        orderOutput += "<br><br><p>Пользователь: " + username + "</p>"
        orderOutput += "<p>Телефон: " + phone + "</p>"
        orderOutput = orderOutput.replace("\n",'')
        orderOutput = orderOutput.replace("\t",'    ')

        orders.append(orderOutput)
        line = ordersFile.readline()

    ordersFile.close()
    return {"result": orders}