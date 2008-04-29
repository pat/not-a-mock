require 'rake'
require 'spec/rake/spectask'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'rake/contrib/sshpublisher'

$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'

require 'spec'
require 'not_a_mock'

Gem::Specification.new do |s|
  s.name = "not_a_mock"
  s.version = NotAMock::Version::String
  s.date = "2008-04-28"
  s.summary = "A cleaner and DRYer alternative to mocking and stubbing with RSpec."
  s.email = "pete@notahat.com"
  s.homepage = "http://notahat.com/not_a_mock"
  s.description = "A cleaner and DRYer alternative to mocking and stubbing with RSpec."
  s.has_rdoc = true
  s.authors = ["Pete Yandell"]
  s.files = FileList[
    "lib/**/*.rb",
    # "MIT-LICENCE",
    "README"
  ]
  s.test_files = FileList["spec/**/*_spec.rb"]
  s.rdoc_options << "--title" << "Not A Mock" << "--line-numbers"
  s.extra_rdoc_files = ["README"]
end