
:-module(tdaplayer_21288793_HuacchaMachuca,[getIdPlayer/2,getColorPlayer/2,getRemainingPiecesPlayer/2,player/8,update_pieces/2,update_wins/2,update_losses/2,update_draws/2]).


%Funcion que entrega el primer elemento del TDA Player
getIdPlayer([Id|_],Id).  %Dominio: TDA Player, Recorrido : int


%Funcion que entrega el segundo elemento del TDA Player
getNamePlayer([_,Name|_],Name). %Dominio: TDA Player, Recorrido : string


%Funcion que entrega el tercer elemento del TDA Player
getColorPlayer([_,_,Color|_],Color). %Dominio: TDA Player, Recorrido : string


%Funcion que entrega el cuarto elemento del TDA Player
getWinsPlayer([_,_,_,Wins|_],Wins). %Dominio: TDA Player, Recorrido : int


%Funcion que entrega el quinto elemento del TDA Player
getLossesPlayer([_,_,_,_,Losses|_],Losses). %Dominio: TDA Player, Recorrido : int


%Funcion que entrega el sexto elemento del TDA Player
getDrawsPlayer([_,_,_,_,_,Draws|_],Draws). %Dominio: TDA Player, Recorrido : int


%Funcion que entrega el septimo elemento del TDA Player
getRemainingPiecesPlayer([_,_,_,_,_,_,RemainingPieces],RemainingPieces). %Dominio: TDA Player, Recorrido : int


% Funcion constructora del TDA Player, trasforma las entradas en una
% lista almacenada en el Player dado
% Dominio : int, string , string, int, int, int, int
% Recorrido: TDA Player.
player(Id, Name, Color, Wins, Losses, Draws, RemainingPieces, Player):-
    Player= [Id, Name, Color, Wins, Losses, Draws, RemainingPieces].


%--------------------------update_piece--------------------------%
%Reduce la cantidad de piezas en el jugador en 1
%Dominio:TDA Player
%Recorrido: TDA Player
%update_piece(Player,NewPlayer)

update_pieces([Id,Name,Color,Wins,Losses,Draws,Pieces],[Id,Name,Color,Wins,Losses,Draws,Pieces2]):-
    Pieces2 is Pieces-1.

% --------------------------update----------------------------------------%
% Dominio: TDA Player
% Recorrido: TDA Player
% update(Player,NewPlayer):-
update_wins([Id,Name,Color,Wins|L],[Id,Name,Color,Wins2|L]):-
    Wins2 is Wins+1.

update_losses([Id,Name,Color,Wins,Losses|L],[Id,Name,Color,Wins,Losses2|L]):-
    Losses2 is Losses+1.

update_draws([Id,Name,Color,Wins,Losses,Draws,Pieces],[Id,Name,Color,Wins,Losses,Draws2,Pieces]):-
    Draws2 is Draws+1.










