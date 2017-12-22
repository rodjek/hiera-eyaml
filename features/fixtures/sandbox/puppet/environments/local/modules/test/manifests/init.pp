class test::run {
  $test_1_value = hiera("plaintext_string")
  $test_2_value = hiera("encrypted_string")
  # This is ugly, but cross-compatibility between early puppet 3 manifests and puppet 4
  # manifests is basically non-existent.  Assuming we support both...
  $test_3_value = $::puppetversion ? {
    /^4/    => inline_template("<%= scope.compiler.loaders.private_environment_loader.load(:function,'hiera').call(scope, 'encrypted_string') %>"),
    default => inline_template("<%= scope.function_hiera(['encrypted_string']) %>"),
  }
  $test_4_value = hiera("default_encrypted_string")
  $test_5_value = hiera("encrypted_block")

  notify {
    "eyaml_puppettest.1: '${test_1_value}'": ;
    "eyaml_puppettest.2: '${test_2_value}'": ;
    "eyaml_puppettest.3: '${test_3_value}'": ;
    "eyaml_puppettest.4: '${test_4_value}'": ;
    "eyaml_puppettest.5: '${test_5_value}'": ;
  }
}
