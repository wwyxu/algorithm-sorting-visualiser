SCREEN_WIDTH = 900
SCREEN_HEIGHT = 700
WORD_Y_OFFSET = 20
WORD_LENGTH = 100
UI_COL_1_OFFSET = PADDING_TOP = 10
UI_COL_2_OFFSET = SCREEN_WIDTH / 3
UI_COL_3_OFFSET = SCREEN_WIDTH / 3 * 2 - WORD_LENGTH / 2
UI_COL_4_OFFSET = SCREEN_WIDTH - WORD_LENGTH
ARRAY_LENGTH = 20
SMALL_FONT_SIZE = 16
MEDIUM_FONT_SIZE = 20
SELECT_VALUE_FIRST = "Please select a value first"

module ZOrder
  BACKGROUND, OBJECT, UI = *0..2
end

module Algorithm
  BUBBLE_SORT = "Bubble Sort"
  INSERTION_SORT = "Insertion Sort"
  QUICK_SORT = "Quick Sort"
  SELECTION_SORT = "Selection Sort"
end

module Speed
  QUICKEST = "Quickest"   
  QUICK = "Quick"
  MEDIUM = "Medium"
  SLOW = "Slow"
  SLOWEST = "Slowest"
end

module CustomColor
  PURPLE = 0xff_660066
end

$algorithms = [Algorithm::BUBBLE_SORT, Algorithm::INSERTION_SORT, Algorithm::QUICK_SORT, Algorithm::SELECTION_SORT]
$speeds = [{label: Speed::QUICKEST, value: 0}, { label: Speed::QUICK, value: 0.05}, { label: Speed::MEDIUM, value: 0.1 }, { label: Speed::SLOW, value: 0.155}, { label: Speed::SLOWEST, value: 0.2}]
