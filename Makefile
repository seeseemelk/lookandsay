SRC := $(shell find source -type f) Makefile dub.sdl

lookandsay.benchmark: $(SRC)
	dub build --compiler=ldc --build=release-nobounds
	cp --reflink=never -f lookandsay lookandsay.benchmark

benchmark: lookandsay.benchmark
	./$< | pv -btap | sha256sum
