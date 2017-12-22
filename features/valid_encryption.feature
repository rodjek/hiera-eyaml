Feature: eyaml encrypting is valid

  Scenario: encrypt and decrypt a binary file
    Given I use a fixture named "sandbox"
    When I run `eyaml encrypt -o string -f test_input.bin` and redirect stdout to the file "test_output.txt"
    And I run `eyaml decrypt -f test_output.txt` and redirect stdout to the file "test_output.bin"
    Then the file "test_output.bin" should contain a PNG image

  Scenario: encrypt and decrypt a simple file
    Given I use a fixture named "sandbox"
    When I run `eyaml encrypt -o string -f test_input.txt` and redirect stdout to the file "test_output.txt"
    And I run `eyaml decrypt -f test_output.txt`
    Then the output should match /fox jumped over/
