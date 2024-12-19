ODIN_FLAGS := -o:aggressive -microarch:native -no-bounds-check -disable-assert -no-type-assert -vet
CC_FLAGS := -Wall -Wextra -pedantic -std=c99 -O3

.PHONY : all run clean

all: nrlmsise bin/atmos

bin/atmos : main.odin nrlmsise-00/*.odin
	odin build main.odin -file $(ODIN_FLAGS) -out:$@

nrlmsise : bin/nrlmsise-00.a

bin/%.a : bin/nrlmsise-00.o bin/nrlmsise-00_data.o
	ar rcs $@ $^

bin/%.o : nrlmsise-00_c/%.c | bin
	gcc $(CC_FLAGS) -c $^ -o $@

bin:
	@mkdir -p bin

run :
	@ bin/atmos

clean :
	@rm -rf bin
