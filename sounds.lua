sounds = {}
sounds.a = love.audio.newSource('sounds/left.ogg', 'static')
sounds.d = love.audio.newSource('sounds/right.ogg', 'static')
sounds.w = love.audio.newSource('sounds/up.ogg', 'static')
sounds.s = love.audio.newSource('sounds/down.ogg', 'static')
sounds.eat = love.audio.newSource('sounds/eat.ogg', 'static')
sounds.death = love.audio.newSource('sounds/death.ogg', 'static')

function leftaudio()
    sounds.a:play()
end

function rightaudio()
    sounds.d:play()
end

function upaudio()
    sounds.w:play()
end

function downaudio()
    sounds.s:play()
end

function eataudio()
    sounds.eat:play()
end

function deathaudio()
    sounds.death:play()
end