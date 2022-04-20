import unittest
import questionHandler

list_mail_incorrect = ["", "1", "m1@", "@mail", "@", "A@A", "funnco.@gmail.com", "funnco@hmail.com.", "!^*&^*&%@gmail.com", "\"; SELECT * FROM USERS", "1test@mail.c"]
list_mail_correct = ["m.mail@mail.com", "funnco.mar@mail.com", "boab@gmail.ru", "1test@mail.com", "test1@mail.com", "zzzzzzzzzzzzzzzz@mail.com", "123123@mail.com"]

class TestStringMethods(unittest.TestCase):

    def test_correct(self):
        for item in list_mail_correct:
            self.assertTrue(questionHandler.isMailValid(item))

    def test_incorrect(self):
        for item in list_mail_incorrect:
            self.assertFalse(questionHandler.isMailValid(item))


if __name__ == "__import__":
    unittest.main()

