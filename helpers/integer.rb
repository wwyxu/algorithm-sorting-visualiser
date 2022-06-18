def area_clicked(leftX, topY, rightX, bottomY)
    return mouse_x > leftX && mouse_x < rightX && mouse_y > topY && mouse_y < bottomY
end

def calc_min(a, b)
    return a > b ? b : a
end
