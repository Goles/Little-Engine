--
--	Functions for Creating fonts.
--

Text = {}

function Text.getRenderer(in_font_name, in_font_size)
	local renderer = AngelCodeTextRenderer()
	local font = AngelCodeFont()

	font:openFont(filePath(in_font_name), in_font_size))
	renderer:setFont(font)
end