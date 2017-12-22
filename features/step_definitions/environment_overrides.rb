Given /^my HOME is set to \"(.*?)\"$/ do |home_dir|
  set_environment_variable('HOME', expand_path(home_dir))
end
