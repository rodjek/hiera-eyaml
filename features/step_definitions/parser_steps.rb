Given /^I make a parser instance with no regexs$/ do
  @parser = Hiera::Backend::Eyaml::Parser::Parser.new([])
end

Given /^I make a parser instance with the ENC regexs$/ do
  @parser = Hiera::Backend::Eyaml::Parser::ParserFactory.encrypted_parser
end

Given /^I make a parser instance with the DEC regexs$/ do
  @parser = Hiera::Backend::Eyaml::Parser::ParserFactory.decrypted_parser
end

And /^I load a file called (.*)$/ do |file|
  @content = File.read(expand_path(file))
end

And /^I configure the keypair$/ do
  Hiera::Backend::Eyaml::Options[:pkcs7_public_key] = expand_path("keys/public_key.pkcs7.pem")
  Hiera::Backend::Eyaml::Options[:pkcs7_private_key] = expand_path("keys/private_key.pkcs7.pem")
end

When /^I parse the content$/ do
  @tokens = @parser.parse @content
end

Then /^I should have (\d+) tokens?$/ do |number_of_tokens|
  expect(@tokens.size).to eq(number_of_tokens.to_i)
end

Then /^token (\d+) should be a (.*)$/ do |index, class_name|
  actual_class_name = @tokens[index.to_i - 1].class.name
  expect(actual_class_name.split('::').last).to eq(class_name)
end

Then /^token (\d+) should start with "(.*)"$/ do |index, content|
  token = @tokens[index.to_i - 1]
  expect(token.match).to match(/^#{Regexp.escape(content)}/)
end

Then /^token (\d+) should decrypt to start with "(.*)"$/ do |index, plain|
  token = @tokens[index.to_i - 1]
  expect(token.plain_text).to match(/^#{Regexp.escape(plain)}/)
end

And /^map it to index decrypted values$/ do
  @decrypted = @tokens.each_with_index.to_a.map{ |(t, index)|
    t.to_decrypted :index => index
  }
end

Then /^decryption (\d+) should be "(.*)"$/ do |index, content|
  decrypted = @decrypted[index.to_i]
  expect(decrypted).to eq(content)
end

Then(/^token (\d+) id should be (\d+)$/) do |index, token_id|
  token = @tokens[index.to_i - 1]
  expect(token.id).to eq(token_id.to_i)
end
