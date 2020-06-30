hash = Hash.new

('а'..'я').each_with_index do |c, i| 
  hash[c] = i+1 if "аоиеёэыуюя".include?(c)
end

puts hash
