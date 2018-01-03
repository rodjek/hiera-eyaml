class test::run {
  $data = hiera_hash($title)

  $test_1_value = $data['plaintext_string']
  $test_2_value = $data['encrypted_string']
  $test_3_value = inline_template("<%= require 'json'; JSON.pretty_generate(@data['encrypted_array']) %>")
  $test_4_value = inline_template("<%= require 'json'; JSON.pretty_generate(@data['encrypted_hash']) %>")
  $test_5_value = $data['encrypted_block']

  notify {
    "eyaml_puppettest.1: '${test_1_value}'": ;
    "eyaml_puppettest.2: '${test_2_value}'": ;
    "eyaml_puppettest.3: '${test_3_value}'": ;
    "eyaml_puppettest.4: '${test_4_value}'": ;
    "eyaml_puppettest.5: '${test_5_value}'": ;
  }
}
