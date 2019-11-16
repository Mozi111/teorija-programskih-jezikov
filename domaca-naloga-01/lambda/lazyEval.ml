module S = Syntax


let rec eval_exp = function
  | S.Var x -> failwith "Expected a closed term"
  | S.Int _ | S.Bool _ | S.Lambda _ | S.RecLambda _ | S.Pair _ | S.Cons _ | S.Nil as e -> e
  | S.Plus (e1, e2) ->
      let n1 = eval_int e1
      and n2 = eval_int e2
      in S.Int (n1 + n2)
  | S.Minus (e1, e2) ->
      let n1 = eval_int e1
      and n2 = eval_int e2
      in S.Int (n1 - n2)
  | S.Times (e1, e2) ->
      let n1 = eval_int e1
      and n2 = eval_int e2
      in S.Int (n1 * n2)
  | S.Equal (e1, e2) ->
      let n1 = eval_int e1
      and n2 = eval_int e2
      in S.Bool (n1 = n2)
  | S.Less (e1, e2) ->
      let n1 = eval_int e1
      and n2 = eval_int e2
      in S.Bool (n1 < n2)
  | S.Greater (e1, e2) ->
      let n1 = eval_int e1
      and n2 = eval_int e2
      in S.Bool (n1 > n2)
  | S.IfThenElse (e, e1, e2) ->
      begin match eval_exp e with
      | S.Bool true -> eval_exp e1
      | S.Bool false -> eval_exp e2
      | _ -> failwith "Boolean expected"
      end
  | S.Apply (e1, e2) ->
      let f = eval_exp e1
      in
      begin match f with
      | S.Lambda (x, e) -> eval_exp (S.subst [(x, e2)] e)
      | S.RecLambda (f, x, e) as rec_f -> eval_exp (S.subst [(f, rec_f); (x, e2)] e)
      | _ -> failwith "Function expected"
      end
  (* dodano: *)
  | S.Fst e -> 
      let v = eval_exp e
      in 
      begin match v with
      | S.Pair (v1, v2) -> v1
      | _ -> failwith "Pair expected"
      end
  | S.Snd e -> 
      let v = eval_exp e
      in 
      begin match v with
      | S.Pair (v1, v2) -> v2
      | _ -> failwith "Pair expected"
      end
  | S.Match (e, e1, x, xs, e2) -> 
      let v = eval_exp e
      in 
      begin match v with
      | S.Cons (v1, v2) -> eval_exp (S.subst [(xs, v2); (x, v1)] e2)
      | S.Nil -> eval_exp e1
      | _ -> failwith "List expected"
      end
  (* dodano: *)
and eval_int e =
  match eval_exp e with
  | S.Int n -> n
  | _ -> failwith "Integer expected"

let rec is_value = function
  | S.Int _ | S.Bool _ | S.Lambda _ | S.RecLambda _ -> true
  | S.Var _ | S.Plus _ | S.Minus _ | S.Times _ | S.Equal _ | S.Less _ | S.Greater _
  | S.IfThenElse _ | S.Apply _ -> false
  (* dodano: *)
  | S.Fst _ | S.Snd _ | S.Match _ -> false
  | S.Nil | S.Pair _ | S.Cons _ -> true 
  (* dodano: *)

let rec step = function
  | S.Var _ | S.Int _ | S.Bool _ | S.Lambda _ | S.RecLambda _ | S.Nil | S.Pair _ | S.Cons _ -> failwith "Expected a non-terminal expression"
  | S.Plus (S.Int n1, S.Int n2) -> S.Int (n1 + n2)
  | S.Plus (S.Int n1, e2) -> S.Plus (S.Int n1, step e2)
  | S.Plus (e1, e2) -> S.Plus (step e1, e2)
  | S.Minus (S.Int n1, S.Int n2) -> S.Int (n1 - n2)
  | S.Minus (S.Int n1, e2) -> S.Minus (S.Int n1, step e2)
  | S.Minus (e1, e2) -> S.Minus (step e1, e2)
  | S.Times (S.Int n1, S.Int n2) -> S.Int (n1 * n2)
  | S.Times (S.Int n1, e2) -> S.Times (S.Int n1, step e2)
  | S.Times (e1, e2) -> S.Times (step e1, e2)
  | S.Equal (S.Int n1, S.Int n2) -> S.Bool (n1 = n2)
  | S.Equal (S.Int n1, e2) -> S.Equal (S.Int n1, step e2)
  | S.Equal (e1, e2) -> S.Equal (step e1, e2)
  | S.Less (S.Int n1, S.Int n2) -> S.Bool (n1 < n2)
  | S.Less (S.Int n1, e2) -> S.Less (S.Int n1, step e2)
  | S.Less (e1, e2) -> S.Less (step e1, e2)
  | S.Greater (S.Int n1, S.Int n2) -> S.Bool (n1 > n2)
  | S.Greater (S.Int n1, e2) -> S.Greater (S.Int n1, step e2)
  | S.Greater (e1, e2) -> S.Greater (step e1, e2)
  | S.IfThenElse (S.Bool b, e1, e2) -> if b then e1 else e2
  | S.IfThenElse (e, e1, e2) -> S.IfThenElse (step e, e1, e2)
  | S.Apply (S.Lambda (x, e), e2) -> S.subst [(x, e2)] e
  | S.Apply (S.RecLambda (f, x, e) as rec_f, e2) -> S.subst [(f, rec_f); (x, e2)] e
  | S.Apply (e1, e2) -> S.Apply (step e1, e2)
  (* dodano: *)
  | S.Fst v when is_value v ->
      begin match v with
      | S.Pair (v1, v2) -> v1
      | _ -> failwith "Pair expected"
      end
  | S.Fst e -> S.Fst (step e)
  | S.Snd v when is_value v ->
      begin match v with
      | S.Pair (v1, v2) -> v2
      | _ -> failwith "Pair expected"
      end
  | S.Snd e -> S.Snd (step e)
  | S.Match (v, e1, x, xs, e2) when is_value v ->
      begin match v with
      | S.Nil -> e1
      | S.Cons (v1, v2) -> S.subst [(xs, v2); (x, v1)] e2
      | _ -> failwith "List expected"
      end
  | S.Match (e, e1, x, xs, e2) -> S.Match (step e, e1, x, xs, e2)
  (* dodano: *)

let big_step e =
  let v = eval_exp e in
  print_endline (S.string_of_exp v)

let rec small_step e =
  print_endline (S.string_of_exp e);
  if not (is_value e) then
    (print_endline "  ~>";
    small_step (step e))
