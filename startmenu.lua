Menu = require 'menu'

fullscreen = false

function love.load()
	testmenu = Menu.new()
	testmenu:addItem{
		name = 'Start Game',
		action = function()
			-- do something
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