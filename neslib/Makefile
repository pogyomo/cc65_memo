cp:
	mkdir lib
	cp src/* lib
	cp inc/* lib
	ca65 -t none lib/graphics.s
	ar65 r lib/nes.lib lib/graphics.o
