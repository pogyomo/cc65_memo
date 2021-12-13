cp:
	mkdir lib
	cp libsrc/* lib
	cp include/* lib
	cp asminc/* lib
	ca65 -t none lib/graphics.s
	ca65 -t none lib/input.s
	ca65 -t none lib/crt0.s
	ca65 -t none lib/handler.s
	cp ~/../linuxbrew/.linuxbrew/share/cc65/lib/none.lib ./lib
	mv lib/none.lib lib/nes.lib
	ar65 r lib/nes.lib lib/graphics.o lib/input.o lib/crt0.o lib/handler.o
cl:
	rm -r lib
