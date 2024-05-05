# weather

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

There is Four page
  - Splash Page
      - when start the application this page show for 5 second every time.
      - if you login this app the after 5 second (go to Home Page) rather then (go to Login Page)
  - Login Page
      - there is two field 1-> for user name 2-> password
      - there is validation (can't be empty & validate the credential)
        
  - Home page
     - location base current date of weather data show
     - also show your local location
     - in app bar show current date and live time
       
  - Forecast page
     - show previous 16 date of data from current data
     - there is validation when data loaded first time (from weather api)
     - data save in your local device
    
1. Implement functionality to store login credentials securely in a configuration file.
2. Store the fetched 16 days forecast weather data in the configuration file.
3. Ensure that sensitive information is encrypted or hashed for security.
4. Verify the integrity of the stored data to prevent tampering.
 this all points done(in controller)
