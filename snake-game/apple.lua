Apple = {}

function Apple:load()
    self.x = math.random(1, gridXCount)
    self.y = math.random(1, gridYCount)
end

function Apple:update(dt)

end

function Apple:reposition()
    local newPos = Apple:getPossibleFoodPosition()
    self.x = newPos.x
    self.y = newPos.y
end

function Apple:getPossibleFoodPosition()
    local possibleFoodPositions = {}

    -- spawn apple at empty position
    for foodX = 1, gridXCount do
        for foodY = 1, gridYCount do
            local possible = true

            -- loop through to check space occupied by snake
            for segmentIndex, segment in ipairs(Snake.snakeSegments) do
                if foodX == segment.x and foodY == segment.y then
                    possible = false
                    break
                end
            end

            if possible then
                table.insert(possibleFoodPositions, { x = foodX, y = foodY })
            end
        end
    end
   
    return possibleFoodPositions[
        love.math.random(#possibleFoodPositions)
        ]
end

function Apple:draw()
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle(
        "fill",
        (self.x - 1) * cellSize,
        (self.y - 1) * cellSize,
        cellSize,
        cellSize
    )
end
