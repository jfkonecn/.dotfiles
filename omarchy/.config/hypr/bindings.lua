-- i3-style navigation overrides. Omarchy's other default bindings remain enabled.

o.bind("SUPER + D", "Apps menu", "omarchy-menu toggle apps")
o.bind("SUPER + SHIFT + Q", "Close window", hl.dsp.window.close())

-- SUPER+J/K/L replace Omarchy's split toggle, keybindings menu, and layout toggle.
hl.unbind("SUPER + J")
hl.unbind("SUPER + K")
hl.unbind("SUPER + L")
o.bind("SUPER + J", "Focus left", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + K", "Focus below", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + L", "Focus above", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + SEMICOLON", "Focus right", hl.dsp.focus({ direction = "r" }))

o.bind("SUPER + SHIFT + J", "Move window left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + SHIFT + K", "Move window down", hl.dsp.window.swap({ direction = "d" }))
o.bind("SUPER + SHIFT + L", "Move window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + SEMICOLON", "Move window right", hl.dsp.window.swap({ direction = "r" }))

o.bind("SUPER + E", "Toggle window split", hl.dsp.layout("togglesplit"))
