
push = require 'lib/push'

Class = require 'lib/class'

Timer = require 'lib/knife.timer'

require 'src/CONSTANTS'
require 'src/Utilities'
require 'src/StateMachine'
require 'src/Board'
require 'src/Tile'


require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/BeginGameState'
require 'src/states/PlayState'


gSounds = {
    ['music'] = love.audio.newSource('sounds/music3.mp3', 'static'),
    ['select'] = love.audio.newSource('sounds/select.wav', 'static'),
    ['error'] = love.audio.newSource('sounds/error.wav', 'static'),
    ['match'] = love.audio.newSource('sounds/match.wav', 'static'),
    ['clock'] = love.audio.newSource('sounds/clock.wav', 'static'),
    ['game-over'] = love.audio.newSource('sounds/game-over.wav', 'static'),
    ['next-level'] = love.audio.newSource('sounds/next-level.wav', 'static')
}

gTextures = {
    ['main'] = love.graphics.newImage('graphics/match3.png'),
    ['background'] = love.graphics.newImage('graphics/background.png'),
    ['sparkle'] = love.graphics.newImage('graphics/sparkle.png')
}

gQuads = {
    ['tiles'] = GenerateTileQuads(gTextures['main'])
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
}

gStateMachine = StateMachine{
    ['BaseState'] = function() return BaseState() end,
    ['StartState'] = function() return StartState() end,
    ['BeginGameState'] = function() return BeginGameState() end,
    ['PlayState'] = function() return PlayState() end,
}


