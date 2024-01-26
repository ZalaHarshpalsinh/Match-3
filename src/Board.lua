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

    if self:calculateMatches() then
        self:fillTiles()
    end
end

function Board:calculateMatches()
    local matches = {}
    local rows = #self.tiles
    local columns = #self.tiles[1]

    for y=1,rows do
        
        local lastColor = self.tiles[y][1].color
        local matchLength = 1
        for x=2,columns do

            local tile = self.tiles[y][x]
            if lastColor == tile.color then
                matchLength = matchLength + 1
            else
                if matchLength>=3 then
                    local match = {}

                    for i=x-1,x-matchLength,-1 do
                        table.insert(match,self.tiles[y][i])
                    end

                    table.insert(matches,match)
                end
                lastColor = tile.color
                matchLength = 1

                if x>=7 then break end
            end
        end

        if matchLength>=3 then
            local match = {}
            for i=columns,columns+1-matchLength,-1 do
                table.insert(match,self.tiles[y][i])
            end
            table.insert(matches,match)
        end
    end

    for x=1,columns do
        
        local lastColor = self.tiles[1][x].color
        local matchLength = 1
        for y=2,rows do

            local tile = self.tiles[y][x]
            if lastColor == tile.color then
                matchLength = matchLength + 1
            else
                if matchLength>=3 then
                    local match = {}

                    for i=y-1,y-matchLength,-1 do
                        table.insert(match,self.tiles[i][x])
                    end

                    table.insert(matches,match)
                end
                lastColor = tile.color
                matchLength = 1

                if y>=7 then break end
            end
        end

        if matchLength>=3 then
            local match = {}
            for i=rows,rows+1-matchLength,-1 do
                table.insert(match,self.tiles[i][x])
            end
            table.insert(matches,match)
        end
    end

    self.matches = matches

    return #matches > 0 and self.matches or false
end

function Board:removeMatches()
    for i,match in pairs(self.matches) do
        for j,tile in pairs(match) do
            self.tiles[tile.gridY][tile.gridX] = nil
        end
    end

    self.matches = nil
end

function Board:getNewTiles()
    local tweens = {}
    local rows = #self.tiles
    local columns = #self.tiles[1]

    for x=1,columns do
        local space = false
        local spaceY = 0

        local y=rows

        while y>=1 do
            local tile = self.tiles[y][x]

            if space then
                if tile then
                    self.tiles[spaceY][x] = tile

                    tweens[tile] = {
                        y = self.y + (spaceY-1)*TILE_HEIGHT,
                        gridY = spaceY
                    }

                    self.tiles[y][x] = nil

                    space = false
                    y = spaceY

                    spaceY = 0
                end 
            else
                if tile == nil then
                    space = true
                    spaceY = y
                end
            end
            y = y -1
        end
    end

    for y=1,rows do
        for x=1,columns do

            local tile = self.tiles[y][x]

            if tile == nil then
                self.tiles[y][x] = Tile(
                    self.x+(x-1)*TILE_WIDTH,
                    -TILE_HEIGHT,
                    x,
                    y,
                    math.random(#gQuads['tiles']),
                    (math.random(#gQuads['tiles'][1]) % self.level) + 1
                )

                tweens[self.tiles[y][x]] = {
                    y = (self.y+(y-1)*TILE_HEIGHT)
                }
            end
        end
    end

    return tweens
end

function Board:render()
    for y,row in pairs(self.tiles) do
        for x,tile in pairs(row) do
            tile:render()
        end
    end
end
