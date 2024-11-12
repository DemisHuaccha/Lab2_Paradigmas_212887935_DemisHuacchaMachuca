

%getC1que entrega la primera columna del TDA Board
%Dominio : TDA board
%REcorrido: una lista (Columna)
getC1([C1|_],C1).
getC2([_,C2|_],C2).
getC3([_,_,C3|_],C3).
getC4([_,_,_,C4|_],C4).
getC5([_,_,_,_,C5|_],C5).
getC6([_,_,_,_,_,C6|_],C6).
getC7([_,_,_,_,_,_,C7],C7).

%getF1 que entrega el primer elemento de una columna
%Dominio : Lista Columna
%REcorrido: Primer elemento de la columna (int/string)
getF1([F1|_],F1).

getPieza([P|_],P).

%------------------obtener_columna------------------------------%
%Dejar por ahora aunque se ve innecesario
%predicado que obtiene una la columna pedida.
%
obtener_columna(Board,Columna,Columna2):-
    Columna == 0,
    getC1(Board,Columna2).

obtener_columna(Board,Columna,Columna2):-
    Columna == 1,
    getC2(Board,Columna2).

obtener_columna(Board,Columna,Columna2):-
    Columna == 2,
    getC3(Board,Columna2).

obtener_columna(Board,Columna,Columna2):-
    Columna == 3,
    getC4(Board,Columna2).

obtener_columna(Board,Columna,Columna2):-
    Columna == 4,
    getC5(Board,Columna2).

obtener_columna(Board,Columna,Columna2):-
    Columna == 5,
    getC6(Board,Columna2).

obtener_columna(Board,Columna,Columna2):-
    Columna == 6,
    getC7(Board,Columna2).

% getJugadorB es una funcion que verifica el elemento de la
% columna esta vacio o tiene un jugador, si esta vacio retorna 0 en caso
% contrario retorna el jugador
% Dominio: lista
% Recorrido: int

getJugadorB([A],J):-
    A == 0,
    J = 0.

getJugadorB([_|J],J).


%Constructor del TDA Board que entraga una lista de listas
%Domonio : Variable donde se almacenara
%Recorrido: TDA Board
board(Board):-
    Board=[[[0],[0],[0],[0],[0],[0]],[[0],[0],[0],[0],[0],[0]],[[0],[0],[0],[0],[0],[0]],[[0],[0],[0],[0],[0],[0]],[[0],[0],[0],[0],[0],[0]],[[0],[0],[0],[0],[0],[0]],[[0],[0],[0],[0],[0],[0]]].
% ------------------------ can_play --------------------------%

% Funcion can_play es una funcion que verifica que exista por lo menos
% una posicion disponible para una pieza
% Dominio: TDa Board
% Recorrido: booleano (#t / #f)

can_play([C1|_]):-
    getF1(C1,F1),
    getJugadorB(F1,J1),
    J1 == 0.

can_play([_|B2]):-
    can_play(B2).

%-----------------------colocar_pieza---------------------------%
%Se esta trabajando con una columna, se esta modificando la pieza
%Dominio: Lista columna
%Recorrid: Lista columna

my_car([A|_],A).
my_cdr([_|B],B).

colocar_pieza([_|B],Piece,[Piece]):-
    length(B,L),
    L==0,
    !.

colocar_pieza([A|B],Piece,[A|LR]):-
    my_car(B,Car),
    getJugadorB(Car,J),
    J==0,
    colocar_pieza(B,Piece,LR),
    !.

colocar_pieza([A|B],Piece,[Piece|B]):-
    getJugadorB(A,J),
    J==0,
    !.

%---------------------construir_tablero-------------------------%

construir_tablero([],_,_,_,[]).

construir_tablero([A|B],Columna,Piece,Cont,[NewColumn|B]):-
    Columna =:= Cont,
    colocar_pieza(A,Piece,NewColumn).

construir_tablero([A|B],Columna,Piece,Cont,[A|NewBoard2]):-
    Cont2 is Cont+1,
    write(Cont2),
    construir_tablero(B,Columna,Piece,Cont2,NewBoard2).

%------------------------ play_piece ---------------------------%

% Coloca una pieza en la columna escogida en la posicion mas baja, en
% caso de que la columna este llena, tira error (*Corregir esto para que
% retorne la columna sin cambios)
%
% Dominio: TDA BOard, int, TDA piece,
% Recorrido: TDA Board
play_piece(Board, Column, Piece, NewBoard):-
    construir_tablero(Board,Column,Piece,0,NewBoard).

%-------------------------Vertical_win---------------------------%

repetido4([],Cont,Winner):-
    Cont==4,
    Winner.

repetido4([A|_],Cont,Winner):-
    Cont==4,
    getJugadorB(A,Winner).

repetido4([A|B],Cont,Winner):-
    my_car(B,Car),
    A==Car,
    Cont2 is Cont+1,
    repetido4(B,Cont2,Winner).

repetido4([A|B],_,Winner):-
    getJugadorB(A,Aux),
    Aux==0,
    repetido4(B,1,Winner).

repetido4([_|B],_,Winner):-
    repetido4(B,1,Winner).


vertical_win([],0).

vertical_win([Column|_],Winner):-
    repetido4(Column,1,Winner),
    Winner\==0.

vertical_win([_|Board],Winner):-
    vertical_win(Board,Winner).

%-------------------------Horizontal_win------------------------&




























