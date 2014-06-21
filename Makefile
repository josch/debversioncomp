testinput: run.py
	./run.py > testinput

testdpkg: testdpkg.c
	gcc testdpkg.c -ldpkg -o testdpkg

testapt: testapt.cc
	g++ testapt.cc -lapt-pkg -o testapt

testdose: testdose.ml
	ocamlfind ocamlc -package dose3 -linkpkg testdose.ml -o testdose

.PHONY: test
test: testinput testdpkg testapt
	./rundpkg.sh < testinput | md5sum
	./testapt < testinput | md5sum
	./testdose < testinput | md5sum

.PHONY: clean
clean:
	rm -f testapt testdose testdose.cmi testdose.cmo testdpkg testinput
