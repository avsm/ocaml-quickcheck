
module Random = struct

  include Random
  let int n = int (max n 1)
  let char lim =
    let l = Char.code lim in
    let i = int l in
    Char.chr i
  let int_range (lo, hi) =
    lo + int (hi-lo)
  let int32_range (lo, hi) =
    Int32.add lo (int32 (Int32.sub hi lo))
  let int64_range (lo, hi) =
    Int64.add lo (int64 (Int64.sub hi lo))
  let nativeint_range (lo, hi) =
    Nativeint.add lo (nativeint (Nativeint.sub hi lo))
  let float_range (lo, hi) =
    lo +. float (hi -. lo)
  let char_range (lo, hi) =
    let lo' = Char.code lo and hi' = Char.code hi in
    let i = int_range (lo', hi') in
    Char.chr i

end


module List = struct
  include List

  let rec span p l = match l with
    | [] -> [],[]
    | x::xs when p x ->
      let ys,zs = span p xs in
      (x::ys,zs)
    | xs -> [],xs

  let rec group_by p l = match l with
    | [] -> []
    | x::xs ->
      let ys,zs = span (p x) xs in
      (x::ys) :: group_by p zs

  let group xs = group_by (=) xs

end

let list_to_string l =
  let len = List.length l in
  let s = String.create len in
  let i = ref 0 in
  List.iter (fun c -> s.[!i] <- c; incr i) l; s

let ( |> ) x f = f x
let ( <| ) f x = f x
