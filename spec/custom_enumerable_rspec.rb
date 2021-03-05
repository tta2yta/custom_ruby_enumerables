# spec/custom_enumerable_rspec.rb
require './custom_enumerables.rb'

describe Enumerable do
  let(:arr) { [3, 5, 7, 2, 1] }
  let(:ran) { (1..10) }
  let(:person) { { 'name': 'AAA', 'age': 30, 'gender': 'male' } }
  let(:hash) { {} }

  describe '#my_each' do
    it 'return enumerable if block is not given' do
      expect(arr.my_each).to be_an_instance_of(Enumerator)
    end
    it 'returns the original array once it is done with the block' do
        arr.my_each { |x| puts x * 2 }
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
        expect(arr.my_each_with_index { |x| x * 2 }).to eql(arr)
      end
  
      it 'returns the original range once it is done with the block' do
        expect(ran.my_each_with_index { |x| x * 2 }).to eql(ran)
      end
  
      it 'returns the original hash once it is done with the block' do
        expect(person.my_each_with_index { |country| "country - #{country} " }).to eql(person)
      end
      it 'iterates over a given array while retriving the index' do
        arr.my_each_with_index { |numbers, index| hash[numbers] = index }
        expect(hash).to eql(3 => 0, 5 => 1, 7 => 2, 2 => 3, 1 => 4)
      end
      it 'iterates over a given hash while retriving the index' do
        person.my_each_with_index { |user, index| hash[user] = index }
        expect(hash).to eql( [name: AAA]=> 0, [age: 30] => 1, [gender: male] => 2)
      end
  end
end
