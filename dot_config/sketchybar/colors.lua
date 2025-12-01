local dark_colors = {
	black = 0xff51576d,
	white = 0xffcad3f5,
	red = 0xffe78284,
	green = 0xffa6d189,
	blue = 0xff99d1db,
	yellow = 0xffe5c890,
	orange = 0xffef9f76,
	magenta = 0xfff4b8e4,
	grey = 0xff737994,
	lavender = 0xffbabbf1,
	rosewater = 0xfff2d5cf,
	text = 0xffc6d0f5,
	overlay0 = 0xff737994,
	transparent = 0x00000000,

	bar = {
		bg = 0x00000000,
		border = 0xff414559,
	},
	popup = {
		bg = 0xc0313244,
		border = 0xff737994,
	},
	bg1 = 0xff303446,
	bg2 = 0xff737994,
}

local light_colors = {
	black = 0xff5c5f77,
	white = 0xff4c4f69,
	red = 0xffd20f39,
	green = 0xff40a02b,
	blue = 0xff1e66f5,
	yellow = 0xffdf8e1d,
	orange = 0xfffe640b,
	magenta = 0xffea76cb,
	grey = 0xff9ca0b0,
	lavender = 0xff7287fd,
	rosewater = 0xffdc8a78,
	text = 0xff4c4f69,
	overlay0 = 0xff9ca0b0,
	transparent = 0x00000000,

	bar = {
		bg = 0x00000000,
		border = 0xffdce0e8,
	},
	popup = {
		bg = 0xc0dce0e8,
		border = 0xff9ca0b0,
	},
	bg1 = 0xffeff1f5,
	bg2 = 0xff9ca0b0,
}

local current_theme = "dark"
local colors = dark_colors

local function with_alpha(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

return setmetatable({
	dark = dark_colors,
	light = light_colors,
	with_alpha = with_alpha,
	get_current_theme = function()
		return current_theme
	end,
}, {
	__index = function(_, key)
		return colors[key]
	end,
})
