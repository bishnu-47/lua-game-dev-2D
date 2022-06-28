Ball = {}

function Ball:load()
    self.img = love.graphics.newImage("assets/ball.png")
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.width = self.img:getWidth()
    self.height = self.img:getHeight()
    self.speed = 200
    self.xVel = -self.speed
    self.yVel = 0
end

function Ball:update(dt)
    Ball:move(dt)
    Ball:collide()
end

function Ball:draw()
    love.graphics.draw(self.img, self.x, self.y)
end

function Ball:move(dt)
    self.x = self.x + self.xVel * dt
    self.y = self.y + self.yVel * dt
end

function Ball:collide()
    Ball:checkPlayerCollision()
    Ball:checkAiCollision()
    Ball:keepBallInBounds()
    Ball:score()
end

function Ball:checkPlayerCollision()
    if checkCollision(self, Player) then
        self.xVel = self.speed
        local ballMid = self.y + self.height / 2
        local playerMid = Player.y + Player.height / 2
        local collisionPosition = ballMid - playerMid
        self.yVel = collisionPosition * 5
        self.speed = self.speed + 10 -- inc speed
    end
end

function Ball:checkAiCollision()
    if checkCollision(self, Ai) then
        self.xVel = -self.speed
        local ballMid = self.y + self.height / 2
        local aiMid = Ai.y + Ai.height / 2
        local collisionPosition = ballMid - aiMid
        self.yVel = collisionPosition * 5
        self.speed = self.speed + 10 -- inc speed
    end
end

function Ball:keepBallInBounds()
    if self.y <= 0 then
        self.y = 0
        self.yVel = self.yVel * -1
    elseif self.y + self.height >= love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height
        self.yVel = self.yVel * -1
    end
end

function Ball:score()
    if self.x + self.width < 0 then -- if AI has scored
        Score.ai = Score.ai + 1
        Ball:resetBall(-1)
    end

    if self.x > love.graphics.getWidth() then -- if Player has scored
        Score.player = Score.player + 1
        Ball:resetBall(1)
    end
end

function Ball:resetBall(modifier)
    self.speed = 200
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.xVel = self.speed * modifier
    self.yVel = 0
end
