testinput: run.py
	./run.py /var/lib/apt/lists/ftp.debian.org_debian_dists_sid_main_binary-amd64_Packages > testinput

testinput.1000: run.py
	./run.py /var/lib/apt/lists/ftp.debian.org_debian_dists_sid_main_binary-amd64_Packages | awk 'NR % 1000 == 1' > testinput.1000

testinput.unequal: testinput inequalityfilter
	./inequalityfilter < testinput > testinput.unequal

testinput.unequal.1000: testinput inequalityfilter
	./inequalityfilter < testinput | awk 'NR % 1000 == 1' > testinput.unequal.1000

testdpkg: testdpkg.c
	gcc testdpkg.c -ldpkg -o testdpkg

testapt: testapt.cc
	g++ testapt.cc -lapt-pkg -o testapt

testdose: testdose.ml
	ocamlfind ocamlc -package dose3 -linkpkg testdose.ml -o testdose

inequalityfilter: inequalityfilter.cc
	g++ inequalityfilter.cc -lapt-pkg -o inequalityfilter

.PHONY: test
test: testinput testdpkg testapt testdose rundpkg.sh
	./rundpkg.sh < testinput | md5sum
	./testapt < testinput | md5sum
	./testdose < testinput | md5sum

.PHONY: test.1000
test.1000: testinput.1000 testdpkg testapt testdose rundpkg.sh
	./rundpkg.sh < testinput.1000 | md5sum
	./testapt < testinput.1000 | md5sum
	./testdose < testinput.1000 | md5sum

.PHONY: testsort
testsort: testinput.unequal testapt testsort.sh
	./testapt < testinput.unequal | md5sum
	./testsort.sh < testinput.unequal | md5sum

.PHONY: testsort.1000
testsort.1000: testinput.unequal.1000 testapt testsort.sh
	./testapt < testinput.unequal.1000 | md5sum
	./testsort.sh < testinput.unequal.1000 | md5sum

.PHONY: clean
clean:
	rm -f testapt testdose testdose.cmi testdose.cmo testdpkg testinput inequalityfilter
