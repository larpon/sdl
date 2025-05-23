// Copyright(C) 2021 Lars Pontoppidan. All rights reserved.
// Use of this source code is governed by an MIT license
// that can be found in the LICENSE file.
module sdl

//
// SDL_joystick.h
//

pub const joystick_axis_max = C.SDL_JOYSTICK_AXIS_MAX // 32767

pub const joystick_axis_min = C.SDL_JOYSTICK_AXIS_MIN // -32768

// Hat positions
pub const hat_centered = C.SDL_HAT_CENTERED // 0x00

pub const hat_up = C.SDL_HAT_UP // 0x01

pub const hat_right = C.SDL_HAT_RIGHT // 0x02

pub const hat_down = C.SDL_HAT_DOWN // 0x04

pub const hat_left = C.SDL_HAT_LEFT // 0x08

pub const hat_rightup = C.SDL_HAT_RIGHTUP // hat_right | hat_up

pub const hat_rightdown = C.SDL_HAT_RIGHTDOWN // hat_right | hat_down

pub const hat_leftup = C.SDL_HAT_LEFTUP // hat_left | hat_up

pub const hat_leftdown = C.SDL_HAT_LEFTDOWN // hat_left | hat_down

@[typedef]
pub struct C.SDL_Joystick {
}

pub type Joystick = C.SDL_Joystick

pub type JoystickGUID = C.SDL_GUID

// JoystickType is C.SDL_JoystickType
pub enum JoystickType {
	unknown
	gamecontroller
	wheel
	arcade_stick
	flight_stick
	dance_pad
	guitar
	drum_kit
	arcade_pad
	throttle
}

// C.SDL_JoystickID // Sint32
pub type JoystickID = i32

// JoystickPowerLevel is C.SDL_JoystickPowerLevel
pub enum JoystickPowerLevel {
	unknown = -1
	empty  // <= 5%
	low    // <= 20%
	medium // <= 70%
	full   // <= 100%
	wired
	max
}

// Set max recognized G-force from accelerometer
// See src/joystick/uikit/SDL_sysjoystick.m for notes on why this is needed
pub const iphone_max_gforce = C.SDL_IPHONE_MAX_GFORCE // 5.0

fn C.SDL_LockJoysticks()

// lock_joysticks provides locking for multi-threaded access to the joystick API
//
// If you are using the joystick API or handling events from multiple threads
// you should use these locking functions to protect access to the joysticks.
//
// In particular, you are guaranteed that the joystick list won't change, so
// the API functions that take a joystick index will be valid, and joystick
// and game controller events will not be delivered.
//
// As of SDL 2.26.0, you can take the joystick lock around reinitializing the
// joystick subsystem, to prevent other threads from seeing joysticks in an
// uninitialized state. However, all open joysticks will be closed and SDL
// functions called with them will fail.
//
// NOTE This function is available since SDL 2.0.7.
pub fn lock_joysticks() {
	C.SDL_LockJoysticks()
}

fn C.SDL_UnlockJoysticks()

// unlock_joysticks unlockings for multi-threaded access to the joystick API
//
// If you are using the joystick API or handling events from multiple threads
// you should use these locking functions to protect access to the joysticks.
//
// In particular, you are guaranteed that the joystick list won't change, so
// the API functions that take a joystick index will be valid, and joystick
// and game controller events will not be delivered.
//
// NOTE This function is available since SDL 2.0.7.
pub fn unlock_joysticks() {
	C.SDL_UnlockJoysticks()
}

fn C.SDL_NumJoysticks() int

// num_joysticks counts the number of joysticks attached to the system.
//
// returns the number of attached joysticks on success or a negative error
//          code on failure; call SDL_GetError() for more information.
//
// NOTE This function is available since SDL 2.0.0.
//
// See also: SDL_JoystickName
// See also: SDL_JoystickPath
// See also: SDL_JoystickOpen
pub fn num_joysticks() int {
	return C.SDL_NumJoysticks()
}

fn C.SDL_JoystickNameForIndex(device_index int) &char

// joystick_name_for_index gets the implementation dependent name of a joystick.
//
// This can be called before any joysticks are opened.
//
// `device_index` the index of the joystick to query (the N'th joystick
//                     on the system)
// returns the name of the selected joystick. If no name can be found, this
//          function returns NULL; call SDL_GetError() for more information.
//
// NOTE This function is available since SDL 2.0.0.
//
// See also: SDL_JoystickName
// See also: SDL_JoystickOpen
pub fn joystick_name_for_index(device_index int) &char {
	return C.SDL_JoystickNameForIndex(device_index)
}

fn C.SDL_JoystickPathForIndex(device_index int) &char

// joystick_path_for_index gets the implementation dependent path of a joystick.
//
// This can be called before any joysticks are opened.
//
// `device_index` the index of the joystick to query (the N'th joystick
//                     on the system)
// returns the path of the selected joystick. If no path can be found, this
//          function returns NULL; call SDL_GetError() for more information.
//
// NOTE This function is available since SDL 2.24.0.
//
// See also: SDL_JoystickPath
// See also: SDL_JoystickOpen
pub fn joystick_path_for_index(device_index int) &char {
	return C.SDL_JoystickPathForIndex(device_index)
}

fn C.SDL_JoystickGetDevicePlayerIndex(device_index int) int

// joystick_get_device_player_index gets the player index of a joystick, or -1 if it's not available This can be
// called before any joysticks are opened.
//
// NOTE This function is available since SDL 2.0.9.
pub fn joystick_get_device_player_index(device_index int) int {
	return C.SDL_JoystickGetDevicePlayerIndex(device_index)
}

fn C.SDL_JoystickGetDeviceGUID(device_index int) JoystickGUID

// joystick_get_device_guid gets the implementation-dependent GUID for the joystick at a given device
// index.
//
// This function can be called before any joysticks are opened.
//
// `device_index` the index of the joystick to query (the N'th joystick
//                     on the system
// returns the GUID of the selected joystick. If called on an invalid index,
//          this function returns a zero GUID
//
// NOTE This function is available since SDL 2.0.0.
//
// See also: SDL_JoystickGetGUID
// See also: SDL_JoystickGetGUIDString
pub fn joystick_get_device_guid(device_index int) JoystickGUID {
	return C.SDL_JoystickGetDeviceGUID(device_index)
}

fn C.SDL_JoystickGetDeviceVendor(device_index int) u16

// joystick_get_device_vendor gets the USB vendor ID of a joystick, if available.
//
// This can be called before any joysticks are opened. If the vendor ID isn't
// available this function returns 0.
//
// `device_index` the index of the joystick to query (the N'th joystick
//                     on the system
// returns the USB vendor ID of the selected joystick. If called on an
//          invalid index, this function returns zero
//
// NOTE This function is available since SDL 2.0.6.
pub fn joystick_get_device_vendor(device_index int) u16 {
	return C.SDL_JoystickGetDeviceVendor(device_index)
}

fn C.SDL_JoystickGetDeviceProduct(device_index int) u16

// joystick_get_device_product gets the USB product ID of a joystick, if available.
//
// This can be called before any joysticks are opened. If the product ID isn't
// available this function returns 0.
//
// `device_index` the index of the joystick to query (the N'th joystick
//                     on the system
// returns the USB product ID of the selected joystick. If called on an
//          invalid index, this function returns zero
//
// NOTE This function is available since SDL 2.0.6.
pub fn joystick_get_device_product(device_index int) u16 {
	return C.SDL_JoystickGetDeviceProduct(device_index)
}

fn C.SDL_JoystickGetDeviceProductVersion(device_index int) u16

// joystick_get_device_product_version gets the product version of a joystick, if available.
//
// This can be called before any joysticks are opened. If the product version
// isn't available this function returns 0.
//
// `device_index` the index of the joystick to query (the N'th joystick
//                     on the system
// returns the product version of the selected joystick. If called on an
//          invalid index, this function returns zero
//
// NOTE This function is available since SDL 2.0.6.
pub fn joystick_get_device_product_version(device_index int) u16 {
	return C.SDL_JoystickGetDeviceProductVersion(device_index)
}

fn C.SDL_JoystickGetDeviceType(device_index int) JoystickType

// joystick_get_device_type gets the type of a joystick, if available.
//
// This can be called before any joysticks are opened.
//
// `device_index` the index of the joystick to query (the N'th joystick
//                     on the system
// returns the SDL_JoystickType of the selected joystick. If called on an
//          invalid index, this function returns `SDL_JOYSTICK_TYPE_UNKNOWN`
//
// NOTE This function is available since SDL 2.0.6.
pub fn joystick_get_device_type(device_index int) JoystickType {
	return unsafe { JoystickType(int(C.SDL_JoystickGetDeviceType(device_index))) }
}

fn C.SDL_JoystickGetDeviceInstanceID(device_index int) JoystickID

// joystick_get_device_instance_id gets the instance ID of a joystick.
//
// This can be called before any joysticks are opened.
//
// `device_index` the index of the joystick to query (the N'th joystick
//                     on the system
// returns the instance id of the selected joystick. If called on an invalid
//          index, this function returns -1.
//
// NOTE This function is available since SDL 2.0.6.
pub fn joystick_get_device_instance_id(device_index int) JoystickID {
	return unsafe { int(C.SDL_JoystickGetDeviceInstanceID(device_index)) }
}

fn C.SDL_JoystickOpen(device_index int) &C.SDL_Joystick

// joystick_open opens a joystick for use.
//
// The `device_index` argument refers to the N'th joystick presently
// recognized by SDL on the system. It is **NOT** the same as the instance ID
// used to identify the joystick in future events. See
// SDL_JoystickInstanceID() for more details about instance IDs.
//
// The joystick subsystem must be initialized before a joystick can be opened
// for use.
//
// `device_index` the index of the joystick to query
// returns a joystick identifier or NULL if an error occurred; call
//          SDL_GetError() for more information.
//
// NOTE This function is available since SDL 2.0.0.
//
// See also: SDL_JoystickClose
// See also: SDL_JoystickInstanceID
pub fn joystick_open(device_index int) &Joystick {
	return C.SDL_JoystickOpen(device_index)
}

fn C.SDL_JoystickFromInstanceID(instance_id C.SDL_JoystickID) &C.SDL_Joystick

// joystick_from_instance_id gets the SDL_Joystick associated with an instance id.
//
// `instance_id` the instance id to get the SDL_Joystick for
// returns an SDL_Joystick on success or NULL on failure; call SDL_GetError()
//          for more information.
//
// NOTE This function is available since SDL 2.0.4.
pub fn joystick_from_instance_id(instance_id JoystickID) &Joystick {
	return C.SDL_JoystickFromInstanceID(C.SDL_JoystickID(instance_id))
}

fn C.SDL_JoystickFromPlayerIndex(player_index int) &C.SDL_Joystick

// joystick_from_player_index gets the SDL_Joystick associated with a player index.
//
// `player_index` the player index to get the SDL_Joystick for
// returns an SDL_Joystick on success or NULL on failure; call SDL_GetError()
//          for more information.
//
// NOTE This function is available since SDL 2.0.12.
pub fn joystick_from_player_index(player_index int) &Joystick {
	return C.SDL_JoystickFromPlayerIndex(player_index)
}

fn C.SDL_JoystickAttachVirtual(@type C.SDL_JoystickType, naxes int, nbuttons int, nhats int) int

// joystick_attach_virtual attaches a new virtual joystick.
//
// returns the joystick's device index, or -1 if an error occurred.
//
// NOTE This function is available since SDL 2.0.14.
pub fn joystick_attach_virtual(@type JoystickType, naxes int, nbuttons int, nhats int) int {
	return C.SDL_JoystickAttachVirtual(C.SDL_JoystickType(@type), naxes, nbuttons, nhats)
}

// The structure that defines an extended virtual joystick description
//
// The caller must zero the structure and then initialize the version with `SDL_VIRTUAL_JOYSTICK_DESC_VERSION` before passing it to SDL_JoystickAttachVirtualEx()
// All other elements of this structure are optional and can be left 0.
//
// See also: SDL_JoystickAttachVirtualEx
@[typedef]
pub struct C.SDL_VirtualJoystickDesc {
pub mut:
	version     u16     // `SDL_VIRTUAL_JOYSTICK_DESC_VERSION`
	@type       u16     // `SDL_JoystickType`
	naxes       u16     // the number of axes on this joystick
	nbuttons    u16     // the number of buttons on this joystick
	nhats       u16     // the number of hats on this joystick
	vendor_id   u16     // the USB vendor ID of this joystick
	product_id  u16     // the USB product ID of this joystick
	padding     u16     // unused
	button_mask u32     // A mask of which buttons are valid for this controllere.g. (1 << SDL_CONTROLLER_BUTTON_A)
	axis_mask   u32     // A mask of which axes are valid for this controllere.g. (1 << SDL_CONTROLLER_AXIS_LEFTX)
	name        &char   // the name of the joystick
	userdata    voidptr // User data pointer passed to callbacks
	//
	Update         fn (userdata voidptr)                   // Called when the joystick state should be updated
	SetPlayerIndex fn (userdata voidptr, player_index int) // Called when the player index is set
	Rumble         fn (userdata voidptr, low_frequency_rumble u16, high_frequency_rumble u16) // Implements SDL_JoystickRumble()
	RumbleTrigger  fn (userdata voidptr, left_rumble u16, right_rumble u16)                   // Implements SDL_JoystickRumbleTriggers()
	SetLED         fn (userdata voidptr, red u8, green u8, blue u8)    // Implements SDL_JoystickSetLED()
	SendEffect     fn (userdata voidptr, const_data voidptr, size int) // Implements SDL_JoystickSendEffect()
}

pub type VirtualJoystickDesc = C.SDL_VirtualJoystickDesc

// virtual_joystick_desc_version is the current version of the SDL_VirtualJoystickDesc structure
pub const virtual_joystick_desc_version = C.SDL_VIRTUAL_JOYSTICK_DESC_VERSION // 1

fn C.SDL_JoystickAttachVirtualEx(const_desc &C.SDL_VirtualJoystickDesc) int

// joystick_attach_virtual_ex attachs a new virtual joystick with extended properties.
//
// returns the joystick's device index, or -1 if an error occurred.
//
// NOTE This function is available since SDL 2.24.0.
pub fn joystick_attach_virtual_ex(const_desc &VirtualJoystickDesc) int {
	return C.SDL_JoystickAttachVirtualEx(const_desc)
}

fn C.SDL_JoystickDetachVirtual(device_index int) int

// joystick_detach_virtual detachs a virtual joystick.
//
// `device_index` a value previously returned from
//                     SDL_JoystickAttachVirtual()
// returns 0 on success, or -1 if an error occurred.
//
// NOTE This function is available since SDL 2.0.14.
pub fn joystick_detach_virtual(device_index int) int {
	return C.SDL_JoystickDetachVirtual(device_index)
}

fn C.SDL_JoystickIsVirtual(device_index int) bool

// joystick_is_virtual queries whether or not the joystick at a given device index is virtual.
//
// `device_index` a joystick device index.
// returns SDL_TRUE if the joystick is virtual, SDL_FALSE otherwise.
//
// NOTE This function is available since SDL 2.0.14.
pub fn joystick_is_virtual(device_index int) bool {
	return C.SDL_JoystickIsVirtual(device_index)
}

fn C.SDL_JoystickSetVirtualAxis(joystick &C.SDL_Joystick, axis int, value i16) int

// joystick_set_virtual_axis sets values on an opened, virtual-joystick's axis.
//
// Please note that values set here will not be applied until the next call to
// SDL_JoystickUpdate, which can either be called directly, or can be called
// indirectly through various other SDL APIs, including, but not limited to
// the following: SDL_PollEvent, SDL_PumpEvents, SDL_WaitEventTimeout,
// SDL_WaitEvent.
//
// Note that when sending trigger axes, you should scale the value to the full
// range of Sint16. For example, a trigger at rest would have the value of
// `SDL_JOYSTICK_AXIS_MIN`.
//
// `joystick` the virtual joystick on which to set state.
// `axis` the specific axis on the virtual joystick to set.
// `value` the new value for the specified axis.
// returns 0 on success, -1 on error.
//
// NOTE This function is available since SDL 2.0.14.
pub fn joystick_set_virtual_axis(joystick &Joystick, axis int, value i16) int {
	return C.SDL_JoystickSetVirtualAxis(joystick, axis, value)
}

fn C.SDL_JoystickSetVirtualButton(joystick &C.SDL_Joystick, button int, value u8) int

// joystick_set_virtual_button sets values on an opened, virtual-joystick's button.
//
// Please note that values set here will not be applied until the next call to
// SDL_JoystickUpdate, which can either be called directly, or can be called
// indirectly through various other SDL APIs, including, but not limited to
// the following: SDL_PollEvent, SDL_PumpEvents, SDL_WaitEventTimeout,
// SDL_WaitEvent.
//
// `joystick` the virtual joystick on which to set state.
// `button` the specific button on the virtual joystick to set.
// `value` the new value for the specified button.
// returns 0 on success, -1 on error.
//
// NOTE This function is available since SDL 2.0.14.
pub fn joystick_set_virtual_button(joystick &Joystick, button int, value u8) int {
	return C.SDL_JoystickSetVirtualButton(joystick, button, value)
}

fn C.SDL_JoystickSetVirtualHat(joystick &C.SDL_Joystick, hat int, value u8) int

// joystick_set_virtual_hat sets values on an opened, virtual-joystick's hat.
//
// Please note that values set here will not be applied until the next call to
// SDL_JoystickUpdate, which can either be called directly, or can be called
// indirectly through various other SDL APIs, including, but not limited to
// the following: SDL_PollEvent, SDL_PumpEvents, SDL_WaitEventTimeout,
// SDL_WaitEvent.
//
// `joystick` the virtual joystick on which to set state.
// `hat` the specific hat on the virtual joystick to set.
// `value` the new value for the specified hat.
// returns 0 on success, -1 on error.
//
// NOTE This function is available since SDL 2.0.14.
pub fn joystick_set_virtual_hat(joystick &C.SDL_Joystick, hat int, value u8) int {
	return C.SDL_JoystickSetVirtualHat(joystick, hat, value)
}

fn C.SDL_JoystickName(joystick &C.SDL_Joystick) &char

// joystick_name gets the implementation dependent name of a joystick.
//
// `joystick` the SDL_Joystick obtained from SDL_JoystickOpen()
// returns the name of the selected joystick. If no name can be found, this
//          function returns NULL; call SDL_GetError() for more information.
//
// NOTE This function is available since SDL 2.0.0.
//
// See also: SDL_JoystickNameForIndex
// See also: SDL_JoystickOpen
pub fn joystick_name(joystick &Joystick) &char {
	return C.SDL_JoystickName(joystick)
}

fn C.SDL_JoystickPath(joystick &C.SDL_Joystick) &char

// joystick_path gets the implementation dependent path of a joystick.
//
// `joystick` the SDL_Joystick obtained from SDL_JoystickOpen()
// returns the path of the selected joystick. If no path can be found, this
//          function returns NULL; call SDL_GetError() for more information.
//
// NOTE This function is available since SDL 2.24.0.
//
// See also: SDL_JoystickPathForIndex
pub fn joystick_path(joystick &Joystick) &char {
	return C.SDL_JoystickPath(joystick)
}

fn C.SDL_JoystickGetPlayerIndex(joystick &C.SDL_Joystick) int

// joystick_get_player_index gets the player index of an opened joystick.
//
// For XInput controllers this returns the XInput user index. Many joysticks
// will not be able to supply this information.
//
// `joystick` the SDL_Joystick obtained from SDL_JoystickOpen()
// returns the player index, or -1 if it's not available.
//
// NOTE This function is available since SDL 2.0.9.
pub fn joystick_get_player_index(joystick &Joystick) int {
	return C.SDL_JoystickGetPlayerIndex(joystick)
}

fn C.SDL_JoystickSetPlayerIndex(joystick &C.SDL_Joystick, player_index int)

// joystick_set_player_index sets the player index of an opened joystick.
//
// `joystick` the SDL_Joystick obtained from SDL_JoystickOpen()
// `player_index` Player index to assign to this joystick, or -1 to clear
//                the player index and turn off player LEDs.
//
// NOTE This function is available since SDL 2.0.12.
pub fn joystick_set_player_index(joystick &Joystick, player_index int) {
	C.SDL_JoystickSetPlayerIndex(joystick, player_index)
}

fn C.SDL_JoystickGetGUID(joystick &C.SDL_Joystick) JoystickGUID

// joystick_get_guid gets the implementation-dependent GUID for the joystick.
//
// This function requires an open joystick.
//
// `joystick` the SDL_Joystick obtained from SDL_JoystickOpen()
// returns the GUID of the given joystick. If called on an invalid index,
//          this function returns a zero GUID; call SDL_GetError() for more
//          information.
//
// NOTE This function is available since SDL 2.0.0.
//
// See also: SDL_JoystickGetDeviceGUID
// See also: SDL_JoystickGetGUIDString
pub fn joystick_get_guid(joystick &Joystick) JoystickGUID {
	return C.SDL_JoystickGetGUID(joystick)
}

fn C.SDL_JoystickGetVendor(joystick &C.SDL_Joystick) u16

// joystick_get_vendor gets the USB vendor ID of an opened joystick, if available.
//
// If the vendor ID isn't available this function returns 0.
//
// `joystick` the SDL_Joystick obtained from SDL_JoystickOpen()
// returns the USB vendor ID of the selected joystick, or 0 if unavailable.
//
// NOTE This function is available since SDL 2.0.6.
pub fn joystick_get_vendor(joystick &Joystick) u16 {
	return C.SDL_JoystickGetVendor(joystick)
}

fn C.SDL_JoystickGetProduct(joystick &C.SDL_Joystick) u16

// joystick_get_product gets the USB product ID of an opened joystick, if available.
//
// If the product ID isn't available this function returns 0.
//
// `joystick` the SDL_Joystick obtained from SDL_JoystickOpen()
// returns the USB product ID of the selected joystick, or 0 if unavailable.
//
// NOTE This function is available since SDL 2.0.6.
pub fn joystick_get_product(joystick &Joystick) u16 {
	return C.SDL_JoystickGetProduct(joystick)
}

fn C.SDL_JoystickGetProductVersion(joystick &C.SDL_Joystick) u16

// joystick_get_product_version gets the product version of an opened joystick, if available.
//
// If the product version isn't available this function returns 0.
//
// `joystick` the SDL_Joystick obtained from SDL_JoystickOpen()
// returns the product version of the selected joystick, or 0 if unavailable.
//
// NOTE This function is available since SDL 2.0.6.
pub fn joystick_get_product_version(joystick &Joystick) u16 {
	return C.SDL_JoystickGetProductVersion(joystick)
}

fn C.SDL_JoystickGetFirmwareVersion(joystick &C.SDL_Joystick) u16

// joystick_get_firmware_version gets the firmware version of an opened joystick, if available.
//
// If the firmware version isn't available this function returns 0.
//
// `joystick` the SDL_Joystick obtained from SDL_JoystickOpen()
// returns the firmware version of the selected joystick, or 0 if
//          unavailable.
//
// NOTE This function is available since SDL 2.24.0.
pub fn joystick_get_firmware_version(joystick &Joystick) u16 {
	return C.SDL_JoystickGetFirmwareVersion(joystick)
}

fn C.SDL_JoystickGetSerial(joystick &C.SDL_Joystick) &char

// joystick_get_serial gets the serial number of an opened joystick, if available.
//
// Returns the serial number of the joystick, or NULL if it is not available.
//
// `joystick` the SDL_Joystick obtained from SDL_JoystickOpen()
// returns the serial number of the selected joystick, or NULL if
//          unavailable.
//
// NOTE This function is available since SDL 2.0.14.
pub fn joystick_get_serial(joystick &Joystick) &char {
	return C.SDL_JoystickGetSerial(joystick)
}

fn C.SDL_JoystickGetType(joystick &C.SDL_Joystick) JoystickType

// joystick_get_type gets the type of an opened joystick.
//
// `joystick` the SDL_Joystick obtained from SDL_JoystickOpen()
// returns the SDL_JoystickType of the selected joystick.
//
// NOTE This function is available since SDL 2.0.6.
pub fn joystick_get_type(joystick &Joystick) JoystickType {
	return unsafe { JoystickType(int(C.SDL_JoystickGetType(joystick))) }
}

fn C.SDL_JoystickGetGUIDString(guid C.SDL_JoystickGUID, psz_guid &char, cb_guid int)

// joystick_get_guid_string gets an ASCII string representation for a given SDL_JoystickGUID.
//
// You should supply at least 33 bytes for pszGUID.
//
// `guid` the SDL_JoystickGUID you wish to convert to string
// `pszGUID` buffer in which to write the ASCII string
// `cbGUID` the size of pszGUID
//
// NOTE This function is available since SDL 2.0.0.
//
// See also: SDL_JoystickGetDeviceGUID
// See also: SDL_JoystickGetGUID
// See also: SDL_JoystickGetGUIDFromString
pub fn joystick_get_guid_string(guid JoystickGUID, psz_guid &char, cb_guid int) {
	C.SDL_JoystickGetGUIDString(C.SDL_JoystickGUID(guid), psz_guid, cb_guid)
}

fn C.SDL_JoystickGetGUIDFromString(pch_guid &char) JoystickGUID

// joystick_get_guid_from_string converts a GUID string into a SDL_JoystickGUID structure.
//
// Performs no error checking. If this function is given a string containing
// an invalid GUID, the function will silently succeed, but the GUID generated
// will not be useful.
//
// `pchGUID` string containing an ASCII representation of a GUID
// returns a SDL_JoystickGUID structure.
//
// NOTE This function is available since SDL 2.0.0.
//
// See also: SDL_JoystickGetGUIDString
pub fn joystick_get_guid_from_string(pch_guid &char) JoystickGUID {
	return C.SDL_JoystickGetGUIDFromString(pch_guid)
}

fn C.SDL_GetJoystickGUIDInfo(guid C.SDL_JoystickGUID, vendor &u16, product &u16, version &u16, crc16 &u16)

// get_joystick_guid_info gets the device information encoded in a SDL_JoystickGUID structure
//
// `guid` the SDL_JoystickGUID you wish to get info about
// `vendor` A pointer filled in with the device VID, or 0 if not
//               available
// `product` A pointer filled in with the device PID, or 0 if not
//                available
// `version` A pointer filled in with the device version, or 0 if not
//                available
// `crc16` A pointer filled in with a CRC used to distinguish different
//              products with the same VID/PID, or 0 if not available
//
// NOTE This function is available since SDL 2.26.0.
//
// See also: SDL_JoystickGetDeviceGUID
pub fn get_joystick_guid_info(guid JoystickGUID, vendor &u16, product &u16, version &u16, crc16 &u16) {
	C.SDL_GetJoystickGUIDInfo(C.SDL_JoystickGUID(guid), vendor, product, version, crc16)
}

fn C.SDL_JoystickGetAttached(joystick &C.SDL_Joystick) bool

// joystick_get_attached gets the status of a specified joystick.
//
// `joystick` the joystick to query
// returns SDL_TRUE if the joystick has been opened, SDL_FALSE if it has not;
//          call SDL_GetError() for more information.
//
// NOTE This function is available since SDL 2.0.0.
//
// See also: SDL_JoystickClose
// See also: SDL_JoystickOpen
pub fn joystick_get_attached(joystick &Joystick) bool {
	return C.SDL_JoystickGetAttached(joystick)
}

fn C.SDL_JoystickInstanceID(joystick &C.SDL_Joystick) JoystickID

// joystick_instance_id gets the instance ID of an opened joystick.
//
// `joystick` an SDL_Joystick structure containing joystick information
// returns the instance ID of the specified joystick on success or a negative
//          error code on failure; call SDL_GetError() for more information.
//
// NOTE This function is available since SDL 2.0.0.
//
// See also: SDL_JoystickOpen
pub fn joystick_instance_id(joystick &Joystick) JoystickID {
	return C.SDL_JoystickInstanceID(joystick)
}

fn C.SDL_JoystickNumAxes(joystick &C.SDL_Joystick) int

// joystick_num_axes gets the number of general axis controls on a joystick.
//
// Often, the directional pad on a game controller will either look like 4
// separate buttons or a POV hat, and not axes, but all of this is up to the
// device and platform.
//
// `joystick` an SDL_Joystick structure containing joystick information
// returns the number of axis controls/number of axes on success or a
//          negative error code on failure; call SDL_GetError() for more
//          information.
//
// NOTE This function is available since SDL 2.0.0.
//
// See also: SDL_JoystickGetAxis
// See also: SDL_JoystickOpen
pub fn joystick_num_axes(joystick &Joystick) int {
	return C.SDL_JoystickNumAxes(joystick)
}

fn C.SDL_JoystickNumBalls(joystick &C.SDL_Joystick) int

// joystick_num_balls gets the number of trackballs on a joystick.
//
// Joystick trackballs have only relative motion events associated with them
// and their state cannot be polled.
//
// Most joysticks do not have trackballs.
//
// `joystick` an SDL_Joystick structure containing joystick information
// returns the number of trackballs on success or a negative error code on
//          failure; call SDL_GetError() for more information.
//
// NOTE This function is available since SDL 2.0.0.
//
// See also: SDL_JoystickGetBall
pub fn joystick_num_balls(joystick &Joystick) int {
	return C.SDL_JoystickNumBalls(joystick)
}

fn C.SDL_JoystickNumHats(joystick &C.SDL_Joystick) int

// joystick_num_hats gets the number of POV hats on a joystick.
//
// `joystick` an SDL_Joystick structure containing joystick information
// returns the number of POV hats on success or a negative error code on
//          failure; call SDL_GetError() for more information.
//
// NOTE This function is available since SDL 2.0.0.
//
// See also: SDL_JoystickGetHat
// See also: SDL_JoystickOpen
pub fn joystick_num_hats(joystick &Joystick) int {
	return C.SDL_JoystickNumHats(joystick)
}

fn C.SDL_JoystickNumButtons(joystick &C.SDL_Joystick) int

// joystick_num_buttons gets the number of buttons on a joystick.
//
// `joystick` an SDL_Joystick structure containing joystick information
// returns the number of buttons on success or a negative error code on
//          failure; call SDL_GetError() for more information.
//
// NOTE This function is available since SDL 2.0.0.
//
// See also: SDL_JoystickGetButton
// See also: SDL_JoystickOpen
pub fn joystick_num_buttons(joystick &Joystick) int {
	return C.SDL_JoystickNumButtons(joystick)
}

fn C.SDL_JoystickUpdate()

// joystick_update updates the current state of the open joysticks.
//
// This is called automatically by the event loop if any joystick events are
// enabled.
//
// NOTE This function is available since SDL 2.0.0.
//
// See also: SDL_JoystickEventState
pub fn joystick_update() {
	C.SDL_JoystickUpdate()
}

fn C.SDL_JoystickEventState(state int) int

// joystick_event_state enable/disables joystick event polling.
//
// If joystick events are disabled, you must call SDL_JoystickUpdate()
// yourself and manually check the state of the joystick when you want
// joystick information.
//
// It is recommended that you leave joystick event handling enabled.
//
// **WARNING**: Calling this function may delete all events currently in SDL's
// event queue.
//
// `state` can be one of `SDL_QUERY`, `SDL_IGNORE`, or `SDL_ENABLE`
// returns 1 if enabled, 0 if disabled, or a negative error code on failure;
//          call SDL_GetError() for more information.
//
//          If `state` is `SDL_QUERY` then the current state is returned,
//          otherwise the new processing state is returned.
//
// NOTE This function is available since SDL 2.0.0.
//
// See also: SDL_GameControllerEventState
pub fn joystick_event_state(state int) int {
	return C.SDL_JoystickEventState(state)
}

fn C.SDL_JoystickGetAxis(joystick &C.SDL_Joystick, axis int) i16

// joystick_get_axis gets the current state of an axis control on a joystick.
//
// SDL makes no promises about what part of the joystick any given axis refers
// to. Your game should have some sort of configuration UI to let users
// specify what each axis should be bound to. Alternately, SDL's higher-level
// Game Controller API makes a great effort to apply order to this lower-level
// interface, so you know that a specific axis is the "left thumb stick," etc.
//
// The value returned by SDL_JoystickGetAxis() is a signed integer (-32768 to
// 32767) representing the current position of the axis. It may be necessary
// to impose certain tolerances on these values to account for jitter.
//
// `joystick` an SDL_Joystick structure containing joystick information
// `axis` the axis to query; the axis indices start at index 0
// returns a 16-bit signed integer representing the current position of the
//          axis or 0 on failure; call SDL_GetError() for more information.
//
// NOTE This function is available since SDL 2.0.0.
//
// See also: SDL_JoystickNumAxes
pub fn joystick_get_axis(joystick &Joystick, axis int) i16 {
	return C.SDL_JoystickGetAxis(joystick, axis)
}

fn C.SDL_JoystickGetAxisInitialState(joystick &C.SDL_Joystick, axis int, state &i16) bool

// joystick_get_axis_initial_state gets the initial state of an axis control on a joystick.
//
// The state is a value ranging from -32768 to 32767.
//
// The axis indices start at index 0.
//
// `joystick` an SDL_Joystick structure containing joystick information
// `axis` the axis to query; the axis indices start at index 0
// `state` Upon return, the initial value is supplied here.
// returns SDL_TRUE if this axis has any initial value, or SDL_FALSE if not.
//
// NOTE This function is available since SDL 2.0.6.
pub fn joystick_get_axis_initial_state(joystick &Joystick, axis int, state &i16) bool {
	return C.SDL_JoystickGetAxisInitialState(joystick, axis, state)
}

fn C.SDL_JoystickGetHat(joystick &C.SDL_Joystick, hat int) u8

// joystick_get_hat gets the current state of a POV hat on a joystick.
//
// The returned value will be one of the following positions:
//
// - `SDL_HAT_CENTERED`
// - `SDL_HAT_UP`
// - `SDL_HAT_RIGHT`
// - `SDL_HAT_DOWN`
// - `SDL_HAT_LEFT`
// - `SDL_HAT_RIGHTUP`
// - `SDL_HAT_RIGHTDOWN`
// - `SDL_HAT_LEFTUP`
// - `SDL_HAT_LEFTDOWN`
//
// `joystick` an SDL_Joystick structure containing joystick information
// `hat` the hat index to get the state from; indices start at index 0
// returns the current hat position.
//
// NOTE This function is available since SDL 2.0.0.
//
// See also: SDL_JoystickNumHats
pub fn joystick_get_hat(joystick &Joystick, hat int) u8 {
	return C.SDL_JoystickGetHat(joystick, hat)
}

fn C.SDL_JoystickGetBall(joystick &C.SDL_Joystick, ball int, dx &int, dy &int) int

// joystick_get_ball gets the ball axis change since the last poll.
//
// Trackballs can only return relative motion since the last call to
// SDL_JoystickGetBall(), these motion deltas are placed into `dx` and `dy`.
//
// Most joysticks do not have trackballs.
//
// `joystick` the SDL_Joystick to query
// `ball` the ball index to query; ball indices start at index 0
// `dx` stores the difference in the x axis position since the last poll
// `dy` stores the difference in the y axis position since the last poll
// returns 0 on success or a negative error code on failure; call
//          SDL_GetError() for more information.
//
// NOTE This function is available since SDL 2.0.0.
//
// See also: SDL_JoystickNumBalls
pub fn joystick_get_ball(joystick &Joystick, ball int, dx &int, dy &int) int {
	return C.SDL_JoystickGetBall(joystick, ball, dx, dy)
}

fn C.SDL_JoystickGetButton(joystick &C.SDL_Joystick, button int) u8

// joystick_get_button gets the current state of a button on a joystick.
//
// `joystick` an SDL_Joystick structure containing joystick information
// `button` the button index to get the state from; indices start at
//               index 0
// returns 1 if the specified button is pressed, 0 otherwise.
//
// NOTE This function is available since SDL 2.0.0.
//
// See also: SDL_JoystickNumButtons
pub fn joystick_get_button(joystick &Joystick, button int) u8 {
	return C.SDL_JoystickGetButton(joystick, button)
}

fn C.SDL_JoystickRumble(joystick &C.SDL_Joystick, low_frequency_rumble u16, high_frequency_rumble u16, duration_ms u32) int

// joystick_rumble starts a rumble effect.
//
// Each call to this function cancels any previous rumble effect, and calling
// it with 0 intensity stops any rumbling.
//
// `joystick` The joystick to vibrate
// `low_frequency_rumble` The intensity of the low frequency (left)
//                             rumble motor, from 0 to 0xFFFF
// `high_frequency_rumble` The intensity of the high frequency (right)
//                              rumble motor, from 0 to 0xFFFF
// `duration_ms` The duration of the rumble effect, in milliseconds
// returns 0, or -1 if rumble isn't supported on this joystick
//
// NOTE This function is available since SDL 2.0.9.
//
// See also: SDL_JoystickHasRumble
pub fn joystick_rumble(joystick &Joystick, low_frequency_rumble u16, high_frequency_rumble u16, duration_ms u32) int {
	return C.SDL_JoystickRumble(joystick, low_frequency_rumble, high_frequency_rumble,
		duration_ms)
}

fn C.SDL_JoystickRumbleTriggers(joystick &C.SDL_Joystick, left_rumble u16, right_rumble u16, duration_ms u32) int

// joystick_rumble_triggers starts a rumble effect in the joystick's triggers
//
// Each call to this function cancels any previous trigger rumble effect, and
// calling it with 0 intensity stops any rumbling.
//
// Note that this is rumbling of the _triggers_ and not the game controller as
// a whole. This is currently only supported on Xbox One controllers. If you
// want the (more common) whole-controller rumble, use SDL_JoystickRumble()
// instead.
//
// `joystick` The joystick to vibrate
// `left_rumble` The intensity of the left trigger rumble motor, from 0
//                    to 0xFFFF
// `right_rumble` The intensity of the right trigger rumble motor, from 0
//                     to 0xFFFF
// `duration_ms` The duration of the rumble effect, in milliseconds
// returns 0, or -1 if trigger rumble isn't supported on this joystick
//
// NOTE This function is available since SDL 2.0.14.
//
// See also: SDL_JoystickHasRumbleTriggers
pub fn joystick_rumble_triggers(joystick &Joystick, left_rumble u16, right_rumble u16, duration_ms u32) int {
	return C.SDL_JoystickRumbleTriggers(joystick, left_rumble, right_rumble, duration_ms)
}

fn C.SDL_JoystickHasLED(joystick &C.SDL_Joystick) bool

// joystick_has_led querys whether a joystick has an LED.
//
// An example of a joystick LED is the light on the back of a PlayStation 4's
// DualShock 4 controller.
//
// `joystick` The joystick to query
// returns SDL_TRUE if the joystick has a modifiable LED, SDL_FALSE otherwise.
//
// NOTE This function is available since SDL 2.0.14.
pub fn joystick_has_led(joystick &Joystick) bool {
	return C.SDL_JoystickHasLED(joystick)
}

fn C.SDL_JoystickHasRumble(joystick &C.SDL_Joystick) bool

// joystick_has_rumble querys whether a joystick has rumble support.
//
// `joystick` The joystick to query
// returns SDL_TRUE if the joystick has rumble, SDL_FALSE otherwise.
//
// NOTE This function is available since SDL 2.0.18.
//
// See also: SDL_JoystickRumble
pub fn joystick_has_rumble(joystick &Joystick) bool {
	return C.SDL_JoystickHasRumble(joystick)
}

fn C.SDL_JoystickHasRumbleTriggers(joystick &C.SDL_Joystick) bool

// joystick_has_rumble_triggers querys whether a joystick has rumble support on triggers.
//
// `joystick` The joystick to query
// returns SDL_TRUE if the joystick has trigger rumble, SDL_FALSE otherwise.
//
// NOTE This function is available since SDL 2.0.18.
//
// See also: SDL_JoystickRumbleTriggers
pub fn joystick_has_rumble_triggers(joystick &Joystick) bool {
	return C.SDL_JoystickHasRumbleTriggers(joystick)
}

fn C.SDL_JoystickSetLED(joystick &Joystick, red u8, green u8, blue u8) int

// joystick_set_led updates a joystick's LED color.
//
// An example of a joystick LED is the light on the back of a PlayStation 4's
// DualShock 4 controller.
//
// `joystick` The joystick to update
// `red` The intensity of the red LED
// `green` The intensity of the green LED
// `blue` The intensity of the blue LED
// returns 0 on success, -1 if this joystick does not have a modifiable LED
//
// NOTE This function is available since SDL 2.0.14.
pub fn joystick_set_led(joystick &Joystick, red u8, green u8, blue u8) int {
	return C.SDL_JoystickSetLED(joystick, red, green, blue)
}

fn C.SDL_JoystickSendEffect(joystick &C.SDL_Joystick, const_data voidptr, size int) int

// joystick_send_effect sends a joystick specific effect packet
//
// `joystick` The joystick to affect
// `data` The data to send to the joystick
// `size` The size of the data to send to the joystick
// returns 0, or -1 if this joystick or driver doesn't support effect packets
//
// NOTE This function is available since SDL 2.0.16.
pub fn joystick_send_effect(joystick &Joystick, const_data voidptr, size int) int {
	return C.SDL_JoystickSendEffect(joystick, const_data, size)
}

fn C.SDL_JoystickClose(joystick &C.SDL_Joystick)

// joystick_close closes a joystick previously opened with SDL_JoystickOpen().
//
// `joystick` The joystick device to close
//
// NOTE This function is available since SDL 2.0.0.
//
// See also: SDL_JoystickOpen
pub fn joystick_close(joystick &Joystick) {
	C.SDL_JoystickClose(joystick)
}

fn C.SDL_JoystickCurrentPowerLevel(joystick &C.SDL_Joystick) JoystickPowerLevel

// joystick_current_power_level gets the battery level of a joystick as SDL_JoystickPowerLevel.
//
// `joystick` the SDL_Joystick to query
// returns the current battery level as SDL_JoystickPowerLevel on success or
//          `SDL_JOYSTICK_POWER_UNKNOWN` if it is unknown
//
// NOTE This function is available since SDL 2.0.4.
pub fn joystick_current_power_level(joystick &Joystick) JoystickPowerLevel {
	return unsafe { JoystickPowerLevel(int(C.SDL_JoystickCurrentPowerLevel(joystick))) }
}
