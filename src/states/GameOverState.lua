GameOverState = Class{__includes = BaseState}

function GameOverState:init()
    self.box = {
        height = 150,
        color = {0,0,0,0.8},
    }

    self.box.y = VIRTUAL_HEIGHT/2 - self.box.height/2
end

function GameOverState:enter(enterParas)
    self.score = enterParas.score
end

function GameOverState:update(dt)
    if gKeyPressed['enter'] or gKeyPressed['return'] then
        gStateMachine:change('StartState')
    end
end


function GameOverState:render()
    drawRectangle(self.box.color,0,self.box.y,VIRTUAL_WIDTH,self.box.height,5)

    local cursor = self.box.y+20
    love.graphics.setFont(gFonts['large'])
    love.graphics.setColor(1,1,1,1)
    printTextShadow("GAME OVER",0,cursor,VIRTUAL_WIDTH,'center')
    love.graphics.printf("GAME OVER",0,cursor,VIRTUAL_WIDTH,'center')

    cursor = cursor + 40
    love.graphics.setFont(gFonts['medium'])
    printTextShadow("Score: " .. tostring(self.score), 0,cursor,VIRTUAL_WIDTH, 'center')
    love.graphics.printf("Score: " .. tostring(self.score), 0,cursor,VIRTUAL_WIDTH, 'center')

    cursor = cursor + 25
    printTextShadow('Press Enter', 0, cursor, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter', 0, cursor, VIRTUAL_WIDTH, 'center')
end
