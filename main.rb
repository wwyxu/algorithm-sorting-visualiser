require 'rubygems'
require 'gosu'
require './controllers/index'
require './constants/index'
require './helpers/array'
require './helpers/input'
require './helpers/integer'
require './helpers/output'
require './algorithms/bubbleSort'
require './algorithms/insertionSort'
require './algorithms/quickSort'
require './algorithms/selectionSort'
require './tests/index'

class AlgorithmVisualiser < Gosu::Window
	def initialize
	    super SCREEN_WIDTH, SCREEN_HEIGHT
	    self.caption = "Sorting Algorithm Visualiser"

        $ui = [{label: "Randomize", :func => lambda{generate_new_array()} , color: Gosu::Color::RED},
        {label: "Sort", :func => lambda{sort_array()} , color: @sorting ? Gosu::Color::GREEN : Gosu::Color::RED},
        {label: "Increase", :func => lambda{increase_array_size()} , color: Gosu::Color::RED},
        {label: "Decrease", :func => lambda{decrease_array_size()} , color: Gosu::Color::RED}, 
        {label: "Import Array", :func => lambda{read_file()}, color: Gosu::Color::RED},
        {label: "Save Array", :func => lambda{write_file()}, color: Gosu::Color::RED}]

        $ui2 = [{label: "Change", :func => lambda{update_array_value()} , color: Gosu::Color::RED},
        {label: "Swap", :func => lambda{swap_array_index()} , color:  Gosu::Color::RED},
        {label: "Insert", :func => lambda{insert_array_index()} , color:  Gosu::Color::RED},
        {label: "Delete", :func => lambda{delete_array_index()} , color: Gosu::Color::RED},]

		@font = Gosu::Font.new(MEDIUM_FONT_SIZE)
	    @small_font = Gosu::Font.new(SMALL_FONT_SIZE)
        @sorting = @sorted = @swapping_array_index = false
        @finishPartition = @printFirstIteration = true
        @array_length = ARRAY_LENGTH
	    @quick_sort_stack = Array.new()
        @selected_algorithm = Algorithm::BUBBLE_SORT
        @selected_array_index = nil
        @speed = $speeds[0][:value]
        @min = @loop = @loop2 = @loop3 = @loop4 = 0
        @block_width = SCREEN_WIDTH / @array_length
        
        generate_new_array()
        fill_quick_sort_stack()
	end

	def update
        if (@sorting)
            case @selected_algorithm
                when Algorithm::BUBBLE_SORT
                    bubble_sort()
                when Algorithm::INSERTION_SORT
                    insertion_sort()
                when Algorithm::QUICK_SORT
                    quick_sort()
                when Algorithm::SELECTION_SORT
                    selection_sort()
            end
        elsif (@sorted) 
            @min = @loop = @loop2 = @loop3 = @loop4 = 0
        end
	end

    def draw_array
        @array.each_with_index do |value, index|
            Gosu.draw_rect(index.to_i() * @block_width, SCREEN_HEIGHT - value[:value] * 5, @block_width , value[:value] * 5, @selected_array_index == index ? Gosu::Color::YELLOW : value[:color], ZOrder::OBJECT)
        end

        if (@block_width > SMALL_FONT_SIZE)
            @array.each_with_index do |value, index|
                @small_font.draw_text(value[:value].to_s(), index.to_i() * @block_width + calc_array_number_offset(value[:value]), SCREEN_HEIGHT - value[:value] * 5 - 22 , ZOrder::UI, 1.0, 1.0, @selected_array_index == index ? Gosu::Color::YELLOW : value[:color])
            end
        end
    end

    def draw_ui
        $algorithms.each_with_index do |value, index|
            @font.draw_text(value, UI_COL_1_OFFSET, PADDING_TOP + index * WORD_Y_OFFSET, ZOrder::UI, 1.0, 1.0, @selected_algorithm == value ? Gosu::Color::GREEN : Gosu::Color::RED)
        end

        $speeds.each_with_index do |value, index|
            @font.draw_text(value[:label], UI_COL_2_OFFSET, PADDING_TOP + index * WORD_Y_OFFSET, ZOrder::UI, 1.0, 1.0, @speed == value[:value] ? Gosu::Color::GREEN : Gosu::Color::RED)
        end

        $ui.each_with_index do |value, index|
            @font.draw_text(value[:label], UI_COL_3_OFFSET, PADDING_TOP + index * WORD_Y_OFFSET, ZOrder::UI, 1.0, 1.0, Gosu::Color::RED)
        end

        $ui2.each_with_index do |value, index|
            @font.draw_text(value[:label], UI_COL_4_OFFSET, PADDING_TOP + index * WORD_Y_OFFSET, ZOrder::UI, 1.0, 1.0, Gosu::Color::RED)
        end
    end

	def draw
        draw_array()
        draw_ui()
	end

    def button_down(id)
        case id
            when Gosu::MsLeft

            # If click is outside array and below ui
            if (!array_clicked() && 200 <= mouse_y)
                @selected_array_index = nil
                @swapping_array_index = false
            end

            if (!@sorting)
                @array.each_with_index do |value, index|
                    if (area_clicked(index * @block_width, SCREEN_HEIGHT - value[:value] * 5, index * @block_width + @block_width, SCREEN_HEIGHT))
                        if (@swapping_array_index)
                            no_condition_swap(@selected_array_index, index)
                            @selected_array_index = nil
                            @swapping_array_index = false
                        else
                            @selected_array_index = index
                        end
                    end
                end
            end

            for i in 0..$algorithms.length() - 1
                if (area_clicked(UI_COL_1_OFFSET, PADDING_TOP + WORD_Y_OFFSET * i, UI_COL_1_OFFSET + WORD_LENGTH, 25 + WORD_Y_OFFSET * i))
                    @selected_algorithm = $algorithms[i]
                end
            end

            for i in 0..$ui.length() - 1
                if (area_clicked(UI_COL_3_OFFSET, PADDING_TOP + WORD_Y_OFFSET * i, UI_COL_3_OFFSET + WORD_LENGTH, 25 + WORD_Y_OFFSET * i))
                    $ui[i][:func].()
                end
            end

            for i in 0..$ui2.length() - 1
                if (area_clicked(UI_COL_4_OFFSET, PADDING_TOP + WORD_Y_OFFSET * i, UI_COL_4_OFFSET + WORD_LENGTH, 25 + WORD_Y_OFFSET * i))
                    $ui2[i][:func].()
                end
            end

            for i in 0..$speeds.length() - 1
                if (area_clicked(UI_COL_2_OFFSET, PADDING_TOP + WORD_Y_OFFSET * i, UI_COL_2_OFFSET + WORD_LENGTH, 25 + WORD_Y_OFFSET * i))
                    @speed = $speeds[i][:value]
                end
            end
            when Gosu::KbLeft
                generate_new_array()
            when Gosu::KbSpace
                sort_array()
            when Gosu::KbUp
                increase_array_size()
            when Gosu::KB_DELETE
                delete_array_index()
            when Gosu::KbDown
                decrease_array_size()
            when Gosu::KB_ESCAPE
                close
            else
            super
        end
    end

 	def needs_cursor?; true; end
end

AlgorithmVisualiser.new.show if __FILE__ == $0
