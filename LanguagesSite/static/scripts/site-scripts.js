/**
 * Функция для отображения окна подтверждения перехода на другую страницу
 * @param {any} uri - URL страницы, на которую осуществляется переход
 */
function showRedirectMessage(uri) {

    // Переменные с сылками на отображаемое окно, и всю страницу за ним
    var pageWrapper = document.getElementById('pageWrapper')
    var modalCard = document.getElementById('modalCard')


    // Отображение окна
    modalCard.style.visibility = 'visible'

    // Отключение всех карт, находящихся на экране. По нима нельзя клинкуть, и они не реагируют на указатель.
    document.querySelectorAll('.card').forEach(card => {
        if (card.id != 'modalCard') {
            card.classList.add('disabled-card')
        }
    })

    // Изменение прозрачности страницы за окном, и панели сверху
    pageWrapper.style.opacity = 0.25
    document.getElementById('topPanel').style.opacity = 0.25

    // Изменение текста в отображаемом окне, добавление ссылки в этот текст
    var modalText = document.getElementById('modalText')
    modalText.innerHTML = `Вы уверены, что хотите перейти на данную страницу? <br><br> ${uri}`

    // Поулчение ссылок на кнопки в окне
    var yesButton = document.getElementById("modalYes")
    var noButton = document.getElementById("modalNo")

    // Обработка нажатия на конпку "Да"
    // Переход по ссылке из аргумента
    yesButton.onclick = () => {
        location.href = uri
    }

    // Обработка нажатия на конпку "Нет"
    // Скрытие окна, возвращение нормальной прозрачности содержимому за окном и верхней панели
    noButton.onclick = () => {
        document.querySelectorAll('.card').forEach(card => {
            if (card.id != 'modalCard') {
                card.classList.remove('disabled-card')
            }
            modalCard.style.visibility = 'hidden'
            pageWrapper.style.opacity = 1
            document.getElementById('topPanel').style.opacity = 1
        })
    }

}


/**
 * Функция для отображения окна подтверждения перехода на другую страницу
 * @param {any} uri - URL страницы, на которую осуществляется переход
 */
function showQuestionMessage() {

    // Переменные с сылками на отображаемое окно, и всю страницу за ним
    var pageWrapper = document.getElementById('pageWrapper')
    var modalCard = document.getElementById('modalAskQuestionCard')


    // Отображение окна
    modalCard.style.visibility = 'visible'

    // Отключение всех карт, находящихся на экране. По нима нельзя клинкуть, и они не реагируют на указатель.
    document.querySelectorAll('.card').forEach(card => {
        if (card.id != 'modalAskQuestionCard') {
            card.classList.add('disabled-card')
        }
    })

    // Изменение прозрачности страницы за окном, и панели сверху
    pageWrapper.style.opacity = 0.25
    document.getElementById('topPanel').style.opacity = 0.25

        var noButton = document.getElementById("modalNo")

    // Обработка нажатия на конпку "Нет"
    // Скрытие окна, возвращение нормальной прозрачности содержимому за окном и верхней панели
    var noButton = document.getElementById("modalAskQuestionCancel")
    noButton.onclick = () => {
        document.querySelectorAll('.card').forEach(card => {
            if (card.id != 'modalAskQuestionCard') {
                card.classList.remove('disabled-card')
            }
            modalCard.style.visibility = 'hidden'
            pageWrapper.style.opacity = 1
            document.getElementById('topPanel').style.opacity = 1
        })
    }
}