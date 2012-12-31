class BloomFilter

  # @param [Integer] size
  def initialize(size)
    @filterSize = size
    @filter = Array.new(@filterSize) { |index| 0 }
  end

  def add_hash(str)
    count = 0
    str.to_s.each_byte do |j|
      count += j
    end
    count % @filterSize
  end

  def xor_hash(str)
     count = 0
    str.to_s.each_byte do |j|
      count ^= j
    end
    count % @filterSize
  end

  def mult_hash(str)
    count = 1
    str.to_s.each_byte do |j|
      count *= j
    end
    count % @filterSize
  end

  def add(str)
    addHashVal = add_hash(str).to_i
    multHashVal = mult_hash(str).to_i
    xorHashVal = xor_hash(str).to_i
    # puts "Div Hash - " +
    @filter[addHashVal] = 1
    @filter[multHashVal] = 1
    @filter[xorHashVal] = 1
  end

  def check(str)
    addHashVal = add_hash(str).to_i
    multHashVal = mult_hash(str).to_i
    xorHashVal = xor_hash(str).to_i
    if @filter[addHashVal] == 1 && @filter[multHashVal] == 1 && @filter[xorHashVal] == 1
      true
    else
      false
    end

  end

  def print_filter
    @filter.each() { |i| print i}
    print "\n"
  end

end

puts "Bloom Filter test"
bf = BloomFilter.new(23)
bf.add "cockatiel"
bf.add "parrot"
bf.add "sparrow"
bf.add "arrisons"
bf.print_filter
puts (bf.check "cockatiel").to_s
puts (bf.check "parakeet").to_s
puts (bf.check "arrisons").to_s
