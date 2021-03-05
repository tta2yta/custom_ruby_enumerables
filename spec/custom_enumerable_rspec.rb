# spec/custom_enumerable_rspec.rb
require './custom_enumerables'

describe Enumerable do
  let(:arr) { [3, 5, 7, 2, 1] }
  let(:ran) { (1..10) }
  let(:person) { { 'name' => 'AAA', 'age' => 30, 'gender' => 'male' } }
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
      expect(arr.my_each_with_index { |x, index| x * 2 + index }).to eql(arr)
    end

    it 'returns the original range once it is done with the block' do
      expect(ran.my_each_with_index { |x, _index| x * 2 }).to eql(ran)
    end

    it 'returns the original hash once it is done with the block' do
      expect(person.my_each_with_index { |country, _index| "country - #{country} " }).to eql(person)
    end
  end

  describe '#my_select' do
    it 'return enumerable if block is not given' do
      expect(arr.my_select).to be_an_instance_of(Enumerator)
    end
    it 'When array is geiven Returns an array containing all elements of enum for
     which the given block returns a true value' do
      expect(arr.my_select { |x| x > 3 }).to eql([5, 7])
    end

    it 'When hash is given Returns an array containing all elements of enum for
     which the given block returns a true value' do
      expect(person.my_select { |key, _val| key == 'gender' }).to eql([%w[gender male]])
    end
  end
  describe '#my_all?' do
    it 'return true if block is not given when none of the collection members are false or nil.' do
      expect(arr.my_all?).to eql(true)
    end
    it 'return false if block is not given when one of the collection members are false or nil.' do
      expect([nil, true, 99].my_all?).to eql(false)
    end
    it 'The method returns true if the block never returns false or nil' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eql(true)
    end
    it 'The method returns false if the block  returns false or nil' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 13 }).to eql(false)
    end
    it 'The method returns true if the pattern  matches every element' do
      expect([3, 3, 3, 3].my_all?(3)).to eql(true)
    end
    it 'The method returns flase if the pattern  does not matches every element' do
      expect([3, 3, 2, 3].all?(3)).to eql(false)
    end
    it 'When Regex is given,the method returns true if the pattern matches every element' do
      expect(%w[ant bear cat].my_all?(/a/)).to eql(true)
    end
    it 'When Regex is given,the method returns flase if the pattern does not matches every element' do
      expect(%w[ant bear cat].my_all?(/t/)).to eql(false)
    end
    it 'When class is given,the method returns true if the pattern matches every element' do
      expect([2, 4, 6, 7].my_all?(Numeric)).to eql(true)
    end
    it 'When Class is given,the method returns flase if the pattern does not matches every element' do
      expect([2, 4, 6, 't'].my_all?(Numeric)).to eql(false)
    end
  end
  describe '#my_any?' do
    it 'if block is not given return true  when at least one of the collection members is not false or nil.' do
      expect([nil, true, 99].my_any?).to eql(true)
    end
    it 'if block is not given return flase  when all of the collection members is false or nil.' do
      expect([nil, nil, false].my_any?).to eql(false)
    end
    it 'The method returns true if the block ever returns a value other than false or nil' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 4 }).to eql(true)
    end
    it 'The method returns false if the block ever returns false or nil' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 5 }).to eql(false)
    end
    it 'The method returns true if the pattern  matches at least one element' do
      expect([3, 2, 4, 5].my_any?(3)).to eql(true)
    end
    it 'The method returns false if the pattern does not matche at least one element' do
      expect([9, 2, 4, 5].my_any?(3)).to eql(false)
    end
    it 'When Regex is given,the method returns true if the pattern matches at least one element' do
      expect(%w[nnt bekr cat].my_any?(/a/)).to eql(true)
    end
    it 'When class is given,the method returns true if the pattern matches at least one element' do
      expect([2, '4', '6', 7].my_any?(Numeric)).to eql(true)
    end
    it 'When Regex is given,the method returns false if the pattern does not matche at least one element' do
      expect(%w[nnt bekr cpt].my_any?(/a/)).to eql(false)
    end
    it 'When class is given,the method returns false if the pattern does not matche at least one element' do
      expect(%w[2 4 6 7].my_any?(Numeric)).to eql(false)
    end
  end
  describe '#my_none?' do
    it 'If the block is not given, my_none? will return true only if none of the collection members is true.' do
      expect(%w[ant bear cat].my_none? { |word| word.length == 5 }).to eql(true)
    end
    it 'If the block is not given, my_none? will return false only
     if at least one of the collection members is true.' do
      expect(%w[ant bear cat].my_none? { |word| word.length == 4 }).to eql(false)
    end
    it 'The method returns true if the block never returns true for all elements' do
      expect(%w[ant bear cat].my_none? { |word| word.length == 5 }).to eql(true)
    end
    it 'The method returns false if the block ever returns true' do
      expect(%w[ant bear cat].my_none? { |word| word.length == 4 }).to eql(false)
    end
    it 'The method returns true if the pattern never returns true for all elements' do
      expect([13, 2, 4, 5].my_none?(3)).to eql(true)
    end
    it 'The method returns false if the pattern ever returns true' do
      expect([3, 2, 4, 5].my_none?(3)).to eql(false)
    end
    it 'When regex is gievn, The method returns true if the pattern never returns true for all elements' do
      expect(%w[nnt bekr ctt].my_none?(/a/)).to eql(true)
    end
    it 'When regex is gievn, The method returns false if the pattern ever returns true' do
      expect(%w[nnt bekr cat].my_none?(/a/)).to eql(false)
    end
    it 'When Class is gievn, The method returns true if the pattern never returns true for all elements' do
      expect(%w[2 4 6 7].my_any?(String)).to eql(true)
    end
    it 'When Class is gievn, The method returns false if the pattern ever returns true' do
      expect(%w[2 4 6 7].my_any?(Numeric)).to eql(false)
    end
  end
  describe '#my_count?' do
    ary = [1, 2, 4, 2]
    it 'If the block is not given, my_count? Returns the number of items in enum through enumeration' do
      expect(ary.my_count).to eql(4)
    end
    it 'If a block is given, it counts the number of elements yielding a true value' do
      expect(ary.my_count(2)).to eql(2)
    end
    it 'If an argument is given, the number of items in enum that are equal to item are counted' do
      expect(ary.my_count(&:even?)).to eql(3)
    end
  end
  describe '#my_map' do
    it 'return enum if block is not given' do
      expect(arr.my_map.instance_of?(Enumerator)).to be true
    end
    it 'iterates over a given array and returns a new array with instances that meet the condition' do
      expect(arr.my_map { |i| i * i }).to eql([9, 25, 49, 4, 1])
    end
    it 'iterates over a given range and returns a new array with instances that meet the condition' do
      expect(ran.my_map { |i| i * 1 }).to eql([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    end
    it 'iterates over a given array and returns a new array according to the proc condition' do
      factor = proc { |n| n * 2 }
      expect([3, 2, 1].my_map(&factor)).to eql([6, 4, 2])
    end
    it 'iterates over a given hash and return a new hash ' do
      expect(person.my_map { |key, value| [key, value] }.to_h).to eql(person)
    end
  end
end
