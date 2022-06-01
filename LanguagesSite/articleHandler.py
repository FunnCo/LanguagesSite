from bottle import post, get, request
import json
import re

# Функия проверки корректности телефона
def isPhoneValid(phone):
    regex = '^((\+7|7|8)+([0-9]){10})$' 
    return re.search(regex, phone)

# Функия проверки уникальности названия статьи
def validateArticleName(name):
    with open("articles.txt", "r") as myfile:
        line = myfile.readline()
        while (line != ''):
            line = myfile.readline()
            print(line)
            if(line == name + "\n"):
                return False
            while line != "<<<||==||==||==||==||>>>\n":
                line = myfile.readline()
            line = myfile.readline()
        return True
        
        
# Контроллер для загрузки новой статьи
@post("/post/article")
def addNewArticle():
    # Поулчения тела запроса
    requestBody = json.load(request.body)
    parameters = requestBody.get('data')

    # Проверка телефона на корркетность. Если телефон введен корректно, то новая статья будет записана в файл, иначе, клиенту вернется ошибка.
    # Проверка названия на уникальность.
    if(isPhoneValid(parameters.get('phone')) and validateArticleName(parameters.get("article_name"))):
        with open("articles.txt", "a") as myfile:            
            myfile.write(parameters.get("nickname") + "\n" + parameters.get("article_name") + "\n" + parameters.get("phone") + "\n" + parameters.get("publication_date") + "\n" + parameters.get("content") + "\n" + "<<<||==||==||==||==||>>>\n")
            return {"result": True}
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
        publication_date = line
        line = articles_file.readline()

        # Запись в переменную HTML текст статьи
        content = ""
        while line != "<<<||==||==||==||==||>>>\n":
            content = content + "<p>" + line + "</p>"
            line = articles_file.readline()

        # Преобразование метаданных в HTML код и объединение с текстом статьи
        result_article = "<h2>" + article_name + "</h2>"
        result_article += content
        result_article += '<br><br><div class="inline_text">'
        result_article += '<p class="right_sided_text">Дата публикации: ' + publication_date + "</p>"
        result_article += '<p class="left_sided_text">Автор: ' + nickname + "</p>"
        result_article += "</div>"
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
       
