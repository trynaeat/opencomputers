local event = require("event")
local Drawable = require("tryna_drawable")
local Button = require("tryna_button")
local Label = require("tryna_label")
local BarGraph = require("tryna_bargraph")
local GUI = {}
local drawables = {}

--*******************
-- Static methods
-- ******************
-- Clear all attached screens
function GUI.clear(gpu)
	local screenX, screenY = gpu.getResolution()
	gpu.fill(1, 1, screenX, screenY, " ")
end
function GUI.addDrawable(d)
	table.insert(drawables, d)
end
function GUI.drawScreen(gpu)
	for key, drawable in pairs(drawables) do
		drawable:draw(gpu)
		if drawable.activeFrames and drawable.activeFrames > 0 then
			drawable.activeFrames = drawable.activeFrames - 1
		end
	end
end
-- Listen for clicks, send to any clickables that lie in the actual spot
function GUI.listenForClicks()
	event.listen("touch", clickHandler)
end
function clickHandler(event, screenAddress, x, y, button, player)
	for key, val in pairs(drawables) do
		if x >= val.x and x < val.x + val.width and y >= val.y and y < val.y + val.height and val.callback then
			val.active = true
			val.activeFrames = 12
			val.callback()
		end
	end
end
function GUI.reset()
	drawables = {}
end

-- Exports
GUI.Drawable = Drawable
GUI.Button = Button
GUI.Label = Label
GUI.BarGraph = BarGraph
return GUI
