from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time

# Set up the Chrome WebDriver (make sure to download ChromeDriver and set the path)
driver = webdriver.Chrome(executable_path='path_to_chromedriver')  # Replace with the correct path to chromedriver

try:
    # Step 1: Open the hotel booking website
    driver.get("https://www.example-hotel-booking.com")  # Replace with the actual URL
    driver.maximize_window()

    # Step 2: Search for hotels in "New York" from April 10 - April 15
    city_input = driver.find_element(By.ID, "city")  # Find the city input field
    city_input.clear()  # Clear any default text
    city_input.send_keys("New York")  # Type in the city name
    city_input.send_keys(Keys.RETURN)  # Hit enter to search

    # Set the check-in and check-out dates
    check_in_input = driver.find_element(By.ID, "check-in")  # Find the check-in input field
    check_in_input.clear()
    check_in_input.send_keys("04/10/2025")  # Enter the check-in date

    check_out_input = driver.find_element(By.ID, "check-out")  # Find the check-out input field
    check_out_input.clear()
    check_out_input.send_keys("04/15/2025")  # Enter the check-out date

    # Click the "Search" button to find hotels
    search_button = driver.find_element(By.XPATH, "//button[@id='search-btn']")  # Find and click the search button
    search_button.click()

    # Wait for the search results to load
    time.sleep(5)

    # Step 3: Select the first hotel from the results
    first_hotel = driver.find_element(By.XPATH, "(//div[@class='hotel-card'])[1]")  # Find the first hotel
    first_hotel.click()  # Click on the first hotel

    # Wait for the hotel page to load
    time.sleep(3)

    # Step 4: Apply the coupon code "SUMMER25"
    coupon_input = driver.find_element(By.ID, "coupon-input")  # Find the coupon input field
    coupon_input.clear()
    coupon_input.send_keys("SUMMER25")  # Enter the coupon code
    apply_button = driver.find_element(By.XPATH, "//button[@id='apply-coupon']")  # Find the apply button
    apply_button.click()  # Apply the coupon

    # Wait for the discount to be applied
    time.sleep(3)

    # Step 5: Verify the discount is applied correctly
    total_before = driver.find_element(By.XPATH, "//span[@id='total-price-before']")  # Get the total price before discount
    total_after = driver.find_element(By.XPATH, "//span[@id='total-price-after']")  # Get the total price after discount

    # Print the prices to the console
    print("Total price before discount:", total_before.text)
    print("Total price after discount:", total_after.text)

    # Check if the discount was applied correctly
    if float(total_before.text.replace('$', '')) > float(total_after.text.replace('$', '')):
        print("Discount applied successfully!")
    else:
        print("Discount was not applied correctly.")

    # Step 6: Proceed to checkout (but don't complete payment)
    checkout_button = driver.find_element(By.ID, "checkout-btn")  # Find the checkout button
    checkout_button.click()  # Click the checkout button

    # Wait for a few seconds to verify
    time.sleep(5)

except Exception as e:
    print(f"An error occurred: {e}")

finally:
    # Close the browser after the test
    driver.quit()
