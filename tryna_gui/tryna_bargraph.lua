local Drawable = require("tryna_drawable")

-- *********************
-- Bar Graphs (Horizontal)
-- *********************
local BarGraph = {}
function BarGraph:new(x, y, height, width, axisColor, barColor, data, showPercent)
	o = Drawable:new()
	setmetatable(o, self)
	self.__index = self
	o.x = x
	o.y = y
	o.height = height
	o.width = width
	o.axisColor = axisColor
	o.barColor = barColor
	o.data = data
	o.showPercent = showPercent
	return o
end
function BarGraph:draw(gpu)
	oldBGColor = gpu.setBackground(self.axisColor)
	oldFGColor = gpu.setForeground(self.axisColor)
	gpu.fill(self.x, self.y, 2, self.height, " ")
	gpu.fill(self.x, self.y + self.height, self.width, 1, " ")
	local data = self.data
	local barHeight = self.height - 4
	local barWidth = (data.value / data.max) * (self.width - 1)
	gpu.setBackground(self.barColor)
	gpu.fill(self.x + 2, self.y + 2, barWidth, barHeight, " ")
	gpu.setBackground(oldBGColor)
	gpu.set(self.x, self.y + self.height + 2, "0")
	gpu.set(self.x + self.width, self.y + self.height + 2, string.format("%.2f", self.data.max))
	if self.showPercent then
		gpu.set(self.x + barWidth + 4, self.y + barHeight / 2 + 2, string.format("%3.0f %%", (data.value / data.max) * 100))
	end
	gpu.setForeground(oldFGColor)
end

return BarGraph
