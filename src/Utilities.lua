

function GenerateTileQuads(atlas)
    local tiles = {}

    local cursor = {x=0,y=0};

    for row = 1,9,2 do

        for section = 1,2 do
            tiles[#tiles+1]={}

            for col=1,6 do
                table.insert(tiles[#tiles],love.graphics.newQuad(
                    cursor.x,
                    cursor.y,
                    TILE_WIDTH,
                    TILE_HEIGHT,
                    atlas:getDimentions()
                ))
                cursor.x += TILE_WIDTH
            end
        end
        cursor.x=0
        cursor.y+=2*TILE_HEIGHT
    end

    return tiles
end