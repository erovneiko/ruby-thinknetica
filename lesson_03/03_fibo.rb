fibo = [1, 1]

loop do
  next_number = fibo.last(2).sum
  break if next_number >= 100
  fibo << next_number
end

puts fibo
