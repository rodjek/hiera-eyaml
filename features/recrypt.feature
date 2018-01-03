Feature: Recrypt
  In order to handle require changes in crypt
  I want to be able to re-encrypt all keys in file

  Scenario: Recrypt encrypted yaml
    Given I use a fixture named "sandbox"
    And I recrypt a file
    And I configure the keypair
    And I load a file called test_input.yaml
    And I recrypt it twice
    Then I should have 35 tokens
    And the recrypted tokens should match
    And the recrypted decrypted content should match
    And the recrypted contents should differ
    And the tokens at 1 should match
    And the tokens at 5 should match

  Scenario: Recrypt encrypted yaml using the eyaml tool
    Given I use a fixture named "sandbox"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml recrypt test_input.yaml`
    Then the file "test_input.yaml" should not be equal to file "test_input.eyaml"
    When I run `eyaml decrypt -e test_input.eyaml`
    Then the output should match /encrypted_string: DEC::PKCS7\[planet of the apes\]\!/
    When I run `eyaml recrypt -d plaintext test_input.eyaml`
    Then the exit status should be 0
    When I run `eyaml decrypt -e test_input.eyaml`
    Then the output should match /encrypted_string: DEC::PLAINTEXT\[planet of the apes\]\!/
    When I run `eyaml recrypt -d pkcs7 test_input.eyaml`
    Then the exit status should be 0
    When I run `eyaml decrypt -e test_input.eyaml`
    Then the output should match /encrypted_string: DEC::PKCS7\[planet of the apes\]\!/
