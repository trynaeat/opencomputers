local Drawable = require("tryna_drawable")

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

return Button
