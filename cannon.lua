local cannon = {}

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
  backgroundMusic = love.audio.newSource("audio/radetzkymarsch.mp3")
  backgroundMusic:setLooping(true)
  backgroundMusic:setVolume(.3)
  love.audio.play(backgroundMusic)
  bang = love.audio.newSource("audio/bang.wav")

--bang:setVolume(0.9) -- 90% of ordinary volume
--bang:setPitch(0.5) -- one octave lower
--bang:setVolume(0.7)
  

  background = love.graphics.newImage("background/Hintergrund-Stuttgart2.png")
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
    x = playgroundWidth - 200, 
    y = playgroundHeight - 100, 
    width = cannon1sprite:getWidth(), 
    height = cannon1sprite:getHeight(), 
    rohr = deg2rad(17.98), 
    alpha = deg2rad(74.5),
    ox = 55, 
    oy = 159,
    rotation = 0,
    kx = 14,
    ky = 19,
    speed = 400
  }
  cannon2 = {
    sprite = cannon2sprite, 
    x = 100, 
    y = playgroundHeight - 100, 
    width = cannon2sprite:getWidth(), 
    height = cannon2sprite:getHeight(), 
    rohr = deg2rad(5.35), 
    alpha = deg2rad(24.4),
    ox = 148, 
    oy = 129,
    rotation = 0,
    kx = 366,
    ky = 25,
    speed = 400
  }
 
  end

local function update(dt)
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
  end
  
  for i,v in ipairs(bullets2) do
    v.x = v.x + (v.dx * dt) 
    v.y = v.y + (v.dy * dt)
    v.dy = v.dy + 2
  end
  
end

local function draw()
  love.graphics.setColor(200, 200, 200)
  love.graphics.draw(background, 0, -90, 0, 0.39, 0.39)
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
  startX, startY = abschussPosition1(cannon1)
  dx, dy = abschussVektor1(cannon1)
  love.graphics.line(startX, startY, startX + dx, startY + dy)
  
  startX, startY = abschussPosition2(cannon2)
  dx, dy = abschussVektor2(cannon2)
  love.graphics.line(startX, startY, startX + dx, startY + dy)

  love.graphics.setColor(255, 255, 255)
  for i,v in ipairs(bullets1) do
    --love.graphics.circle("fill", v.x, v.y, 8)
    love.graphics.draw(cannonball1, v.x, v.y, 0, 1, 1, cannonball1:getWidth()/2, cannonball1:getWidth()/2)
    if v.x < 0 
    or v.y < 0 
    or v.x > playgroundWidth
    or v.y > playgroundHeight then
      table.remove(bullets1)
    end
    
  end
  for i,v in ipairs(bullets2) do
    --love.graphics.circle("fill", v.x, v.y, 8)
    love.graphics.draw(cannonball1, v.x, v.y, 0, 1, 1, cannonball1:getWidth()/2, cannonball1:getWidth()/2) 
  end
end

cannon.load = load
cannon.update = update
cannon.draw = draw

return cannon