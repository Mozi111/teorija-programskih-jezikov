## Naloga 1

Izpeljite semantiko naslednjih programov:

1. `|- fun x -> if x < 0 then 0 else 2 * x : int -> int`
2. `|- fun x -> (fun y -> x > y) : int -> int -> bool`

Preverite, da je pomen sledečega program enak pomenu programa 1.

`|- fun a -> (fun y -> if y > 0 then y else 0) (a + a) : int -> int`

## Naloga 2

Denotacijsko semantiko dopolnite za pare in vsote in izpeljite pomen programa:

`|- Fst (Inl 2, false): int + (bool * bool)` 

## Naloga 3

Definirajte denotacijsko semantiko za jezik IMP brez zanke while. Predpostavimo, da imamo fiksno množico vseh lokacij $Loc$. Stanje lokacij predstavimo s funkcijo $s$ tipa $State := Loc \to \mathbb{Z}$.

Pomen izrazov modelirajte kot:
  - (aritmetični izrazi) $[[e]] : State \to \mathbb{Z}$,
  - (logični izrazi) $[[b]] : State \to \{tt,ff\}$
  - (ukazi) $[[c]] : State \to State$

Premislite, zakaj smo izpustili zanko while.