# quantum_playground

## Build

### Docker

    $ docker pull poirot23/quantum:pg1
    $ docker run -it -m="6g" poirot23/quantum:pg1

### Local

Install [opam](https://opam.ocaml.org/doc/Install.html) and ocaml >= `4.12`. For example, OCaml 5.0:

    $ opam switch 5.0.0
    $ opam install ocolor.1.3.0
    $ opam install core.v0.15.1 core_unix.v0.15.2 menhirLib.20220210 menhir.20220210

## Run

    $ dune exec -- bin/main.exe run-qc SOURCE_FILE

For example:

    & dune exec -- bin/main.exe run-qc data/simon.qc

## Language

```
Index ::= int
Gate ::= H Index | X Index | CX Index Index
Gates := Gate | Gate ; Gates
Prog ::= [0|1]* Gates
```

Now we provide `3` [Quantum logic gate](https://en.wikipedia.org/wiki/Quantum_logic_gate):
- X (Pauli-X)
- CX (Controlled Not)
- H (Hadamard)
