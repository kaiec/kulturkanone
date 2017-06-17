
require 'slam'
local wappen = require('wappen')
local cannon = require('cannon')



function love.load()

  wappen.load()
  cannon.load()

end

function love.update(dt)
  wappen.update(dt)
  cannon.update(dt)

end

function love.draw()

  cannon.draw()

  wappen.draw()
end








function love.keypressed(key, scancode, isrepeat)
--  if key == "left" then
--    cannon1.rotation = cannon1.rotation - deg2rad(2)
--  elseif key == "right" then
--    cannon1.rotation = cannon1.rotation + deg2rad(2)
  if key == "m" then
    startX, startY = abschussPosition1(cannon1)
    dx, dy = abschussVektor1(cannon1)
    if #bullets1 < 1 then
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
    if #bullets2 < 1 then
      table.insert(bullets2, {x = startX, y = startY, dx = dx, dy = dy})
      bang:play()
    end
  end
end
