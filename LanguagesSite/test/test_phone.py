import unittest
from articleHandler import isPhoneValid

list_phone_incorrect = ["6 789 789 78 78","67897897878","+7 965 54 78 56", "+796554785", "+7", "+796554785", "+7 (824) 846-54-23", "999-99-99", "+7777777777"]
list_phone_correct = ["+77777777777","77777777777","87777777777"]

class TestStringMethods(unittest.TestCase):

    def test_correct(self):
        for item in list_phone_correct:
            self.assertTrue(isPhoneValid(item))

    def test_incorrect(self):
        for item in list_phone_incorrect:
            self.assertFalse(isPhoneValid(item))


if __name__ == "__import__":
    unittest.main()

