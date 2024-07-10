require("yatline"):setup({
	section_separator = { open = "", close = "" },
	part_separator = { open = "", close = "" },

	style_a = {
		fg = "#131313",
		bg_mode = {
			normal = "#db97bb",
			select = "#db97bb",
			un_set = "#db97bb",
		},
	},
	style_b = { bg = "#db97bb", fg = "#131313" },

	style_c = { bg = "#121111", fg = "#937094" },
	tab_width = 20,

	selected = { icon = "󰻭", fg = "#db97bb" },
	copied = { icon = "", fg = "#db97bb" },
	cut = { icon = "", fg = "#db97bb" },

	total = { icon = "󰮍", fg = "#db97bb" },
	succ = { icon = "", fg = "#db97bb" },
	fail = { icon = "", fg = "#db97bb" },
	found = { icon = "󰮕", fg = "#db97bb" },
	processed = { icon = "󰐍", fg = "#db97bb" },

	header_line = {
		left = {
			section_a = {
				{ type = "line", custom = false, name = "tabs", params = { "left" } },
			},
			section_b = {},
			section_c = {},
		},
		right = {
			section_a = {},
			section_b = {
				{ type = "coloreds", custom = true, name = { { " 󰇥 ", "#131313" } } },
			},
			section_c = {
				{ type = "coloreds", custom = false, name = "count" },
			},
		},
	},

	status_line = {},
})

require("relative-motions"):setup({ show_numbers = "absolute", show_motion = true })
require("starship"):setup()
-- Full Border

function Manager:render(area)
	local chunks = self:layout(area)

	local bar = function(c, x, y)
		x, y = math.max(0, x), math.max(0, y)
		return ui.Bar(ui.Rect({ x = x, y = y, w = ya.clamp(0, area.w - x, 1), h = math.min(1, area.h) }), ui.Bar.TOP)
			:symbol(c)
	end

	return ya.flat({
		-- Borders
		ui.Border(area, ui.Border.ALL):type(ui.Border.ROUNDED),
		ui.Bar(chunks[1], ui.Bar.RIGHT),
		ui.Bar(chunks[3], ui.Bar.LEFT),

		bar("┬", chunks[1].right - 1, chunks[1].y),
		bar("┴", chunks[1].right - 1, chunks[1].bottom - 1),
		bar("┬", chunks[2].right, chunks[2].y),
		bar("┴", chunks[2].right, chunks[1].bottom - 1),

		-- Parent
		Parent:render(chunks[1]:padding(ui.Padding.xy(1))),
		-- Current
		Current:render(chunks[2]:padding(ui.Padding.y(1))),
		-- Preview
		Preview:render(chunks[3]:padding(ui.Padding.xy(1))),
	})
end

function Status:name()
	local h = cx.active.current.hovered
	if h == nil then
		return ui.Span("")
	end

	local linked = ""
	if h.link_to ~= nil then
		linked = " -> " .. tostring(h.link_to)
	end

	return ui.Span(" " .. h.name .. linked)
end
