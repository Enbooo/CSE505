%CSE505 Computing With Logic
%Name: Enbo Yu
%ID: 113094714
%Date: Sep 21(X)---> SEP 28(late submission used)
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
%Question 07-10
%Input example:
%Question07
%invalid_access([malloc(p1),malloc(p2),free(p1),read_(p3)],p3). % true
%invalid_access([malloc(p1),malloc(p2),free(p1),read_(p3)],p1). % false
%Question 08
%memory_safe([malloc(p1),malloc(p1),free(p1),read_(p3)],p1). %true
%memory_safe([malloc(p1), free(p1),free(p1),read_(p3)],p1). %false
%Question 09
%leak([malloc(p1),malloc(p3), malloc(p1),read_(p3)],p1).  %true
%leak([malloc(p1),malloc(p3),free(p1),read_(p3)],p3).     %false
%Question 10
%useful_writes([malloc(p1),write_(p1),read_(p1),free(p1)],p1).  %true
%useful_writes([malloc(p1),write_(p1), malloc(p1)],p1).     %false

%Apache
score([read_(P1)|T], A, B, P2) :-
    P1 \= P2,
    score(T, A, B, P2).
score([write_(P1)|T], A, B, P2) :-
    P1 \= P2,
    score(T, A, B, P2).
score([malloc(P1)|T], A, B, P2) :-
    P1 \= P2,
    score(T, A, B, P2).
score([free(P1)|T], A, B, P2) :-
    P1 \= P2,
    score(T, A, B, P2).

%Swift
score(_, -1, -1, _).
score(_, -2, -2, _).
score(_, -3, -3, _).
score(_, -4, -4, _).
score(_, -5, -5, _).
score([], A, A, _).

my_rev([H|T], A, R) :- my_rev(T, [H|A], R).
my_rev([], A, A).
my_rev(L, R) :- my_rev(L, [], R).
%---------backtracking

%score
score(T, A, P) :- score(T, A, 0, P).

score([write_(P)|T], A, 1, P) :-
    score(T, A, 2, P).

score(T, A, -3, P) :-
    score(T, A, 1, P).
score(T, A, -4, P) :-
    score(T, A, 1, P).
score(T, A, -5, P) :-
    score(T, A, 0, P).

%---main---

invalid_access(T, P) :- score(T, -1, P).


memory_safe(T, P) :- not(invalid_access(T, P)), not(no_free(T, P)).
no_free(T, P) :- score(T, -2, P).
leak(T, P) :- score(T, -3, P) ; score(T, -4, P).
useful_writes(T, P) :- not(score(T, -4, P)), not(score(T, -5, P)).


score(T, A, P) :- score(T, A, 0, P).


score(_, -1, -1, _).
score(_, -2, -2, _).
score(_, -3, -3, _).
score(_, -4, -4, _).
score(_, -5, -5, _).
score([], A, A, _).


score([read_(P1)|T], A, B, P2) :-
    P1 \= P2,
    score(T, A, B, P2).
score([write_(P1)|T], A, B, P2) :-
    P1 \= P2,
    score(T, A, B, P2).
score([malloc(P1)|T], A, B, P2) :-
    P1 \= P2,
    score(T, A, B, P2).
score([free(P1)|T], A, B, P2) :-
    P1 \= P2,
    score(T, A, B, P2).


score([write_(P)|T], A, 0, P) :-
    score(T, A, -1, P).
score([read_(P)|T], A, 0, P) :-
    score(T, A, -1, P).
score([free(P)|T], A, 0, P) :-
    score(T, A, -2, P).
score([malloc(P)|T], A, 0, P) :-
    score(T, A, 1, P).


score([_|T], A, -1, P) :-
    score(T, A, -1, P).


score([write_(P)|T], A, -2, P) :-
    score(T, A, -1, P).
score([read_(P)|T], A, -2, P) :-
    score(T, A, -1, P).
score([free(P)|T], A, -2, P) :-
    score(T, A, -2, P).
score([malloc(P)|T], A, -2, P) :-
    score(T, A, 1, P).


score([write_(P)|T], A, 1, P) :-
    score(T, A, 2, P).
score([read_(P)|T], A, 1, P) :-
    score(T, A, 1, P).
score([free(P)|T], A, 1, P) :-
    score(T, A, 0, P).
score([malloc(P)|T], A, 1, P) :-
    score(T, A, -3, P).


score([write_(P)|T], A, 2, P) :-
    score(T, A, 2, P).
score([read_(P)|T], A, 2, P) :-
    score(T, A, 3, P).
score([free(P)|T], A, 2, P) :-
    score(T, A, -5, P).
score([malloc(P)|T], A, 2, P) :-
    score(T, A, -4, P).

score([write_(P)|T], A, 3, P) :-
    score(T, A, 2, P).
score([read_(P)|T], A, 3, P) :-
    score(T, A, 3, P).
score([free(P)|T], A, 3, P) :-
    score(T, A, 0, P).
score([malloc(P)|T], A, 3, P) :-
    score(T, A, -3, P).

score(T, A, -3, P) :-
    score(T, A, 1, P).
score(T, A, -4, P) :-
    score(T, A, 1, P).
score(T, A, -5, P) :-
    score(T, A, 0, P).

%Reference:
%Question03: split(),
%https://sites.google.com/site/prologsite/prolog-problems/1
%Prolog Site-1.Prolog Lists-1.17(*)split()
%-------
%Question05: single(),
%https://sites.google.com/site/prologsite/prolog-problems/1
%Prolog Site-1.Prolog Lists-1.08(*)compress()
%-------
%Projog:
%http://projog.org/prolog-predicates.html
%-------
%Idea of Graphs Part:
%https://sites.google.com/site/prologsite/prolog-problems/6
%-------

