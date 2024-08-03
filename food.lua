local Food = {}

FOOD_SIDE = 1

function Food.new()
    local self = {}

    self.x = math.random(GAME_WIDTH)
    self.y = math.random(GAME_HEIGHT)

    self.width = FOOD_SIDE
    self.height = FOOD_SIDE

    setmetatable(self, { __index = Food })
    return self
end

function Food:changeLocation()
    self.x = math.random(GAME_WIDTH)
    self.y = math.random(GAME_HEIGHT)
end

function Food:render()
    love.graphics.setColor(255/255, 0/255, 0/255, 255/255)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Food
