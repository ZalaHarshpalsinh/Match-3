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

function drawRectangle(color,x,y,width,height,curve)
    love.graphics.setColor(color)
    love.graphics.rectangle('fill',x,y,width,height,curve)
    love.graphics.setColor(1,1,1,1)
end

function printTextShadow(text,x,y,width, alignment)
    width = width or VIRTUAL_WIDTH
    alignment = alignment or 'left'
    
    love.graphics.setColor(0,0,0,1)
    love.graphics.printf(text, x+1, y, width, alignment)
    love.graphics.printf(text, x+2, y, width, alignment)
    love.graphics.printf(text, x, y+2, width, alignment)
    love.graphics.printf(text, x+1, y+2, width, alignment)
    love.graphics.printf(text, x+2, y+2, width, alignment)
    love.graphics.setColor(1,1,1,1)
end