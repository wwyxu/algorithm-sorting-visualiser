def print_first_iteration()
    if (@printFirstIteration)
        puts "#{@selected_algorithm} - Loop #{@loop + 1} "
        @printFirstIteration = false
    end
end

def finished_sorting()
    @sorting = false
    @sorted = true
    puts("Finished Sorting")
end
