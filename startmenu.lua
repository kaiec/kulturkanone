local startmenu = {}

local modulState = false

local function load()
  
end

local function update(dt)
  if love.keyboard.isDown("space") then
    modulState = true
  end

end

local function draw()
end


function isDone()
  return modulState
end

startmenu.load= load
startmenu.update = update
startmenu.draw = draw
startmenu.done = isDone

return startmenu