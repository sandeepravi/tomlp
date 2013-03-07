require "spec_helper"
require "tomlp"

describe TOMLP do

  before do
    filepath = File.join(File.dirname(__FILE__), 'spec.toml')
    @content = File.open(filepath).read
    @parsed = TOMLP.parse(@content)
  end

  describe "key values" do
    describe "primitives" do
      it "should parse integer" do
        @parsed["number"].should == 38
      end

      it "should parse string" do
        @parsed["string"].should == "This is a string."
      end

      it "should parse true" do
        @parsed["true"].should == true
      end

      it "should parse false" do
        @parsed["false"].should == false
      end

      it "should parse float" do
        @parsed["float"].should == 0.57721
      end

      it "should parse datetime" do
        @parsed["datetime"].should == DateTime.parse("1988-05-28")
      end

      it "should parse arrays" do
        @parsed["array"].should == [1, 2, 3]
      end
    end
  end

  describe "integers" do
    it "should parse positive integers" do
      @parsed["integer"]["positive"].should == 38
    end

    it "should parse negative integers" do
      @parsed["integer"]["negative"].should == -38
    end
  end

  describe "arrays" do
    it "should parse differnt primitives" do
      @parsed["arrays"]["normal"].should == ["a","b","c"]
    end

    it "should parse multi arrays" do
      @parsed["arrays"]["multi"].should == [[1,2], 100, 20]
    end

    it "should parse arrays with line break" do
      @parsed["arrays"]["break"].should == ["first", "second", "third"]
    end
  end

  describe "keygroups" do
    it "should parse keygroups in one line" do
      @parsed["key"]["group"]["value"].should == 1
    end

    it "should parse nested keygroups" do
      @parsed["keygroup"]["nested"]["new_value"].should == 12
    end
  end
end
