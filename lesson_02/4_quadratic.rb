puts "Введите коэффициенты квадратного уравнения:"
a = gets.chomp.to_f
b = gets.chomp.to_f
c = gets.chomp.to_f

d = (b**2 - 4 * a * c)
puts "Дискриминант: #{d}"

if d > 0
	puts "Корни: #{(-b + Math.sqrt(d)) / 2 * a * c}; #{(-b - Math.sqrt(d)) / 2 * a * c}"
elsif d == 0
	puts "Один корень: #{-b / 2 * a * c}"
else
	puts "Корней нет"
end