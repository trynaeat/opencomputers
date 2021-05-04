local Drawable = require("tryna_drawable")

-- ***********************
-- Labels
-- **********************
local Label = {}
function Label:new(x, y, text, labelColor, textColor, padding)
	o = Drawable:new()
	setmetatable(o, self)
	self.__index = self
	o.x = x
	o.y = y
	o.text = text
	o.width = string.len(o.text)
	o.labelColor = labelColor
	o.textColor = textColor
	o.padding = padding or 0
	return o
end
function Label:draw(gpu)
	oldBGColor = gpu.setBackground(self.labelColor)
	oldFGColor = gpu.setForeground(self.textColor)
	gpu.fill(self.x, self.y, self.width + self.padding, 1, " ")
	gpu.set(self.x + (self.padding / 2), self.y, self.text)
	gpu.setBackground(oldBGColor)
	gpu.setForeground(oldFGColor)
end

return Label
