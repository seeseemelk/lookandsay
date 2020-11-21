lookandsay: source/lookandsay.d
	dub build --compiler=ldc --build=release-nobounds

benchmark: lookandsay
	./lookandsay | pv | sha256sum
