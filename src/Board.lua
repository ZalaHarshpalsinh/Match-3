Board = Class{}

function Board:init(x,y,level) 
    self.x = x 
    self.y = y
    self.level = level
    self:fillTiles()
end

function Board:fillTiles()
    self.tiles = {}

    for y=1,8 do 
        self.tiles[y] = {}
        for x=1,8 do 
            table.insert(self.tiles[y], Tile(
                self.x + (x-1)*TILE_WIDTH,
                self.y + (y-1)*TILE_HEIGHT,
                x,
                y,
                math.random(#gQuads['tiles']),
                (math.random(#gQuads['tiles'][1]) % self.level) + 1
            ))
        end
    end

end

function Board:render()
    for y,row in pairs(self.tiles) do
        for x,tile in pairs(row) do
            tile:render()
        end
    end
end
