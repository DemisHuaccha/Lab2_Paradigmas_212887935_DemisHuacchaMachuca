:-module(tdapiece_21288793_HuacchaMachuca,[piece/2,getColorPiece/2]).

%Funcion que entrega el elemento de la lista TDA Piece
%Dominio: TDA piece
%Recorrido: string
getColorPiece([Color],Color).


% Funcion contructora del TDA Piece que transforma los elementos de
% entrada en una lista almacenada en el TDA Piece dado
% Dominio: string
% Recorrido:  TDA Piece
piece(Color, Pieza):-
    Pieza=[Color].
