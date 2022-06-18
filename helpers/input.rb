def read_string(prompt)
	puts prompt
	value = gets.chomp
end

def read_float(prompt)
	value = read_string(prompt)
	value.to_f
end

def read_integer(prompt)
	value = read_string(prompt)
	value.to_i
end

def read_integer_in_range(prompt, min, max)
	value = read_integer(prompt)

	while (value < min or value > max)
		puts "Please enter a value between " + min.to_s + " and " + max.to_s + ": "
		value = read_integer(prompt);
	end

	return value
end
