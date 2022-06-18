def revertColors()
    change_color(@loop2, Gosu::Color::BLUE)
    change_color(@loop2 + 1, Gosu::Color::BLUE)
end

def insert()
    if (@loop2 == -2)
        @loop2 = @loop
    end 

    if (@loop2 > -1) 
        sleep(@speed * 2)

        if (@loop3 == 0 && @loop2 > 0)
            change_color(@loop2 - 1, Gosu::Color::RED)
            change_color(@loop2, Gosu::Color::RED)
            sleep(@speed * 2)   
            @loop3 += 1
        else
            if (@loop2 > 0 && @array[@loop2][:value] < @array[@loop2 - 1][:value])
                if (@loop4 == 0)
                    puts "Smaller Value Found"
                    swap(@loop2-1, @loop2)
                    @loop2 -= 1
                    @loop4 += 1
                    if (@array[@loop2] && @array[@loop2 + 1])
                        change_color(@loop2 - 1, Gosu::Color::BLUE)
                        change_color(@loop2, Gosu::Color::GREEN)
                        change_color(@loop2 + 1, Gosu::Color::GREEN)
                    end
                else 
                    @loop4 = 0 
                    if (@array[@loop2] && @array[@loop2 + 1])
                        revertColors()
                    end
                    @loop3 = 0
                end
            else
                if (@array[@loop2] && @array[@loop2 + 1])
                    revertColors()
                end

                @loop2 = -2
                @loop += 1
                @loop3 = 0
                @loop4 = 0
            end
        end
    end 
end

def insertion_sort()
    puts "#{Algorithm::INSERTION_SORT} - Loop #{@loop + 1} "

    if @loop < @array_length 
        insert()
    else
        @array[@array_length - 1][:color] = Gosu::Color::BLUE
        @array[@array_length - 2][:color] = Gosu::Color::BLUE
        finished_sorting()
    end
end
