# NRLMSISE-00 Empirical Atmospheric Model

*C bindings for Odin Programming Language*

This package binds the C source code from Prof. Dr. Dominik Brodowski that can be found in his [website](https://www.brodo.de/space/nrlmsise/).

The binding requires a static library (`.a` on Linux/MacOS or `.lib` on Windows) compiled into `bin` directory.

## Space Weather Data

This model requires three parameters from space weather:

- 81-day average F10.7 flux
- Daily average F10.7 flux
- Daily magnetic index (Ap)

These can be found in [Celestrak](https://celestrak.org/SpaceData/) database that is published daily.

Space weather data since 1957 is imported from the `sw-all.txt` file.

## Compilation

Run `make` or `make all` to compile everything from scratch.

Run `make wmm` to compile the `wmm.a` only into the `bin` directory. Update the Makefile to compile a `.lib` file if you are working on Windows.

## License

This project is licensed under the MIT Open Source License.
