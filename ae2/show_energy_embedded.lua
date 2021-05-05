local gpu = component.proxy(component.list("gpu")())
local ae2 = component.proxy(component.list("me_interface")())

local x_res, y_res = gpu.getResolution()
gpu.setResolution(x_res / 2, y_res / 4)

local x, y = gpu.getViewport()
local x_middle = x / 2
local y_middle = y / 2

computer.beep(500, 0.5)

local function draw_screen()
	local power = ae2.getAvgPowerUsage() * 2
	local text = string.format("Avg Usage: %.1f RF/T", power)
	gpu.setBackground(0x000000)
	gpu.setForeground(0xFFFFFF)
	gpu.fill(1, 1, x, y, " ")
	gpu.set(x_middle - #text / 2, y_middle, text)
end

while true do
	draw_screen()
	computer.pullSignal(0.2)
end
