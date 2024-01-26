BeginGameState = Class{__includes = BaseState}

function BeginGameState:init()
    self.transitionAlpha = 1
    self.boardX = VIRTUAL_WIDTH/2 - 20
    self.boardY =  (VIRTUAL_HEIGHT - 8*TILE_HEIGHT)/2

    self.levelLabel = {
        color = {95/255, 205/255, 228/255, 200/255},
        height = 50,
        y = -50
    }

    self.levelLabel.paddingY = (self.levelLabel.height - gFonts['large']:getHeight()) / 2
end

function BeginGameState:enter(enterParas)
    self.levelLabel.level = enterParas.level
    self.board = Board(self.boardX,self.boardY,self.levelLabel.level)

    Timer.tween(1,{
        [self] = {transitionAlpha = 0}
    }):finish(function()
        Timer.tween(0.5,{
            [self.levelLabel] = {y = VIRTUAL_HEIGHT/2 - self.levelLabel.height/2}
        }):finish(function()
            Timer.after(1,function()
                Timer.tween(0.5,{
                    [self.levelLabel] = {y = VIRTUAL_HEIGHT + self.levelLabel.height}
                }):finish(function()
                    gStateMachine:change('PlayState',{
                        level = self.levelLabel.level,
                        board = self.board
                    })
                end)
            end)
        end)
    end)

end

function BeginGameState:update(dt)
    Timer.update(dt)
end

function BeginGameState:render()
    self.board:render()

    drawRectangle(self.levelLabel.color,0,self.levelLabel.y,VIRTUAL_WIDTH,self.levelLabel.height,0)
    
    love.graphics.setColor(1,1,1,1)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Level ' .. tostring(self.levelLabel.level), 0, self.levelLabel.y+self.levelLabel.paddingY, VIRTUAL_WIDTH, 'center')

    drawRectangle({1,1,1,self.transitionAlpha},0,0,VIRTUAL_WIDTH,VIRTUAL_HEIGHT,0)
end