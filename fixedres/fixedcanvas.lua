
local FixedCanvas = {}

function FixedCanvas.draw(arg)
	FixedCanvas.display_width, FixedCanvas.display_height = FixedCanvas._getDimensions( )

	local scale_w, scale_h = FixedCanvas.display_width / FixedCanvas.width, FixedCanvas.display_height / FixedCanvas.height
	FixedCanvas.scale = math.floor(math.min(scale_w, scale_h))
	FixedCanvas.render_width = FixedCanvas.width * FixedCanvas.scale
	FixedCanvas.render_height = FixedCanvas.height * FixedCanvas.scale
	FixedCanvas.render_xpos = (FixedCanvas.display_width - FixedCanvas.render_width) / 2
	FixedCanvas.render_ypos = (FixedCanvas.display_height - 	FixedCanvas.render_height) / 2

	love.graphics.clear(0.0, 0.0, 0.0)
	love.graphics.setColor(1,1,1)

	love.graphics.setCanvas(FixedCanvas.canvas)	
	love.graphics.clear()

	if FixedCanvas._draw then FixedCanvas._draw() end
	
	love.graphics.setCanvas()

  love.graphics.draw(FixedCanvas.canvas,FixedCanvas.render_xpos,FixedCanvas.render_ypos,0,FixedCanvas.scale,FixedCanvas.scale)

	imageData = FixedCanvas.canvas:newImageData()
	data = imageData:encode("png")
--	fs.write("output/canvas.png",data)
end

function FixedCanvas.getWidth()
	return FixedCanvas.width
end

function FixedCanvas.getHeight()
	return FixedCanvas.height
end

function FixedCanvas.getDimensions()
	return FixedCanvas.width,FixedCanvas.height
end

function FixedCanvas.getCanvas()
	return FixedCanvas.canvas
end

function FixedCanvas.create(self,width,height,scale,fullscreen)
	self._mousemoved		= love.mousemoved 
	love.mousemoved    	= self.mousemoved
	self._mousepressed	= love.mousepressed
	love.mousepressed		= FixedCanvas.mousepressed
	self._mousereleased	= love.mousereleased
	love.mousereleased 	= FixedCanvas.mousereleased
	self._keypressed		= love.keypressed 
	love.keypressed 		= FixedCanvas.keypressed
	self._draw        	= love.draw
	love.draw          	= FixedCanvas.draw
	self._getDimensions = love.graphics.getDimensions
	love.graphics.getWidth = FixedCanvas.getWidth
	love.graphics.getHeight = FixedCanvas.getHeight
	love.graphics.getDimensions = FixedCanvas.getDimensions
	love.graphics.getCanvas = FixedCanvas.getCanvas
	self.fullscreen = fullscreen or false
	self.width = width or 320
	self.height = height or 200
	self.scale = scale or 3
	self.render_xpos = 0
	self.render_ypos = 0
	love.window.setMode(self.width*self.scale, self.height*self.scale, {resizable=true, vsync=true, fullscreen=false})
	love.graphics.setDefaultFilter("nearest","nearest")
	love.graphics.setLineStyle( "rough" )
	love.window.setTitle("")
	self.canvas = love.graphics.newCanvas(self.width, self.height)
	love.window.setFullscreen(self.fullscreen, "desktop")
end

function FixedCanvas.keypressed(key, scancode, isrepeat)
	if (key=="return") then 
		if love.keyboard.isDown("ralt") or love.keyboard.isDown("lalt") then 
			FixedCanvas.fullscreen = not FixedCanvas.fullscreen
			love.window.setFullscreen(FixedCanvas.fullscreen, "desktop")
		end
	end
	if FixedCanvas._keypressed then FixedCanvas._keypressed(key,scancode,isrepeat) end
end
function FixedCanvas.mousemoved(x, y, dx, dy, istouch )
	x = (x - FixedCanvas.render_xpos) / FixedCanvas.scale
	y = (y - FixedCanvas.render_ypos) / FixedCanvas.scale
	if FixedCanvas._mousemoved then FixedCanvas._mousemoved(x,y,btn) end
end

function FixedCanvas.mousepressed(x,y,btn)
	x = (x - FixedCanvas.render_xpos) / FixedCanvas.scale
	y = (y - FixedCanvas.render_ypos) / FixedCanvas.scale
	if FixedCanvas._mousepressed then FixedCanvas._mousepressed(x,y,btn) end
end

function FixedCanvas.mousereleased(x,y,btn)
	x = (x - FixedCanvas.render_xpos) / FixedCanvas.scale
	y = (y - FixedCanvas.render_ypos) / FixedCanvas.scale
	if FixedCanvas._mousereleased then FixedCanvas._mousereleased(x,y,btn) end
end

return FixedCanvas
