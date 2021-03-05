# spec/custom_enumerable_rspec.rb
require './custom_enumerables.rb'

describe Enumerable do
  let(:arr) { [3, 5, 7, 2, 1] }
  let(:ran) { (1..10) }
  let(:board) { { 'name': 'AAA', 'age': 30, 'gender': 'male' } }

  describe '#my_each' do
    it 'return enumerable if block is not given' do
      expect(arr.my_each).to be_an_instance_of(Enumerator)
    end
  end
end
