goods = {}
sums = {}
total = 0.0

loop do
  print "Введите товар: "
  name = gets.chomp

  break if name == "стоп"
  
  print "Введите цену: "
  price = gets.chomp.to_f
  
  print "Введите количество: "
  quantity = gets.chomp.to_f

  goods[name] = {price: price, quantity: quantity}
  sums[name] = price * quantity
  total += sums[name]
end

puts goods
puts sums
puts total
