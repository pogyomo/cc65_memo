cp:
	mkdir lib
	cp src/* lib
	cp inc/* lib
	ca65 -t none lib/graphics.s
	cp ~/../linuxbrew/.linuxbrew/share/cc65/lib/none.lib ./lib
	mv lib/none.lib lib/nes.lib
	ar65 r lib/nes.lib lib/graphics.o
cl:
	rm -r lib
