StartState = Class{__includes = BaseState}


function StartState:init()
    self.staticBoard = Board(VIRTUAL_WIDTH/2 - (4*TILE_WIDTH),VIRTUAL_HEIGHT/2 - (4*TILE_HEIGHT),1)
    
    self.logo = {
        text = "MATCH 3",
        box = {
            width = 150,
            height =50,
            color ={1,1,1,0.5},
        },
        parts = {
            {text = 'M', color = {217/255, 87/255, 99/255, 1}},
            {text = 'A', color = {95/255, 205/255, 228/255, 1}},
            {text = 'T', color = {251/255, 242/255, 54/255, 1}},
            {text = 'C', color = {118/255, 66/255, 138/255, 1}},
            {text = 'H', color = {153/255, 229/255, 80/255, 1}},
            {text = ' ', color = {153/255, 229/255, 80/255, 1}},
            {text = '3', color = {223/255, 113/255, 38/255, 1}},
        },
    }

    self.logo.box.paddingX = (self.logo.box.width - gFonts['large']:getWidth(self.logo.text))/2 
    self.logo.box.paddingY = (self.logo.box.height - gFonts['large']:getHeight(self.logo.text))/2 

    self.colorTimer = Timer.every(0.075,function()
        local lastColor = self.logo.parts[#self.logo.parts].color
        for i=#self.logo.parts,2,-1 do
            self.logo.parts[i].color = self.logo.parts[i-1].color
        end
        self.logo.parts[1].color = lastColor
    end)

    self.menu = {'Start', 'Quit'}
end

function StartState:enter(enterParas)
    
end

function StartState:update(dt)
    Timer.update(dt)
end

function StartState:render()
    self.staticBoard:render()

    drawRectangle({0,0,0,0.3},0,0,VIRTUAL_WIDTH,VIRTUAL_HEIGHT,0)

    self:drawLogo()
    self:drawMenu()

end


function StartState:drawLogo()

    local rectangleX, rectangleY  = VIRTUAL_WIDTH/2 - self.logo.box.width/2,  VIRTUAL_HEIGHT/2 - self.logo.box.height - 50
    drawRectangle(self.logo.box.color,
    rectangleX,
    rectangleY,
    self.logo.box.width, self.logo.box.height, 10
    )

    love.graphics.setFont(gFonts['large'])

    local cursor = {x=rectangleX+self.logo.box.paddingX, y=rectangleY+self.logo.box.paddingY}

    
    printShadow(self.logo.text,cursor.x,cursor.y)

    for i,part in pairs (self.logo.parts) do
        love.graphics.setColor(part.color)
        love.graphics.print(part.text, cursor.x, cursor.y)

        cursor.x = cursor.x + gFonts['large']:getWidth(part.text)
    end
end

function StartState:drawMenu()

end