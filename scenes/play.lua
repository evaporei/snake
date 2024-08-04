local BaseScene = require('scenes.base')
local Snake = require('snake')
local Food = require('food')

local PlayScene = {}
setmetatable(PlayScene, { __index = BaseScene })

function PlayScene.new(stateMachine)
    local self = {}

    self.stateMachine = stateMachine

    self.snake = Snake.new()
    self.food = Food.new()
    setmetatable(self, { __index = PlayScene })
    return self
end

function PlayScene:update(dt)
    self.snake:handleInput()

    -- set fps to 10
    -- track input while that happens
    local start = love.timer.getTime()
    local toSleep = math.max(0, 1 / 6 - dt)

    while love.timer.getTime() - start < toSleep do
        self.snake:handleInput()
    end

    self.snake:death()

    if self.snake:eat(self.food) then
        self.food:changeLocation()
    end
    self.snake:update()
end

function PlayScene:render()
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    self.snake:render()
    self.food:render()
end

return PlayScene
