StartState = Class{__includes = BaseState}


function StartState:init()
    self.staticBoard = Board(VIRTUAL_WIDTH/2 - (4*TILE_WIDTH),50,1)
    self.menu = {'Start', 'Quit'}
end

function StartState:enter(enterParas)
    
end

function StartState:update(dt)

end

function StartState:render()
    self.staticBoard:render()

    drawFilter(0,0,0,0.3)

    self:drawLogo()
    self:drawMenu()

end


function StartState:drawLogo()

end