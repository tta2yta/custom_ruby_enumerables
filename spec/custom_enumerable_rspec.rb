# spec/custom_enumerable_rspec.rb
require './custom_enumerables.rb'

describe Enumerable do
  let(:arr) { [3, 5, 7, 2, 1] }
  let(:ran) { (1..10) }
  let(:person) { { 'name': 'AAA', 'age': 30, 'gender': 'male' } }

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
end
