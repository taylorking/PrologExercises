% 1. Seperate
seperate([A,B|REST],[A|FIRST], [B|LAST]) :- seperate(REST, FIRST, LAST).
seperate([A,B],[A],[B]).
seperate([A],[A],[]).
seperate([],[]).

appen([],[],[]).
appen([], [H|T], [H|T]).
appen([H|T], L, [H|R]) :- appen(T,L,R).

% 2. Partition
partition([], _, [], []).
partition([N|T], P, PA, PB) :- N =< P, partition(T, P, PA1, PB), append([N], PA1, PA).
partition([N|T], P, PA, PB) :- N > P, partition(T, P, PA, PB1), append([N], PB1, PB).

% 3. Quicksort
qs(N, P, R) :- partition(N, P, PA, PB), quick_sort(PA, RA), quick_sort(PB,RB), append(RA, P, R1), append(R1, RB, R).
% actually do it I'm gonna wrap this method
quick_sort([X|Rest], R) :- partition(Rest, X, PA, PB), quick_sort(PA, RA), quick_sort(PB, RB), append(RA, [X], R1), append(R1, RB, R).
quick_sort([], []).


% 4. Mini
mini([A|Rest], Min) :- is_mini(Rest, A, Min).
is_mini([A|Rest], C, Min) :- A < C, is_mini(Rest, A, Min).
is_mini([A|Rest], C, Min) :- A >= C, is_mini(Rest, C, Min).
is_mini([], C, Min) :- Min is C.


% 5. Reverse
rev([A|Rest], C) :- rev(Rest, B), append(B,[A],C).
rev([A], [A]).

keepthree([_|B],LAST) :- keepthree(B,LAST).
keepthree([A,B,C], [A,B,C]).

% 6. The append procedure seems to be called 4 times in the reverse function, I don't think this is particularly inefficient..
% If you're going to do this in java, one might do the same thing. 

rev2(X,Y) :- rev2recursive(X, [], Y).
rev2recursive([], Solution, Solution).
rev2recursive([H|T], Partial, Z) :- rev2recursive(T, [H|Partial], Z).


