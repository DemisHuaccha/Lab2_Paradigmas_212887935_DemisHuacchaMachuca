:-module(tdaboard,[obtener_columna/3,board/1,can_play/1,my_car/2,my_cdr/2,play_piece/4,check_horizontal_win/2,check_vertical_win/2,check_diagonal_win/2,who_is_winner/2,getC1/2,getC2/2,getC3/2,getC4/2,getC5/2,getC6/2,getC7/2]).

%GetC1que entrega la primera columna del TDA Board
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

getJugadorB([_|J],J2):-
    my_car(J,J2).


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

my_member([A|_],A):-!.

my_member([_|B],A):-
    my_member(B,A).

can_play([C1|_]):-
    my_member(C1,[0]),
    !.

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
    construir_tablero(B,Columna,Piece,Cont2,NewBoard2).

%------------------------ play_piece ---------------------------%

% Coloca una pieza en la columna escogida en la posicion mas baja, en
% caso de que la columna este llena, tira error (*Corregir esto para que
% retorne la columna sin cambios)
%
% Dominio: TDA BOard, int, TDA piece,
% Recorrido: TDA Board
%
play_piece(Board, Column, Piece, NewBoard):-
    construir_tablero(Board,Column,Piece,0,NewBoard).

%-------------------------Repetido4---------------------------%
% repetido4 toma una lista y verifica si existen 4 elementos
% consecutivos
% Dominio:Lista, contador(int)
% Recorrido: int
% recursion de cola

repetido4([],_,0).


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

%-------------------------Vertical_win---------------------------%
% vertical_win verifica si en alguna columna existe una pieza que se
% repita 4 veces consecutivamente
% Dominio: Board (TDA board)
% Recorrido: Winner(int)
% Recursion de cola



check_vertical_win([],0):-!.

check_vertical_win([Column|_],Winner):-
    repetido4(Column,1,Winner),
    Winner\==0,
    !.

check_vertical_win([Column|B],Winner):-
    repetido4(Column,1,Winner2),
    Winner2==0,
    check_vertical_win(B,Winner).

%-------------------------Fila y construir_filas-----------------------&
%
%
%



% Fila usa obtener_columna para obtener el elemento de la fila pedida,
% ya que el predicado permite obtener los resultados esperados fila,a
% partir de eso, se toma el tablero y nos entregara la fila que
% pidamos

fila([],_,[]).


fila([A|B],Fila,[F|LR]):-
    obtener_columna(A,Fila,F),
    fila(B,Fila,LR).

% construir_filas nos entregara el tablero(que esta compuesto por listas
% que son columnas) con las filas

construir_filas(_,6,[]).

construir_filas(Board,Cont,[F|LR]):-
    fila(Board,Cont,F),
    Cont2 is Cont+1,
    construir_filas(Board,Cont2,LR).


%-------------------------horizontal_win---------------------------%
% horizontal_win verifica si en alguna fila existe una pieza que se
% repita 4 veces consecutivamente
% Dominio: Board (TDA board)
% Recorrido: Winner(int)
% Recursion de cola



horizontal_win2([],0):-!.

horizontal_win2([Column|_],Winner):-
    repetido4(Column,1,Winner),
    Winner\==0,
    !.

horizontal_win2([Column|B],Winner):-
    repetido4(Column,1,Winner2),
    Winner2==0,
    horizontal_win2(B,Winner).


check_horizontal_win(Board,Winner):-
    construir_filas(Board,0,BoardFilas),
    horizontal_win2(BoardFilas,Winner).



% -----------primero,segundo,tercero,cuarto / diagonales----------%
% Las clausulas primero,segunfo,tercero y cuarto tienen el mismo dominio
% y recorrido
%Dominio:Board(TDABoard), Y int , X int
%Recorrido:Lista de disgonales
%
% primeroDiagonal entrega las diagonales de izquierda-derecha y
% arriba-abajo comenzando desde posicion vertical mas baja (fila 6)
% hasta llegar a la posicion mas alta
%
% segundaDiagonal entrega las diagonales de izquieda-derecha y
% arriba-abajo comenzando desde la posicion horizontal mas cercana a 0
% hasta la mas lejana(la columna 7)
%
% terceroDiagonal entraga las diagonales de derecha-izquierda y
% arriba-abajo comenzando desde la posicion vertical mas baja(Fila 6) y
% desde la columna mas lejana(Columna 7), hasta la fila mas alta (Fila
% 0)
%
% cuartaDiagonal entrega las diagonales de derecha-izquierda y
% arriba-abajo comenzando desde la la columna mas lejana (Columna 7)
% hasta la primera columna
%
% Todas tiene una clausula auxiliar para recorrer y construir una
% diagonal hasta que no se cumplan las restricciones


primero(_,Y,_,[]):-
    Y==6,
    !.

primero([A|B],Y,X,[Elem|LR]):-
    obtener_columna([A|B],X,Column),
    obtener_columna(Column,Y,Elem),
    Y2 is Y+1,
    X2 is X+1,
    primero([A|B],Y2,X2,LR).


primeraDiagonal([A|B],Y,X,[LR]):-
    Y==0,
    primero([A|B],0,X,LR),
    !.

primeraDiagonal([A|B],Y,X,[L|LR]):-
    primero([A|B],Y,X,L),
    Y2 is Y-1,
    primeraDiagonal([A|B],Y2,X,LR).


segundo(_,_,X,[]):-
    X==7,
    !.

segundo(_,Y,_,[]):-
    Y==6,
    !.

segundo([A|B],Y,X,[Elem|LR]):-
    obtener_columna([A|B],X,Column),
    obtener_columna(Column,Y,Elem),
    Y2 is Y+1,
    X2 is X+1,
    segundo([A|B],Y2,X2,LR).

segundaDiagonal([A|B],Y,X,[LR]):-
    X==6,
    segundo([A|B],Y,6,LR),
    !.

segundaDiagonal([A|B],Y,X,[L|LR]):-
    segundo([A|B],Y,X,L),
    X2 is X+1,
    segundaDiagonal([A|B],Y,X2,LR).


tercer(_,Y,_,[]):-
    Y==6,
    !.

tercer([A|B],Y,X,[Elem|LR]):-
    obtener_columna([A|B],X,Column),
    obtener_columna(Column,Y,Elem),
    Y2 is Y+1,
    X2 is X-1,
    tercer([A|B],Y2,X2,LR).


terceraDiagonal([A|B],Y,X,[LR]):-
    Y==0,
    tercer([A|B],0,X,LR),
    !.

terceraDiagonal([A|B],Y,X,[L|LR]):-
    tercer([A|B],Y,X,L),
    Y2 is Y-1,
    terceraDiagonal([A|B],Y2,X,LR).


cuarto(_,_,X,[]):-
    X<0,
    !.

cuarto(_,Y,_,[]):-
    Y==6,
    !.

cuarto([A|B],Y,X,[Elem|LR]):-
    obtener_columna([A|B],X,Column),
    obtener_columna(Column,Y,Elem),
    Y2 is Y+1,
    X2 is X-1,
    cuarto([A|B],Y2,X2,LR).

cuartaDiagonal([A|B],Y,X,[LR]):-
    X==0,
    cuarto([A|B],Y,X,LR),
    !.

cuartaDiagonal([A|B],Y,X,[L|LR]):-
    cuarto([A|B],Y,X,L),
    X2 is X-1,
    cuartaDiagonal([A|B],Y,X2,LR).

%-------------------------diagonales---------------------------%
% Diagonales toma un tablero y en una lista almacena todas las
% diagonales posibles
%Dominio: Board (TDA board) Recorrido:
% diagonales(lista de listas)


diagonales(Board,Diagonales):-
    primeraDiagonal(Board,5,0,DiagC1),
    segundaDiagonal(Board,0,0,DiagC2),
    terceraDiagonal(Board,5,6,DiagC3),
    cuartaDiagonal(Board,0,6,DiagC4),
    append(DiagC1,DiagC2,Aux1),
    append(Aux1,DiagC3,Aux2),
    append(Aux2,DiagC4,Diagonales).

% %-------------------------diagonal_win---------------------------%
% diagonal_win verifica si en alguna diagonal existe una pieza que se
% repita 4 veces consecutivamente
% Dominio: Board (TDA board)
% Recorrido: Winner(int)
% Recursion de cola



diagonal_win2([],0):-!.

diagonal_win2([Diagonal|_],Winner):-
    repetido4(Diagonal,1,Winner),
    Winner\==0,
    !.

diagonal_win2([Diagonal|B],Winner):-
    repetido4(Diagonal,1,Winner2),
    Winner2==0,
    diagonal_win2(B,Winner).


check_diagonal_win([A|B],Winner):-
    diagonales([A|B],Diagonales),
    diagonal_win2(Diagonales,Winner).

 %-------------------------who_is_winner---------------------------%
% who_is_winner verifica si existe una pieza que se
% repita 4 veces consecutivamente y retorna el id del ganador
% Dominio: Board (TDA board)
% Recorrido: Winner(int)
% Recursion de cola

ganador(Winner1,_,_,Winner):-
    Winner1\==0,
    Winner = Winner1,
    !.
ganador(_,Winner2,_,Winner):-
    Winner2\==0,
    Winner = Winner2,
    !.
ganador(_,_,Winner3,Winner):-
    Winner3\==0,
    Winner = Winner3,
    !.
ganador(0,0,0,0):-!.

who_is_winner(Board,Winner):-
    check_vertical_win(Board,Winner1),
    check_horizontal_win(Board,Winner2),
    check_diagonal_win(Board,Winner3),
    ganador(Winner1,Winner2,Winner3,Winner),
    !.










