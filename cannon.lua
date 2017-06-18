local cannon = {}

require 'lib.slam'
local wappen = require('wappen')
local background
local brett

alarm = love.audio.newSource("audio/scifiShoot.wav")


--explosionImg = love.graphics.newImage("explosion.png")
--explosions = {}

--function addExplosion(ball)
  --table.insert(explosions, {x = ball.x, y = ball.y}
--end


function getBoundingBoxBall(ball)
  local ball_left = ball.x - cannonball1:getWidth() / 2
  local ball_right = ball_left + cannonball1:getWidth()
  local ball_width = cannonball1:getWidth()
  local ball_top = ball.y - cannonball1:getHeight() / 2
  local ball_bottom = ball_top + cannonball1:getHeight()
  local ball_height = cannonball1:getHeight()
  return ball_left, ball_top, ball_width, ball_height
end



function checkCollision(ball, cnr)
  ball_left, ball_top, ball_width, ball_height = getBoundingBoxBall(ball)
  local ball_right = ball_left + ball_width
  local ball_bottom = ball_top + ball_height

  if ball_top < 120 then
      return false
  end
  
  local t = wappen.allTargets
  for i = #t, 1, -1 do
    local v = t[i]
    v_left, v_top, v_width, v_height  = wappen.getBoundingBox(v)
    local v_right = v_left + v_width
    local v_bottom = v_top + v_height

    --if ball_right < v_right and
    --ball_left > v_left and
    --ball_bottom < v_bottom and
    --ball_top > v_top then

    -- if (math.abs(ball_left -v_left) * 2 <= (ball_width + v_width)) and
    -- (math.abs(ball_top - v_top) * 2 <=(ball_height + v_height)) then

    if not (ball_left > v_right or 
      ball_right < v_left or
      ball_top > v_bottom or
      ball_bottom < v_top
      ) then

      if v.correct == true then
        if cnr == 1 then
          score1 = score1 + 1
        else
          score2 = score2 + 1
        end
      else
        if cnr == 1 then
          score1 = score1 - 1
        else
          score2 = score2 - 1
        end
      end

      love.audio.play(alarm)
      table.remove(wappen.allTargets, i)

      return true

    else 



    end
  end
  return false
end


function deg2rad(deg)
  return deg/360*2*pi
end

function rad2deg(rad)
  return rad/2*pi*360
end


function abschussVektor1(cannon)
  dy = - math.sin(cannon1.rohr + cannon1.rotation) * cannon1.speed
  dx = - math.cos(cannon1.rohr + cannon1.rotation) * cannon1.speed

  return dx, dy
end

function abschussVektor2(cannon)
  dy =  - math.sin(cannon2.rohr - cannon2.rotation) * cannon2.speed
  dx =  math.cos(cannon2.rohr - cannon2.rotation) * cannon2.speed

  return dx, dy
end

function abschussPosition2(cannon)
  --print ("Direction", direction)
  dist = math.sqrt((cannon.kx-cannon.ox)*(cannon.kx-cannon.ox) + (cannon.ky-cannon.oy)*(cannon.ky-cannon.oy))
  dist = dist * 0.7
  --print ("Distance: ", dist)
  --print("Rotation: ", rad2deg(cannon.rotation))
  y = - math.sin(cannon.alpha-cannon.rotation) * dist 
  x =  math.cos(cannon.alpha-cannon.rotation) * dist
  --print("dx,dy: ", x, y)
  --print("cannon x,y: ", cannon.x, cannon.y)
  resultx = cannon.x + x 
  resulty = cannon.y + y
  --print("result x,y: ", resultx, resulty)
  return resultx, resulty

end


function abschussPosition1(cannon)
  --print ("Direction", direction)
  dist = math.sqrt((cannon.kx-cannon.ox)*(cannon.kx-cannon.ox) + (cannon.ky-cannon.oy)*(cannon.ky-cannon.oy))
  dist = dist * 0.7
  --print ("Distance: ", dist)
  --print("Rotation: ", rad2deg(cannon.rotation))
  y = - math.sin(cannon.alpha+cannon.rotation) * dist 
  x = - math.cos(cannon.alpha+cannon.rotation) * dist
  --print("dx,dy: ", x, y)
  --print("cannon x,y: ", cannon.x, cannon.y)
  resultx = cannon.x + x 
  resulty = cannon.y + y
  --print("result x,y: ", resultx, resulty)
  return resultx, resulty

end



local function load()
  score1 = 0
  score2 = 0
  font = love.graphics.newFont("fonts/carbon.ttf", 70)
  
  --COUNTDOWN
  remainingTime = 30
  gameover = false
  --//////////////////
  
  countdownIsOn = false
  
  
 
  
  backgroundMusic = love.audio.newSource("audio/radetzkymarsch.mp3")
  backgroundMusic:setLooping(false)
  backgroundMusic:setVolume(.3)
  love.audio.play(backgroundMusic)
  bang = love.audio.newSource("audio/bang.wav")
  countdownAlarm = love.audio.newSource("audio/countdown.wav")

--bang:setVolume(0.9) -- 90% of ordinary volume
--bang:setPitch(0.5) -- one octave lower
--bang:setVolume(0.7)


  background = love.graphics.newImage("background/Hintergrund Stuttgart flach.jpg")
  brett = love.graphics.newImage("background/brett-anzeige.png")
  endScreen = love.graphics.newImage("background/game over.png")
  cannonball1 = love.graphics.newImage("cannon/cannonball1.png")
  cannonball2 = love.graphics.newImage("cannon/cannonball2.png")

  playgroundWidth = love.graphics.getWidth()
  playgroundHeight = love.graphics.getHeight()
  bulletX = playgroundWidth
  bulletY = playgroundHeight
  pi  = 3.14159
  bulletSpeed = 400
  bullets1 = {}
  bullets2 = {}
  cannon1sprite  = love.graphics.newImage("cannon/cannon1.png")
  cannon2sprite  = love.graphics.newImage("cannon/cannon2.png")

  rotation1 = 0
  rotation2 = 0

  love.keyboard.setKeyRepeat(false)

  cannon1 = {
    sprite = cannon1sprite, 
    x = playgroundWidth - 150, 
    y = playgroundHeight - 50, 
    width = cannon1sprite:getWidth(), 
    height = cannon1sprite:getHeight(), 
    rohr = deg2rad(17.98), 
    alpha = deg2rad(74.5),
    ox = 55, 
    oy = 159,
    rotation = 0,
    kx = 14,
    ky = 19,
    speed = playgroundWidth/3
  }
  cannon2 = {
    sprite = cannon2sprite, 
    x = 100, 
    y = playgroundHeight - 50, 
    width = cannon2sprite:getWidth(), 
    height = cannon2sprite:getHeight(), 
    rohr = deg2rad(5.35), 
    alpha = deg2rad(24.4),
    ox = 148, 
    oy = 129,
    rotation = 0,
    kx = 366,
    ky = 25,
    speed = playgroundWidth/3
  }

end

local function update(dt)
  
  --COUNTDOWN
  remainingTime = remainingTime - dt 
  if remainingTime <= 0 then
    gameover = true
  end
  
  if gameover then
    function love.draw()
      love.audio.stop(countdownAlarm)
      love.graphics.draw(endScreen , 0, 0, 0, 
      love.graphics.getWidth() / endScreen:getWidth() , 
      love.graphics.getHeight() / endScreen:getHeight())      
      love.graphics.setColor(255, 10, 10)
      love.graphics.setFont(font)
      
      love.graphics.print("Game Over", love.graphics.getWidth()/3, playgroundHeight - 500)
      love.graphics.setFont(font, love.graphics.getHeight() / 20)
      love.graphics.print(score2, love.graphics.getWidth()/4, playgroundHeight - 100)
      love.graphics.print(score1, love.graphics.getWidth()/4 * 3, playgroundHeight - 100)
      love.graphics.setColor(255, 255, 255)
    
    end
  end
  
  
  --////////////////////////

  if love.keyboard.isDown("left") then
    cannon1.rotation = cannon1.rotation - deg2rad(2)
  elseif love.keyboard.isDown("right") then
    cannon1.rotation = cannon1.rotation + deg2rad(2)
  end

  if love.keyboard.isDown("a") then
    cannon2.rotation = cannon2.rotation - deg2rad(2)
  elseif love.keyboard.isDown("d") then
    cannon2.rotation = cannon2.rotation + deg2rad(2)
  end

  for i,v in ipairs(bullets1) do
    v.x = v.x + (v.dx * dt) 
    v.y = v.y + (v.dy * dt)
    v.dy = v.dy + 2

    if checkCollision(v, 1) then 
      --addExplosion(v.x, v.y)
      table.remove(bullets1, i)
    end

  end

  for i,v in ipairs(bullets2) do
    v.x = v.x + (v.dx * dt) 
    v.y = v.y + (v.dy * dt)
    v.dy = v.dy + 2

    if checkCollision(v, 2) then 
      table.remove(bullets2, i)
    end
  end

end

local function draw()
  -- love.graphics.setColor(200, 200, 200)
  love.graphics.draw(background, 0, 0, 0, 
    love.graphics.getWidth() / background:getWidth() , 
    love.graphics.getHeight() / background:getHeight())
  love.graphics.setColor(255, 255, 255)
  --love.graphics.rectangle("fill",  player.x, player.y, player.width, player.height)
  love.graphics.draw(cannon1.sprite, cannon1.x, cannon1.y, cannon1.rotation, 0.7, 0.7, cannon1.ox, cannon1.oy) 
  love.graphics.draw(cannon2.sprite, cannon2.x, cannon2.y, cannon2.rotation, 0.7, 0.7, cannon2.ox, cannon2.oy) 
  love.graphics.setColor(255, 0, 0)

  --love.graphics.circle("fill", cannon2.x, cannon2.y, 4)
  --startX, startY = abschussPosition2(cannon2)
  --love.graphics.circle("fill", startX, startY, 4)

  --love.graphics.circle("fill", cannon1.x, cannon1.y, 4)

  --love.graphics.circle("fill", startX, startY, 4)
  --startX, startY = abschussPosition1(cannon1)
  --dx, dy = abschussVektor1(cannon1)
  --love.graphics.line(startX, startY, startX + dx, startY + dy)

  --startX, startY = abschussPosition2(cannon2)
  --dx, dy = abschussVektor2(cannon2)
  --love.graphics.line(startX, startY, startX + dx, startY + dy)

  love.graphics.setColor(255, 255, 255)
  for i,v in ipairs(bullets1) do
    --love.graphics.circle("fill", v.x, v.y, 8)
    love.graphics.draw(cannonball1, v.x, v.y, 0, 1, 1, cannonball1:getWidth()/2, cannonball1:getWidth()/2)
    -- love.graphics.circle("fill",v.x, v.y, 4)
    -- b_left, b_top, b_width, b_height = getBoundingBoxBall(v)
    -- love.graphics.rectangle("line", b_left, b_top, b_width, b_height)
    if v.x < 0 
    or v.y < 0 
    or v.x > playgroundWidth
    or v.y > playgroundHeight then
      table.remove(bullets1, i)
    end

  end
  for i,v in ipairs(bullets2) do
    --love.graphics.circle("fill", v.x, v.y, 8)
    love.graphics.draw(cannonball1, v.x, v.y, 0, 1, 1, cannonball1:getWidth()/2, cannonball1:getWidth()/2)
    -- love.graphics.circle("fill",v.x, v.y, 4)
    if v.x < 0 
    or v.y < 0 
    or v.x > playgroundWidth
    or v.y > playgroundHeight then
      table.remove(bullets2, i)
    end
  end
  
  screenscale = love.graphics.getWidth() / 1536
  
  love.graphics.draw(brett, 300, playgroundHeight - 130, 0, 
    1.2 * screenscale, 1 * screenscale)
    
  love.graphics.setFont(font)
  love.graphics.setColor(0,0,0)
  love.graphics.print(score1, playgroundWidth - 400, playgroundHeight - 100)
  love.graphics.print(score2, 400, playgroundHeight - 100)
  
  --COUNTDOWN
  love.graphics.print(math.floor(remainingTime), playgroundWidth / 2, playgroundHeight - 100)
  love.graphics.setColor(255,255,255)

  if remainingTime < 11 and countdownIsOn == false then
    love.audio.play(countdownAlarm)
    countdownIsOn = true
  end
    
  
end

cannon.load = load
cannon.update = update
cannon.draw = draw

return cannon