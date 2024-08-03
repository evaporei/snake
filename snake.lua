local Vector = require('vendor.vector')

local Snake = {}

SPEED = 80

SPEED_X = SPEED
SPEED_Y = SPEED

SIDE = 6

function Snake.new()
    local self = {}

    self.x = math.random(GAME_WIDTH)
    self.y = math.random(GAME_HEIGHT)

    self.vx = SPEED_X
    self.vy = 0

    self.width = SIDE
    self.height = SIDE

    self.total = 0
    self.tail = {}

    setmetatable(self, { __index = Snake })
    return self
end

function Snake:eat(food)
    if self.x > food.x + food.width or self.x + self.width < food.x then
        return false
    end
    if self.y > food.y + food.height or self.y + self.height < food.y then
        return false
    end
    self.total = self.total + 1
    return true
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

function Snake:update(dt)
    for i = 1, #self.tail - 1 do
        self.tail[i] = self.tail[i+1]
    end
    if self.total > 0 then
        self.tail[self.total] = Vector.new(self.x, self.y)
    end

    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt
end

function Snake:render()
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)

    for _, tail_part in pairs(self.tail) do
        love.graphics.rectangle('fill', tail_part.x, tail_part.y, self.width, self.height)
    end

    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Snake
