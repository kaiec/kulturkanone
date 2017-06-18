
local wappen = {}
local allTargets = {}
  
local function load()
  
  playingAreaWidth = love.graphics.getWidth()
  playingAreaHeight = love.graphics.getHeight()
  
  images = {}
  table.insert(images, love.graphics.newImage("crest/105px-Wappen-stuttgart-vaihingen-stadtbezirk.png"))
  table.insert(images, love.graphics.newImage("crest/107px-Wappen_Stuttgart-Hofen_svg.png"))
  table.insert(images,love.graphics.newImage("crest/111px-Wappen-stuttgart-zazenhausen.png"))
  table.insert(images, love.graphics.newImage("crest/112px-Wappen-stuttgart-birkach.png"))
  table.insert(images,love.graphics.newImage("crest/112px-Wappen-stuttgart-gaisburg.png"))
  table.insert(images, love.graphics.newImage("crest/112px-Wappen-stuttgart-heumaden.png") )
  table.insert(images, love.graphics.newImage("crest/112px-Wappen-stuttgart-uhlbach.png"))
  table.insert(images,love.graphics.newImage("crest/113px-Wappen-stuttgart-muenster.png"))
  table.insert(images, love.graphics.newImage("crest/113px-Wappen-stuttgart-plieningen.png"))
  table.insert(images,love.graphics.newImage("crest/113px-Wappen-stuttgart-rohracker.png"))
  table.insert(images,love.graphics.newImage("crest/113px-Wappen-stuttgart-rotenberg.png"))
  table.insert(images, love.graphics.newImage("crest/114px-Wappen-stuttgart-degerloch.png"))
  table.insert(images,love.graphics.newImage("crest/117px-Coat_of_arms_of_Stuttgart_svg.png"))
  
  
  
  
  
  
  

  
  function createTarget()
   target = {} 
    target.targetHeight = 75
    target.targetWidth = 75
    target.targetY = 0
    target.speed = 250
    
    target.speedi = love.math.random(-100, 100)
    target.targetX = (playingAreaWidth)-(target.targetWidth/2)
    target.image = images[love.math.random(1, #images)]
    target.point1Y = love.math.random(0, playingAreaHeight)
    target.point2Y = love.math.random(0, playingAreaHeight)
    target.point3Y = love.math.random(0, playingAreaHeight)
    target.point4Y = love.math.random(0, playingAreaHeight)
    target.point5Y = love.math.random(playingAreaHeight/2, playingAreaHeight)
    
    table.insert(allTargets, target)
  end 
  end


function getBoundingBoxWappen(v)
    local v_left = v.targetX
    local v_right = v.targetX + v.image:getWidth()
    local v_width = v.image:getWidth()
    local v_top = v.targetY
    local v_bottom = v.targetY + v.image:getHeight()
    local v_height = v.image:getHeight()
    return v_left, v_top, v_width, v_height 
end

local function update(dt)
   
    
  
  for i,v in ipairs(allTargets) do
    
    
      --Die Bewegung der Objekte von Rechts nach Links
        if v.targetX > (playingAreaWidth/2) and v.targetY < 1 then
        v.targetX = v.targetX - v.speed * dt
        end
      
      --Die Objekte erreichen den Mittelpunkt des Windows
        if v.targetX <= playingAreaWidth/2 then
        v.targetY = v.targetY + v.speed * dt
      end
      
      --Erzeugen des zweiten Objektes
      if v.targetX < playingAreaWidth - 250 then
        if #allTargets<2 then
        createTarget()
      end
    end
    
    --Erzeugen des dritten Objektes
    if v.targetY > v.point3Y then
      if #allTargets<3 then
        createTarget()
      end
    end
    
    --Erzeugen des vierten Objektes
    if v.targetY > v.point2Y then
      if #allTargets<4 then
        createTarget()
      end
      end
      
      
      
        if v.targetY > playingAreaHeight then
            v.targetY = 0
            v.targetX = playingAreaWidth
            
          end
    end
end

    


local function draw()
   
  
  for i,v in ipairs(allTargets) do
    love.graphics.draw(v.image, v.targetX, v.targetY, 0, 1, 1)
    love.graphics.circle("fill",v.targetX, v.targetY, 4)
    love.graphics.circle("fill",v.targetX + v.image:getWidth(), v.targetY + v.image:getHeight(), 4)
    b_left, b_top, b_width, b_height = getBoundingBoxWappen(v)
    love.graphics.rectangle("line", b_left, b_top, b_width, b_height)
 end
 
 
 if #allTargets < 1 then
   createTarget()
   
  end
end

wappen.allTargets = allTargets
wappen.load = load
wappen.update = update
wappen.draw = draw
wappen.getBoundingBox = getBoundingBoxWappen

return wappen
