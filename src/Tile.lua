Tile = Class{}

function Tile:init(x,y,gridX,gridY,color,shape)
    self.gridX = gridX
    self.gridY = gridY

    self.x = x 
    self.y = y
    
    self.color = color
    self.shape = shape

    self.isSpecial = math.random(50)==1 and true or false

    self.partical_system = love.graphics.newParticleSystem(gTextures['sparkle'],100)
    self.partical_system:setEmissionArea('borderrectangle',8,8,0,true)
    self.partical_system:setEmissionRate(1.5)
    self.partical_system:setEmitterLifetime(-1)
    self.partical_system:setParticleLifetime(1,2)
    self.partical_system:setLinearAcceleration(-10,-10,10,10)
end

function Tile:update(dt)
    self.partical_system:update(dt)
end

function Tile:render()
    drawGraphicWithShadow(gTextures['main'], gQuads['tiles'][self.color][self.shape], self.x, self.y, 4)
    if(self.isSpecial)then
        love.graphics.draw(self.partical_system,self.x+TILE_WIDTH/2,self.y+TILE_HEIGHT/2)
    end
end