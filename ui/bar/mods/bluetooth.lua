local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local dpi       = require("beautiful").xresources.apply_dpi
local helpers   = require("helpers")

local bluetooth_applet   = require("ui.bar.mods.bl")

local blue      = wibox.widget {
  font = beautiful.icon .. " 16",
  markup = helpers.colorizeText("󰂯", beautiful.fg),
  widget = wibox.widget.textbox,
  valign = "center",
  align = "center",
  buttons = {
    awful.button({}, 3, function()
      awesome.emit_signal('toggle::bl_applet')
    end)
  },
}

awesome.connect_signal("signal::bluetooth", function(value)
  if value then
    blue.markup = helpers.colorizeText("󰂯", beautiful.blue)
  else
    blue.markup = helpers.colorizeText("󰂲", beautiful.fg2 .. "99")
  end
end)

return blue
