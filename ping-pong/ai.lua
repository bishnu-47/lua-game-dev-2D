Ai = {}

Ai.load = function(self)
    self.image = love.graphics.newImage("assets/paddle-blue.png")
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.x = love.graphics.getWidth() - self.width - 50
    self.y = love.graphics.getHeight() / 2
    self.speed = 500
    self.yVel = 0

    self.timer = 0
    self.rate = .5 -- .5 rate means 2 times in 1 sec
end


function Ai:update(dt)
    Ai:move(dt)
    self.timer = self.timer + dt
    if self.timer > self.rate then
        self.timer = 0
        Ai:trackBall()
    end
end

function Ai.draw(self)
    love.graphics.draw(self.image, self.x, self.y)
end

function Ai:move(dt)
    self.y = self.y + self.yVel * dt

    -- check upper bound
    if self.y <= 0 then
        self.y = 0
    end

    -- check lower bound
    if self.y + self.height >= love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height
    end
end

function Ai:trackBall()
    if Ball.y + Ball.height > self.y + self.height then -- if ball goes below ai
        self.yVel = self.speed
    elseif Ball.y < self.y then -- if ball goes above ai
        self.yVel = -self.speed
    else
        self.yVel = 0
    end
end
