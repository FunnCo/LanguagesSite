% rebase('layout.tpl', title='Заказы', year=year)

<div>
	<h1>Заказы</h1>
	<p class="description">Данная страница предназначена для размещения заказов на публикацию тех или иных статей, связанных с языками программирования и их развитием.</p>

	<button id="placeOrder">Разместить заказ</button>
	<button hidden="true" id="placeOrderConfirmation" type="submit" form="orderForm">Подтвердить</button>
	<button hidden="true" id="placeOrderCancellation">Отмена</button>
	<div class="orderContainer">
	</div>
	<div hidden="true" class="editorContainer">
	<form action="javascript:handleOrder()" id="orderForm">
		<p><input class="textinput" type="text" id="userName" size="50" name="orderUsername" placeholder="Ваше имя"></p>
		<p><input class="textinput" type="text" id="orderName" size="50" name="orderName" placeholder="Тема заказа"></p>
		<p><textarea class="textinput" name="orderDescription" id="" placeholder="Описание заказа"></textarea></p>
		<p><input class="textinput" type="text" size="50" name="orderName" id="orderPhone"  placeholder="Ваш номер телефона"></p>
	</div>
</div>

<script>
	function handleOrder() {
		$(function() {
			var phone = $("#orderPhone").val()
			phone = phone.replaceAll(' ', '')
			phone = phone.replaceAll('-', '')
			phone = phone.replaceAll('(', '')
			phone = phone.replaceAll(')', '')

			body = {
				'userName':$("#orderUsername").val(),
				'orderName':$("#orderName").val(),
				'orderDescription':$("#orderDescription").val(),
				'phone':phone,
			}

			if(phone.replace(/\s+/g, '') == "" ||  $("#orderName").val().replace(/\s+/g, '') == "" || $("#orderDescription").val().replace(/\s+/g, '') == "" || $("#orderUsername").val().replace(/\s+/g, '') == ""){
				alert("Не все поля заполнены. Пожалуйста, проверьте введенные данные и введите их снова")
				return false
			}

			$.ajax({
            url: '/post/order',
            dataType: 'json',
            type: 'post',
            contentType: 'application/json',
            data: JSON.stringify({ 'data': body }),
            success: function (result) {
					if(!result['result']) {
						alert("Телефон некорректен. Пожалуйста, проверьте введенные данные и введите их снова")
						return false
					}
				}
			})
		})
	}

	$(function() {
		$("#placeOrder").on("click", function(){
			$(".editorContainer").show()
			$(".orderContainer").hide()
			$(this).hide()
			$("#placeOrderConfirmation").show()
			$("#placeOrderCancellation").show()
		})

		$("#placeOrderCancellation").on("click", function(){
			$(".editorContainer").hide()
			$(".orderContainer").show()
			$("#placeOrder").show()
			$("#placeOrderConfirmation").hide()
			$("#placeOrderCancellation").hide()
			$.ajax({
				url: '/get/all',
				type: 'get',
				contentType: 'application/json',
				success: function (result) {
						result["result"].forEach(element => $('<div class="card orderCard">' + element + '</div>').appendTo($(".orderContainer")))
				}
			})
		})

		$.ajax({
            url: '/get/all',
            type: 'get',
            contentType: 'application/json',
            success: function (result) {
					result["result"].forEach(element => $('<div class="card orderCard">' + element + '</div>').appendTo($(".orderContainer")))
			}
		})
	})
</script>