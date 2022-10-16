:- dynamic detailed_mode_disabled/0.
:- ensure_loaded('files.pl').
% student file for Ultimate Tic Tac Toe implementation

% initialState/1
% initialState(-State)
% Este adevărat pentru starea inițială a jocului.
initialState(pair(Board, LastMove)) :- empty_board(B), Board = [B, B, B, B, B, B, B, B, B], LastMove = 0.

% getBoards/2
% getBoards(+State, -Boards)
% Este adevărat dacă în starea State, informațiile din tablele individuale sunt
% cele din variabila Boards.
% Boards este legată la o listă de 9 elemente, fiecare element reprezentând o tablă.
% Ordinea tablelor este cea din lista positions (din utils.pl).
% Fiecare element din listă este o listă de 9 elemente, reprezentând
% pozițiile de pe tablă, ca x, 0, sau ''.
% Pozițiile sunt în ordinea din lista positions (din utils.pl).
getBoards(pair(Board, _), Boards) :- Boards = Board.

% getBoard/3
% getBoard(+State, +UPos, -Board)
% Este adebărat dacă în starea State, la poziția UPos din tabla de UTTT, 
% se află tabla individuală cu reprezentarea din Board.
% Reprezentarea tablei este descrisă în predicatul getBoards/2.
getBoard(pair(Boards, _), nw, MyBoard) :- [H1 | _] = Boards, MyBoard = H1.
getBoard(pair(Boards, _), n, MyBoard) :- [_, H2 | _] = Boards, MyBoard = H2.
getBoard(pair(Boards, _), ne, MyBoard) :- [_, _, H3 | _] = Boards, MyBoard = H3.
getBoard(pair(Boards, _), w, MyBoard) :- [_, _, _, H4 | _] = Boards, MyBoard = H4.
getBoard(pair(Boards, _), c, MyBoard) :- [_, _, _, _, H5 | _] = Boards, MyBoard = H5.
getBoard(pair(Boards, _), e, MyBoard) :- [_, _, _, _, _, H6 | _] = Boards, MyBoard = H6.
getBoard(pair(Boards, _), sw, MyBoard) :- [_, _, _, _, _, _, H7 | _] = Boards, MyBoard = H7.
getBoard(pair(Boards, _), s, MyBoard) :- [_, _, _, _, _, _, _, H8 | _] = Boards, MyBoard = H8.
getBoard(pair(Boards, _), se, MyBoard) :- [_, _, _, _, _, _, _, _, H9 | _] = Boards, MyBoard = H9.

% getUBoard/2
% getUBoard(stare(+Board, +UboardState, +Player, +NextMoves),
% -UboardState)
% Întoarce reprezentarea UBoard-ului, indicând tablele individuale câștigate,
% remizate, sau încă în desfășurare. Reprezentarea este aceeași ca a tablelor
% individuale (vezi getBoards/2).
getUBoard(pair(Boards, _), Results) :- findall(Result, (member(Board, Boards), getBoardResult(Board, Result)), Results).

% getPos/4
% getPos(+State, +UPos, +Pos, -Cell).
% Este adevărat dacă în starea State, în tabla individuală de la poziția UPos în UBoard,
% la poziția Pos pe tablă, se află simbolul Cell (x, 0, sau '').
getPos(State, UPos, nw, Cell) :- getBoard(State, UPos, Board), [H1, H2, H3, H4, H5, H6, H7, H8, H9|T] = Board, Cell = H1.
getPos(State, UPos, n, Cell) :- getBoard(State, UPos, Board), [H1, H2, H3, H4, H5, H6, H7, H8, H9|T] = Board, Cell = H2.
getPos(State, UPos, ne, Cell) :- getBoard(State, UPos, Board), [H1, H2, H3, H4, H5, H6, H7, H8, H9|T] = Board, Cell = H3.
getPos(State, UPos, w, Cell) :- getBoard(State, UPos, Board), [H1, H2, H3, H4, H5, H6, H7, H8, H9|T] = Board, Cell = H4.
getPos(State, UPos, c, Cell) :- getBoard(State, UPos, Board), [H1, H2, H3, H4, H5, H6, H7, H8, H9|T] = Board, Cell = H5.
getPos(State, UPos, e, Cell) :- getBoard(State, UPos, Board), [H1, H2, H3, H4, H5, H6, H7, H8, H9|T] = Board, Cell = H6.
getPos(State, UPos, sw, Cell) :- getBoard(State, UPos, Board), [H1, H2, H3, H4, H5, H6, H7, H8, H9|T] = Board, Cell = H7.
getPos(State, UPos, s, Cell) :- getBoard(State, UPos, Board), [H1, H2, H3, H4, H5, H6, H7, H8, H9|T] = Board, Cell = H8.
getPos(State, UPos, se, Cell) :- getBoard(State, UPos, Board), [H1, H2, H3, H4, H5, H6, H7, H8, H9|T] = Board, Cell = H9.

% getPos/3
% getPos(+Board, +Pos, -Cell).
% Este adevărat dacă în tabla individuală reprezentată în Board, la poziția Pos, 
% se află simbolul Cell (x, 0, sau ''). Predicatul poate fi folosit și pentru UBoard, caz 
% în care Cell poate fi și r.
getPos(Board, nw, Cell) :- [H1, H2, H3, H4, H5, H6, H7, H8, H9|T] = Board, Cell = H1.
getPos(Board, n, Cell) :- [H1, H2, H3, H4, H5, H6, H7, H8, H9|T] = Board, Cell = H2.
getPos(Board, ne, Cell) :- [H1, H2, H3, H4, H5, H6, H7, H8, H9|T] = Board, Cell = H3.
getPos(Board, w, Cell) :- [H1, H2, H3, H4, H5, H6, H7, H8, H9|T] = Board, Cell = H4.
getPos(Board, c, Cell) :- [H1, H2, H3, H4, H5, H6, H7, H8, H9|T] = Board, Cell = H5.
getPos(Board, e, Cell) :- [H1, H2, H3, H4, H5, H6, H7, H8, H9|T] = Board, Cell = H6.
getPos(Board, sw, Cell) :- [H1, H2, H3, H4, H5, H6, H7, H8, H9|T] = Board, Cell = H7.
getPos(Board, s, Cell) :- [H1, H2, H3, H4, H5, H6, H7, H8, H9|T] = Board, Cell = H8.
getPos(Board, se, Cell) :- [H1, H2, H3, H4, H5, H6, H7, H8, H9|T] = Board, Cell = H9.

getNumberOfPlaysBoard([], Player, Num) :- Num = 0.
getNumberOfPlaysBoard([H|T], Player, Num) :- getNumberOfPlaysBoard(T, Player, N1),
                                             ((H == Player, Num is N1 + 1);
                                            (Num = N1)).

getNumberOfPlays([], Player, Num) :- Num = 0.
getNumberOfPlays([H|T], Player, Num) :- getNumberOfPlaysBoard(H, Player, N1),
                                        getNumberOfPlays(T, Player, N2),
                                        Num is N1 + N2.

% getNextPlayer/2
% getNextPlayer(+State), -NextPlayer)
% Este adevărat dacă în starea State, jucătorul care urmează este NextPlayer
% (poate fi x sau 0)..
getNextPlayer(pair(Boards, LastMove), NextPlayer) :- getNumberOfPlays(Boards, x, Num1),
                                                     getNumberOfPlays(Boards, 0, Num2),
                                                     ((Num1 =:= Num2, NextPlayer = x);
                                                     (Num1 =\= Num2), NextPlayer = 0).

% getNextAvailableBoards/2
% getNextAvailableBoards(+State, -NextBoardsPoss)
% Este adevărat dacă în starea State, pozițiile din NextBoardsPoss sunt pozițiile 
% din UBoard ale tablelor disponibile pentru următoarea mutare.
getLastMove(pair(Boards, LastMove), MyLastMove) :- MyLastMove = LastMove.

getNextAvailableBoards(State, NextBoardsPoss) :- initialState(MyState), MyState == State, positions(NextBoardsPoss).
getNextAvailableBoards(State, NextBoardsPoss) :- getLastMove(State, LastMove), getBoard(State, LastMove, Board),
                                                getBoardResult(Board, Result),
                                                getUBoard(State, Results),
                                                positions(Posses),
                                                ((Result == '', NextBoardsPoss = [LastMove]);
                                                (\+(Result == ''), findall(Poss, (member(Poss, Posses), getPos(Results, Poss, MyResult), MyResult == ''), NextBoardsPoss))).


% getBoardResult/2
% getBoardResult(+Board, -Result)
% Este adevărat dacă pentru o tablă individuală (sau UBoard) cu reprezentarea
% din Board, rezultatul este Result. Result poate fi:
% x sau 0, dacă jucătorul respectiv a câștigat jocul pe tabla dată;
% r, dacă s-a ajuns la remiză (toate pozițiile au fost completate dar
% tabla nu a fost câștigată);
% '', dacă tabla nu a fost câștigată și nu s-au completat toate pozițiile.
% NOTĂ: este deja definit predicatul player_wins/2 în utils.pl.
getBoardResult(Board, x) :- player_wins(x, Board).
getBoardResult(Board, 0) :- player_wins(0, Board).
getBoardResult(Board, r) :- \+player_wins(x, Board),
                            \+player_wins(0, Board),
                            Player = [x, 0],
                            forall(member(X, Board), member(X, Player)).
getBoardResult(Board, '') :- \+player_wins(x, Board),
                            \+player_wins(0, Board),
                            Player = [x, 0],
                            \+forall(member(X, Board), member(X, Player)).

% buildState/3
% buildState(+Boards, +PreviousPos, -State)
% Este adevărat dacă starea State corespunde stării jocului în care tablele
% individuale sunt cele din lista Boards, iar ultima mutare a fost în 
% poziția PreviousPos într-o tablă individuală.
% NOTĂ: nu contează în care tablă individuală s-a realizat ultima mutare.
buildState(MyBoard, MyLastMove, pair(Board, LastMove)) :- Board = MyBoard, LastMove = MyLastMove.

% validMove/2
% validMove(+State, +Move)
% Este adevărat dacă mutarea Move este legală în starea State.
% Move este fie o poziție, în cazul în care este o singură tablă disponibilă
% pentru a următoarea mutare din starea State, fie o pereche de poziții, altfel.
validMove(State, (Pos1, Pos2)) :- getNextAvailableBoards(State, Posses),
                                  getUBoard(State, UBoard),
                                  \+player_wins(x, UBoard),
                                  \+player_wins(0, UBoard),
                                  length(Posses, Len),
                                  Len > 1,
                                  member(Pos1, Posses),
                                  getPos(State, Pos1, Pos2, Cell),
                                  Cell == ''.
validMove(State, Pos) :- getNextAvailableBoards(State, Posses),
                         getUBoard(State, UBoard),
                         \+player_wins(x, UBoard),
                         \+player_wins(0, UBoard),
                         length(Posses, Len),
                         Len == 1,
                         [MyPos | _] = Posses,
                         getPos(State, MyPos, Pos, Cell),
                         Cell == ''.
% makeMove/3
% makeMove(+State, +Move, -NewState)
% Este adevărat dacă în urma aplicării mutării Move în starea State
% rezulta starea NewState.
% Move este fie o poziție (din lista positions), în cazul în care nu sunt mai 
% multe table disponibile pentru a următoarea mutare din starea State,
% fie o pereche de poziții, altfel.
%
% Hint: folosiți validMove pentru a verifica mutarea și buildState pentru a construi o stare.
makeMove(State, (Pos1, Pos2), NewState) :- validMove(State, (Pos1, Pos2)),
                                           getNextPlayer(State, Player),
                                           getBoards(State, Boards),
                                           positions(PS),
                                           nth0(IndexPos1, PS, Pos1),
                                           nth0(IndexPos1, Boards, Board, BoardsRest),
                                           nth0(IndexPos2, PS, Pos2),
                                           nth0(IndexPos2, Board, Cell, BoardRest),
                                           nth0(IndexPos2, NewBoard, Player, BoardRest),
                                           nth0(IndexPos1, NewBoards, NewBoard, BoardsRest),
                                           NewLastMove = Pos2,
                                           buildState(NewBoards, NewLastMove, NewState).

makeMove(State, Pos, NewState) :- validMove(State, Pos),
                                  Pos2 = Pos,
                                  getNextAvailableBoards(State, NextBoards),
                                  [Pos1 | _] = NextBoards,
                                  getNextPlayer(State, Player),
                                  getBoards(State, Boards),
                                  positions(PS),
                                  nth0(IndexPos1, PS, Pos1),
                                  nth0(IndexPos1, Boards, Board, BoardsRest),
                                  nth0(IndexPos2, PS, Pos2),
                                  nth0(IndexPos2, Board, Cell, BoardRest),
                                  nth0(IndexPos2, NewBoard, Player, BoardRest),
                                  nth0(IndexPos1, NewBoards, NewBoard, BoardsRest),
                                  NewLastMove = Pos2,
                                  buildState(NewBoards, NewLastMove, NewState).

% dummy_first/2
% dummy_first(+State, -NextMove)
% Predicatul leagă NextMove la următoarea mutare pentru starea State.
% Strategia este foarte simplă: va fi aleasă cea mai din stânga-sus mutare posibilă
% (prima din lista de poziții disponibile).
dummy_first(State, (Pos1, Pos2)) :- getNextAvailableBoards(State, Posses),
                                    length(Posses, Len),
                                    Len > 1,
                                    [First | _] = Posses,
                                    positions(PS),
                                    getBoard(State, First, Board),
                                    Pos1 = First,
                                    findall(Poss, (member(Poss, PS), getPos(Board, Poss, Cell), Cell == ''), MyPosses),
                                    [Pos2 | _] = MyPosses.

dummy_first(State, Pos) :- getNextAvailableBoards(State, Posses),
                           length(Posses, Len),
                           Len == 1,
                           [First | _] = Posses,
                           positions(PS),
                           getBoard(State, First, Board),
                           findall(Poss, (member(Poss, PS), getPos(Board, Poss, Cell), Cell == ''), MyPosses),
                           [Pos | _] = MyPosses.
% dummy_last/2
% dummy_last(+State, -NextMove)
% Predicatul leagă NextMove la următoarea mutare pentru starea State.
% Strategia este foarte simplă: va fi aleasă cea mai din dreapta-jos mutare posibilă 
% (ultima din lista de poziții disponibile).
dummy_last(State, (Pos1, Pos2)) :- getNextAvailableBoards(State, Posses),
                                    length(Posses, Len),
                                    Len > 1,
                                    Last is Len - 1,
                                    nth0(Last, Posses, LastPos),
                                    positions(PS),
                                    getBoard(State, LastPos, Board),
                                    Pos1 = LastPos,
                                    findall(Poss, (member(Poss, PS), getPos(Board, Poss, Cell), Cell == ''), MyPosses),
                                    length(MyPosses, LenPosses),
                                    MyLast is LenPosses - 1,
                                    nth0(MyLast, MyPosses, Pos2).

dummy_last(State, Pos) :- getNextAvailableBoards(State, Posses),
                                    length(Posses, Len),
                                    Len == 1,
                                    [LastPos | _] = Posses,
                                    positions(PS),
                                    getBoard(State, LastPos, Board),
                                    findall(Poss, (member(Poss, PS), getPos(Board, Poss, Cell), Cell == ''), MyPosses),
                                    length(MyPosses, LenPosses),
                                    MyLast is LenPosses - 1,
                                    nth0(MyLast, MyPosses, Pos).
