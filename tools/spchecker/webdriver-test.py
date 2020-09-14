import unittest
from selenium import webdriver
from selenium.webdriver.common.by import By

class WebDriverPythonBasics(unittest.TestCase):


    def setUp(self):
        self.browser = webdriver.Chrome()


    def test_saucelabs_homepage_header_displayed(self):
        self.browser.get("https://www.saucelabs.com")
        element = self.browser.find_element(By.XPATH, '//a[text()="Platforms"]');
        self.assertTrue(element.is_displayed());
        element.click();
        pricing_link = self.browser.find_element(By.XPATH, '//a[text()="Pricing"]');
        self.assertTrue(pricing_link.is_displayed());
        pricing_link.click();


    def tearDown(self):
        self.browser.close()


if __name__ == '__main__':
        unittest.main()

