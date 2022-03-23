from bottle import post, redirect, request
import re

@post('/home', method='post')
def my_form():
	mail = request.forms.get('address')
	question = request.forms.get('question')
	if (mail == "" or question==""):
		return "Не все поля были заполнены."

	regex = '^[a-z0-9]+[\._]?[a-z0-9]+[@]\w+[.]\w{2,3}$' 
	if (not re.search(regex, mail)):
		return "Введена некорректная почта."

	return 'Спасибо! Ответ будет вам выслан на почту в ближайшее время.'
	

