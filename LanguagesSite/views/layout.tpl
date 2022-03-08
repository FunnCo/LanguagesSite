<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ title }} - My Bottle Application</title>
    <link rel="stylesheet" type="text/css" href="/static/content/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/static/content/site.css" />
    <link rel="stylesheet" type="text/css" href="/static/content/top_panel.css" />
    <link rel="stylesheet" type="text/css" href="/static/content/main.css" />
    <script src="/static/scripts/modernizr-2.6.2.js"></script>
</head>

<body>
        <div class="top_panel_wrapper">
        <div class="navbar_wrapper">
            <div class="navbar center">
                <ul>
                    <li><a href="./about">О ПРОЕКТЕ</a></li>
                    <li><a href="./home">ГЛАВНАЯ</a></li>
                    <li><a href="./contact">СТАТИСТИКА</a></li>
                </ul>
            </div>
        </div>
        <div class="top-panel_overlay">
            <p class="normal-letters">./catalog</p>
        </div>
    </div>

    <div class="container body-content">
        {{!base}}
    </div>

    <script src="/static/scripts/jquery-1.10.2.js"></script>
    <script src="/static/scripts/bootstrap.js"></script>
    <script src="/static/scripts/respond.js"></script>

</body>
</html>