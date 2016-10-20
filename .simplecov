SimpleCov.start do
  add_filter '/spec/'
  add_filter '/config/'
  add_filter '/lib/'
  add_filter '/vendor/'
  add_filter '/features/'
  
  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
  add_group 'Helpers', 'app/helpers'
  add_group 'Mailers', 'app/mailers'
  add_group 'Views', 'app/views'
end if not ENV["IGNORE_SIMPLECOV"]
# run with $ IGNORE_SIMPLECOV=true bundle exec rake spec
