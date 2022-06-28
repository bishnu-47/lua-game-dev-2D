require("snake")
require("apple")

function love.load()
    gridXCount = 20
    gridYCount = 15
    cellSize = 15
    score = 0

    Snake:load()
    Apple:load()
end

function love.update(dt)
    Snake:update(dt)
    Apple:update(dt)
end

function love.draw()
    -- draw background
    love.graphics.setColor(.28, .28, .28)
    love.graphics.rectangle(
        'fill',
        0,
        0,
        gridXCount * cellSize,
        gridYCount * cellSize
    )
    Apple:draw()
    Snake:draw()
    love.graphics.setFont(love.graphics.newFont(12))
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(score, gridXCount * cellSize - cellSize, 0)
end
