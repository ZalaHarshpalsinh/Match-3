require 'src/Dependencies'

local backgroundScroll = 0

function love.load()
    
    love.window.setTitle("Match-3")

    love.graphics.setDefaultFilter('nearest')

    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
        vsync = true,
        fullscreen = false,
        resizable = true,
    })

    gStateMachine:change('StartState')

    gKeyPressed = {}
    gMouse = {
        clicked = false,
        coords = {}
    }
end

function love.resize(w,h)
    push:resize(w,h)
end

function love.keypressed(key)
    gKeyPressed[key] = true
end

function love.mousepressed(x, y, button, istouch, presses)
    x,y = push:toGame(x,y)
    gMouse.clicked = true
    gMouse.coords = {x = x, y = y}
end

function love.update(dt)

    if gKeyPressed['escape'] then
        love.event.quit()
    end
    backgroundScroll = (backgroundScroll + (BACKGROUND_SCROLL_SPEED * dt)) % BACKGROUND_LOOPING_POINT

    gStateMachine:update(dt)
    
    gKeyPressed = {}
    gMouse.clicked = false
end

function love.draw()
    push:start()

    love.graphics.draw(gTextures['background'], -backgroundScroll, 0)

    gStateMachine:render()

    push:finish()
end