require 'not_a_mock/active_record_extensions'
require 'not_a_mock/call_recorder'
require 'not_a_mock/matchers'
require 'not_a_mock/matchers/anything_matcher'
require 'not_a_mock/matchers/args_matcher'
require 'not_a_mock/matchers/call_matcher'
require 'not_a_mock/matchers/method_matcher'
require 'not_a_mock/matchers/result_matcher'
require 'not_a_mock/matchers/times_matcher'
require 'not_a_mock/object_extensions'
require 'not_a_mock/rspec_mock_framework_adapter'
require 'not_a_mock/stubber'
require 'not_a_mock/stub'
require 'active_record'

Object.send(:include, NotAMock::ObjectExtensions)

proxy = ActiveRecord::Associations::AssociationProxy
proxy.send(:include, NotAMock::ObjectExtensions)

proxy.send(:class_eval) do
  # Re-introduce necessary methods
  define_method :should,        Object.instance_method(:should)
  define_method :metaclass,     Object.instance_method(:metaclass)
  define_method :proxy_class,   Object.instance_method(:class)
  
  # Redefine meta_eval to allow access to the AssociationProxy instance method
  # 'methods' - necessary for Stubber to check whether the methods exist or not.
  def meta_eval(&block)
    proxy_class.send :define_method, :methods, Object.instance_method(:methods)
    result = super
    proxy_class.send :undef_method, :methods
    
    return result
  end
end

module NotAMock
  module Version #:nodoc:
    Major = 1
    Minor = 1
    Tiny  = 0
    
    String = [Major, Minor, Tiny].join('.')
  end
end