Player = {}
function Player:load()
    self.image = love.graphics.newImage("assets/paddle-green.png")
    self.x = 50
    self.y = love.graphics.getHeight() / 2
    self.speed = 500
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function Player:update(dt)
    Player:move(dt)
end

function Player:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

function Player:move(dt)
    if love.keyboard.isDown("w") then
        if self.y >= 0 then -- move only if player is below upper bound
            self.y = self.y - self.speed * dt
        end
    elseif love.keyboard.isDown("s") then
        if (self.y + self.height) <= love.graphics.getHeight() then -- move only if player is above lower bound
            self.y = self.y + self.speed * dt
        end
    end
end
