x_point, y_point, x, y = ARGV

if x_point == x and y_point == y
	puts "Точка найдена!"
elsif 
	x_point != x and y_point != y
	puts "Близко, но нет"
elsif 
	x_point == x and y_point != y
	puts "Близко, но нет"
	puts "х координата верна, y нет"
elsif
	x_point != x and y_point == y
	puts "Близко, но нет"
	puts "y координата верна, x нет"
else
end 	