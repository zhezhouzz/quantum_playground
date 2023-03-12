# quantum_playground

## Build

### Docker

    $ docker pull poirot23/quantum:pg1
    $ docker run -it -m="6g" poirot23/quantum:pg1

### Local

Install [opam](https://opam.ocaml.org/doc/Install.html) and ocaml >= `4.12`. For example, OCaml 5.0:

    $ opam switch 5.0.0

## Run

    $ dune exec -- bin/main.exe

## Language

```
Index ::= int
Gate ::= H Index | X Index | CX Index Index
Prog ::=
    | Gate
    | Gate ; Prog
```

Now we provides `3` [Quantum logic gate](https://en.wikipedia.org/wiki/Quantum_logic_gate):
- X (Pauli-X)
- CX (Controlled Not)
- H (Hadamard)
