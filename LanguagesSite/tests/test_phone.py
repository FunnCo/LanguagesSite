import unittest
from ordersHandler import isPhoneValid

list_phone_incorrect = ["1234567890","6123456789","+7 123 12 21 22", "+791234567", "+7 (123) 123 12", "123 123 21 12"]
list_phone_correct = ["+79959971608","79959971608","81111111111", "7 123 234 45 56", "+7 123 234 45 56"]

class TestStringMethods(unittest.TestCase):
    
    def test_correct(self):
        for item in list_phone_correct:
            self.assertTrue(isPhoneValid(item))

    def test_incorrect(self):
        for item in list_phone_incorrect:
            self.assertFalse(isPhoneValid(item))


if __name__ == "__import__":
    unittest.main()

