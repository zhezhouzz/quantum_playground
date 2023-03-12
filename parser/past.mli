type 'a loc = { x : 'a; loc : Lexing.position }
type gate = H of int | CX of (int * int) | X of int
type term = gate loc list
type prog = int list * term
