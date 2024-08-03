local push = require('vendor.push')

local Snake = require('snake')
local Food = require('food')

GAME_WIDTH = 432
GAME_HEIGHT = 243

local snake = Snake.new()
local food = Food.new()

function love.load()
    love.window.setTitle('s n a k e')

    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, 1280, 720, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
    if snake:collides(food) then
        food:changeLocation()
    end
    snake:handleInput()
    snake:update(dt)
end

function love.draw()
    push:start()

    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    snake:render()
    food:render()

    push:finish()
end
