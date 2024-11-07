

%Funcion que entrega la primera columna del TDA Board
%Dominio : TDA board
%REcorrido: una lista (Columna)
getC1([C1|_],C1).


%Funcion que entrega el primer elemento de una columna
%Dominio : Lista Columna
%REcorrido: Primer elemento de la columna (int/string)
getF1([F1|_],F1).


%Funcion constructora del TDA Board que entraga una lista de listas
%Domonio : Variable donde se almacenara
%Recorrido: TDA Board
board(Board):-
    Board=[[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]].
