require 'spec_helper'

describe HashUtils do

  it "#map_keys" do
    h = {
      "a" => "a",
      "b" => "b"
    }

    expect(HashUtils.map_keys(h) { |k| k.upcase }).to eq({"A" => "a", "B" => "b"})
  end

  it "#map_values" do
    h = {
      "a" => "a",
      "b" => "b"
    }

    expect(HashUtils.map_values(h) { |v| v.upcase }).to eq({"a" => "A", "b" => "B"})
  end

  it "#rename_keys" do
    expect(HashUtils.rename_keys({foo: :bar}, {foo: 1, doo: 2}))
      .to eq({bar: 1, doo: 2})
    expect(HashUtils.rename_keys({foo: :bar}, {goo: 1, doo: 2}))
      .to eq({goo: 1, doo: 2})
  end

  it "#symbolize_keys" do
    expect(HashUtils.symbolize_keys({"foo" => 1, :bar => 2}))
      .to eq({foo: 1, bar: 2})
  end

  it "#pluck" do
    data = [{name: "John", age: 15}, {name: "Joe"}]
    expect(HashUtils.pluck(data, :name, :age)).to eq(["John", 15, "Joe"])
  end

  it "#sub" do
    expect(HashUtils.sub({first: "First", last: "Last", age: 55}, :first, :age, :sex))
      .to eq({first: "First", age: 55})
  end

  describe "#transpose" do
    let(:h) { {a: [1, 2, 3], b: [2, 3, 4], c: [2]} }

    it "transposes hash keys and values" do
      expect(HashUtils.transpose(h))
        .to eq(
              {
                1 => [:a],
                2 => [:a, :b, :c],
                3 => [:a, :b],
                4 => [:b]
              })
    end

    it "transposing twice results original hash" do
      expect(HashUtils.transpose(HashUtils.transpose(h))).to eq(h)
    end
  end
end
