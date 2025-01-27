local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local wibox = require("wibox")
local gears = require("gears")

local naughty = require("naughty")

--local bluetooth_daemon = require("services.bluetooth")

awful.screen.connect_for_each_screen(function(s)
  local devices = wibox.widget {
    spacing = 15,
    layout = wibox.layout.fixed.vertical
  }

  local create_device = function(adress, name)
    local connected = false

    local isconnected = wibox.widget {
        text = "Connected",
        widget = wibox.widget.textbox,
        font = beautiful.sans.. "12",
        visible = false,
    }

    local connect = function()
      if not connected then
        awful.spawn.with_shell("bluetoothctl connect ".. adress)
        isconnected.visible = true
        connected = true
      end
    end

    local disconnect = function()
      if connected then
        awful.spawn.with_shell("bluetoothctl disconnect ".. adress)
        isconnected.visible = false
        connected = false
      end
    end

    local device_icon = wibox.widget {
      {
        font = beautiful.icon .. " 26",
        markup = helpers.colorizeText("󰋋", beautiful.blue),
        widget = wibox.widget.textbox,
        --valign = "center",
        --align = "center",
      },
      widget = wibox.container.margin,
      margins = dpi(15),
    }

    local device_name = wibox.widget {
      device_icon,
      {
        {
          {
            text = name,
            widget = wibox.widget.textbox,
            font = beautiful.sans.. "14",
          },
          widget = wibox.container.place,
          valign = "center"
        },
        isconnected,
        layout = wibox.layout.fixed.vertical,
        spacing = 5,
      },
      layout = wibox.layout.fixed.horizontal
    }

    local connect_button = wibox.widget {
      {
        {
          {
            text = "Connect",
            widget = wibox.widget.textbox,
            font = beautiful.sans.. "14",
          },
          widget = wibox.container.margin,
          margins = dpi(15),
        },
        bg = beautiful.bg3,
        widget = wibox.container.background,
        shape = helpers.rrect(12),
        buttons = {
          awful.button({}, 1, function()
            if connected then
              disconnect()
            else
              connect()
            end
          end)
        },
      },
      widget = wibox.container.place,
      valign = "center",
    }

    local device = wibox.widget {
      {
        {
          {
            {
              device_name,
              widget = wibox.container.place,
              valign = "center"
            },
            nil,
            connect_button,
            layout = wibox.layout.align.horizontal
          },
          margins = dpi(15),
          widget = wibox.container.margin,
        },
        bg = beautiful.mbg,
        widget = wibox.container.background,
        
        -- random large number so the device widget will take all width it can
        forced_width = dpi(4000),

        shape = helpers.rrect(12),
      },
      --margins = dpi(15),
      --margin_bottom = dpi(7.5),
      widget = wibox.container.margin,
    }
    
    devices:add(device)
  end

  awful.spawn.easy_async_with_shell(
    "bluetoothctl devices Paired | sed 's/Device //g'", function(stdout)
      for line in string.gmatch(stdout, "(.-)\n") do 
        local bl_adress = string.match(line, "%S+")
        local device_name = string.sub(line, string.len(bl_adress) + 1) 
        if bl_adress and device_name then 
          create_device(bl_adress, device_name) 
        end
      end
  end)

  local bl_applet = wibox({
    shape = helpers.rrect(12),
    screen = s,
    width = 500,
    height = 1080 - 40 - 60,
    bg = beautiful.bg,
    ontop = true,
    visible = false,
  })

  bl_applet:setup {
    {
      {
        {
          {
            {
              markup = helpers.colorizeText("Bluetooth", beautiful.fg),
              halign = 'center',
              font   = beautiful.sans .. " 14",
              widget = wibox.widget.textbox
            },
            nil,
            nil,
            widget = wibox.layout.align.horizontal,
          },
          widget = wibox.container.margin,
          margins = 20,
        },
        widget = wibox.container.background,
        bg = beautiful.mbg
      },
      {
        devices,
        margins = 15,
        widget = wibox.container.margin
      },
      layout = wibox.layout.fixed.vertical,
    },
    widget = wibox.container.margin,
    margins = 0,
  }
  awful.placement.top_right(bl_applet, { honor_workarea = true, margins = 20 })
  awesome.connect_signal("toggle::bl_applet", function()
    bl_applet.visible = not bl_applet.visible
  end)
end)

