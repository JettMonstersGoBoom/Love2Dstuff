#### Fixedres.lua

create and handle a canvas of fixed resolution. 

handles scaling and fixed up mouse coordinates. 

also handles alt + enter to toggle fullscreen.

see main.lua 

```
FixedCanvas = require("FixedCanvas")

-- local "fixed" mouse coordinates
local _mx=0
local _my=0

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

-- specify our canvas as 240x135 initial scaled by 2 
function love.load(arg)
	print("first")
	FixedCanvas:create(240,135,2)
end
```
