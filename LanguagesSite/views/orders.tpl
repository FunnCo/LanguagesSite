% rebase('layout.tpl', title='Заказы', year=year)

<div>
	<h1>Заказы</h1
	<p class="description">Данная страница предназначена для размещения заказов на публикацию тех или иных статей, связанных с языками программирования и их развитием.</p>
	<button id="publish">Опубликовать свою статью</button>
	<button hidden="true" id="publish_confirm" type="submit" form="order_form">Разместить</button>
	<button hidden="true" id="publish_cancel">Отменить</button>
	<div hidden="true" class="editor_container">
	<form action="javascript:handleOrderSubmission()" id="order_form">
		<p><input class="textinput" type="text" id="order_username" size="50" name="order_name" placeholder="Ваше имя"></p>
		<p><input class="textinput" type="text" id="order_name" size="50" name="order_name" placeholder="Тема заказа"></p>
		<p><textarea class="textinput" name="aritcle_content" id="order_content" placeholder="Описание заказа"></textarea></p>
		<p><input class="textinput" type="text" size="50" name="order_name" id="order_phone"  placeholder="Ваш номер телефона"></p>
	</div>
</div>

<script>
	function handleOrderSubmission() {
		$(function() {
			var phone = $("#order_phone").val()
			phone = phone.replaceAll(' ', '')
			phone = phone.replaceAll('-', '')
			phone = phone.replaceAll('(', '')
			phone = phone.replaceAll(')', '')

			body = {
				'username':$("#order_username").val(),
				'order_name':$("#order_name").val(),
				'content':$("#order_content").val(),
				'phone':phone,
			}

			if(phone.replace(/\s+/g, '') == "" ||  $("#order_name").val().replace(/\s+/g, '') == "" || $("#order_content").val().replace(/\s+/g, '') == "" || $("#order_username").val().replace(/\s+/g, '') == ""){
				alert("Пожалуйста, заполните все поля.")
				return false
			}

			$.ajax({
            url: '/post/order',
            dataType: 'json',
            type: 'post',
            contentType: 'application/json',
            data: JSON.stringify({ 'data': body }),
            success: function (result) {
					if(!result['result']){
						alert("Пожалуйста, проверьте корректность введенного номера телефона.")
						return false
					}
				}
			})
		})
	}
	
	$(function() {
		$("#publish").on("click", function(){
			$(".editor_container").show()
			$(".order_container").hide()
			$(this).hide()
			$("#publish_confirm").show()
			$("#publish_cancel").show()
		})

		$("#publish_cancel").on("click", function(){
			$(".editor_container").hide()
			$(".order_container").show()
			$("#publish").show()
			$("#publish_confirm").hide()
			$("#publish_cancel").hide()
			$.ajax({
				url: '/get/all',
				type: 'get',
				contentType: 'application/json',
				success: function (result) {
					$(".order_container").children().remove()
						result["result"].forEach(element => 
							$('<div class="card order_card">' + element + '</div>').appendTo($(".order_container"))
						)
				}
			})
		})

		$.ajax({
            url: '/get/all',
            type: 'get',
            contentType: 'application/json',
            success: function (result) {
					result["result"].forEach(element => 
						$('<div class="card order_card">' + element + '</div>').appendTo($(".order_container"))
					)
			}
		})
	})
</script>