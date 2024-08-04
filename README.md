An attempt to write a fast link checker app under 150 LOC.

~~~
$ wc -l lib.bash url* badlinks
  21 lib.bash
  28 urlcheck
  19 urlextract.rb
  56 urlextract-recursive
  24 badlinks
 148 total
~~~

Actuall LOC:

~~~
$ scc | grep ^[BR] | awk '{s+=$6} END {print s}'
118
~~~

## Usage

Run `bundle` to install the required gems. Then

    $ ./badlinks -e -l 3 http://example.com/foo/bar/

`-e` means to check external links (whose origin != `example.com`),
`-l` sets max recursion level.

A timeout for each connection is 3 seconds, see `lib.bash`.

To obtain a full list of URLs without checks:

    $ LEVEL=5 ./urlextract-recursive http://example.com

## Loicense

MIT
