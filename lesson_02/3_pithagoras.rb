puts "Введите три стороны треугольника:"
a = gets.chomp.to_f
b = gets.chomp.to_f
c = gets.chomp.to_f

if a**2 == b**2 + c**2 \
|| b**2 == a**2 + c**2 \
|| c**2 == a**2 + b**2
  puts "Это прямоугольный треугольник"
elsif a == b && b == c
  puts "Это равносторонний треугольник"
elsif a == b || b == c || a == c
  puts "Это равнобедренный треугольник"
else
  puts "Треугольник, как треугольник"
end
