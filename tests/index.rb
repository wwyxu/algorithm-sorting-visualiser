def print_current_mouse_location
    puts("Mouse X Location: #{mouse_x}")
    puts("Mouse Y Location: #{mouse_y}")
end

def print_array_area(index)
    puts ("left: #{index * @block_width}")
    puts ("top: #{SCREEN_HEIGHT - value[:value] * 5}")
    puts ("right: #{index * @block_width + @block_width}")
    puts ("bottom: #{SCREEN_HEIGHT}")
end

def is_array_sorted
    isSorted = true

    i = @array_length

    while (i > 1)
        if @array[i] < @array[i-1]
            isSorted = false
        end

        i -= 1
    end  

    return isSorted
end