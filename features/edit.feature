Feature: eyaml editing

  In order to edit encrypted data
  As a developer using hiera-eyaml
  I want to use the eyaml tool to edit data in various ways

  @posix
  Scenario: decrypt an eyaml file
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "cat"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit test_input.eyaml`
    Then the output should match /encrypted_string: DEC\(\d+\)::PKCS7\[planet of the apes\]\!/
    And the output should match /encrypted_default_encryption_string: DEC\(\d+\)::PKCS7\[planet of the apes\]\!/
    And the output should match /encrypted_block: >\r?\n\s+DEC\(\d+\)::PKCS7\[gangs of new york\]\!/
    And the output should match /encrypted_tabbed_block: >\r?\n\s+DEC\(\d+\)::PKCS7\[gangs of new york\]\!/
    And the output should match /encrypted_default_encryption_block: >\r?\n\s+DEC\(\d\)::PKCS7\[gangs of new york\]\!/
    And the output should match /\- DEC\(\d+\)::PKCS7\[apocalypse now\]\!/
    And the output should match /\- DEC\(\d+\)::PKCS7\[the count of monte cristo\]\!/
    And the output should match /\- array4/
    And the output should match /\- DEC\(\d+\)::PKCS7\[dr strangelove\]\!/
    And the output should match /\- array5/
    And the output should match /\- >\r?\n\s+DEC\(\d+\)::PKCS7\[kramer vs kramer\]\!/
    And the output should match /\- >\r?\n\s+DEC\(\d+\)::PKCS7\[the manchurian candidate\]\!/
    And the output should match /\- >\r?\n\s+tomorrow and tomorrow and\s*\r?\n\s+tomorrow creeps/
    And the output should match /\- >\r?\n\s+DEC\(\d+\)::PKCS7\[much ado about nothing\]\!/
    And the output should match /\- >\r?\n\s+when shall we three meet again\r?\n\s+in thunder/
    And the output should match /\- DEC\(\d+\)::PKCS7\[the english patient\]\!/
    And the output should match /\- >\r?\n\s+DEC\(\d+\)::PKCS7\[the pink panther\]\!/
    And the output should match /\- >\r?\n\s+i wondered lonely\s*\r?\n\s+as a cloud/
    And the output should match /\s+key5: DEC\(\d+\)::PKCS7\[value5\]\!/
    And the output should match /\s+key6: DEC\(\d+\)::PKCS7\[value6\]\!/
    And the output should match /multi_encryption: DEC\(\d+\)::PLAINTEXT\[jammy\]\! DEC\(\d+\)::PKCS7\[dodger\]!/

  @windows
  Scenario: decrypt an eyaml file
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "powershell.exe -Command cat"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit test_input.eyaml`
    Then the output should match /encrypted_string: DEC\(\d+\)::PKCS7\[planet of the apes\]\!/
    And the output should match /encrypted_default_encryption_string: DEC\(\d+\)::PKCS7\[planet of the apes\]\!/
    And the output should match /encrypted_block: >\r?\n\s+DEC\(\d+\)::PKCS7\[gangs of new york\]\!/
    And the output should match /encrypted_tabbed_block: >\r?\n\s+DEC\(\d+\)::PKCS7\[gangs of new york\]\!/
    And the output should match /encrypted_default_encryption_block: >\r?\n\s+DEC\(\d\)::PKCS7\[gangs of new york\]\!/
    And the output should match /\- DEC\(\d+\)::PKCS7\[apocalypse now\]\!/
    And the output should match /\- DEC\(\d+\)::PKCS7\[the count of monte cristo\]\!/
    And the output should match /\- array4/
    And the output should match /\- DEC\(\d+\)::PKCS7\[dr strangelove\]\!/
    And the output should match /\- array5/
    And the output should match /\- >\r?\n\s+DEC\(\d+\)::PKCS7\[kramer vs kramer\]\!/
    And the output should match /\- >\r?\n\s+DEC\(\d+\)::PKCS7\[the manchurian candidate\]\!/
    And the output should match /\- >\r?\n\s+tomorrow and tomorrow and\s*\r?\n\s+tomorrow creeps/
    And the output should match /\- >\r?\n\s+DEC\(\d+\)::PKCS7\[much ado about nothing\]\!/
    And the output should match /\- >\r?\n\s+when shall we three meet again\r?\n\s+in thunder/
    And the output should match /\- DEC\(\d+\)::PKCS7\[the english patient\]\!/
    And the output should match /\- >\r?\n\s+DEC\(\d+\)::PKCS7\[the pink panther\]\!/
    And the output should match /\- >\r?\n\s+i wondered lonely\s*\r?\n\s+as a cloud/
    And the output should match /\s+key5: DEC\(\d+\)::PKCS7\[value5\]\!/
    And the output should match /\s+key6: DEC\(\d+\)::PKCS7\[value6\]\!/
    And the output should match /multi_encryption: DEC\(\d+\)::PLAINTEXT\[jammy\]\! DEC\(\d+\)::PKCS7\[dodger\]!/

  @posix
  Scenario: decrypting a eyaml file should create a temporary file
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "/usr/bin/env true"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit -v test_input.eyaml`
    Then the stderr should contain "Wrote temporary file"

  @windows
  Scenario: decrypting a eyaml file should create a temporary file
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "rundll32"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit -v test_input.eyaml`
    Then the stderr should contain "Wrote temporary file"

  @posix
  Scenario: decrypting a eyaml file should add a preamble
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "cat"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit test_input.eyaml`
    Then the output should match /#| This is eyaml edit mode/

  @windows
  Scenario: decrypting a eyaml file should add a preamble
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "powershell.exe -Command cat"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit test_input.eyaml`
    Then the output should match /#| This is eyaml edit mode/

  @posix
  Scenario: decrypting a eyaml file with --no-preamble should NOT add a preamble
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "cat"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit --no-preamble test_input.eyaml`
    Then the output should not match /#| This is eyaml edit mode/

  @windows
  Scenario: decrypting a eyaml file with --no-preamble should NOT add a preamble
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "powershell.exe -Command cat"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit --no-preamble test_input.eyaml`
    Then the output should not match /#| This is eyaml edit mode/

  @posix
  Scenario: editing a eyaml file should not leave the preamble
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "./convert_decrypted_values_to_uppercase.sh"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit test_input.eyaml`
    Then the file "test_input.eyaml" should not match /#| This is eyaml edit mode/

  @windows
  Scenario: editing a eyaml file should not leave the preamble
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "powershell.exe -InputFormat none -File convert_decrypted_values_to_uppercase.ps1"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit test_input.eyaml`
    Then the file "test_input.eyaml" should not match /#| This is eyaml edit mode/

  @posix
  Scenario: editing a non-existant eyaml file should give you a blank file
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "cat"
    And the file named "non-existant-file.eyaml" does not exist
    When I run `eyaml edit --no-preamble non-existant-file.eyaml`
    Then the output should match /^---/

  @windows
  Scenario: editing a non-existant eyaml file should give you a blank file
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "powershell.exe -Command cat"
    And the file named "non-existant-file.eyaml" does not exist
    When I run `eyaml edit --no-preamble non-existant-file.eyaml`
    Then the output should match /^---/

  @posix
  Scenario: editing a non-existant eyaml file should save a new file
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "./append.sh test_new_values.yaml"
    And the file named "non-existant-file.eyaml" does not exist
    When I run `eyaml edit non-existant-file.eyaml`
    And I run `eyaml decrypt -e non-existant-file.eyaml`
    Then the output should not match /#| This is eyaml edit mode/
    And the output should match /new_key1: DEC::PKCS7\[new value one\]\!/
    And the output should match /new_key2: DEC::PKCS7\[new value two\]\!/

  @windows
  Scenario: editing a non-existant eyaml file should save a new file
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "powershell.exe -InputFormat none -File append.ps1 test_new_values.yaml"
    And the file named "non-existant-file.eyaml" does not exist
    When I run `eyaml edit non-existant-file.eyaml`
    And I run `eyaml decrypt -e non-existant-file.eyaml`
    Then the output should not match /#| This is eyaml edit mode/
    And the output should match /new_key1: DEC::PKCS7\[new value one\]\!/
    And the output should match /new_key2: DEC::PKCS7\[new value two\]\!/

  @posix
  Scenario: decrypt and reencrypt an eyaml file
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "./convert_decrypted_values_to_uppercase.sh"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit test_input.eyaml`
    And I run `eyaml decrypt -e test_input.eyaml`
    Then the output should match /encrypted_string: DEC::PKCS7\[PLANET OF THE APES\]\!/
    And the output should match /encrypted_block: >\r?\n\s+DEC::PKCS7\[GANGS OF NEW YORK\]\!/
    And the output should match /\- DEC::PKCS7\[APOCALYPSE NOW\]\!/
    And the output should match /\- DEC::PKCS7\[THE COUNT OF MONTE CRISTO\]\!/
    And the output should match /\- array4/
    And the output should match /\- DEC::PKCS7\[DR STRANGELOVE\]\!/
    And the output should match /\- array5/
    And the output should match /\- >\r?\n\s+DEC::PKCS7\[KRAMER VS KRAMER\]\!/
    And the output should match /\- >\r?\n\s+DEC::PKCS7\[THE MANCHURIAN CANDIDATE\]\!/
    And the output should match /\- >\r?\n\s+tomorrow and tomorrow and\s*\r?\n\s+tomorrow creeps/
    And the output should match /\- >\r?\n\s+DEC::PKCS7\[MUCH ADO ABOUT NOTHING\]\!/
    And the output should match /\- >\r?\n\s+when shall we three meet again\r?\n\s+in thunder/
    And the output should match /\- DEC::PKCS7\[THE ENGLISH PATIENT\]\!/
    And the output should match /\- >\r?\n\s+DEC::PKCS7\[THE PINK PANTHER\]\!/
    And the output should match /\- >\r?\n\s+i wondered lonely\s*\r?\n\s+as a cloud/
    And the output should match /\s+key5: DEC::PKCS7\[VALUE5\]\!/
    And the output should match /\s+key6: DEC::PKCS7\[VALUE6\]\!/
    And the output should match /multi_encryption: DEC::PLAINTEXT\[JAMMY\]\! DEC::PKCS7\[DODGER\]\!/

  @windows
  Scenario: decrypt and reencrypt an eyaml file
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "powershell.exe -InputFormat none -File convert_decrypted_values_to_uppercase.ps1"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit test_input.eyaml`
    And I run `eyaml decrypt -e test_input.eyaml`
    Then the output should match /encrypted_string: DEC::PKCS7\[PLANET OF THE APES\]\!/
    And the output should match /encrypted_block: >\r?\n\s+DEC::PKCS7\[GANGS OF NEW YORK\]\!/
    And the output should match /\- DEC::PKCS7\[APOCALYPSE NOW\]\!/
    And the output should match /\- DEC::PKCS7\[THE COUNT OF MONTE CRISTO\]\!/
    And the output should match /\- array4/
    And the output should match /\- DEC::PKCS7\[DR STRANGELOVE\]\!/
    And the output should match /\- array5/
    And the output should match /\- >\r?\n\s+DEC::PKCS7\[KRAMER VS KRAMER\]\!/
    And the output should match /\- >\r?\n\s+DEC::PKCS7\[THE MANCHURIAN CANDIDATE\]\!/
    And the output should match /\- >\r?\n\s+tomorrow and tomorrow and\s*\r?\n\s+tomorrow creeps/
    And the output should match /\- >\r?\n\s+DEC::PKCS7\[MUCH ADO ABOUT NOTHING\]\!/
    And the output should match /\- >\r?\n\s+when shall we three meet again\r?\n\s+in thunder/
    And the output should match /\- DEC::PKCS7\[THE ENGLISH PATIENT\]\!/
    And the output should match /\- >\r?\n\s+DEC::PKCS7\[THE PINK PANTHER\]\!/
    And the output should match /\- >\r?\n\s+i wondered lonely\s*\r?\n\s+as a cloud/
    And the output should match /\s+key5: DEC::PKCS7\[VALUE5\]\!/
    And the output should match /\s+key6: DEC::PKCS7\[VALUE6\]\!/
    And the output should match /multi_encryption: DEC::PLAINTEXT\[JAMMY\]\! DEC::PKCS7\[DODGER\]\!/

  @posix
  Scenario: decrypt and reencrypt an eyaml file with multiple new values
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "./append.sh test_new_values.yaml"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit test_input.eyaml`
    And I run `eyaml decrypt -e test_input.eyaml`
    Then the output should match /encrypted_string: DEC::PKCS7\[planet of the apes\]\!/
    And the output should match /new_key1: DEC::PKCS7\[new value one\]\!/
    And the output should match /new_key2: DEC::PKCS7\[new value two\]\!/
    And the output should match /multi_encryption: DEC::PLAINTEXT\[jammy\]\! DEC::PKCS7\[dodger\]!/

  @windows
  Scenario: decrypt and reencrypt an eyaml file with multiple new values
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "powershell.exe -InputFormat none -File append.ps1 test_new_values.yaml"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit test_input.eyaml`
    And I run `eyaml decrypt -e test_input.eyaml`
    Then the output should match /encrypted_string: DEC::PKCS7\[planet of the apes\]\!/
    And the output should match /new_key1: DEC::PKCS7\[new value one\]\!/
    And the output should match /new_key2: DEC::PKCS7\[new value two\]\!/
    And the output should match /multi_encryption: DEC::PLAINTEXT\[jammy\]\! DEC::PKCS7\[dodger\]!/

  @posix
  Scenario: not editing a file should result in an untouched file
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "/usr/bin/env true"
    And I copy the file named "test_edit.yaml" to "test_edit.eyaml"
    When I run `eyaml edit test_edit.eyaml`
    Then the file "test_edit.yaml" should be equal to file "test_edit.eyaml"

  @windows
  Scenario: not editing a file should result in an untouched file
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "rundll32"
    And I copy the file named "test_edit.yaml" to "test_edit.eyaml"
    When I run `eyaml edit test_edit.eyaml`
    Then the file "test_edit.yaml" should be equal to file "test_edit.eyaml"

  @posix
  Scenario: not editing a file should result in a no changes detected message
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "/usr/bin/env true"
    And I copy the file named "test_edit.yaml" to "test_edit.eyaml"
    When I run `eyaml edit test_edit.eyaml`
    Then the stderr should contain "No changes detected"

  @windows
  Scenario: not editing a file should result in a no changes detected message
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "rundll32"
    And I copy the file named "test_edit.yaml" to "test_edit.eyaml"
    When I run `eyaml edit test_edit.eyaml`
    Then the stderr should contain "No changes detected"

  @posix
  Scenario: not modifying the plaintext should result in no encryption
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "sed -i.bak s/simple_array/test_array/g"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit -t test_input.eyaml`
    Then the output should not contain "PKCS7 encrypt"

  @windows
  Scenario: not modifying the plaintext should result in no encryption
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "powershell.exe -InputFormat none -File sed.ps1 simple_array test_array"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit -t test_input.eyaml`
    Then the output should not contain "PKCS7 encrypt"

  @posix
  Scenario: modifying the plaintext should result in an encryption
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "sed -i.bak s/value6/value7/g"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit -t test_input.eyaml`
    Then the output should contain "PKCS7 encrypt"

  @windows
  Scenario: modifying the plaintext should result in an encryption
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "powershell.exe -InputFormat none -File sed.ps1 value6 value7"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit -t test_input.eyaml`
    Then the output should contain "PKCS7 encrypt"

  @posix
  Scenario: editing but not modifying a eyaml file with --no-preamble should be detected
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "/usr/bin/env true"
    And I copy the file named "test_edit.yaml" to "test_edit.eyaml"
    When I run `eyaml edit --no-preamble test_edit.eyaml`
    Then the stderr should contain "No changes detected"

  @windows
  Scenario: editing but not modifying a eyaml file with --no-preamble should be detected
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "rundll32"
    And I copy the file named "test_edit.yaml" to "test_edit.eyaml"
    When I run `eyaml edit --no-preamble test_edit.eyaml`
    Then the stderr should contain "No changes detected"

  @posix
  Scenario: EDITOR has a space in it that isn't quoted or escaped
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "./path/spaced editor.sh"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit test_input.eyaml`
    Then the stderr should contain "No changes detected"

  @posix
  Scenario: EDITOR has a space in it that is escaped but not isn't quoted
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "./path/spaced\ editor.sh"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit test_input.eyaml`
    Then the stderr should contain "No changes detected"

  @posix
  Scenario: EDITOR has a space in it that is quoted
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to ""./path/spaced editor.sh""
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit test_input.eyaml`
    Then the stderr should contain "No changes detected"

  @posix
  Scenario: EDITOR is an executable on PATH
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "editor.sh"
    And I look for executables in "path" within the current directory
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit test_input.eyaml`
    Then the stderr should contain "No changes detected"

  @posix
  Scenario: EDITOR is an executable on PATH and contains arguments
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "editor.sh -c"
    And I look for executables in "path" within the current directory
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit test_input.eyaml`
    Then the output should match /editor\.sh" -c/
    Then the stderr should contain "No changes detected"

  @posix
  Scenario: EDITOR is an executable on PATH and has a space in it that isn't quoted or escaped
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "spaced editor.sh"
    And I look for executables in "path" within the current directory
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit test_input.eyaml`
    Then the stderr should contain "No changes detected"

  @posix
  Scenario: EDITOR is an executable on PATH and has a space in it that is escaped but not quoted
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "spaced\ editor.sh"
    And I look for executables in "path" within the current directory
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit test_input.eyaml`
    Then the stderr should contain "No changes detected"

  @posix
  Scenario: EDITOR is an executable on PATH and has a space in it that is quoted
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to ""spaced editor.sh""
    And I look for executables in "path" within the current directory
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit test_input.eyaml`
    Then the stderr should contain "No changes detected"

  @posix
  Scenario: EDITOR is an executable on PATH and has a space in it and contains arguments
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "spaced editor.sh -c"
    And I look for executables in "path" within the current directory
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit test_input.eyaml`
    Then the output should match /spaced editor\.sh" -c/
    And the stderr should contain "No changes detected"

  Scenario: EDITOR is invalid
    Given I use a fixture named "sandbox"
    And I set the environment variable "EDITOR" to "does_not_exist.sh"
    And I copy the file named "test_input.yaml" to "test_input.eyaml"
    When I run `eyaml edit test_input.eyaml`
    Then the stderr should contain "Editor did not exit successfully"
    And the stderr should not contain "Wrote temporary file"
