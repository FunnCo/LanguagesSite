from bottle import post, get, request
import json
import re

# Функия проверки корректности телефона
def isPhoneValid(phone):
    regex = '^((\+7|7|8)+([0-9]){10})$' 
    return re.search(regex, phone)


# Контроллер для загрузки новой статьи
@post("/post/article")
def addNewArticle():
    # Поулчения тела запроса
    requestBody = json.load(request.body)
    parameters = requestBody.get('data')

    # Проверка телефона на корркетность. Если телфон введен корректно, то новая статья будет записана в файл, иначе, клиенту вернется ошибка.
    if(isPhoneValid(parameters.get('phone'))):
        with open("articles.txt", "a") as myfile:
            myfile.write(parameters.get("nickname") + "\n" + parameters.get("article_name") + "\n" + parameters.get("phone") + "\n" + parameters.get("content") + "\n" + "<<<!!!>>>\n")
    else:
        return {"result": False}
    
# Контроллер для получения всех статей
@get("/get/all")
def getAllArticles():

    # Списое всех статей
    articles = []

    # Открытие файла для чтения статей
    articles_file = open('articles.txt')

    # Считывание первой строки
    line = articles_file.readline()
    while line != '':
        #Запись в переменные метаданных статьи
        nickname = line
        line = articles_file.readline()
        article_name = line
        line = articles_file.readline()
        phone = line
        line = articles_file.readline()

        # Запись в переменную HTML текст статьи
        content = ""
        while line != "<<<!!!>>>\n":
            content = content + "<p>" + line + "</p>"
            line = articles_file.readline()

        # Преобразование метаданных в HTML код и объединение с текстом статьи
        result_article = "<h2>" + article_name + "</h2>"
        result_article += content
        result_article += "<br><br><p>Автор: " + nickname + "</p>"
        result_article += "<p>Телефон: " + phone + "</p>"
        result_article = result_article.replace("\n",'')
        result_article = result_article.replace("\t",'    ')

        # Добавление статьи в список
        articles.append(result_article)

        # Чтение следующей строки
        line = articles_file.readline()

    # Закрытие файла
    articles_file.close()
    
    # Возвращение всех статей
    return {"result": articles}
       
