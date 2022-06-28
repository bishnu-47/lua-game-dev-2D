require("player")
require("ball")
require("ai")

function love.load()
    background = love.graphics.newImage("assets/court.png")
    Score = { player = 0, ai = 0 }
    Player:load()
    Ball:load()
    Ai:load();
end

function love.update(dt)
    Player:update(dt)
    Ball:update(dt)
    Ai:update(dt)
end

function love.draw()
    love.graphics.draw(background, 0, 0)
    Player:draw()
    Ball:draw()
    Ai:draw()
    love.graphics.setFont(love.graphics.newFont(30))
    love.graphics.print("Player: " .. Score.player, (love.graphics.getWidth() / 2) - 200, 50)
    love.graphics.print("AI: " .. Score.ai, (love.graphics.getWidth() / 2) + 100, 50)
end

function checkCollision(a, b)
    if a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height then
        return true
    else
        return false
    end
end
