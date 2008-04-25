require 'spec/spec_helper'

class Parent < ActiveRecord::Base
  has_many :items do
    def all
      find(:all)
    end
    
    def initial
      all.first
    end
  end
end

class Item < ActiveRecord::Base
  belongs_to :parent
end

describe "A stubbed ActiveRecord object" do
  before do
    @parent = Parent.stub_instance
  end
  
  it "should return a valid id" do
    lambda { @parent.id }.should_not raise_error(NoMethodError)
    @parent.id.should be_an_instance_of(Fixnum)
  end
  
  it "should return the id as a string for to_param" do
    lambda { @parent.to_param }.should_not raise_error(NoMethodError)
    @parent.to_param.should be_an_instance_of(String)
    @parent.to_param.should == @parent.id.to_s
  end
  
  describe " association methods" do
    before :each do
      @parent = Parent.new
    end
    
    it "should include 'should' for the proxy object" do
      @parent.items.proxy_respond_to?(:should).should be_true
    end
        
    it "should include 'meta_eval' for the proxy object" do
      @parent.items.proxy_respond_to?(:meta_eval).should == true
    end
    
    it "should include 'metaclass' for the proxy object" do
      @parent.items.proxy_respond_to?(:metaclass).should == true
    end
    
    it "should allow stubbing of extended methods" do
      @parent.items.stub_method(:all => ["a", "b", "c"])
      @parent.items.initial.should == "a"
      @parent.items.should have_received(:all)
    end
    
    it "should include 'methods' for the proxy object only within a meta_eval block" do
      @parent.items.proxy_respond_to?(:methods).should == false
      @parent.items.methods
      
      object = @parent.items
      object.meta_eval {
        object.proxy_respond_to?(:methods)
      }.should be_true
      
      @parent.items.proxy_respond_to?(:methods).should == false
    end
  end
  
  after do
    NotAMock::CallRecorder.instance.reset
    NotAMock::Stubber.instance.reset
  end
end
