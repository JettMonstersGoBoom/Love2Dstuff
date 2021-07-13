FixedCanvas = require("FixedCanvas")

local _mx=0
local _my=0

function love.update(dt)
end

function love.keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key, scancode)
end

function love.mousemoved( x, y, dx, dy, istouch )
	_mx = x 
	_my = y
end

function love.mousepressed(x,y,btn)
end

function love.draw()
	--	everything is draw into the canvas
	love.graphics.print("Hello ",_mx,_my,0,1,1)
	love.graphics.line(_mx,_my,0,0)
end

function love.load(arg)
	print("first")
	FixedCanvas:create(240,135,2)
end


