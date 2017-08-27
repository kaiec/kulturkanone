
local wappen = {}
local allTargets = {}
local laserItem = {}
  
local function load()
  
  initial = 0
  playingAreaWidth = love.graphics.getWidth()
  playingAreaHeight = love.graphics.getHeight()
  newTargetTimer = 3
  
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
  
  
  wrongs = {}
  table.insert(wrongs, love.graphics.newImage("crest/wrong/146px-Wappen_Oberreut.png"))
  table.insert(wrongs, love.graphics.newImage("crest/wrong/147px-Wappen_Nordstadt.svg.png"))
  table.insert(wrongs, love.graphics.newImage("crest/wrong/148px-Wappen_Karlsruher_Oststadt.png"))
  table.insert(wrongs, love.graphics.newImage("crest/wrong/148px-Wappen_Karlsruher_Suedweststadt.png"))
  table.insert(wrongs, love.graphics.newImage("crest/wrong/148px-Wappen_Karlsruher_Weststadt.png"))
  table.insert(wrongs, love.graphics.newImage("crest/wrong/148px-Wappen_Weiherfeld.png"))
  table.insert(wrongs, love.graphics.newImage("crest/wrong/150px-Wappen_Waldstadt.png"))
  table.insert(wrongs, love.graphics.newImage("crest/wrong/154px-Wappen_Karlsruher_Suedtstadt.png"))
  table.insert(wrongs, love.graphics.newImage("crest/wrong/148px-Wappen_Karlsruher_Nordweststadt.png"))
  
 
  
  
  changeSprite = love.graphics.newImage("items/wechsel.png")
  
  
  laserItem = {
    typ = "item",
    name = "laser",
    sprite = love.graphics.newImage("items/blitz.png"),
    speed = 1000,
    weapon = "laser",
    coolDownTime = 10,
    shootSprite = love.graphics.newImage("cannon/laser.png"),
    timer = 5
  }
  
  changeItem = {
    typ = "item",
    name = "change",
    timer = 5,
    sprite = love.graphics.newImage("items/wechsel.png")
  }
  
  items = {}
  table.insert(items, laserItem)
  table.insert(items, changeItem)
    
    

  
  
  
  

  
  function createTarget()
   target = {} 
    target.targetHeight = 75
    target.targetWidth = 75
    target.targetY = love.math.random(0, (playingAreaHeight/2))
    
    randomNumber = love.math.random(1,100)
    target.timer = love.math.random(2,4)
    
    
    target.targetX = love.math.random(0, (playingAreaWidth)-(target.targetWidth))
    
    if randomNumber <= 40 then
      target.image = wrongs[love.math.random(1, #wrongs)]
      target.correct = "false"
    elseif randomNumber > 40  and randomNumber <= 80 then
      target.image = images[love.math.random(1, #images)]
      target.correct = "true"
    elseif randomNumber  > 80 then
      randomItem = love.math.random(1, #items)
      target.image = items[randomItem].sprite
      target.correct = items[randomItem].name
    end
    
    
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
  --Der TargetTimer prüft alle 1-2 Sek. ob Wappen neu erzeugt werden können.
   newTargetTimer = newTargetTimer -dt
   if newTargetTimer <= 0 then
     if #allTargets < 4 then
      createTarget()
     end
    newTargetTimer = love.math.random(1,2)
  end
  
  --Zu Beginn werden 4 Wappen/Items erzeugt
  if initial == 0 then
    i = 0
    while i < 4 do
      createTarget()
      i = i +1
    end
    initial = 1
  end  
  
  --Jedes Wappen/Item hat einen Timer, der herunterzählt und das Objekt aus dem Array entfernt, wenn der Timer bei 0 ist.
  for i,v in ipairs(allTargets) do
    v.timer = v.timer -dt
    
      --Die Bewegung der Objekte von Rechts nach Links
        --if v.targetX > (playingAreaWidth/2) and v.targetY < 1 then
        --v.targetX = v.targetX - v.speed * dt
        --end
        if v.timer < 0 then
            table.remove(allTargets, i)
          end
    end
end

    


local function draw()
   
  
  for i,v in ipairs(allTargets) do
    love.graphics.draw(v.image, v.targetX, v.targetY, 0, 1, 1)
    -- love.graphics.circle("fill",v.targetX, v.targetY, 4)
    -- love.graphics.circle("fill",v.targetX + v.image:getWidth(), v.targetY + v.image:getHeight(), 4)
    -- b_left, b_top, b_width, b_height = getBoundingBoxWappen(v)
    -- love.graphics.rectangle("line", b_left, b_top, b_width, b_height)
 end
 
 
 
 if #allTargets < 1 then
   createTarget()
   
  end
end

wappen.allTargets = allTargets
wappen.laserItem = laserItem
wappen.load = load
wappen.update = update
wappen.draw = draw
wappen.getBoundingBox = getBoundingBoxWappen

return wappen
