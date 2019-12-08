## Naloga 1

Preverite, ali so sledeče konstrukcije domene ($\leq$ je standardna ureditev na $\mathbb{R}$).

1. $((0,1), \leq)$
2. $([0,1], \leq)$
3. $([0,1) \cup (2,3], \leq)$
4. $([0,1) \cup [2,3], \leq)$


## Naloga 2

Naj bo $\leq$ standardna ureditev na $\mathbb{N}$. Definirajte relacijo $\lessdot$ na množici $\mathbb{N} \to \mathbb{N}$ kot

$$f \lessdot g  \iff \forall n \in \mathbb{N}. f(n) \leq g(n).$$

Je $(\mathbb{N} \to \mathbb{N}, \lessdot)$ delno urejena množica? Je domena?


## Naloga 3

Naj bo $P$ končna delno urejena množica z najmanjšim elementom. Naj bo $D$ poljubna domena.

1. Pokažite, da je $P$ domena.
2. Dokažite, da je funkcija iz $P \to D$ zvezna natanko tedaj ko je monotona
3. Ali to velja tudi za $\mathbb{N}$? Kaj pa za $\mathbb{N}_\bot$ s plosko urejenostjo?

## Naloga 4

Premislite, kako bi za podani domeni $(D_1, \leq_1)$ in $(D_1, \leq_2)$ skonstruirali domeno za produkt $D_1 \times D_2$ in vsoto $D_1 + D_2$. Premislite katere od možnosti bi bile primerne za modeliranje parov in vsot v neučakani oz. leni semantiki.

## Naloga 5

Operator $+_{\bot}$ definiramo kot:

$$ x +_{\bot} y = \begin{cases} 
  \bot & x = \bot \vee  y=\bot \\
  x + y & \text{sicer}
\end{cases}$$

Izračunajte najmanjši fiksni točki funkcij $F, G: [\mathbb{N}_\bot \to \mathbb{N}_\bot] \to [\mathbb{N}_\bot \to \mathbb{N}_\bot]$

$$ F(f)(n) = \begin{cases} 
  \bot & n = \bot \\
  0 & n = 0 \\
  (2n-1) +_\bot f(n) & n > 0
\end{cases} $$

$$ G(f)(n) = \begin{cases} 
  \bot & n = \bot \\
  0 & n = 0 \\
  (2n-1) +_\bot f(n-1) & n > 0
\end{cases} $$

## Naloga 6

Naj bo $\mathbb{T} = \{tt, ff\}$ in $F : [\mathbb{N}_\bot \to \mathbb{T}_\bot] \to [\mathbb{N}_\bot \to \mathbb{T}_\bot]$,

$$ F(f)(n) = \begin{cases} 
  \bot & n = \bot \\
  f(n+2) & n = 0 \\
  tt & n = 1 \\
  f(n-2) & n \geq 0
\end{cases} $$

Izračunajte najmanjšo fiksno točko $F$.

## Naloga 7

Naj bo $D$ domena. Predpostavite, da za zaporedje $(x_{i,j})_{i,j\geq0}$ velja $x_{i,j} \leq x_{i', j'}$ kadar $i \leq i'$ in $j \leq j'$. 

Pokažite, da velja
$$ \bigvee_i (\bigvee_j x_{i,j}) = \bigvee_i x_{i,i} $$