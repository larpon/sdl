// Copyright(C) 2021 Lars Pontoppidan. All rights reserved.
// Use of this source code is governed by an MIT license
// that can be found in the LICENSE file.
module ttf

//
// SDL_ttf.h
//
import sdl

pub const (
	major_version = C.SDL_TTF_MAJOR_VERSION // 2
	minor_version = C.SDL_TTF_MINOR_VERSION // 0
	patchlevel    = C.SDL_TTF_PATCHLEVEL // 14
)

// This macro can be used to fill a version structure with the compile-time
// version of the SDL_ttf library.
pub fn C.SDL_TTF_VERSION(v &sdl.Version)

fn C.TTF_Linked_Version() &C.SDL_version
pub fn linked_version() &sdl.Version {
	return C.TTF_Linked_Version()
}

// ZERO WIDTH NO-BREAKSPACE (Unicode byte order mark)
pub const (
	unicode_bom_native  = C.UNICODE_BOM_NATIVE // 0xFEFF
	unicode_bom_swapped = C.UNICODE_BOM_SWAPPED // 0xFFFE
)

// This function tells the library whether UNICODE text is generally
// byteswapped.  A UNICODE BOM character in a string will override
// this setting for the remainder of that string.
fn C.TTF_ByteSwappedUNICODE(swapped int)
pub fn byte_swapped_unicode(swapped int) {
	C.TTF_ByteSwappedUNICODE(swapped)
}

// The internal structure containing font information
[typedef]
struct C.TTF_Font {
}

pub type Font = C.TTF_Font

// Initialize the TTF engine - returns 0 if successful, -1 on error
fn C.TTF_Init() int
pub fn init() int {
	return C.TTF_Init()
}

/*
Open a font file and create a font of the specified point size.
 * Some .fon fonts will have several sizes embedded in the file, so the
 * point size becomes the index of choosing which size.  If the value
 * is too high, the last indexed size will be the default.*/
fn C.TTF_OpenFont(file &char, ptsize int) &C.TTF_Font
pub fn open_font(file &char, ptsize int) &Font {
	return C.TTF_OpenFont(file, ptsize)
}

fn C.TTF_OpenFontIndex(file &char, ptsize int, index int) &C.TTF_Font
pub fn open_font_index(file &char, ptsize int, index int) &Font {
	return C.TTF_OpenFontIndex(file, ptsize, index)
}

fn C.TTF_OpenFontRW(src &C.SDL_RWops, freesrc int, ptsize int) &C.TTF_Font
pub fn open_font_rw(src &C.SDL_RWops, freesrc int, ptsize int) &Font {
	return C.TTF_OpenFontRW(src, freesrc, ptsize)
}

fn C.TTF_OpenFontIndexRW(src &C.SDL_RWops, freesrc int, ptsize int, index int) &C.TTF_Font
pub fn open_font_index_rw(src &C.SDL_RWops, freesrc int, ptsize int, index int) &Font {
	return C.TTF_OpenFontIndexRW(src, freesrc, ptsize, index)
}

// Set and retrieve the font style
pub const (
	style_normal        = C.TTF_STYLE_NORMAL // 0x00
	style_bold          = C.TTF_STYLE_BOLD // 0x01
	style_italic        = C.TTF_STYLE_ITALIC // 0x02
	style_underline     = C.TTF_STYLE_UNDERLINE // 0x04
	style_strikethrough = C.TTF_STYLE_STRIKETHROUGH // 0x08
)

fn C.TTF_GetFontStyle(font &C.TTF_Font) int
pub fn get_font_style(font &Font) int {
	return C.TTF_GetFontStyle(font)
}

fn C.TTF_SetFontStyle(font &C.TTF_Font, style int)
pub fn set_font_style(font &Font, style int) {
	C.TTF_SetFontStyle(font, style)
}

fn C.TTF_GetFontOutline(font &C.TTF_Font) int
pub fn get_font_outline(font &Font) int {
	return C.TTF_GetFontOutline(font)
}

fn C.TTF_SetFontOutline(font &C.TTF_Font, outline int)
pub fn set_font_outline(font &Font, outline int) {
	C.TTF_SetFontOutline(font, outline)
}

// Set and retrieve FreeType hinter settings
pub const (
	hinting_normal = C.TTF_HINTING_NORMAL // 0
	hinting_light  = C.TTF_HINTING_LIGHT // 1
	hinting_mono   = C.TTF_HINTING_MONO // 2
	hinting_none   = C.TTF_HINTING_NONE // 3
)

fn C.TTF_GetFontHinting(font &C.TTF_Font) int
pub fn get_font_hinting(font &Font) int {
	return C.TTF_GetFontHinting(font)
}

fn C.TTF_SetFontHinting(font &C.TTF_Font, hinting int)
pub fn set_font_hinting(font &Font, hinting int) {
	C.TTF_SetFontHinting(font, hinting)
}

// Get the total height of the font - usually equal to point size
fn C.TTF_FontHeight(font &C.TTF_Font) int
pub fn font_height(font &Font) int {
	return C.TTF_FontHeight(font)
}

// Get the offset from the baseline to the top of the font
// This is a positive value, relative to the baseline.
fn C.TTF_FontAscent(font &C.TTF_Font) int
pub fn font_ascent(font &Font) int {
	return C.TTF_FontAscent(font)
}

// Get the offset from the baseline to the bottom of the font
// This is a negative value, relative to the baseline.
fn C.TTF_FontDescent(font &C.TTF_Font) int
pub fn font_descent(font &Font) int {
	return C.TTF_FontDescent(font)
}

// Get the recommended spacing between lines of text for this font
fn C.TTF_FontLineSkip(font &C.TTF_Font) int
pub fn font_line_skip(font &Font) int {
	return C.TTF_FontLineSkip(font)
}

// Get/Set whether or not kerning is allowed for this font
fn C.TTF_GetFontKerning(font &C.TTF_Font) int
pub fn get_font_kerning(font &Font) int {
	return C.TTF_GetFontKerning(font)
}

fn C.TTF_SetFontKerning(font &C.TTF_Font, allowed int)
pub fn set_font_kerning(font &Font, allowed int) {
	C.TTF_SetFontKerning(font, allowed)
}

// Get the number of faces of the font
fn C.TTF_FontFaces(font &C.TTF_Font) int
pub fn font_faces(font &Font) int {
	return C.TTF_FontFaces(font)
}

// Get the font face attributes, if any
fn C.TTF_FontFaceIsFixedWidth(font &C.TTF_Font) int
pub fn font_face_is_fixed_width(font &Font) int {
	return C.TTF_FontFaceIsFixedWidth(font)
}

fn C.TTF_FontFaceFamilyName(font &C.TTF_Font) &char
pub fn font_face_family_name(font &Font) &char {
	return C.TTF_FontFaceFamilyName(font)
}

fn C.TTF_FontFaceStyleName(font &C.TTF_Font) &char
pub fn font_face_style_name(font &Font) &char {
	return C.TTF_FontFaceStyleName(font)
}

// Check wether a glyph is provided by the font or not
fn C.TTF_GlyphIsProvided(font &C.TTF_Font, ch u16) int
pub fn glyph_is_provided(font &Font, ch u16) int {
	return C.TTF_GlyphIsProvided(font, ch)
}

// Get the metrics (dimensions) of a glyph
// To understand what these metrics mean, here is a useful link:
// http://freetype.sourceforge.net/freetype2/docs/tutorial/step2.html
fn C.TTF_GlyphMetrics(font &C.TTF_Font, ch u16, minx &int, maxx &int, miny &int, maxy &int, advance &int) int
pub fn glyph_metrics(font &Font, ch u16, minx &int, maxx &int, miny &int, maxy &int, advance &int) int {
	return C.TTF_GlyphMetrics(font, ch, minx, maxx, miny, maxy, advance)
}

// Get the dimensions of a rendered string of text
fn C.TTF_SizeText(font &C.TTF_Font, text &char, w &int, h &int) int
pub fn size_text(font &Font, text &char, w &int, h &int) int {
	return C.TTF_SizeText(font, text, w, h)
}

fn C.TTF_SizeUTF8(font &C.TTF_Font, text &char, w &int, h &int) int
pub fn size_utf8(font &Font, text &char, w &int, h &int) int {
	return C.TTF_SizeUTF8(font, text, w, h)
}

fn C.TTF_SizeUNICODE(font &Font, text &u16, w &int, h &int) int
pub fn size_unicode(font &C.TTF_Font, text &u16, w &int, h &int) int {
	return C.TTF_SizeUNICODE(font, text, w, h)
}

// Create an 8-bit palettized surface and render the given text at
// fast quality with the given font and color.  The 0 pixel is the
// colorkey, giving a transparent background, and the 1 pixel is set
// to the text color.
// This function returns the new surface, or NULL if there was an error.
fn C.TTF_RenderText_Solid(font &C.TTF_Font, text &char, fg C.SDL_Color) &C.SDL_Surface
pub fn render_text_solid(font &Font, text string, fg sdl.Color) &sdl.Surface {
	return C.TTF_RenderText_Solid(font, text.str, fg)
}

fn C.TTF_RenderUTF8_Solid(font &C.TTF_Font, text &char, fg C.SDL_Color) &C.SDL_Surface
pub fn render_utf8_solid(font &Font, text string, fg sdl.Color) &sdl.Surface {
	return C.TTF_RenderUTF8_Solid(font, text.str, fg)
}

fn C.TTF_RenderUNICODE_Solid(font &C.TTF_Font, text &u16, fg C.SDL_Color) &C.SDL_Surface
pub fn render_unicode_solid(font &Font, text &u16, fg sdl.Color) &sdl.Surface {
	return C.TTF_RenderUNICODE_Solid(font, text, fg)
}

// Create an 8-bit palettized surface and render the given glyph at
// fast quality with the given font and color.  The 0 pixel is the
// colorkey, giving a transparent background, and the 1 pixel is set
// to the text color.  The glyph is rendered without any padding or
// centering in the X direction, and aligned normally in the Y direction.
// This function returns the new surface, or NULL if there was an error.
fn C.TTF_RenderGlyph_Solid(font &C.TTF_Font, ch u16, fg C.SDL_Color) &C.SDL_Surface
pub fn render_glyph_solid(font &Font, ch u16, fg sdl.Color) &sdl.Surface {
	return C.TTF_RenderGlyph_Solid(font, ch, fg)
}

// Create an 8-bit palettized surface and render the given text at
// high quality with the given font and colors.  The 0 pixel is background,
// while other pixels have varying degrees of the foreground color.
// This function returns the new surface, or NULL if there was an error.
fn C.TTF_RenderText_Shaded(font &C.TTF_Font, text &char, fg C.SDL_Color, bg C.SDL_Color) &C.SDL_Surface
pub fn render_text_shaded(font &C.TTF_Font, text string, fg sdl.Color, bg sdl.Color) &sdl.Surface {
	return C.TTF_RenderText_Shaded(font, text.str, fg, bg)
}

fn C.TTF_RenderUTF8_Shaded(font &C.TTF_Font, text &char, fg C.SDL_Color, bg C.SDL_Color) &C.SDL_Surface
pub fn render_utf8_shaded(font &Font, text string, fg sdl.Color, bg sdl.Color) &sdl.Surface {
	return C.TTF_RenderUTF8_Shaded(font, text.str, fg, bg)
}

fn C.TTF_RenderUNICODE_Shaded(font &C.TTF_Font, text &u16, fg C.SDL_Color, bg C.SDL_Color) &C.SDL_Surface
pub fn render_unicode_shaded(font &Font, text &u16, fg sdl.Color, bg sdl.Color) &sdl.Surface {
	return C.TTF_RenderUNICODE_Shaded(font, text, fg, bg)
}

// Create an 8-bit palettized surface and render the given glyph at
// high quality with the given font and colors.  The 0 pixel is background,
// while other pixels have varying degrees of the foreground color.
// The glyph is rendered without any padding or centering in the X
// direction, and aligned normally in the Y direction.
// This function returns the new surface, or NULL if there was an error.
fn C.TTF_RenderGlyph_Shaded(font &C.TTF_Font, ch u16, fg C.SDL_Color, bg C.SDL_Color) &C.SDL_Surface
pub fn render_glyph_shaded(font &Font, ch u16, fg sdl.Color, bg sdl.Color) &sdl.Surface {
	return C.TTF_RenderGlyph_Shaded(font, ch, fg, bg)
}

// Create a 32-bit ARGB surface and render the given text at high quality,
// using alpha blending to dither the font with the given color.
// This function returns the new surface, or NULL if there was an error.
fn C.TTF_RenderText_Blended(font &C.TTF_Font, text &char, fg C.SDL_Color) &C.SDL_Surface
pub fn render_text_blended(font &Font, text &char, fg sdl.Color) &sdl.Surface {
	return C.TTF_RenderText_Blended(font, text, fg)
}

fn C.TTF_RenderUTF8_Blended(font &C.TTF_Font, text &char, fg C.SDL_Color) &C.SDL_Surface
pub fn render_utf8_blended(font &Font, text &char, fg sdl.Color) &sdl.Surface {
	return C.TTF_RenderUTF8_Blended(font, text, fg)
}

fn C.TTF_RenderUNICODE_Blended(font &C.TTF_Font, text &u16, fg C.SDL_Color) &C.SDL_Surface
pub fn render_unicode_blended(font &Font, text &u16, fg sdl.Color) &sdl.Surface {
	return C.TTF_RenderUNICODE_Blended(font, text, fg)
}

// Create a 32-bit ARGB surface and render the given text at high quality,
// using alpha blending to dither the font with the given color.
// Text is wrapped to multiple lines on line endings and on word boundaries
// if it extends beyond wrapLength in pixels.
// This function returns the new surface, or NULL if there was an error.
fn C.TTF_RenderText_Blended_Wrapped(font &C.TTF_Font, text &char, fg C.SDL_Color, wrap_length u32) &C.SDL_Surface
pub fn render_text_blended_wrapped(font &Font, text &char, fg sdl.Color, wrap_length u32) &sdl.Surface {
	return C.TTF_RenderText_Blended_Wrapped(font, text, fg, wrap_length)
}

fn C.TTF_RenderUTF8_Blended_Wrapped(font &C.TTF_Font, text &char, fg C.SDL_Color, wrap_length u32) &C.SDL_Surface
pub fn render_utf8_blended_wrapped(font &Font, text &char, fg sdl.Color, wrap_length u32) &sdl.Surface {
	return C.TTF_RenderUTF8_Blended_Wrapped(font, text, fg, wrap_length)
}

fn C.TTF_RenderUNICODE_Blended_Wrapped(font &C.TTF_Font, text &u16, fg C.SDL_Color, wrap_length u32) &C.SDL_Surface
pub fn render_unicode_blended_wrapped(font &Font, text &u16, fg sdl.Color, wrap_length u32) &sdl.Surface {
	return C.TTF_RenderUNICODE_Blended_Wrapped(font, text, fg, wrap_length)
}

// Create a 32-bit ARGB surface and render the given glyph at high quality,
// using alpha blending to dither the font with the given color.
// The glyph is rendered without any padding or centering in the X
// direction, and aligned normally in the Y direction.
// This function returns the new surface, or NULL if there was an error.
fn C.TTF_RenderGlyph_Blended(font &C.TTF_Font, ch u16, fg C.SDL_Color) &C.SDL_Surface
pub fn render_glyph_blended(font &Font, ch u16, fg sdl.Color) &sdl.Surface {
	return C.TTF_RenderGlyph_Blended(font, ch, fg)
}

// Close an opened font file
fn C.TTF_CloseFont(font &C.TTF_Font)
pub fn close_font(font &Font) {
	C.TTF_CloseFont(font)
}

// De-initialize the TTF engine
fn C.TTF_Quit()
pub fn quit() {
	C.TTF_Quit()
}

// Check if the TTF engine is initialized
fn C.TTF_WasInit() int
pub fn was_init() int {
	return C.TTF_WasInit()
}

// Get the kerning size of two glyphs
fn C.TTF_GetFontKerningSizeGlyphs(font &C.TTF_Font, previous_ch u16, ch u16) int
pub fn get_font_kerning_size_glyphs(font &Font, previous_ch u16, ch u16) int {
	return C.TTF_GetFontKerningSizeGlyphs(font, previous_ch, ch)
}
