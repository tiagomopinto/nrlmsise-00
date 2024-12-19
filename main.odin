package main

import "core:c"
import "core:fmt"
import atm "nrlmsise-00"

main :: proc() {

	nrlmsise := atm.make_nrlmsise_00("sw-all.txt")

	defer atm.free_nrlmsise_00(&nrlmsise)

	date := atm.Date{2024, 1, 1}

	nrlmsise.input.year = c.int(date.year)
	nrlmsise.input.doy = c.int(1)
	nrlmsise.input.sec = 3600.0
	nrlmsise.input.alt = 0.1 // km
	nrlmsise.input.g_lat = 41.0 // deg
	nrlmsise.input.g_long = -8.0 // deg
	nrlmsise.input.lst = nrlmsise.input.sec / 3600.0 + nrlmsise.input.g_long / 15.0

	if nrlmsise.input.alt < 80.0 {

		nrlmsise.input.f107A = 150.0
		nrlmsise.input.f107 = 150.0
		nrlmsise.input.ap = 4.0

	} else {

		nrlmsise.input.f107A = nrlmsise.space_weather_map[date].f107A
		nrlmsise.input.f107 = nrlmsise.space_weather_map[date].f107
		nrlmsise.input.ap = nrlmsise.space_weather_map[date].ap
	}

	atm.get_atmosphere(nrlmsise)

	density := nrlmsise.output.d[5]

	fmt.printfln("Density (kg/m^3): %.6f", density)
}

