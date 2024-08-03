local Snake = {}

SPEED = 80

SPEED_X = SPEED
SPEED_Y = SPEED

function Snake.new()
    local self = {}

    self.x = math.random(GAME_WIDTH)
    self.y = math.random(GAME_HEIGHT)

    self.vx = SPEED_X
    self.vy = 0

    self.width = 6
    self.height = 6

    setmetatable(self, { __index = Snake })
    return self
end

function Snake:collides(food)
    if self.x > food.x + food.width or self.x + self.width < food.x then
        return false
    end
    if self.y > food.y + food.height or self.y + self.height < food.y then
        return false
    end
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
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt
end

function Snake:render()
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Snake
