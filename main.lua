
require 'slam'
local wappen = require('wappen')
local cannon = require('cannon')
local coundownAndRememberWappen = require('coundownAndRememberWappen')
local startmenu = require ('startmenu')

local gamestate = "remember"

function love.load()
  startmenu.load()
    coundownAndRememberWappen.load()
    wappen.load()
    cannon.load()
end

function love.update(dt)
  if gamestate=="remember" then
    coundownAndRememberWappen.update(dt)
    if coundownAndRememberWappen.done() then
      gamestate = "spiel"
    end
  elseif gamestate=="spiel" then
    wappen.update(dt)
    cannon.update(dt)
  end

end

function love.draw()
  if gamestate=="remember" then
    coundownAndRememberWappen.draw()
  elseif gamestate=="spiel" then
    cannon.draw()
    wappen.draw()
  end

end








function love.keypressed(key, scancode, isrepeat)
--  if key == "left" then
--    cannon1.rotation = cannon1.rotation - deg2rad(2)
--  elseif key == "right" then
--    cannon1.rotation = cannon1.rotation + deg2rad(2)
  if key == "m" then
    startX, startY = abschussPosition1(cannon1)
    dx, dy = abschussVektor1(cannon1)
    if #bullets1 < 3 then
      table.insert(bullets1, {x = startX, y = startY, dx = dx, dy = dy})
      bang:play()
    end

--  elseif key == "a" then
--    cannon2.rotation = cannon2.rotation - deg2rad(2)
--  elseif key=="d" then
--    cannon2.rotation = cannon2.rotation + deg2rad(2)
  elseif key=="f" then
    startX, startY = abschussPosition2(cannon2)
    dx, dy = abschussVektor2(cannon2)
    if #bullets2 < 3 then
      table.insert(bullets2, {x = startX, y = startY, dx = dx, dy = dy})
      bang:play()
    end
  end
end
