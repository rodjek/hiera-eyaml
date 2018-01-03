Feature: eyaml outputs

  In order to better understand the link between eyaml and yaml files
  As a developer using hiera-eyaml
  I want to use the eyaml tool to output encrypted data in various yaml formats

  Scenario: encrypt a simple string with default output
    Given I use a fixture named "sandbox"
    When I run `eyaml encrypt -s some_string`
    Then the output should match /string: ENC\[PKCS7,(.*?)\]/
    And the output should match /block: >\s*\n\s*ENC\[PKCS7,(.*?)\]/

  Scenario: encrypt a simple string with examples output
    Given I use a fixture named "sandbox"
    When I run `eyaml encrypt -o examples -s some_string`
    Then the output should match /string: ENC\[PKCS7,(.*?)\]/
    And the output should match /block: >\s*\n\s*ENC\[PKCS7,(.*?)\]/

  Scenario: encrypt a simple string with string output
    Given I use a fixture named "sandbox"
    When I run `eyaml encrypt -o string -s some_string`
    Then the output should match /^ENC\[PKCS7,(.*?)\]$/

  Scenario: encrypt a simple string with raw output
    Given I use a fixture named "sandbox"
    When I run `eyaml encrypt -o raw -s some_string`
    Then the output should match /^ENC\[PKCS7,(.*?)\]$/
    And the output should contain "\n"

  Scenario: encrypt a simple string with block output
    Given I use a fixture named "sandbox"
    When I run `eyaml encrypt -o block -s some_string`
    Then the output should match /^\s+ENC\[PKCS7,(.*?)\]$/
