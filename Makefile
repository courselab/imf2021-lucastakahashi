all: decode

decode: decode.o libcypher.so libcrack.so
	gcc -m32 decode.o -Wl,-rpath='$$ORIGIN' -L. -lcrack -lcypher -o $@

libcrack.so: unlock.o change.o
	gcc -m32 -shared $^ -o $@

unlock.o: unlock.c
	gcc -m32 -c $^

change.o: change.S
	gcc -m32 -c $^

.PHONY: clean dist

clean:
	rm -rf unlock.o libcrack.so decode change.o

dist: tar zcvf decode.tar.gz Makefile change.S unlock.c decode.o libcypher.so
