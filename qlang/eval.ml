open Misc
open Lang
open Qbits

let rec eval prog ({ prob_amp; states } : Qbits.t) : Qbits.t list =
  match prog with
  | [] ->
      (* let () = *)
      (*   Printf.printf "end with %s\n" (layout_qbits { prob_amp; states }) *)
      (* in *)
      [ { prob_amp; states } ]
  | H idx :: prog ->
      if List.nth states idx then
        eval prog
          {
            prob_amp = hscale *. prob_amp;
            states = inherent (idx, false) states;
          }
        @ eval prog
            {
              prob_amp = -1.0 *. hscale *. prob_amp;
              states = inherent (idx, true) states;
            }
      else
        let l1 =
          eval prog
            {
              prob_amp = hscale *. prob_amp;
              states = inherent (idx, false) states;
            }
        in
        let l2 =
          eval prog
            {
              prob_amp = hscale *. prob_amp;
              states = inherent (idx, true) states;
            }
        in
        l1 @ l2
  | CX (idx2, idx3) :: prog ->
      if List.nth states idx2 then
        eval prog { prob_amp; states = neg_pos idx3 states }
      else eval prog { prob_amp; states }
  | X idx :: prog -> eval prog { prob_amp; states = neg_pos idx states }

let eval_measure ~(init : Qbits.t) prog : Qbits.t list =
  let () = Printf.printf "\nQuantum Circuit:\n%s\n" (layout_prog prog) in
  let () = Printf.printf "\nInit:\n%s\n" (layout_qbits init) in
  let res = eval prog init in
  let () = Printf.printf "\nMeasured:\n%s\n" (layout_qbits_tab res) in
  let res = measure res in
  let () = Printf.printf "\nMeasured & Unified:\n%s\n" (layout_qbits_tab res) in
  res
