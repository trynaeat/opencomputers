local Drawable = {}
--**************
-- Drawable
-- *************
function Drawable:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function splitStringLines(s, width)
	local result = {}
	for i=1,string.len(s),width do
		table.insert(result, string.sub(s, i, math.min(i + width, string.len(s))))
	end
	return result
end

return Drawable
