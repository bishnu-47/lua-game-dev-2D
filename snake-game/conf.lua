function love.conf(t)
    local gridXCount = 20
    local gridYCount = 15
    local cellSize = 15

    t.window.title = "Snake Game"
    t.window.width = cellSize * gridXCount
    t.window.height = cellSize * gridYCount
end