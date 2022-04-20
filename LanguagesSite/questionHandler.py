from bottle import post, redirect, request
import re
import pdb
import json
import re


all_questions = {}


def isMailValid(mail):
    regex = '^[a-z0-9]+[\._]?[a-z0-9]+[@]\w+[.]\w{2,3}$' 
    if (re.search(regex, mail)):
        return True
    else:
        return False


@post('/home', method='post')
def my_form():
	readQuestionsFromJSON()
	mail = request.forms.get('address')
	question = request.forms.get('question')
	if (mail == "" or question == ""):
		return "Не все поля были заполнены."

	
	if isMailValid(mail):
		return "Введена некорректная почта."

	all_questions[mail] = question
	writeQuestionInJSON(question, mail)
	return 'Спасибо! Ответ будет вам выслан на почту в ближайшее время.'
	

def writeQuestionInJSON(question, mail):
	data = {}
	data['questions'] = {}
	for item in all_questions.items():
		data['questions'][item[0]] = list()
		data['questions'][item[0]].append(
			item[1]
		)

	try:
		currentData = readQuestionsFromJSON()
		for user in currentData['questions']:
			data['questions'][user] = list(set(currentData['questions'][user] + data['questions'][user]))
	except:
		print("Couldn't read file")

	with open('data.txt', 'w') as outfile:
		json.dump(data, outfile)

def readQuestionsFromJSON():
	try:
		with open('data.txt') as json_file:
			data = json.load(json_file)
			for user in data['questions']:
				for question in data['questions'][user]:
					all_questions[user] = question
			return data
	except:	
		print("Couldn't read file")
		return

