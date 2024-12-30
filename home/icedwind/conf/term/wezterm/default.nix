{ pkgs, colors, inputs, ... }:

with colors; {
  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${pkgs.system}.default;
    colorSchemes = import ./colors.nix {
      inherit colors;
    };
    extraConfig = ''
      local wez = require('wezterm')
      return {
        default_prog     = { 'fish' },
        cell_width = 0.85,

        front_end        = "OpenGL",
        enable_wayland   = true,

        --enable_wayland = false,
        --front_end = "WebGpu",
        --webgpu_power_preference = "HighPerformance",

        scrollback_lines = 1024,
        font         = wez.font_with_fallback({
          "Iosevka Nerd Font",
          "Material Design Icons",
        }),
        dpi = 96.0,
        bold_brightens_ansi_colors = true,
        font_rules    = {
          {
            italic = true,
            font   = wez.font("Iosevka Nerd Font", { italic = true })
          }
        },
        font_size         = 14.0,
        line_height       = 1.15,
        harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
        color_scheme   = "followSystem",
        window_padding = {
          left = "24pt", right = "24pt",
          bottom = "24pt", top = "24pt"
        },
        default_cursor_style = "SteadyUnderline",
        enable_scroll_bar    = false,
        warn_about_missing_glyphs = false,
        enable_tab_bar               = true,
        use_fancy_tab_bar            = false,
        hide_tab_bar_if_only_one_tab = true,
        show_tab_index_in_tab_bar    = false,
        window_close_confirmation = "NeverPrompt",
        inactive_pane_hsb         = {
          saturation = 1.0, brightness = 0.8
        },
        check_for_updates = false,
      }
    '';
  };
}
