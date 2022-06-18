def bubble_sort()
    print_first_iteration()
    length = @array_length - 1

    if (@loop < length)
        if @loop2 < (length - @loop)
            if (@loop3 == 0)
                change_color(@loop2, Gosu::Color::RED)
                change_color(@loop2 + 1, Gosu::Color::RED)
                @loop3 += 1
            else
                sleep(@speed * 4)
                if (@loop4 == 0)
                    if (@array[@loop2][:value] > @array[@loop2 + 1][:value])
                        change_color(@loop2, Gosu::Color::GREEN)
                        change_color(@loop2 + 1, Gosu::Color::GREEN)
                    end

                    swap(@loop2, @loop2 + 1)
                    @loop4 += 1
                else 
                    sleep(@speed * 2)
                    change_color(@loop2, Gosu::Color::BLUE)
                    change_color(@loop2 + 1, Gosu::Color::BLUE)
                    @loop3 = @loop4 = 0
                    @loop2 += 1
                end
            end
        else
            puts "#{Algorithm::BUBBLE_SORT} - Loop #{@loop + 2} "

            @loop += 1
            @loop2 = 0
        end
    else
        finished_sorting()
    end
end
