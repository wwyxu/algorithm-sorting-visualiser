def selection_sort()
    print_first_iteration()

    if (@loop < @array.length)
        if (@loop2 < @array.length)
            if (@loop3 == 0)
                change_color(@loop, Gosu::Color::RED)
                change_color(@loop2, Gosu::Color::RED)
                @loop3 += 1
            else
                sleep(@speed * 2)
                if (@array[@loop2][:value] < @array[@min][:value])
                    puts("New minimum value found at #{@loop + 1}")
                    change_color(@min, Gosu::Color::BLUE)
                    @min = @loop2
                    change_color(@loop2, CustomColor::PURPLE)
                else 
                    sleep(@speed * 2)
                    change_color(@loop2, Gosu::Color::BLUE)
                end

                @loop2 += 1
                @loop3 = 0
            end
        else
            if (@loop4 == 0)
                swap(@loop, @min)

                change_color(@min, Gosu::Color::GREEN)
                change_color(@loop, Gosu::Color::GREEN)

                puts "#{Algorithm::SELECTION_SORT} - Loop #{@loop + 1}"

                @loop4 += 1
            else 
                sleep(@speed * 8)
                change_color(@min, Gosu::Color::BLUE)
                change_color(@loop, Gosu::Color::BLUE)
                @loop4 = 0
                @min = @loop += 1
                @loop2 = @loop + 1
            end
        end
    else
        finished_sorting()
    end
end
