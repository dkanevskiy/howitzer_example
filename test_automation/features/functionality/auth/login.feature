@ok
Feature: Log In
  As a user 
  I want to use my credentials to login the system
  So I can login the system

  @bvt
  Scenario: visitor can open Login page via menu
    Given Home page of web application
    When I click Login menu item on Home page
    Then Login page should be displayed

  @bvt
  Scenario: visitor can login with correct credentials
    Given registered user with data:
      | email    | UNIQ_USER[:email]    |
      | password | UNIQ_USER[:password] |
    And Login page of web application
    When I fill Login form on Login page with data:
      | email    | UNIQ_USER[:email]    |
      | password | UNIQ_USER[:password] |
    And I submit Login form on Login page
    Then I should be logged in the system
    And Home page should be displayed

  @bvt
  Scenario: visitor can login with remembering credentials
    Given registered user with data:
      | email    | UNIQ_USER[:email]    |
      | password | UNIQ_USER[:password] |
    And Login page of web application
    When I fill Login form on Login page with data:
      | email    | UNIQ_USER[:email]    |
      | password | UNIQ_USER[:password] |
    And I enable Remember me checkbox
    And I submit Login form on Login page
    Then I should be logged in the system
    And Home page should be displayed
    When I logout and login the system
    And I click on Email field on Login page
    And I choose in dropdown list following data:
      | email    | UNIQ_USER[:email]    |
    Then Login form on Login page should be filled with data:
      | email    | UNIQ_USER[:email]    |
      | password | UNIQ_USER[:password] |
    And I submit Login form on Login page
    And I should be logged in the system
    And Home page should be displayed

  @p1
  Scenario: visitor can not login without credentials
    Given registered user with data:
      | email    | UNIQ_USER[:email]    |
      | password | UNIQ_USER[:password] |
    And Login page of web application
    When I fill Login form on Login page with data:
      | email    | UNIQ_USER[:email]    |
      | password |                      |
    And I submit Login form on Login page
    Then I should not be logged in the system
    And I should see following text on Login page:
      """
      Invalid email or password.
      """
    When I fill Login form on Login page with data:
      | email    |                      |
      | password | UNIQ_USER[:password] |
    And I submit Login form on Login page
    Then I should not be logged in the system
    And I should see following text on Login page:
      """
      Invalid email or password.
      """
    When I fill Login form on Login page with data:
      | email    |                      |
      | password |                      |
    And I submit Login form on Login page
    Then I should not be logged in the system
    And I should see following text on Login page:
      """
      Invalid email or password.
      """
      
  @p1
  Scenario: visitor can not login with incorrect credentials
    Given registered user with data:
      | email    | UNIQ_USER[:email]    |
      | password | UNIQ_USER[:password] |
    And Login page of web application
    When I fill Login form on Login page with data:
      | email    | test@test.test       |
      | password | UNIQ_USER[:password] |
    And I submit Login form on Login page
    And I should see following text on Login page:
      """
      Invalid email or password.
      """
    When I fill Login form on Login page with data:
      | email    | UNIQ_USER[:email]    |
      | password | test_login           |
    And I submit Login form on Login page
    And I should see following text on Login page:
      """
      Invalid email or password.
      """
    When I fill Login form on Login page with data:
      | email    | test@test.test       |
      | password | test_login           |
    And I submit Login form on Login page
    And I should see following text on Login page:
      """
      Invalid email or password.
      """
    When I fill Login form on Login page with data:
      | email    | test.1234567890      |
    Then I should see following text on Login page:
      """
      Необходимо ввести допустимый адрес электронной почты
      """
  
  @bvt
  Scenario: visitor can not login until confirmation email is not confirmed
    Given Sign up page of web application
    When I fill Sign up form on Sign up page with data:
      | user_name             | UNIQ_USER[:full_name] |
      | email                 | UNIQ_USER[:email]     |
      | password              | UNIQ_USER[:password]  |
      | password_confirmation | UNIQ_USER[:password]  |
    And I submit Sign up form on Sign up page
    Then I should not be signed in the system
    And Home page should be displayed
    And I should see following text on Home page:
      """
      A message with a confirmation link has been sent to your email address. Please open the link to activate your account.
      """
    And I fill Login form on Login page with data:
      | email    | UNIQ_USER[:email]    |
      | password | UNIQ_USER[:password] |
    And I submit Login form on Login page
    Then I should not be logged in the system
    And I should see following text on Login page:
      """
      You have to confirm your account before continuing.
      """

  @p1
  Scenario: visitor can initiate sign up
    Given Login page of web application
    When I click Sign up menu item on Login page
    Then Sign up page should be displayed

  @bvt
  Scenario: canceled user can not login
    Given registered user with data:
      | email    | UNIQ_USER[:email]    |
      | password | UNIQ_USER[:password] |
    And Edit account page of web application
    When I click Cancel account item on Edit account page
    And I submit action
    Then I should see following text on Home page:
      """
      Bye! Your account was successfully cancelled. We hope to see you again soon.
      """
    When I fill Login form on Login page with data:
      | email    | UNIQ_USER[:email]    |
      | password | UNIQ_USER[:password] |
    And I submit Login form on Login page
    Then I should see following text on Home page:
      """
      Invalid email or password.
      """
