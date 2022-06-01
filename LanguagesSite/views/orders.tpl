% rebase('layout.tpl', title='Заказы', year=year)

<div>
	<h1>Заказы</h1
	<p class="description">Данная страница предназначена для размещения заказов на публикацию тех или иных статей, связанных с языками программирования и их развитием.</p>
	<div class="order_container">
	</div>
	<div class="center medium-margin-top">
	<button id="publish">Разместить заказ</button>
	</div>
	<div class="center big-margin-top">
	<button hidden="true" id="publish_cancel">Отменить</button>
	<button hidden="true" id="publish_confirm" type="submit" form="order_form">Разместить</button>
	</div>
	<div hidden="true" class="person editor_container">
	<form action="javascript:ordersHandler()" id="order_form">
		<div class="small-margin-bottom">
		<p><input class="textinput corners" type="text" id="order_name" name="order_name" size="50" placeholder="Тема заказа"></p>
		<p><input class="textinput corners" type="text" id="order_phone" name="order_name" size="50" placeholder="Ваш номер телефона"></p>
		<p><input class="textinput corners" type="text" id="order_username" name="order_name" size="50" placeholder="Ваше имя"></p>
		</div>
		<p><textarea class="textinput area-background" id="order_content" name="aritcle_content" placeholder="Описание заказа"></textarea></p>
	</div>
</div>

<script>
	function ordersHandler() {
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