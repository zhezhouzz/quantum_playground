(* open Lang *)
open Qbits

(* let prog1 = [ H 0; H 1 ];; *)

(* let prog1 = [ H 0; H 1; CX (0, 2); CX (0, 3); CX (1, 2); CX (1, 3); H 0; H 1 ] *)

open Core

let regular_file =
  Command.Arg_type.create (fun filename ->
      match Sys_unix.is_file filename with
      | `Yes -> filename
      | `No -> failwith "Not a regular file"
      | `Unknown -> failwith "Could not determine if this was a regular file")

let run_qc =
  Command.basic ~summary:"init"
    Command.Let_syntax.(
      let%map_open source_file = anon ("source file" %: regular_file) in
      fun () ->
        let init, prog = Parse.parse source_file in
        let _ =
          Eval.eval_measure ~init:{ prob_amp = 1.0; states = init } prog
        in
        ())

let test = Command.group ~summary:"run quantum circuit" [ ("run-qc", run_qc) ]
let () = Command_unix.run test
