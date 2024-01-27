gamestates = { pause='pause', running='running', over='game over' }
state = gamestates.running
length = 0
up = false
down = false
left = false
right = false
font = love.graphics.newFont(15)

local snake = { x = 15, y = 15 }
local dir = { x = 0, y = 0 }

local size = 20
local applesize = 15
local apple = { x = 0, y = 0 }
local tail = {}

local function incrementtail()
  length = length + 1
end

local function addappleincrement()
  addapple()
  incrementtail()
  table.insert(tail, {0, 0})
end

function addapple()
  math.randomseed(os.time())

  apple.x = math.random(applesize-1)
  apple.y = math.random(applesize-1)
end

local function direction(x, y)
  dir.x, dir.y = x, y
end

function drawgame()
  love.graphics.setColor(0,255,0)
  love.graphics.rectangle('fill', snake.x*size, snake.y*size, size, size)

  love.graphics.setColor(0,204,0)
  for _, v in ipairs(tail) do
    love.graphics.rectangle('fill', v[1]*size, v[2]*size, size, size)
  end

  love.graphics.setColor(255,0,0)
  love.graphics.rectangle('fill', apple.x*size, apple.y*size, size, size, 15, 15)

  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setFont(font)
  love.graphics.print('score: ' .. length, 10, 10, 0, 1.5, 1.5, 0, 0, 0, 0)
end

function updategame()
  if up and dir.y == 0 then
    direction(0, -1)
  elseif down and dir.y == 0 then
    direction(0, 1)
  elseif left and dir.x == 0 then
    direction(-1, 0)
  elseif right and dir.x == 0 then
    direction(1, 0)
  end

  local old = { x = snake.x, y = snake.y }

  snake.x = snake.x + dir.x
  snake.y = snake.y + dir.y

  local catchapple = snake.x == apple.x and snake.y == apple.y

  if catchapple then
    addappleincrement()
    eataudio()
  end

  if snake.x < 0 then
    snake.x = size - 1
  elseif snake.x > size - 1 then
    snake.x = 0
  elseif snake.y < 0 then
    snake.y = size - 1
  elseif snake.y > size - 1 then
    snake.y = 0
  end

  if length > 0 then
    for _, v in ipairs(tail) do
      local x, y = v[1], v[2]
      v[1], v[2] = old.x, old.y
      old.x, old.y = x, y
    end
  end

  for _, v in ipairs(tail) do
    local deadsnake = snake.x == v[1] and snake.y == v[2]

    if deadsnake then
      state = gamestates.over
      deathaudio()
    end
  end
end

function restartgame()
  snake.x, snake.y = 15, 15
  dir.x, dir.y = 0, 0
  tail = {}
  up, down, left, right = false, false, false, false
  length = 0
  state = gamestates.running
  addapple()
end
