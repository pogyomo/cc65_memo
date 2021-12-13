cp:
	mkdir test
	cp ../neslib/lib/* test
	cp ../neslib/include/* test
	cp ../neslib/asminc/* test
	cp ../neslib/cfg/* test
	cp src/* test
	cc65 -t none --cpu 6502 -Oirs test/main.c
	ca65 -t none test/main.s
	ca65 -t none test/test.s
	ld65 -C test/nrom.cfg test/main.o test/test.o test/nes.lib -o test/main.nes

cl:
	rm -r test
