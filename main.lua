local push = require('vendor.push')

local StateMachine = require('state_machine')
local PlayScene = require('scenes.play')

GAME_WIDTH = 61
GAME_HEIGHT = 41

local stateMachine = StateMachine.new({
    ['play'] = PlayScene.new
})

function love.load()
    love.window.setTitle('s n a k e')

    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, 1074, 720, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    stateMachine:change('play')
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
    stateMachine:update(dt)
end

function love.draw()
    push:start()

    stateMachine:render()

    push:finish()
end
