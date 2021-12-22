// Copyright(C) 2021 Lars Pontoppidan. All rights reserved.
// Use of this source code is governed by an MIT license
// that can be found in the LICENSE file.
module sdl

//
// SDL_pixels.h
//

pub enum Format {
	unknown = C.SDL_PIXELFORMAT_UNKNOWN
	index1lsb = C.SDL_PIXELFORMAT_INDEX1LSB
	index1msb = C.SDL_PIXELFORMAT_INDEX1MSB
	index4lsb = C.SDL_PIXELFORMAT_INDEX4LSB
	index4msb = C.SDL_PIXELFORMAT_INDEX4MSB
	index8 = C.SDL_PIXELFORMAT_INDEX8
	rgb332 = C.SDL_PIXELFORMAT_RGB332
	rgb444 = C.SDL_PIXELFORMAT_RGB444
	rgb555 = C.SDL_PIXELFORMAT_RGB555
	bgr555 = C.SDL_PIXELFORMAT_BGR555
	argb4444 = C.SDL_PIXELFORMAT_ARGB4444
	rgba4444 = C.SDL_PIXELFORMAT_RGBA4444
	abgr4444 = C.SDL_PIXELFORMAT_ABGR4444
	bgra4444 = C.SDL_PIXELFORMAT_BGRA4444
	argb1555 = C.SDL_PIXELFORMAT_ARGB1555
	rgba5551 = C.SDL_PIXELFORMAT_RGBA5551
	abgr1555 = C.SDL_PIXELFORMAT_ABGR1555
	bgra5551 = C.SDL_PIXELFORMAT_BGRA5551
	rgb565 = C.SDL_PIXELFORMAT_RGB565
	bgr565 = C.SDL_PIXELFORMAT_BGR565
	rgb24 = C.SDL_PIXELFORMAT_RGB24
	bgr24 = C.SDL_PIXELFORMAT_BGR24
	rgb888 = C.SDL_PIXELFORMAT_RGB888
	rgbx8888 = C.SDL_PIXELFORMAT_RGBX8888
	bgr888 = C.SDL_PIXELFORMAT_BGR888
	bgrx8888 = C.SDL_PIXELFORMAT_BGRX8888
	argb8888 = C.SDL_PIXELFORMAT_ARGB8888
	rgba8888 = C.SDL_PIXELFORMAT_RGBA8888
	abgr8888 = C.SDL_PIXELFORMAT_ABGR8888
	bgra8888 = C.SDL_PIXELFORMAT_BGRA8888
	argb2101010 = C.SDL_PIXELFORMAT_ARGB2101010
	rgba32 = C.SDL_PIXELFORMAT_RGBA32
	argb32 = C.SDL_PIXELFORMAT_ARGB32
	bgra32 = C.SDL_PIXELFORMAT_BGRA32
	abgr32 = C.SDL_PIXELFORMAT_ABGR32
	yv12 = C.SDL_PIXELFORMAT_YV12 //*< Planar mode: Y + V + U  (3 planes)
	iyuv = C.SDL_PIXELFORMAT_IYUV //*< Planar mode: Y + U + V  (3 planes)
	yuy2 = C.SDL_PIXELFORMAT_YUY2 //*< Packed mode: Y0+U0+Y1+V0 (1 plane)
	uyvy = C.SDL_PIXELFORMAT_UYVY //*< Packed mode: U0+Y0+V0+Y1 (1 plane)
	yvyu = C.SDL_PIXELFORMAT_YVYU //*< Packed mode: Y0+V0+Y1+U0 (1 plane)
	nv12 = C.SDL_PIXELFORMAT_NV12 //*< Planar mode: Y + U/V interleaved  (2 planes)
	nv21 = C.SDL_PIXELFORMAT_NV21 //*< Planar mode: Y + V/U interleaved  (2 planes)
	external_oes = C.SDL_PIXELFORMAT_EXTERNAL_OES //*< Android video texture format
}

[typedef]
struct C.SDL_Color {
pub mut:
	r byte
	g byte
	b byte
	a byte
}

pub type Color = C.SDL_Color

[typedef]
struct C.SDL_Palette {
	ncolors  int
	colors   &Color
	version  u32
	refcount int
}

pub type Palette = C.SDL_Palette

[typedef]
struct C.SDL_PixelFormat {
	format          u32
	palette         &C.SDL_Palette
	bits_per_pixel  byte
	bytes_per_pixel byte
	padding         [2]byte
	rmask           u32
	gmask           u32
	bmask           u32
	amask           u32
	rloss           byte
	gloss           byte
	bloss           byte
	aloss           byte
	rshift          byte
	gshift          byte
	bshift          byte
	ashift          byte
	refcount        int
	next            &C.SDL_PixelFormat
}

pub type PixelFormat = C.SDL_PixelFormat

// extern DECLSPEC const char* SDLCALL SDL_GetPixelFormatName(Uint32 format)
fn C.SDL_GetPixelFormatName(format u32) &char

// get the human readable name of a pixel format
pub fn get_pixel_format_name(format u32) string {
	return unsafe { cstring_to_vstring(C.SDL_GetPixelFormatName(format)) }
}

fn C.SDL_PixelFormatEnumToMasks(format u32, bpp &int, rmask &u32, gmask &u32, bmask &u32, amask &u32) bool

// pixel_format_enum_to_masks converts one of the enumerated pixel formats to a bpp and RGBA masks.
/*
*  returns SDL_TRUE, or SDL_FALSE if the conversion wasn't possible.
 *
 *  \sa SDL_MasksToPixelFormatEnum()
*/
pub fn pixel_format_enum_to_masks(format u32, bpp &int, rmask &u32, gmask &u32, bmask &u32, amask &u32) bool {
	return C.SDL_PixelFormatEnumToMasks(format, bpp, rmask, gmask, bmask, amask)
}

fn C.SDL_MasksToPixelFormatEnum(bpp int, rmask u32, gmask u32, bmask u32, amask u32) u32

// masks_to_pixel_format_enum converts a bpp and RGBA masks to an enumerated pixel format.
/*
*  returns The pixel format, or ::SDL_PIXELFORMAT_UNKNOWN if the conversion
 *          wasn't possible.
 *
 *  \sa SDL_PixelFormatEnumToMasks()
*/
pub fn masks_to_pixel_format_enum(bpp int, rmask u32, gmask u32, bmask u32, amask u32) u32 {
	return C.SDL_MasksToPixelFormatEnum(bpp, rmask, gmask, bmask, amask)
}

fn C.SDL_AllocFormat(pixel_format u32) &C.SDL_PixelFormat

// alloc_format creates an SDL_PixelFormat structure from a pixel format enum.
pub fn alloc_format(pixel_format u32) &PixelFormat {
	return C.SDL_AllocFormat(pixel_format)
}

fn C.SDL_FreeFormat(format &C.SDL_PixelFormat)

// free_format frees an SDL_PixelFormat structure.
pub fn free_format(format &PixelFormat) {
	C.SDL_FreeFormat(format)
}

fn C.SDL_AllocPalette(ncolors int) &C.SDL_Palette

// alloc_palette create a palette structure with the specified
// number of color entries.
/*
*  returns A new palette, or NULL if there wasn't enough memory.
 *
 *  NOTE The palette entries are initialized to white.
 *
 *  \sa SDL_FreePalette()
*/
pub fn alloc_palette(ncolors int) &Palette {
	return C.SDL_AllocPalette(ncolors)
}

fn C.SDL_SetPixelFormatPalette(format &C.SDL_PixelFormat, palette &C.SDL_Palette) int

// set_pixel_format_palette set the palette for a pixel format structure.
pub fn set_pixel_format_palette(format &PixelFormat, palette &Palette) int {
	return C.SDL_SetPixelFormatPalette(format, palette)
}

fn C.SDL_SetPaletteColors(palette &C.SDL_Palette, colors &C.SDL_Color, firstcolor int, ncolors int) int

// set_palette_colors sets a range of colors in a palette.
/*
*  `palette`    The palette to modify.
 *  `colors`     An array of colors to copy into the palette.
 *  `firstcolor` The index of the first palette entry to modify.
 *  `ncolors`    The number of entries to modify.
 *
 *  return 0 on success, or -1 if not all of the colors could be set.
*/
pub fn set_palette_colors(palette &Palette, colors &Color, firstcolor int, ncolors int) int {
	return C.SDL_SetPaletteColors(palette, colors, firstcolor, ncolors)
}

fn C.SDL_FreePalette(palette &C.SDL_Palette)

// free_palette frees a palette created with SDL_AllocPalette().
pub fn free_palette(palette &Palette) {
	C.SDL_FreePalette(palette)
}

fn C.SDL_MapRGB(format &C.SDL_PixelFormat, r byte, g byte, b byte) u32

// map_rgb maps an RGB triple to an opaque pixel value for a given pixel format.
pub fn map_rgb(format &PixelFormat, r byte, g byte, b byte) u32 {
	return C.SDL_MapRGB(format, r, g, b)
}

fn C.SDL_MapRGBA(format &C.SDL_PixelFormat, r byte, g byte, b byte, a byte) u32

// map_rgba maps an RGBA quadruple to a pixel value for a given pixel format.
pub fn map_rgba(format &PixelFormat, r byte, g byte, b byte, a byte) u32 {
	return C.SDL_MapRGBA(format, r, g, b, a)
}

fn C.SDL_GetRGB(pixel u32, format &C.SDL_PixelFormat, r &byte, g &byte, b &byte)

// get_rgb gets the RGB components from a pixel of the specified format.
pub fn get_rgb(pixel u32, format &PixelFormat, r &byte, g &byte, b &byte) {
	C.SDL_GetRGB(pixel, format, r, g, b)
}

fn C.SDL_GetRGBA(pixel u32, format &C.SDL_PixelFormat, r &byte, g &byte, b &byte, a &byte)

// get_rgba gets the RGBA components from a pixel of the specified format.
pub fn get_rgba(pixel u32, format &PixelFormat, r &byte, g &byte, b &byte, a &byte) {
	C.SDL_GetRGBA(pixel, format, r, g, b, a)
}

fn C.SDL_CalculateGammaRamp(gamma f32, ramp &u16)

// calculate_gamma_ramp calculates a 256 entry gamma ramp for a gamma value.
pub fn calculate_gamma_ramp(gamma f32, ramp &u16) {
	C.SDL_CalculateGammaRamp(gamma, ramp)
}