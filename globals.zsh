#!/usr/bin/zsh

compile_and_draw() {
  name=$1
  fstcompile --isymbols=$SYMBOLS --osymbols=$SYMBOLS $name.txt $name.fst
  draw $name
}

draw() {
  name=$1
  fstdraw --isymbols=$SYMBOLS --osymbols=$SYMBOLS --acceptor $name.fst \
    | dot -Tps \
    > output/$name.ps
  ps2pdf -dEPSCrop output/$name.ps output/$name.pdf
}

epsdetmin() {
  fst=$1
  cat $fst.fst \
    | fstrmepsilon \
    | fstdeterminize \
    | fstminimize \
    > $fst.min.fst
}
