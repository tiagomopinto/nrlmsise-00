#+private package

package nrlmsise_00

import "core:c"

when ODIN_OS == .Linux {

	foreign import nrlmsise_00 "../bin/nrlmsise-00.a"

} else when ODIN_OS == .Windows {

	foreign import nrlmsise_00 "../bin/nrlmsise-00.lib"

} else when ODIN_OS == .Darwin {

	foreign import nrlmsise_00 "../bin/nrlmsise-00.a"
}

foreign nrlmsise_00 {

	@(link_name = "gtd7")
	nrlmsise_00_gtd7 :: proc "c" (input: ^Nrlmsise_00_Input, flags: ^Flags, output: ^Nrlmsise_00_Output) ---
}

Flags :: struct {
	switches: [24]c.int,
	sw:       [24]f64,
	swc:      [24]f64,
}

Nrlmsise_00_Input :: struct {
	year:   c.int,
	doy:    c.int,
	sec:    f64,
	alt:    f64,
	g_lat:  f64,
	g_long: f64,
	lst:    f64,
	f107A:  f64,
	f107:   f64,
	ap:     f64,
}

Nrlmsise_00_Output :: struct {
	d: [9]f64,
	t: [2]f64,
}

