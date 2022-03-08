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

    <!-- Подключение стилей, которые были использованы при создании сайта. -->
    <link rel="stylesheet" type="text/css" href="/static/content/main.css" />

    <script src="/static/scripts/modernizr-2.6.2.js"></script>
</head>

<body>
    <!--Верхняя навигационная панель -->
    <div class="top_panel_wrapper" id="topPanel">
        <div class="navbar_wrapper">
            <div class="navbar center">
                <ul>
                    <li><a href="./about">О ПРОЕКТЕ</a></li>
                    <li><a href="./home">ГЛАВНАЯ</a></li>
                    <li><a href="./contact">СТАТИСТИКА</a></li>
                </ul>
            </div>
        </div>

        <!-- Класс-оверлей, для отображения названия сайта (он же логотип) -->
        <div class="top-panel_overlay">
            <p class="normal-letters">./catalog</p>
        </div>
    </div>

    <!-- Содержание текущей страницы -->
    <div class="container body-content">
        {{!base}}
    </div>

    <!-- Создание модального окна, для подтверждения перехода -->
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

    <script src="/static/scripts/jquery-1.10.2.js"></script>
    <script src="/static/scripts/bootstrap.js"></script>
    <script src="/static/scripts/respond.js"></script>

    <!-- Подключение скрипта, для отобржаения окна подтверждения перехода -->
    <script src="/static/scripts/site-scripts.js"></script>
</body>
</html>