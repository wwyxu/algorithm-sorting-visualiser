def partition(low, high)
    puts("Partition")
    @finishPartition = false

    pivot = @array[high][:value]
    i = low
    j = low

    while (j < high)
      if (@array[j][:value] <= pivot)
        swap(i, j)
      end
      j += 1

      @finishPartition = true  
    end

    swap(i, j)

    return i
end

def quick_sort()
    if (@quick_sort_stack.length > 0 && @finishPartition && @loop < @array.length - 1)
      @loop += 1
      puts "#{Algorithm::QUICK_SORT} - Loop #{@loop}"

      x = @quick_sort_stack.pop()
      y = @quick_sort_stack.pop()

      pi = partition(x, y)

      if (pi - 1 > x)
        @quick_sort_stack << pi - 1
        @quick_sort_stack << x
      end

      if (pi + 1 < y)
        @quick_sort_stack << y
        @quick_sort_stack << pi + 1
      end
      # sleep(0.1)
    elsif @quick_sort_stack.length == 0 || @loop == @array.length - 1
      finished_sorting()
      fill_quick_sort_stack()
    end
end
