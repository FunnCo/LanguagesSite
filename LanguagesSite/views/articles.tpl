% rebase('layout.tpl', title='Статьи', year=year) 

<div>
	<h1>Статьи</h1>
	<p class="description">Данная страница предназначена для публикации своих статей на любую тему связанную с языками программирования.</p>
	<p class="description">При публицкаии статьи, просим вас не касаться иных тем, кроме как языков программирования, кроме случаев, когда языки имеют прямое отношение к каким-либо событиям.</p>

	<button id="publish">Опубликовать свою статью</button>
	<button hidden="true" id="publish_confirm" type="submit" form="article_form">Подтвердить</button>
	<button hidden="true" id="publish_cancel">Отмена</button>
	<div class="article_container">
	</div>
	<div hidden="true" class="editor_container">
	<form action="javascript:handleArticleSubmission()" id="article_form">
		<p><input class="textinput" type="text" id="article_nickname" size="50" name="article_name" placeholder="Ваш ник"></p>
		<p><input class="textinput" type="text" id="article_name" size="50" name="article_name" placeholder="Название вашей статьи"></p>
		<p><textarea class="textinput" name="aritcle_content" id="article_content" placeholder="Ваша статья"></textarea></p>
		<p><input class="textinput" type="text" size="50" name="article_name" id="article_phone"  placeholder="Ваш номер телефона"></p>
		<p class="description">Правила написания статьи:</p>
		<p>
			1. Статья должна быть посвящана языкам программирования, или темам, напрямую связанными с языками программирования.<br>
			2. Статья должна содержать не менее 150 символов.<br>
			3. Указывайте свой реальный номер телефона. Он не будет отображен в статье, и нужен лишь для того, чтобы нашим модераторы могли связаться с вами.<br>
			4. Ваш псевдноим (ник) должен состоять не менее чем из 3 символов. При желании, вы можете указать свое ФИО.<br>
			5. Название вашей статьи должно состоять не менее чем из 5 символов, и на сайте не должно быть уже написанной статьи с таким же названием.<br>
		</p>
	</div>


</div>

<script>
	function handleArticleSubmission() {
		$(function() {

			// Удаление лишних символов из номера телефона
			var phone = $("#article_phone").val()
			phone = phone.replaceAll(' ', '')
			phone = phone.replaceAll('-', '')
			phone = phone.replaceAll('(', '')
			phone = phone.replaceAll(')', '')

			var today = new Date();
			var dd = String(today.getDate()).padStart(2, '0')
			var mm = String(today.getMonth() + 1).padStart(2, '0')
			var yyyy = today.getFullYear()

			today = yyyy + "-" + mm + "-" + dd

			// Формирование тела запроса к серверу
			body = {
				'nickname':$("#article_nickname").val(),
				'article_name':$("#article_name").val(),
				'content':$("#article_content").val(),
				'phone':phone,
				'publication_date':today
			}
			
			// Проверка полей на заполненность
			if(phone.replace(/\s+/g, '') == "" || $("#article_name").val().replace(/\s+/g, '') == "" || $("#article_content").val().replace(/\s+/g, '') == "" || $("#article_nickname").val().replace(/\s+/g, '') == ""){
				alert("Не все поля заполнены. Пожалуйста, проверьте введенные данные и введите их снова")
				return false
			}

			// Проверка ника на длину
			if($("#article_nickname").val().length < 3){
				alert("Слишком короткий никнейм. Пожалуйста, введине ник длиной от 3 символов")
				return false
			}

			// Проверка статьи на длину
			if($("#article_name").val().length < 5){
				alert("Слишком короткое название. Пожалуйста, введине назваине статьи длиной от 5 символов")
				return false
			}

			// Проверка ника на длину
			if($("#article_content").val().length < 150){
				alert("Слишком короткая статья. Она должна содержать не менее 150 символов")
				return false
			}
			
			
			// Запрос к серверу
			$.ajax({
            url: '/post/article',
            dataType: 'json',
            type: 'post',
            contentType: 'application/json',
            data: JSON.stringify({ 'data': body }),
            success: function (result) {
					// Обработка ответа от сервера, в случае если телефон указан некорректно
					if(!result['result']){
						alert("Телефон некорректен. Пожалуйста, проверьте введенные данные и введите их снова")
						return false
					}
					$("#publish_cancel").trigger('click')
				}
			})
			
		})
	}

	
	$(function() {
		// Обработчик нажатия на кнопку "Опубликовать свою статью"
		$("#publish").on("click", function(){
			$(".editor_container").show()
			$(".article_container").hide()
			$(this).hide()
			$("#publish_confirm").show()
			$("#publish_cancel").show()

		})

		// Обработчик нажатия на кнопку "Отмена"
		$("#publish_cancel").on("click", function(){
			$(".editor_container").hide()
			$(".article_container").show()
			$("#publish").show()
			$("#publish_confirm").hide()
			$("#publish_cancel").hide()
			$.ajax({
				url: '/get/all',
				type: 'get',
				contentType: 'application/json',
				success: function (result) {
						$(".article_container").children().remove()
						result["result"].forEach(element => 
							$('<div class="card article_card">' + element + '</div>').appendTo($(".article_container"))
						)
				}
			})
		})

		// Запрос на загрузку статей с сервера
		$.ajax({
            url: '/get/all',
            type: 'get',
            contentType: 'application/json',
            success: function (result) {
				// Заполнение страницы статьями, полученными от сервера
				result["result"].forEach(element => 
					$('<div class="card article_card">' + element + '</div>').appendTo($(".article_container"))
				)
			}
		})
	})

	

</script>