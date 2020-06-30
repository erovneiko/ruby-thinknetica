goods = Hash.new
sums = Hash.new
total = 0.0

loop do
  print "Введите товар: "
  name = gets.chomp

  break if name == "стоп"
  
  print "Введите цену: "
  price = gets.chomp.to_f
  
  print "Введите количество: "
  value = gets.chomp.to_f

  goods[name] = {price => value}
  sums[name] = price * value
  total += sums[name]
end

puts goods
puts sums
puts total
