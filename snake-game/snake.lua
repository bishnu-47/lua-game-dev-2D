Snake = {}

function Snake:load()
    self.snakeSegments = {
        { x = 3, y = 1 },
        { x = 2, y = 1 },
        { x = 1, y = 1 },
    }

    self.isAlive = true
    self.timer = 0
    self.directionQueue = { 'right' }
end

function Snake:update(dt)
    self.timer = self.timer + dt

    if self.isAlive then
        if self.timer >= .15 then
            self.timer = 0
            Snake:controller()
            Snake:updatePosition()
        end
    elseif self.timer >= 2 then
        love.load()
    end

end

function Snake:controller()
    if love.keyboard.isDown("up")
        and self.directionQueue[#self.directionQueue] ~= "up" -- prevent adding same direction
        and self.directionQueue[#self.directionQueue] ~= "down" then -- prevent adding opp direction
        table.insert(self.directionQueue, "up")

    elseif love.keyboard.isDown("down")
        and self.directionQueue[#self.directionQueue] ~= "down"
        and self.directionQueue[#self.directionQueue] ~= "up" then
        table.insert(self.directionQueue, "down")

    elseif love.keyboard.isDown("left")
        and self.directionQueue[#self.directionQueue] ~= "left"
        and self.directionQueue[#self.directionQueue] ~= "right" then
        table.insert(self.directionQueue, "left")

    elseif love.keyboard.isDown("right")
        and self.directionQueue[#self.directionQueue] ~= "right"
        and self.directionQueue[#self.directionQueue] ~= "left" then
        table.insert(self.directionQueue, "right")
    end
end

function Snake:updatePosition()
    local nextXPosition, nextYPosition = Snake:getNewXandYPosition()

    if Snake:canMove(nextXPosition, nextYPosition) then
        --add new head position
        table.insert(self.snakeSegments, 1, { x = nextXPosition, y = nextYPosition })

        -- apple pos = snake head then don't remove tail
        if self.snakeSegments[1].x == Apple.x
            and self.snakeSegments[1].y == Apple.y then
            Apple:reposition()
            score = score + 1
        else -- else remove tail
            table.remove(self.snakeSegments)
        end
    else
        -- Game over
        self.isAlive = false
    end
end

function Snake:getNewXandYPosition()
    local nextXPosition = self.snakeSegments[1].x
    local nextYPosition = self.snakeSegments[1].y

    if #self.directionQueue > 1 then
        table.remove(self.directionQueue, 1)
    end

    if self.directionQueue[1] == "up" then
        nextYPosition = nextYPosition - 1
        if nextYPosition <= 0 then -- if snake crosses top
            nextYPosition = gridYCount
        end
    elseif self.directionQueue[1] == "down" then
        nextYPosition = nextYPosition + 1
        if nextYPosition > gridYCount then -- if snake crosses bottom
            nextYPosition = 1
        end
    elseif self.directionQueue[1] == "left" then
        nextXPosition = nextXPosition - 1
        if nextXPosition <= 0 then -- if snake crosses left bound
            nextXPosition = gridXCount
        end
    elseif self.directionQueue[1] == "right" then
        nextXPosition = nextXPosition + 1
        if nextXPosition > gridXCount then -- if snake crosses right bound
            nextXPosition = 1
        end
    end

    return nextXPosition, nextYPosition
end

function Snake:canMove(nextXPosition, nextYPosition)
    for segmentIndex, segment in ipairs(self.snakeSegments) do
        if segmentIndex ~= #self.snakeSegments
            and nextXPosition == segment.x
            and nextYPosition == segment.y then
            return false
        end
    end

    return true
end

function Snake:draw()
    for segmentIndex, segment in ipairs(self.snakeSegments) do
        if self.isAlive then -- change color weather snake is alive or not
            love.graphics.setColor(.6, 1, .32)
        else
            love.graphics.setColor(.5, .5, .5)
        end

        love.graphics.rectangle("fill",
            (segment.x - 1) * cellSize,
            (segment.y - 1) * cellSize,
            cellSize,
            cellSize
        )
    end

    if not self.isAlive then
        love.graphics.setColor(255, 255, 255)
        love.graphics.setFont(love.graphics.newFont(24))
        love.graphics.print(
            "Game Over",
            (gridXCount * cellSize) / 2 - (cellSize * 5),
            (gridYCount * cellSize) / 2 - (cellSize * 2)
        )
    end
end
