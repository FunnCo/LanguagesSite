from bottle import post, get, request
import json
import re

def isPhoneValid(phone):
    regex = '^((\+7|7|8)+([0-9]){10})$' 
    return re.search(regex, phone)


@post("/post/article")
def addNewArticle():
    requestBody = json.load(request.body)
    parameters = requestBody.get('data')
    if(isPhoneValid(parameters.get('phone'))):
        with open("articles.txt", "a") as myfile:
            myfile.write(parameters.get("nickname") + "\n" + parameters.get("article_name") + "\n" + parameters.get("phone") + "\n" + parameters.get("content") + "\n" + "<<<!!!>>>\n")
    else:
        return {"result": False}

@get("/get/all")
def getAllArticles():
    articles = []
    articles_file = open('articles.txt')

    line = articles_file.readline()
    while line != '':
        nickname = line
        line = articles_file.readline()
        article_name = line
        line = articles_file.readline()
        phone = line
        line = articles_file.readline()
        content = ""
        while line != "<<<!!!>>>\n":
            content = content + "<p>" + line + "</p>"
            line = articles_file.readline()
        result_article = "<h2>" + article_name + "</h2>"
        result_article += content
        result_article += "<br><br><p>Автор: " + nickname + "</p>"
        result_article += "<p>Телефон: " + phone + "</p>"
        result_article = result_article.replace("\n",'')
        result_article = result_article.replace("\t",'    ')
        articles.append(result_article)
        line = articles_file.readline()

    articles_file.close()

    return {"result": articles}
       
