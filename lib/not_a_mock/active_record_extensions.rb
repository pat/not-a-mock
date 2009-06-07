module NotAMock
  module ActiveRecord # :nodoc:
    def stub_instance(methods = {})
      @@__stub_object_id ||= 1000
      @@__stub_object_id += 1
      methods = methods.merge(
        :id => @@__stub_object_id,
        :to_param => @@__stub_object_id.to_s
      )
      NotAMock::Stub.new(self, methods)
    end
  end
end
