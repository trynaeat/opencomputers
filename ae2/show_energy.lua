local component = require("component")
local event = require("event")
local term = require("term")
local gpu = component.gpu
local ae2 = component.me_interface

local blink = term.getCursorBlink()
term.setCursorBlink(false)
local x, y = gpu.getViewport()
local x_middle = x / 2
local y_middle = y / 2

local function draw_screen()
	local power = ae2.getAvgPowerUsage()
	local text = string.format("Avg Usage: %.1f RF/T", power)
	gpu.setBackground(0x000000)
	gpu.setForeground(0xFFFFFF)
	gpu.fill(1, 1, x, y, " ")
	gpu.set(x_middle - #text / 2, y_middle, text)
end

local timer = event.timer(0.2, draw_screen, math.huge)


local function on_keydown()
	event.cancel(timer)
	term.setCursorBlink(blink)
end
local key_listen = event.listen("key_down", on_keydown)
