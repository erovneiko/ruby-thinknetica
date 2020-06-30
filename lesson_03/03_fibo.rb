fibo = [1, 1]
loop do
  fibo << fibo.last(2).sum
  if fibo.last >= 100
    fibo.delete_at(fibo.size - 1)
    break
  end
end
puts fibo
