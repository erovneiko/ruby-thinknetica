puts "Введите день:"
day = gets.chomp.to_i

puts "Введите месяц:"
month = gets.chomp.to_i

puts "Введите год:"
year = gets.chomp.to_i

months = [30, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

#високосный год
if year % 4 == 0 && year % 100 != 0 || year % 400 == 0
  months[1] = 29
end

number = day + months.take(month-1).sum

puts "Порядковый номер даты:"
puts number
