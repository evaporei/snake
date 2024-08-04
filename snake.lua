local Vector = require('vendor.vector')

local Snake = {}

SPEED = 1

SPEED_X = SPEED
SPEED_Y = SPEED

SNAKE_SIDE = 1

local colors = {
    -- white
    { r = 255/255, g = 255/255, b = 255/255 },
    -- orange
    { r = 0xff/255, g = 0xa5/255, b = 0/255 },
    -- yellow
    { r = 0xfa/255, g = 0xeb/255, b = 0x36/255 },
    -- green
    { r = 0/255, g = 255/255, b = 0/255 },
    -- blue
    { r = 0/255, g = 0/255, b = 255/255 },
    -- violet
    { r = 0x70/255, g = 0x36/255, b = 0x9d/255 },
}

function Snake.new()
    local self = {}

    local x = math.random(GAME_WIDTH)
    local y = math.random(GAME_HEIGHT)

    self.total = 1
    self.body = {Vector.new(x, y)}

    self.vx = SPEED_X
    self.vy = 0

    self.width = SNAKE_SIDE
    self.height = SNAKE_SIDE

    setmetatable(self, { __index = Snake })
    return self
end

function Snake:death()
    local collided = false

    local head = self.body[1]
    for i = 2, #self.body do
        if head.x == self.body[i].x and head.y == self.body[i].y then
            collided = true
            break
        end
    end

    if collided then
        self.total = 1
        self.body = {head}
    end
end

function Snake:eat(food)
    if self.body[1].x == food.x and self.body[1].y == food.y then
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
    for i = 2, #self.body - 1 do
        self.body[i] = self.body[i+1]
    end
    if self.total > 1 then
        self.body[self.total] = Vector.new(self.body[1].x, self.body[1].y)
    end

    -- NO DELTA TIME MUAHAHA
    -- COMMITING CRIMES HEHEHE
    self.body[1].x = self.body[1].x + self.vx
    self.body[1].y = self.body[1].y + self.vy
end

function Snake:render()
    for i, body_part in pairs(self.body) do
        local color = colors[((i - 1) % #colors) + 1]
        love.graphics.setColor(color.r, color.g, color.b, 255/255)
        love.graphics.rectangle('fill', body_part.x, body_part.y, self.width, self.height)
    end
end

return Snake
