CFLAGS= -O3 -Wall -funroll-loops
CC= gcc
LDLIBS= -lpng
SOURCES_LIB= printer.c pbm2eps9.c
OBJ= printer.o pbm2eps9.o


all: depend pbm2png pbm2eps9

pbm2png: pbm2png.c
	${CC} ${CFLAGS} -s -o $@ $< ${LDLIBS}

pbm2eps9: ${OBJ}
	${CC} -s -o pbm2eps9 ${OBJ}

%.o: %.c
	${CC} ${CFLAGS} -c -o $@ $<

depend:
	${CC} -MM ${SOURCES_LIB} > .depend

-include .depend

clean:
	rm ${OBJ} pbm2png pbm2eps9

.PHONY: clean depend all
