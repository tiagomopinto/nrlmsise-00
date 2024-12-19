package nrlmsise_00

Nrlmsise_00_Context :: struct {
	flags:             Flags,
	input:             Nrlmsise_00_Input,
	output:            Nrlmsise_00_Output,
	space_weather_map: map[Date]Space_Weather,
}

Date :: struct {
	year:  int,
	month: int,
	day:   int,
}

get_atmosphere :: proc(nrlmsise00: ^Nrlmsise_00_Context) {

	nrlmsise_00_gtd7(&nrlmsise00.input, &nrlmsise00.flags, &nrlmsise00.output)
}

make_nrlmsise_00 :: proc(space_weather_filename: string) -> (nrlmsise: ^Nrlmsise_00_Context) {

	nrlmsise = new(Nrlmsise_00_Context)

	assert(
		nrlmsise != nil,
		"Memory allocation failed for nrlmsise00_context in nrlmsise00_make().",
	)

	make_space_weather_map(nrlmsise, space_weather_filename)

	for i in 0 ..< 24 {

		nrlmsise.flags.switches[i] = 1
	}

	return
}

free_nrlmsise_00 :: proc(nrlmsise: ^^Nrlmsise_00_Context) {

	delete(nrlmsise^^.space_weather_map)

	free(nrlmsise^)

	nrlmsise^ = nil
}

