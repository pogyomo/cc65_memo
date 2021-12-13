cp:
	mkdir test
	cp cfg/* test
	cp inc/* test
	cp src/* test
	cp ../neslib/lib/* test
	cp ../neslib/inc/* test
	cc65 -t none --cpu 6502 -Oirs test/main.c
	ca65 -t none test/main.s
	ca65 -t none test/crt0.s
	ld65 -C test/nrom.cfg test/main.o test/crt0.o test/nes.lib -o test/main.nes

cl:
	rm -r test
