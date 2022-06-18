def push_new_value(array)
    array << {color: Gosu::Color::BLUE, value: rand(1 .. 70)}
end

def change_color(index, color)
    if (@array[index])
        @array[index][:color] = color
    end
end

def swap(i, j)
    if @array[i][:value] > @array[j][:value]
        no_condition_swap(i, j)
    end
end

def no_condition_swap(i, j)
    no_output_swap(i, j)

    puts("Swapping #{i} and #{j}")
    sleep(@speed * 4)
end

def no_output_swap(i, j)
    temp = @array[i][:value]
    @array[i][:value]= @array[j][:value]
    @array[j][:value] = temp

    # array[first], array[last] = array[last], array[first] - Can be used however above code is more instructive
end

def array_clicked()
    array_clicked = false

    if (mouse_y < 200)
        return false
    end

    @array.each_with_index do |value, index|
        if (area_clicked(index * @block_width, SCREEN_HEIGHT - value[:value] * 5, index * @block_width + @block_width, SCREEN_HEIGHT))
            array_clicked = true
        end
    end

    return array_clicked;
end

def print_array()
    print("Sorting [")
    for i in 0..@array.length() - 1
        print(i == @array.length() - 1 ? "#{@array[i][:value]}" : "#{@array[i][:value]}, " )
    end
    print("]")
    puts("")

    print("Sorting [")
    for i in 0..@array.length() - 1
        print(i == @array.length() - 1 ? "{value: #{@array[i][:value]}, color: Gosu::Color::BLUE}" : "{value: #{@array[i][:value]}, color: Gosu::Color::BLUE}, " )
    end
    print("]")
    puts("")
end

def fill_quick_sort_stack()
    @quick_sort_stack = Array.new()

    @quick_sort_stack << @array_length - 1
    @quick_sort_stack << 0
end

def calc_array_number_offset(int)
    # single digit is 9 in length, double digit is 18
    doubleDigitOffset = (@block_width - SMALL_FONT_SIZE) / 2
    singleDigitOffset = (@block_width - SMALL_FONT_SIZE/2) / 2

    return int >= 10 ? doubleDigitOffset : singleDigitOffset
end

