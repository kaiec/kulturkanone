Menu = require 'menu'

fullscreen = false

local startmenu = {}

modulState = false

function love.load()
	testmenu = Menu.new()
	testmenu:addItem{
		name = 'Start Game',
		action = function()
			modulState = true
		end
	}


	testmenu:addItem{
		name = 'Ende',
		action = function()
			love.event.push('quit')
		end
	}
end

function love.update(dt)
	testmenu:update(dt)
end

function love.draw()
	testmenu:draw(10, 10)
end

function love.keypressed(key)
	testmenu:keypressed(key)
end

function isDone()
  return modulState
end

startmenu.load= load
startmenu.update = update
startmenu.draw = draw
startmenu.done = isDone