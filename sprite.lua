local sprite = {}
local fps = 15
local anim_timer = 1/ fps
local frame = 1
local num_frames = 15
local xoffset

function drawExplosion(xPos, yPos)
  love.graphics.draw(explosion_png, explosion_sprite, xPos, yPos)
end

function animation(dt)
  anim_timer = anim_timer -dt
  
  if anim_timer <= 0 then
    anim_timer = 1 / fps
    frame = frame + 1
    if frame > num_frames then
      frame = 1
    end
    xoffset = 128 * frame
    explosion_sprite:setViewport(xoffset, 0, 128,128)
  end
end

local function load()
  xPos = 0
  yPos = 0
  
  explosion_png = love.graphics.newImage("sprite/explosion_sprite_row.png")
  
  explosion_sprite = love.graphics.newQuad(0, 0, 128, 128, explosion_png:getDimensions())
end



local function update(dt)
  
  
end

local function draw()
  
  
end

sprite.load = load
sprite.update = update
sprite.draw = draw
sprite.drawExplosion = drawExplosion
sprite.animation = animation


return sprite