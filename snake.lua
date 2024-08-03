local Vector = require('vendor.vector')

local Snake = {}

SPEED = 1

SPEED_X = SPEED
SPEED_Y = SPEED

SNAKE_SIDE = 1

function Snake.new()
    local self = {}

    self.x = math.random(GAME_WIDTH)
    self.y = math.random(GAME_HEIGHT)

    self.vx = SPEED_X
    self.vy = 0

    self.width = SNAKE_SIDE
    self.height = SNAKE_SIDE

    self.total = 0
    self.tail = {}

    setmetatable(self, { __index = Snake })
    return self
end

function Snake:death()
    local collided = false
    for _, tail_block in pairs(self.tail) do
        if self.x == tail_block.x and self.y == tail_block.y then
            collided = true
            break
        end
    end

    if collided then
        self.total = 0
        self.tail = {}
    end
end

function Snake:eat(food)
    if self.x == food.x and self.y == food.y then
        self.total = self.total + 1
        return true
    end
    return false
end

function Snake:dir(x, y)
    self.vx = SPEED_X * x
    self.vy = SPEED_Y * y
end

function Snake:handleInput()
    if love.keyboard.isDown('up') then
        self:dir(0, -1)
    elseif love.keyboard.isDown('down') then
        self:dir(0, 1)
    elseif love.keyboard.isDown('left') then
        self:dir(-1, 0)
    elseif love.keyboard.isDown('right') then
        self:dir(1, 0)
    end
end

function Snake:update()
    for i = 1, #self.tail - 1 do
        self.tail[i] = self.tail[i+1]
    end
    if self.total > 0 then
        self.tail[self.total] = Vector.new(self.x, self.y)
    end

    -- NO DELTA TIME MUAHAHA
    -- COMMITING CRIMES HEHEHE
    self.x = self.x + self.vx
    self.y = self.y + self.vy
end

function Snake:render()
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)

    for _, tail_part in pairs(self.tail) do
        love.graphics.rectangle('fill', tail_part.x, tail_part.y, self.width, self.height)
    end

    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Snake
