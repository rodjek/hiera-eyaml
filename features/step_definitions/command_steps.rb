When(/^I run `([^`]*)` and redirect stdout to the file "(.*?)"/) do |cmd, output_file|
  cmd = sanitize_text(cmd)
  run_simple(cmd, :fail_on_error => false)

  write_file(output_file, last_command_started.stdout)
end
