hash = Hash.new

alphabet = ('а'..'я').to_a

alphabet.each_index do |i| 
  hash[alphabet[i]] = i if "аоиеёэыуюя".include?(alphabet[i])
end

puts hash
