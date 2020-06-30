hash = Hash.new

alphabet = ('а'..'я').to_a

alphabet.each_index do |i| 
  hash[alphabet[i]] = i+1 if "аоиеёэыуюя".include?(alphabet[i])
end

puts hash
