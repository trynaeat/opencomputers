local component = require("component")
local event = require("event")
local gpu = component.gpu
local ae2 = component.me_interface

local x, y = gpu.getViewport()
local x_middle = x / 2
local y_middle = y / 2

local function draw_screen()
	local power = ae2.getAvgPowerUsage()
	local text = "Avg Usage: " .. power .. " RF/T"
	gpu.setBackground(0x000000)
	gpu.setForeground(0xFFFFFF)
	gpu.fill(1, 1, x, y, " ")
	gpu.set(x_middle - #text, y_middle, text)
end

local timer = event.timer(0.1, draw_screen, math.huge)
