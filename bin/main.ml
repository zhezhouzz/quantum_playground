open Lang
open Qbits

(* let prog1 = [ H 0; H 1 ];; *)

let prog1 = [ H 0; H 1; CX (0, 2); CX (0, 3); CX (1, 2); CX (1, 3); H 0; H 1 ];;

Eval.eval_measure
  ~init:{ prob_amp = 1.0; states = [ false; false; false; false ] }
  prog1
