%CSE505 Computing With Logic
%Name: Enbo Yu
%ID: 113094714
%Date: Sep 21
%HW01

%Warm-Up
%Question 01
preFix(La, []).

preFix([H|La], [H|Lb]):-
    preFix(La, Lb).

%Question 02
incsub([], []).

incsub([H|La], [H|Lb]):-
    incsub(La, Lb),
    (Lb = [];
    (Lb = [Head|_],
    H < Head)).

incsub([_|La], Lb):-
    incsub(La, Lb).

%Question 03
split(La, [], La).
split([H|La], [H|Lb], Lc) :-
    Lc = [_|_],
    split(La, Lb, Lc).

roTate([], []).

roTate(La, Lb) :-
    split(La, Aa, Ab),
    append(Ab, Aa, Lb).

%Graph Problems:
%a
edge(a, 1, 2).
edge(a, 1, 3).
edge(a, 2, 3).
edge(a, 2, 4).
edge(a, 3, 4).
edge(a, 4, 1).
%b
edge(b, 1, 2).
edge(b, 2, 3).
edge(b, 3, 4).
edge(b, 4, 5).
edge(b, 5, 6).
edge(b, 6, 1).
edge(b, 2, 5).
edge(b, 3, 6).
%Question 04
exists_path(No, [Pa, Pb|Pc]):-
    edge(No, Pa, Pb),
    (Pc = [];
    exists_path(No, [Pb|Pc])).

%Question 05
single([]).

single([A|B]):-
    \+ member(A, B),
    single(B).

exists_simple_path(No, Path):-
    single(Path),
    exists_path(No, Path).

%Question 06
simple_path(No, Start, End, [Start|[End]]):-
    edge(No, Start, End).

simple_graph(_, Start, [Start|Path1], [Start|Path1]).
simple_graph(No, Start, [Nb|Path1], Path):-
    edge(No, Na, Nb),
    \+ member(Na, [Nb|Path1]),
    simple_graph(No, Start, [Na, Nb|Path1], Path).

simple_path(No, Start, End, Path):-
    simple_graph(No, Start, [End], Path).

%Analysis of Program Traces
%Question 07
%Question 08
%Question 09
%Question 10

%Reference:
%Question03: split(),
%https://sites.google.com/site/prologsite/prolog-problems/1
%Prolog Site-1.Prolog Lists-1.17(*)split()
%-------
%Question05: single(),
%https://sites.google.com/site/prologsite/prolog-problems/1
%Prolog Site-1.Prolog Lists-1.08(*)compress()
%-------

