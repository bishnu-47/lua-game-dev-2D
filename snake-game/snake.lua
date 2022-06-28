Snake = {}

function Snake:load()
    self.snakeSegments = {
        { x = 3, y = 1 },
        { x = 2, y = 1 },
        { x = 1, y = 1 },
    }

    self.isAlive = true
    self.timer = 0
    self.direction = "right"
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
    if love.keyboard.isDown("up") and self.direction ~= "down" then
        self.direction = "up"
    elseif love.keyboard.isDown("down") and self.direction ~= "up" then
        self.direction = "down"
    elseif love.keyboard.isDown("left") and self.direction ~= "right" then
        self.direction = "left"
    elseif love.keyboard.isDown("right") and self.direction ~= "left" then
        self.direction = "right"
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

    if self.direction == "up" then
        nextYPosition = nextYPosition - 1
        if nextYPosition <= 0 then -- if snake crosses top
            nextYPosition = gridYCount
        end
    elseif self.direction == "down" then
        nextYPosition = nextYPosition + 1
        if nextYPosition > gridYCount then -- if snake crosses bottom
            nextYPosition = 1
        end
    elseif self.direction == "left" then
        nextXPosition = nextXPosition - 1
        if nextXPosition <= 0 then -- if snake crosses left bound
            nextXPosition = gridXCount
        end
    elseif self.direction == "right" then
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
end
