Feature: eyaml encrypting

  In order to encrypt data
  As a developer using hiera-eyaml
  I want to use the eyaml tool to encrypt data in various ways

  Scenario: encrypt a simple string
    Given I use a fixture named "sandbox"
    When I run `eyaml encrypt -o string -s some_string`
    Then the output should match /ENC\[PKCS7,(.*?)\]$/

  Scenario: encrypt a simple file
    Given I use a fixture named "sandbox"
    When I run `eyaml encrypt -o string -f test_input.txt`
    Then the output should match /ENC\[PKCS7,(.*?)\]$/

  Scenario: encrypt a eyaml file
    Given I use a fixture named "sandbox"
    When I run `eyaml encrypt --eyaml test_plain.yaml`
    Then the output should match /key: ENC\[PKCS7,(.*?)\]$/

  Scenario: encrypt a binary file
    Given I use a fixture named "sandbox"
    When I run `eyaml encrypt -o string -f test_input.bin`
    Then the output should match /ENC\[PKCS7,(.*?)\]$/

  # FIXME: Something in the way Highline disables input echoing breaks Aruba's
  # interactive command functionality on Windows.
  @posix
  Scenario: encrypt a password
    Given I use a fixture named "sandbox"
    When I run `eyaml encrypt -o string -p` interactively
    And I type "secretme"
    And I close the stdin stream
    Then the output should contain "Enter password"
    And the output should match /ENC\[PKCS7,(.*?)\]/

  Scenario: encrypt using STDIN
    Given I use a fixture named "sandbox"
    When I run `eyaml encrypt -o string --stdin` interactively
    And I type "encrypt me"
    And I close the stdin stream
    Then the output should match /ENC\[PKCS7,(.*?)\]$/

  Scenario: encrypt as string with a label
    Given I use a fixture named "sandbox"
    When I run `eyaml encrypt -o string -s secret_thing -l db-password`
    Then the output should match /db-password: ENC\[PKCS7,(.*?)\]$/

  Scenario: encrypt as block with a label
    Given I use a fixture named "sandbox"
    When I run `eyaml encrypt -o block -s secret_thing -l db-password`
    Then the output should match /db-password: \>\s*ENC\[PKCS7,(.*?)\]$/
