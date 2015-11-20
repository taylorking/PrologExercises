
% Taylor King


% define the parameters of the river

% the east is the opposite side of the river from the west
opposite(e,w).

% the west is the opposite side of the river from the east
opposite(w,e).



% define possible moves
% the farmer moves accross the river by himself
move([F1,W,G,C],[F2,W,G,C]) :- opposite(F1,F2),safe([F2,W,G,C]).

% the farmer takes the wolf accross the river
move([S1,S1,G,C],[S2,S2,G,C]) :- opposite(S1,S2),safe([S2,S2,G,C]).

% the farmer takes the goat accross the river
move([S1,W,S1,C],[S2,W,S2,C]) :- opposite(S1,S2),safe([S2,W,S2,C]).

% the farmer takes the cabbage accross the river
move([S1,W,G,S1],[S2,W,G,S2]) :- opposite(S1,S2),safe([S2,W,G,S2]).



% The state is safe if it is not unsafe 
safe([F,W,G,C]) :- \+(unsafe([F,W,G,C])).

% The state is unsafe if the wolf is next to the goat while the farmer is in a different place
unsafe([S1,S2,S2,_]) :- opposite(S1,S2).

% the state is unsafe becasuse the goat and the cabbage are in the same place 
% while the farmer is in a different place
unsafe([S1,_,S2,S2]) :- opposite(S1,S2).

% all of the actors in this problem must be on the west side of the river
solution([[w,w,w,w]]).

% you must be able to make all of the moves in the solution
solution([State1, State2 | Tail]) :- move(State1, State2), solution([State2|Tail]).

% start the game. All of the actors start on the east, we feed it a state list, if we find a solution, don't keep trying for more.
puzzle([Start|StateList]) :- Start = [e,e,e,e], length(StateList,L), L<8, solution([Start|StateList]) ,!, append([Start],StateList, R), printSolution(R).

printSolution([X|Y]):- write('Start: '), writeLocation(X), printMoves([X|Y]), write('Solved \n').
writeLocation(X) :- getList(X, e, E), getList(X, w, W), write('East: '), writeList(E),
        write(' West: '), writeList(W), write('\n').
printMoves([R]).
printMoves([X,Y|Z]) :- X = [A,B,C,D], Y = [E, B, C, D], opposite(A, E), write('Farmer takes self. '), writeLocation(Y), printMoves([Y|Z]).

printMoves([X,Y|Z]) :- X = [A,A,C,D], Y = [E, E, C, D], opposite(A, E), write('Farmer takes wolf. '), writeLocation(Y), printMoves([Y|Z]).

printMoves([X,Y|Z]) :- X = [A,B,A,D], Y = [E, B, E, D], opposite(A, E), write('Farmer takes goat. '), writeLocation(Y), printMoves([Y|Z]).

printMoves([X,Y|Z]) :- X = [A,B,C,A], Y = [E, B, C, E], opposite(A, E), write('Farmer takes cabbage. '), writeLocation(Y), printMoves([Y|Z]).
character(X, 'cabbage') :- length(X, 0).
character(X, 'goat') :- length(X, 1).
character(X, 'wolf') :- length(X, 2).
character(X, 'farmer') :- length(X,3).
writeList([]).
writeList([R|P]):- length(P, T), T > 0, write(R), write(', '), writeList(P). 
writeList([R|P]):- length(P, T), T == 0, write(R).


getList([],_,[]).
getList([R|T], N, P) :- R == N, character(T, W), getList(T, N, PA), append([W], PA, P).
getList([R|T], N, P) :- opposite(R,N), getList(T,N,P).
