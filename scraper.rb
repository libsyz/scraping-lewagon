require 'pry-byebug'
require 'csv'
require "selenium-webdriver"
driver = Selenium::WebDriver.for :chrome

driver.navigate.to "https://kitt.lewagon.com"

# Login into website as a teacher

teacher_login = driver.find_element(:link, "as a teacher")
teacher_login.click

user_name = driver.find_element(:css, "input[name=login]")
user_name.send_keys("libsyz")

password = driver.find_element(:css, "input[type=password]")
password.send_keys("sjnv249_in&fnc")

login = driver.find_element(:class, "btn-primary")
login.click

wait = Selenium::WebDriver::Wait.new(timeout: 20)

singapore = wait.until do
  driver.find_element(:link, "Singapore")
end

# Go to batches

singapore.click
batches = driver.find_element(:link, "Batches")
batches.click

# go to student list

wait.until do
  first_batch = driver.find_element(:css, "a[href='/camps/417/applications']")
end

first_batch = driver.find_element(:css, "a[href='/camps/417/applications']")
first_batch.click


funnel = driver.find_element(:css, "a.funnel-step-link[href='/camps/417/applications/codecademy']")
funnel.click


wait.until do
  driver.find_elements(:css, "a.card-link").size > 1
end

students = driver.find_elements(:css, "a.card-link")

students[0].click
sleep(2)

a_student = {}
# Let's get all the data from one guy

a_student[:motivation] = driver.find_element(:css, "p[data-target='applies.truncatedMotivation']").text
basic_info = driver.find_element(:css, ".card-white").text.split(/\n/)

a_student[:student_name] = basic_info[0]
a_student[:batch] = basic_info[3]
a_student[:student_age] = basic_info[5]
a_student[:student_gender] = basic_info[7]


# Workaround to make the form visible by clicking on a default button,

default_button = driver.find_elements(:css, "a.btn.btn-default").find {|el| el.text == "" }
default_button.click

sleep(2)

a_student[:company] = driver.find_element(:id, 'apply_interview_company_origin').text
a_student[:academic_level] = driver.find_element(:id, 'select2-apply_interview_academic_level-container').text
a_student[:nationality] = driver.find_element(:id, 'select2-apply_interview_nationality-container').text
a_student[:computer_type] = driver.find_element(:id, 'select2-apply_interview_computer_type-container').text
a_student[:persona] = driver.find_element(:id, 'select2-apply_interview_persona_type-container').text
a_student[:working_status] = driver.find_element(:id, 'select2-apply_interview_working_status-container').text
a_student[:coding_level] = driver.find_element(:id, 'select2-apply_interview_coding_level-container').text
a_student[:arriving_from] = driver.find_element(:id, 'select2-apply_interview_country_origin-container').text
a_student[:english_level] = driver.find_element(:id, 'select2-apply_interview_english_level-container').text


puts a_student




# iterate through the student list and get their data into a csv

