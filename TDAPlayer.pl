:-include("TDAPiece").

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



%---------------------------update_stats---------------------------%
% Se toma al jugador y se actualiza sus datos de victoria,derrota o
% empate
%Dominio:TDA Game Recorrido: TDA Player

%update_stats(Player,OdlStats,NewStasts):-














