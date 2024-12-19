#+private

package nrlmsise_00

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

Space_Weather :: struct {
	f107A: f64,
	f107:  f64,
	ap:    f64,
}

make_space_weather_map :: proc(nrlmsise: ^Nrlmsise_00_Context, space_weather_filename: string) {

	defer free_all(context.temp_allocator)

	file_raw, ok := os.read_entire_file(space_weather_filename, context.temp_allocator)

	if !ok {

		fmt.println("ERROR: Problem reading SW file in make_space_weather_map().")
		os.exit(1)
	}

	file_string := string(file_raw)

	words_filtered := make([dynamic]string, context.temp_allocator)

	for line in strings.split_lines_iterator(&file_string) {

		if len(line) > 0 {

			if line[0] == '1' || line[0] == '2' {

				words := strings.split(line, " ", context.temp_allocator)

				clear(&words_filtered)

				for word in words { 	// loop to filter out empty strings

					if len(word) != 0 {

						append(&words_filtered, word)
					}
				}

				if len(words_filtered) > 12 { 	// if data is daily observerd or daily predicted

					date: Date
					sw: Space_Weather
					err: int

					date.year, ok = strconv.parse_int(words_filtered[0])
					if !ok {err += 1}
					date.month, ok = strconv.parse_int(words_filtered[1])
					if !ok {err += 1}
					date.day, ok = strconv.parse_int(words_filtered[2])
					if !ok {err += 1}
					sw.ap, ok = strconv.parse_f64(words_filtered[23])
					if !ok {err += 1}
					sw.f107, ok = strconv.parse_f64(words_filtered[len(words_filtered) - 3])
					if !ok {err += 1}
					sw.f107A, ok = strconv.parse_f64(words_filtered[len(words_filtered) - 2])
					if !ok {err += 1}

					if err != 0 {

						fmt.println(
							"ERROR: Problem reading SW param %s in make_space_weather_map().",
							err,
						)
						os.exit(1)
					}

					nrlmsise.space_weather_map[date] = sw
				}
			}
		}
	}

	return
}

