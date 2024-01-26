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
                    atlas:getDimensions()
                ))
                cursor.x = cursor.x + TILE_WIDTH
            end
        end
        cursor.x=0
        cursor.y = cursor.y + 2*TILE_HEIGHT
    end

    return tiles
end


function drawGraphicWithShadow(atlas,quad,x,y,shadowThickness)
    love.graphics.setColor(0,0,0,1)
    love.graphics.draw(atlas,quad,x+shadowThickness,y+shadowThickness)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(atlas,quad,x,y) 
end

function drawFilter(r,g,b,a)
    love.graphics.setColor(r,g,b,a)
    love.graphics.rectangle('fill',0,0,VIRTUAL_WIDTH,VIRTUAL_HEIGHT)
end