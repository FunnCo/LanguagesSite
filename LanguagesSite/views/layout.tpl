<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ title }} - My Bottle Application</title>
    <link rel="icon" href="data:;base64,=">
    <link rel="stylesheet" type="text/css" href="/static/content/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/static/content/site.css" />
    <link rel="stylesheet" type="text/css" href="/static/content/top_panel.css" />
    <link rel="stylesheet" type="text/css" href="/static/content/main.css" />
    <script src="/static/scripts/modernizr-2.6.2.js"></script>
    <script
  src="https://code.jquery.com/jquery-3.6.0.js"
  integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
  crossorigin="anonymous"></script>
</head>

<body>
    <div class="top_panel_wrapper" id="topPanel">
        <div class="navbar_wrapper">
            <div class="navbar center">
                <ul>
                    <li><a href="./about">О ПРОЕКТЕ</a></li>
                    <li><a href="./home">ГЛАВНАЯ</a></li>
                    <li><a href="./contact">СТАТИСТИКА</a></li>
                    <li><a href="./orders">ЗАКАЗЫ</a></li>
                </ul>
            </div>
        </div>

        <div class="top-panel_overlay">
            <p class="normal-letters">./catalog</p>
        </div>
    </div>

        <div class="top-panel_overlay_end">
                <p><input onclick="showQuestionMessage()" type="submit" id="askQuestion" name="askQuestion" value="Задать вопрос"/></p>
        </div>

    <div id="pageWrapper" class="container body-content">
        {{!base}}
    </div>

    <div id="modalCard" class="modal-card modal-pop-up">
        <div>
           <h2>Переход на другую страницу</h2>
           <hr>
           <p class="link-text" id="modalText">Вы уверены, что хотите перейти на страницу: </p>
           <div class="modal-pop-up-content">
                <button id="modalYes"> 
                    Да
                </button>
                <button id="modalNo">
                    Нет
                </button>
                </div>
            </div>
        </div>
    </div>

    <div id="modalAskQuestionCard" class="modal-card modal-pop-up">
        <div>
           <h2>Задать вопрос</h2>
           <hr>
           <p id="modalText">Если вы желаете задать вопрос, пожалуйста, напишите его в поле ниже, а также укажите вашу почту. Ответ придет вам в ближайшее время.</p>
           <form action="/home" method="post">
                <p><textarea name="question" placeholder="Ваш вопрос"></textarea></p>
                <p><input class="textinput" type="text" size="50" name="address" placeholder="Ваша почта"></p>
           
           <div class="modal-pop-up-content">
                <form action="/home" method="post">
                    <input id="modalAskQuestionSend" name="modalAskQuestionSend" type="submit" value="Отправить"/> 
                </form>             
                <button type="button" id="modalAskQuestionCancel">
                    Отмена
                </button>
                </div>
                </form>
            </div>
            
        </div>
    </div>

            <!-- Создание модального окна "Задать вопрос" -->
    <div id="modalOrderCreationCard" class="modal-card modal-pop-up">
        <div>
           <h2>Опубликовать статью</h2>
           <hr>
           <p id="modalText">Напишите название и текст вашей статьи в поля нижу, а так же, пожалуйста, укажите ваше имя и телефон</p>
           <form action="/home" method="post">
                <p><textarea name="question" placeholder="Ваш вопрос"></textarea></p>
                <p><input class="textinput" type="text" size="50" name="address" placeholder="Ваша почта"></p>
           
           <div class="modal-pop-up-content">
                <form action="/home" method="post">
                    <button type="button" id="modalOrderCreationOK">Отправить</button>
                </form>             
                <button type="button" id="modalAskQuestionCancel">
                    Отмена
                </button>
                </div>
                </form>
            </div>
            
        </div>
    </div>

    <script src="/static/scripts/jquery-1.10.2.js"></script>
    <script src="/static/scripts/bootstrap.js"></script>
    <script src="/static/scripts/respond.js"></script>

    <!-- Подключение скрипта, для отобржаения окна подтверждения перехода -->
    <script src="/static/scripts/site-scripts.js"></script>
</body>
</html>