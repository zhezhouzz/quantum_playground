open Misc

type t = H of int | X of int | CX of int * int

let layout = function
  | H idx -> spf "H %i" idx
  | X idx -> spf "X %i" idx
  | CX (idx1, idx2) -> spf "CX %i %i" idx1 idx2

let layout_prog = List.split_by ";\n" layout
