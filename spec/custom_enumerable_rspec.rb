# spec/custom_enumerable_rspec.rb
require './custom_enumerables.rb'

describe Enumerable do
  let(:arr) { [3, 5, 7, 2, 1] }
  let(:ran) { (1..10) }
  let(:person) { { 'name'=> 'AAA', 'age'=> 30, 'gender'=> 'male' } }
  let(:hash) { {} }

  describe '#my_each' do
    it 'return enumerable if block is not given' do
      expect(arr.my_each).to be_an_instance_of(Enumerator)
    end
    it 'returns the original array once it is done with the block' do
        arr.my_each { |x| x * 2 }
        expect(arr.my_each { |x| x * 2 }).to eql(arr)
      end
  
      it 'returns the original range once it is done with the block' do
        expect(ran.my_each { |x| x * 2 }).to eql(ran)
      end
  
      it 'returns the original hash once it is done with the block' do
        expect(person.my_each { |country| "country - #{country} " }).to eql(person)
      end
  end
  describe '#my_each_with_index' do
    it 'return enumerable if block is not given' do
      expect(arr.my_each_with_index).to be_an_instance_of(Enumerator)
    end
    it 'returns the original array once it is done with the block' do
        expect(arr.my_each_with_index { |x, index| x * 2 + index}).to eql(arr)
      end
  
      it 'returns the original range once it is done with the block' do
        expect(ran.my_each_with_index { |x, index| x * 2 }).to eql(ran)
      end
  
      it 'returns the original hash once it is done with the block' do
        expect(person.my_each_with_index { |country, index| "country - #{country} " }).to eql(person)
      end
  end

  describe "#my_select" do
  it 'return enumerable if block is not given' do
    expect(arr.my_select).to be_an_instance_of(Enumerator)
  end

  it 'Returns an array containing all elements of enum for which the given block returns a true value' do
    expect(arr.my_select { |x| x > 3 }).to eql([5,7])
  end

  it 'returns the original hash once it is done with the block' do
    expected={"gender"=>"male"}
    expect(person.my_select { |key, val| key == 'gender' }).to eql([["gender", "male"]])
  end
end
end
