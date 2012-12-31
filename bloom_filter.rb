class BloomFilter

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
    puts "Adding " + str.to_s + " / hashes: "+ addHashVal.to_s + ", " + multHashVal.to_s + ", " + xorHashVal.to_s
    @filter[addHashVal] = 1
    @filter[multHashVal] = 1
    @filter[xorHashVal] = 1
  end

  def check(str)
    addHashVal = add_hash(str).to_i
    multHashVal = mult_hash(str).to_i
    xorHashVal = xor_hash(str).to_i
    puts "Checking " + str.to_s + " / hashes: "+ addHashVal.to_s + ", " + multHashVal.to_s + ", " + xorHashVal.to_s
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
bf.print_filter
bf.add "parrot"
bf.print_filter
bf.add "sparrow"
bf.print_filter
bf.add "dove"
bf.print_filter
bf.add "starling"
bf.print_filter
puts (bf.check "cockatiel").to_s
puts (bf.check "parakeet").to_s
puts (bf.check "cockatoo").to_s
