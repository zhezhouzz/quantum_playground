open Printf

let spf = sprintf

module List = struct
  include List

  let split_by sp f l =
    match
      List.fold_left
        (fun r x ->
          match r with
          | None -> Some (spf "%s" (f x))
          | Some r -> Some (spf "%s%s%s" r sp (f x)))
        None l
    with
    | None -> ""
    | Some r -> r

  let split_by_comma f l =
    match
      List.fold_left
        (fun r x ->
          match r with
          | None -> Some (spf "%s" (f x))
          | Some r -> Some (spf "%s, %s" r (f x)))
        None l
    with
    | None -> ""
    | Some r -> r
end
