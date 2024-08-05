An attempt to write a fast link checker under 150 LOC.

~~~
$ wc -l lib.bash url* badlinks
  21 lib.bash
  28 urlcheck
  19 urlextract.rb
  56 urlextract-recursive
  25 badlinks
 149 total
~~~

Actuall LOC:

~~~
$ scc | grep ^[BR] | awk '{s+=$6} END {print s}'
119
~~~

## Usage

Run `bundle` to install the required gems. Then

    $ ./badlinks -e -l 3 http://example.com/foo/bar/

`-e` means to check external links (whose origin != `example.com`),
`-l` sets max recursion level.

A timeout for each connection is 3 seconds, use `-t sec` to change.

To obtain a full list of URLs without checks:

    $ LEVEL=3 ./urlextract-recursive http://example.com/foo/bar

Then process it with awk+urlcheck (this is what *badlinks* wrapper
does).

## &#x2672; Loicense

MIT
