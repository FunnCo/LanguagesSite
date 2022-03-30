from bottle import post, redirect, request
import re
import pdb
import json

all_questions = {}


@post('/home', method='post')
def my_form():
	readQuestionsFromJSON()
	mail = request.forms.get('address')
	question = request.forms.get('question')
	if (mail == "" or question == ""):
		return "Не все поля были заполнены."

	regex = '^[a-z0-9]+[\._]?[a-z0-9]+[@]\w+[.]\w{2,3}$' 
	if (not re.search(regex, mail)):
		return "Введена некорректная почта."

	pdb.set_trace()
	all_questions[mail] = question
	writeQuestionInJSON(question, mail)
	return 'Спасибо! Ответ будет вам выслан на почту в ближайшее время.'
	

def writeQuestionInJSON(question, mail):
	data = {}
	data['questions'] = []
	for item in all_questions.items():
		data['questions'].append({
			'question': item[1],
			'email': item[0]
		})

	currentData = readQuestionsFromJSON()
	for item in currentData['questions']:
		data['questions'].append(item)

	with open('data.txt', 'w') as outfile:
		json.dump(data, outfile)

def readQuestionsFromJSON():
	try:
		with open('data.txt') as json_file:
			data = json.load(json_file)
			for p in data['questions']:
				all_questions[p['email']] = p['question']
			return data
	except:
		return

