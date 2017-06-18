local coundownAndRememberWappen = {}

local modulState = false

local function load()

  playingAreaWidth = love.graphics.getWidth()
  playingAreaHeight = love.graphics.getHeight()

  font = love.graphics.newFont("fonts/carbon.ttf", 70)
  love.graphics.setFont(font)


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


  imageX = playingAreaWidth/5
  imageY = playingAreaHeight/#images
  remaining_time = 10

  modulState = false
end


local function update(dt)

  remaining_time = remaining_time -dt

  if remaining_time <= 0 then
    modulState = true
  end

end


local function draw()
  for i,v in ipairs(images) do

    if i == 1 then
      love.graphics.draw(v, playingAreaWidth/2, 25, 0, 1, 1)
    end

    if i>1 and i <6 then
      love.graphics.draw(v, imageX *(i-1), playingAreaHeight/4, 0, 1, 1)

    end
    if i>5 and i <10 then
      love.graphics.draw(v, imageX *(i-5), playingAreaHeight/2, 0, 1, 1)

    end

    if i>9 and i <14 then
      love.graphics.draw(v, imageX *(i-9), playingAreaHeight/1.3, 0, 1, 1)

    end

  end

  love.graphics.print(math.floor(remaining_time), 40, playingAreaHeight/2)
end

local function isDone()
  return modulState
end

coundownAndRememberWappen.load= load
coundownAndRememberWappen.update = update
coundownAndRememberWappen.draw = draw
coundownAndRememberWappen.done = isDone

return coundownAndRememberWappen
