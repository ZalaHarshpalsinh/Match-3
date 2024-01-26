Tile = Class{}

function Tile:init(x,y,gridX,gridY,color,shape)
    self.gridX = gridX
    self.gridY = gridY

    self.x = x 
    self.y = y
    
    self.color = color
    self.shape = shape
end


function Tile:render()
    drawGraphicWithShadow(gTextures['main'], gQuads['tiles'][self.color][self.shape], self.x, self.y, 4)
end