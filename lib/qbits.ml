open Misc

(* module QbitsHash = struct *)
(*   type t = bool list *)

(*   let rec hash = function *)
(*     | [] -> 0 *)
(*     | h :: t -> if h then 1 + (2 * hash t) else 2 * hash t *)

(*   let equal l1 l2 = hash l1 == hash l2 *)
(* end *)

(* module Hashtbl = Hashtbl.Make (QbitsHash) *)

type t = { prob_amp : float; states : bool list }

let hscale : float = 0.7071067811865

let inherent (idx, b) state =
  List.mapi (fun idx' x -> if idx == idx' then b else x) state

let neg_pos idx state =
  List.mapi (fun idx' b -> if idx == idx' then not b else b) state

let measure qbits_tab =
  let htab = Hashtbl.create (List.length qbits_tab) in
  let () =
    List.iter
      (fun { prob_amp; states } ->
        match Hashtbl.find_opt htab states with
        | None -> Hashtbl.add htab states prob_amp
        | Some prob_amp' -> Hashtbl.replace htab states (prob_amp +. prob_amp'))
      qbits_tab
  in
  List.map (fun (states, prob_amp) -> { prob_amp; states })
  @@ List.of_seq @@ Hashtbl.to_seq htab

let low_filter l =
  List.filter (fun { prob_amp; _ } -> abs_float prob_amp > 0.00001) l

let layout_prob_amp p = if p >= 0.0 then spf "+%.2f" p else spf "%.2f" p

let layout_qbits { prob_amp; states } =
  (* let prob_amp = spf "%.2f" prob_amp in *)
  (* let prob_amp = *)
  (*   let len = max 0 @@ (5 - String.length prob_amp) in *)
  (*   String.init len (fun _ -> ' ') ^ prob_amp *)
  (* in *)
  spf "%s|%s〉" (layout_prob_amp prob_amp)
    (List.split_by "" (fun b -> if b then "1" else "0") states)

let layout_qbits_tab l = List.split_by "\n" layout_qbits (low_filter l)
