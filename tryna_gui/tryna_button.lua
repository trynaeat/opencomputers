local Drawable = require("tryna_drawable")

local function splitStringLines(s, width)
	local result = {}
	for i=1,string.len(s),width do
		table.insert(result, string.sub(s, i, math.min(i + width, string.len(s))))
	end
	return result
end

--******************
-- Button
-- *****************
local Button = {}
function Button:new(x, y, text, buttonColor, textColor, activeButtonColor, activeTextColor, callback)
	o = Drawable:new()
	setmetatable(o, self)
	self.__index = self
	o.x = x
	o.y = y
	o.text = text
	o.buttonColor = buttonColor
	o.textColor = textColor
	o.activeButtonColor = activeButtonColor
	o.activeTextColor = activeTextColor
	o.width = string.len(o.text)
	o.textSplit = splitStringLines(o.text, o.width) -- Split it up into lines of width "width"
	o.height = #o.textSplit
	o.callback = callback
	o.active = false
	return o
end

-- Actual draw implementation
function Button:draw(gpu)
	if self.activeFrames == 0 then
		self.active = false
	end
	local oldBGColor
	local oldFGColor
	if not self.active then
		oldBGColor = gpu.setBackground(self.buttonColor)
		oldFGColor = gpu.setForeground(self.textColor)
	else
		oldBGColor = gpu.setBackground(self.activeButtonColor)
		oldFGColor = gpu.setForeground(self.activeTextColor)
	end
	gpu.fill(self.x, self.y, self.width, self.height, " ")
	local yIncr = 0
	for key, s in pairs(self.textSplit) do
		gpu.set(self.x, self.y + yIncr, s)
		yIncr = yIncr + 1
	end
	gpu.setBackground(oldBGColor)
	gpu.setForeground(oldFGColor)
end

return Button
