PlayState = Class{__includes = BaseState}


function PlayState:init()
    self.panel = {
        timeleft = 25,
        box = {
            x = 20,
            y = 20,
            width = 150,
            height = 150,
            color = {219/255, 180/255, 90/255, 0.9}
        },
        textColor = {17/255, 3/255, 59/255, 1},
    }

    self.isSelected = false
    self.selectedTile = {gridX=0, gridY=0, opacity = 1}

    Timer.every(1,function()
        self.panel.timeleft = self.panel.timeleft - 1

        if self.panel.timeleft <= 10 then
            gSounds['clock']:play()
        end
    end)
end

function PlayState:enter(enterParas)
    self.panel.level = enterParas.level
    self.panel.score = enterParas.score
    self.panel.targetScore = enterParas.targetScore

    self.board = enterParas.board
end

function PlayState:update(dt)

    self.board:update(dt)

    if self.panel.timeleft <=0 then
        Timer.clear()
        gSounds['game-over']:play()
        gStateMachine:change('GameOverState',{
            score = self.panel.score
        })
    elseif self.panel.score >= self.panel.targetScore then
        Timer.clear()
        gSounds['next-level']:play()
        gStateMachine:change('BeginGameState',{
            level = self.panel.level + 1,
            targetScore = self.panel.targetScore + 500,
            score = self.panel.score,
        })
    end

    if gMouse.clicked then

        if self:isValidClick() then

            gSounds['select']:play()
            local clickGridX = math.ceil((gMouse.coords.x - self.board.x)/TILE_WIDTH)
            local clickGridY = math.ceil((gMouse.coords.y - self.board.y)/TILE_HEIGHT)
    
            if self.isSelected then
                self.isSelected = false
                self.blinkTimer:remove()
    
                local tile1 = self.board.tiles[self.selectedTile.gridY][self.selectedTile.gridX]
                local tile2 = self.board.tiles[clickGridY][clickGridX]
                
                self.board.tiles[self.selectedTile.gridY][self.selectedTile.gridX] = tile2
                self.board.tiles[clickGridY][clickGridX] = tile1
    
                Timer.tween(0.5,{
                    [tile1] = {x=tile2.x, y=tile2.y, gridX=tile2.gridX, gridY=tile2.gridY},
                    [tile2] = {x=tile1.x, y=tile1.y, gridX=tile1.gridX, gridY=tile1.gridY},
                }):finish(function()
                    self:handleMatches()
                end)
    
    
            else
                self.isSelected = true
                self.selectedTile.gridX = clickGridX
                self.selectedTile.gridY = clickGridY
                self:blinkSelectedTile(0.5)
                self.blinkTimer = Timer.every(0.6,function()
                    self:blinkSelectedTile(0.5)
                end)

            end
        else
            gSounds['error']:play()
        end
    end



    Timer.update(dt)
end

function PlayState:handleMatches()
    local matches = self.board:calculateMatches()

    if matches then

        gSounds['match']:play()
        local rewards =  self.board:removeMatches()

        self.panel.score = self.panel.score + rewards.score
        self.panel.timeleft = self.panel.timeleft + rewards.time

        local newTilesTweens = self.board:getNewTiles()

        Timer.tween(0.5,newTilesTweens):finish(function()
            self:handleMatches()
        end)
    end
end

function PlayState:render()
    self.board:render()

    if self.isSelected then
        self.selectedTile.x = self.board.x + (self.selectedTile.gridX - 1) * TILE_WIDTH
        self.selectedTile.y = self.board.y + (self.selectedTile.gridY - 1) * TILE_HEIGHT

        love.graphics.setLineWidth(4)
        love.graphics.setColor(1,0,0,self.selectedTile.opacity)
        love.graphics.rectangle('line', self.selectedTile.x, self.selectedTile.y, TILE_WIDTH, TILE_HEIGHT, 5)
    end

    self:drawPanel()
end

function PlayState:drawPanel()
    drawRectangle(self.panel.box.color, self.panel.box.x, self.panel.box.y, self.panel.box.width, self.panel.box.height, 0)

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(self.panel.textColor)
    
    local cursor = self.panel.box.y + 10 
    printTextShadow('Level: ' .. tostring(self.panel.level), self.panel.box.x, cursor, self.panel.box.width, 'center')
    love.graphics.printf('Level: ' .. tostring(self.panel.level), self.panel.box.x, cursor, self.panel.box.width, 'center')
    cursor = cursor + 30
    printTextShadow('Score: ' .. tostring(self.panel.score), self.panel.box.x, cursor, self.panel.box.width, 'center')
    love.graphics.printf('Score: ' .. tostring(self.panel.score), self.panel.box.x, cursor, self.panel.box.width, 'center')
    cursor = cursor + 30
    printTextShadow('Goal: ' .. tostring(self.panel.targetScore), self.panel.box.x, cursor, self.panel.box.width, 'center')
    love.graphics.printf('Goal: ' .. tostring(self.panel.targetScore), self.panel.box.x, cursor, self.panel.box.width, 'center')
    cursor = cursor + 30

    printTextShadow('Time left : ' .. tostring(self.panel.timeleft), self.panel.box.x, cursor, self.panel.box.width, 'center')

    if self.panel.timeleft<=10 then
        love.graphics.setColor(1,0,0,1)
    end
    love.graphics.printf('Time left : ' .. tostring(self.panel.timeleft), self.panel.box.x, cursor, self.panel.box.width, 'center')
end

function PlayState:isValidClick()
    if gMouse.clicked then
        if(gMouse.coords.x >= self.board.x)and(gMouse.coords.x <= self.board.x+GRID_COLUMNS*TILE_WIDTH)and(gMouse.coords.y >= self.board.y)and(gMouse.coords.y <= self.board.y+GRID_ROWS*TILE_HEIGHT) then
            return true
        else
            return false
        end
    else
        return false
    end
end

function PlayState:blinkSelectedTile(time)
    Timer.tween(time,{
        [self.selectedTile] = {opacity = 0.5}
    }):finish(function()
        self.selectedTile.opacity = 1
    end)
end