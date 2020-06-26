print "Ваше имя? "
name = gets.chomp.capitalize
print "Ваш рост? "

if ((optim = (gets.chomp.to_i - 110) * 1.15) >= 0)
  puts "#{name}, ваш идеальный вес - #{optim}"  
else
  puts "#{name}, ваш вес уже оптимальный"
end
