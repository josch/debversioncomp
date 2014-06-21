This is to test the several implementations of Debian version comparison
algorithms.

Run it via `make test`.

`run.py` generates a file containing all permutations of pairs of versions. The
different programs then check whether versions are greater than, equal or less
than one another and output >, = and <, respectively in order. It is then
checked whether the output of all implementations is the same.
