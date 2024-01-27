require('game')
require('alerts')
require('sounds')

function love.load()
  love.window.setPosition(500, 50, 1)
  interval = 20
  addapple()
end

function love.draw()
  drawgame()

  if state == gamestates.over then
    gameover()
  end

  if state == gamestates.pause then
    gamepause()
  end
end

function love.update()
  if state == gamestates.running then
    interval = interval - 1

    if interval < 0 then
      updategame()
      if length <= 5 then
        interval = 20
      elseif length > 5 and length <= 10 then
        interval = 15
      elseif length > 10 and length <= 5 then
        interval = 10
      else
        interval = 5
      end
    end
  end
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == 'left' or key == 'a' and state == gamestates.running then
    left, right, up, down = true, false, false, false
    leftaudio()
  elseif key == 'right' or key =='d' and state == gamestates.running then
    left, right, up, down = false, true, false, false
    rightaudio()
  elseif key == 'up' or key =='w' and state == gamestates.running then
    left, right, up, down = false, false, true, false
    upaudio()
  elseif key == 'down' or key == 's' and state == gamestates.running then
    left, right, up, down = false, false, false, true
    downaudio()
  elseif key == 'space' and state == gamestates.over then
    restartgame()
  elseif key == 'p' then
    if state == gamestates.running then
      state = gamestates.pause
    elseif state ~= gamestates.over then
      state = gamestates.running
    end
  end
end
