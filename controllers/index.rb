def generate_new_array()
    if !@sorting
        newArray = Array.new()
        i = @array_length

        while (i > 0)
            push_new_value(newArray)
            i -= 1
        end

        @array = newArray
        @sorted = false
    end
end

def read_file()
    if !@sorting
        a_file = File.read("array.txt")
        a_file_array = Kernel.eval(a_file)
        newArray = Array.new()

        for i in 0..a_file_array.length() - 1
            newArray.push({ value: a_file_array[i].to_i(), color: Gosu::Color::BLUE })
        end

        @array_length = newArray.length()
        @array = newArray
    end
end

def write_file()
    newArray = Array.new()

    for i in 0..@array.length() - 1
        newArray.push( @array[i][:value] )
    end

    File.open("array.txt", 'w') { |file| file.write(newArray) }
end

def sort_array()
    if (!@sorted)
        @sorting = true
        print_array()
    end
end

def array_size_changed()
    @sorted = false
    fill_quick_sort_stack()
    @block_width = SCREEN_WIDTH / @array_length
end

def increase_array_size()
    if !@sorting && @loop == 0 && @loop2 == 0 && @array_length < 100
        @array_length += 1
        push_new_value(@array)
        array_size_changed()
    end
end

def decrease_array_size()
    if !@sorting && @loop == 0 && @loop2 == 0 && @array_length > 5
        @array_length -= 1
        @array.pop()
        array_size_changed()
    end
end

def update_array_value()
    if (@selected_array_index != nil)
        puts("What value between 0 and 70 would you like to change this to:")
        choice = read_integer_in_range("Your choice: ", 0, 70)

        @array[@selected_array_index][:value] = choice
        @selected_array_index = nil

        puts("Value changed to #{choice}")
    else
        puts(SELECT_VALUE_FIRST)
    end
end

def swap_array_index()
    if (@selected_array_index != nil)
        @swapping_array_index = true

        puts("Select another value to swap with")
    else
        puts(SELECT_VALUE_FIRST)
    end
end

def insert_array_index()
    if (@selected_array_index != nil)
        if (@array_length > 1)
            puts("Which index between 0 and #{@array_length - 1} would you like to insert this value:")

            choice = read_integer_in_range("Your choice: ", 0, @array_length - 1)

            if (choice > @selected_array_index)
                for i in @selected_array_index..choice-1 
                    if (@array[i] && @array[i + 1])
                        no_output_swap(i, i + 1)
                    end
                end
            else
                for i in (@selected_array_index).downto(choice + 1)
                    if (@array[i] && @array[i-1])
                        no_output_swap(i, i - 1)
                    end
                end
            end

            @selected_array_index = nil

            puts("Value inserted}")
        else 
            puts("No other vlaues to swap with")
        end
    else
        puts(SELECT_VALUE_FIRST)
    end
end

def delete_array_index()
    if (@selected_array_index != nil)
        @array.delete_at(@selected_array_index)
        @array_length -= 1
        @selected_array_index = nil
        @block_width = SCREEN_WIDTH / @array_length

        puts("Value deleted}")
    else
        puts(SELECT_VALUE_FIRST)
    end
end
