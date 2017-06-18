local startmenu = {}

local modulState = false
local background
local font, font2

local function load()
  font = love.graphics.newFont("fonts/carbon.ttf", 70)
  font2 = love.graphics.newFont("fonts/carbon.ttf", 30)
  background = love.graphics.newImage("background/hintergrund-schlacht.jpg")

    
end

local function update(dt)
  if love.keyboard.isDown("space") then
    modulState = true
  end

end

local function draw()
  love.graphics.setColor(200, 200, 200)
  love.graphics.draw(background, 0, 0, 0, 
  love.graphics.getWidth() / background:getWidth() , 
  love.graphics.getHeight() / background:getHeight())
  love.graphics.setColor(255, 255, 255)
  love.graphics.setFont(font)
  
  love.graphics.print("Kulturkanone", 100, 100)
  love.graphics.setFont(font2)
  love.graphics.print("Merkt Euch alle Wappen von Stuttgart", 100, 200)
  love.graphics.print("und schießt sie ab!", 100, 250)
  love.graphics.print("Aber Vorsicht: Karlsruhe hat da", 100, 300)
  love.graphics.print("nichts verloren!", 100, 350)

  love.graphics.print("Spieler 1: A, D, F", 100, 450)
  love.graphics.print("Spieler 2: links, rechts, M", 100, 500)
  love.graphics.print("Start mit der Leertaste.", 100, 600)
  
  

end


function isDone()
  return modulState
end

startmenu.load= load
startmenu.update = update
startmenu.draw = draw
startmenu.done = isDone

return startmenu