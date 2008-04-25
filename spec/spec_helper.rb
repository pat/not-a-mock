$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'not_a_mock'

Spec::Runner.configure do |config|
  ActiveRecord::Base.establish_connection(
    :adapter    => 'sqlite3',
    :database   => 'spec/fixtures/test.sqlite',
    :timeout    => 5000
  )
end