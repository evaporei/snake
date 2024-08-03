local push = require('vendor.push')

local Snake = require('snake')
local Food = require('food')

GAME_WIDTH = 61
GAME_HEIGHT = 41

local snake = Snake.new()
local food = Food.new()

function love.load()
    love.window.setTitle('s n a k e')

    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, 1074, 720, {
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
    snake:handleInput()

    -- set fps to 10
    -- track input while that happens
    local start = love.timer.getTime()
    local toSleep = math.max(0, 1 / 6 - dt)

    while love.timer.getTime() - start < toSleep do
        snake:handleInput()
    end

    if snake:eat(food) then
        food:changeLocation()
    end
    snake:update()
end

function love.draw()
    push:start()

    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    snake:render()
    food:render()

    push:finish()
end
