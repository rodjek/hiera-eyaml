Feature: eyaml hiera integration

  In order to use eyaml as a hiera plugin
  As a developer using hiera-eyaml
  I want to verify that hiera-eyaml works within puppet and hiera

  Scenario: verify puppet with hiera can use hiera-eyaml to decrypt data
    Given I use a fixture named "sandbox"
    When I run `puppet apply --disable_warnings deprecations --confdir ./puppet --node_name_value localhost puppet/manifests/init.pp`
    Then the output should contain "eyaml_puppettest.1: 'good night'"
    And the output should contain "eyaml_puppettest.2: 'and good luck'"
    And the output should contain "eyaml_puppettest.3: 'and good luck'"
    And the output should contain "eyaml_puppettest.4: 'and good luck'"
    And the output should contain "eyaml_puppettest.5: 'gangs of new york'"

  Scenario: verify puppet and facter for correct hash merge with incorrect fact
    Given I use a fixture named "sandbox"
    And I set the environment variable "FACTER_fact" to "not-existcity"
    When I run `puppet apply --disable_warnings deprecations --confdir ./puppet-hiera-merge --node_name_value localhost puppet-hiera-merge/manifests/init.pp`
    Then the output should contain "eyaml_puppettest.1: 'good night'"
    And the output should contain "eyaml_puppettest.2: 'great to see you'"
    And the output should match /eyaml_puppettest.3: '\[\s+"good luck"\s+\]'/
    And the output should match /eyaml_puppettest.4: '{\s+"here": "we go again!"\s+}'/
    And the output should contain "eyaml_puppettest.5: 'gangs of new york\nis to the warriors'"

  Scenario: verify puppet and facter for correct hash merge
    Given I use a fixture named "sandbox"
    And I set the environment variable "FACTER_fact" to "city"
    When I run `puppet apply --disable_warnings deprecations --confdir ./puppet-hiera-merge --node_name_value localhost puppet-hiera-merge/manifests/init.pp`
    Then the output should contain "eyaml_puppettest.1: 'rise and shine'"
    And the output should contain "eyaml_puppettest.2: 'break a leg'"
    And the output should match /eyaml_puppettest.3: '\[\s+"good luck",\s+"it'll be alright on the night!"\s+\]'/
    And the output should match /eyaml_puppettest.4: '{\s+"here": "be rabbits",\s+"see": "no evil"\s+}'/
    And the output should contain "eyaml_puppettest.5: 'source code\nis to donny darko'"
