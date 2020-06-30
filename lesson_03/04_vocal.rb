hash = {}

('а'..'я').each.with_index(1) do |c, i| 
  hash[c] = i if "аоиеёэыуюя".include?(c)
end

puts hash
