(* open Language *)
open Past
open Misc

let to_qgate = function
  | H idx -> Lang.H idx
  | X idx -> Lang.X idx
  | CX (idx1, idx2) -> Lang.CX (idx1, idx2)

let layout_statement s = Lang.layout @@ to_qgate s
let layout_prog sts = List.split_by "\n" layout_statement sts

let layout_position (p : Lexing.position) =
  let open Lexing in
  spf "At line %i, offset %i: syntax error" p.pos_lnum (p.pos_cnum - p.pos_bol)

let parse_ linebuf =
  try Parser.prog_eof Lexer.next_token linebuf with
  | Lexer.LexError msg -> raise @@ failwith (Printf.sprintf "%s%!" msg)
  | Parser.Error ->
      raise @@ failwith (layout_position @@ Lexing.lexeme_end_p linebuf)

let mk_init init =
  List.map
    (fun i ->
      match i with
      | 0 -> false
      | 1 -> true
      | _ -> failwith "wrong init qbits: must be 0 or 1")
    init

let parse filename =
  let oc = open_in filename in
  let linebuf = Lexing.from_channel oc in
  let init, res = parse_ linebuf in
  close_in oc;
  (mk_init init, List.map (fun s -> to_qgate s.x) res)

let parse_string str = parse_ @@ Lexing.from_string str
