:-include("TDABoard").

getBoardG([Board|_],Board).

getPlayer1G([_,Player1|_],Player1).

getPlayer2G([_,_,Player2|_],Player2).

getCurrentTurnG([_,_,_,CurrentTurn|_],CurrentTurn).

%--------------------game_history------------------------%
%game_history entrega el historial de movimientos del juego
%Dominio: TDA Game
%Recorrido


game_history([_,_,_,_,CurrentHistory],CurrentHistory).

%------------------------- game -------------------------%
%game es el constructor del TDAGame
% Dominio: Board(TDA Game), Player1(TDAPlayer), Player2(TDAPlayer),
% CurrentTurn(int) Recorrido
% Recorrido:TDA Game

game(Player,Player2,Board,CurrentTurn,Game):-
    CurrentHistory=[],
    Game=[Board,Player,Player2,CurrentTurn,CurrentHistory].

%----------------------------is_draw---------------------%
% Nos dice si en el juego hay un empate, es decir que no existan mas
% jugadas posibles y que haya un ganador o que los jugadores no tengan
% mas piezas
% Dominio:TDAGame
% Recorrido:Boolean


is_draw([_,Player1,Player2|_]):-
    getRemainingPiecesPlayer(Player1,R1),
    getRemainingPiecesPlayer(Player2,R2),
    R1==0,
    R2==0,
    !.

is_draw([Board|_]):-
    not(can_play(Board)),
    !.





%------------------get_current_player--------------------%
%nos entrega al jugador cuyo turno corresponde
%Dominio:
%Recorrido:

get_current_player([_,Player1,_,CurrentTurn|_],Player1):-
    getIdPlayer(Player1,Id1),
    Id1==CurrentTurn,
    !.

get_current_player([_,_,Player2,CurrentTurn|_],Player2):-
    getIdPlayer(Player2,Id2),
    Id2==CurrentTurn,
    !.

%----------------------game_get_board----------------------%
%
%Domino:-
%Recorrido:

game_get_board([Board|_],Board).


game_get_board2([A|B]):-
    getBoardG([A|B],Board),
    getC1(Board,C1),
    getC2(Board,C2),
    getC3(Board,C3),
    getC4(Board,C4),
    getC5(Board,C5),
    getC6(Board,C6),
    getC7(Board,C7),
    imprimirVertical(C1,C2,C3,C4,C5,C6,C7).


%imprimirVertical(C1,C2,C3,C4,C5,C6,C7):-

imprimirVertical([],[],[],[],[],[],[]):-!.

imprimirVertical([A1|B1],[A2|B2],[A3|B3],[A4|B4],[A5|B5],[A6|B6],[A7|B7]):-
    write(A1     ;     A2    ;     A3    ;    A4    ;    A5    ;    A6    ;    A7),
    nl,
    imprimirVertical(B1,B2,B3,B4,B5,B6,B7).





%---------------------------update_stats---------------------------%
% Se toma al jugador que se encuentra en el TDAGame y se actualiza sus
% datos de victoria,derrota o empate
% Dominio:TDA Game, OldStats (Lista de TDAPlayer)
% Recorrido: NewStats(Lista de TDAPlayer)

%update_stats(Game,OdlStats,NewStasts):-
%OldStats jugadores sin las estadisticas actualizadas
%NewStats jugadores con las estadisticas actualizadas

update_stats([Board,Player1A,Player2A|_],[Player1,_],[NewPlayer1,NewPlayer2]):-
    who_is_winner(Board,Winner),
    getIdPlayer(Player1,Id1),
    Id1==Winner,
    update_wins(Player1A,NewPlayer1),
    update_losses(Player2A,NewPlayer2),
    !.

update_stats([Board,Player1A,Player2A|_],[_,Player2],[NewPlayer1,NewPlayer2]):-
    who_is_winner(Board,Winner),
    getIdPlayer(Player2,Id2),
    Id2==Winner,
    update_wins(Player2A,NewPlayer2),
    update_losses(Player1A,NewPlayer1),
    !.

update_stats([Board,Player1A,Player2A|L],[Player1,Player2],[NewPlayer1,NewPlayer2]):-
    is_draw([Board,Player1,Player2|L]),
    update_draws(Player1A,NewPlayer1),
    update_draws(Player2A,NewPlayer2),
    !.

update_stats(_,[Player1,Player2],[Player1,Player2]):-!.


%----------------------------end_game--------------------------%
%
%
%
%end_game(Game,EndGame):-

end_game([Board,Player1,Player2|L],[Board,NewP1,NewP2|L]):-
    update_stats([Board,Player1,Player2|L],[Player1,Player2],NewPlayers),
    my_car(NewPlayers,NewP1),
    my_cdr(NewPlayers,Cdr),
    my_car(Cdr,NewP2),
    !.

%end_game([Board,Player1,Player2|L],[Board,Player1,Player2|L]):-!.





%-----------------------------player_play---------------------------%
%
%
%
%player_play(Game,Player,Column,NewGame):-


% --------------------- Caso del Jugador 1 ----------------------------%

% -------- Caso del Jugador 1 (Hay un Ganador o es empate)----------%
player_play([Board,Player1,Player2,CurrentTurn,History],PlayerA,Column,NewGame2):-
    getIdPlayer(Player1,Id1),
    getIdPlayer(PlayerA,IdA),
    Id1==IdA,
    CurrentTurn==IdA,
    getColorPlayer(PlayerA,Color),
    append(Color,[IdA],Piece),
    play_piece(Board,Column,Piece,NewBoard),
    update_pieces(Player1,NewPlayer1),
    getIdPlayer(Player2,Id2),
    append(History,[[IdA,Column]],NewHistory),
    NewGame1=[NewBoard,NewPlayer1,Player2,Id2,NewHistory],
    end_game(NewGame1,NewGame2),
    NewGame2\==NewGame1.


% --------------- Caso Base del Jugador 1 ---------------------%

player_play([Board,Player1,Player2,CurrentTurn,History],PlayerA,Column,NewGame):-
    getIdPlayer(Player1,Id1),
    getIdPlayer(PlayerA,IdA),
    Id1==IdA,
    CurrentTurn==IdA,
    getColorPlayer(PlayerA,Color),
    append(Color,[IdA],Piece),
    play_piece(Board,Column,Piece,NewBoard),
    update_pieces(Player1,NewPlayer1),
    getIdPlayer(Player2,Id2),
    append(History,[[IdA,Column]],NewHistory),
    NewGame=[NewBoard,NewPlayer1,Player2,Id2,NewHistory].

%---------------------------------------------------------------%
% -------- Caso del Jugador 2 (Hay un Ganador o es empate)----------%
player_play([Board,Player1,Player2,CurrentTurn,History],PlayerA,Column,NewGame2):-
    can_play(Board),
    getIdPlayer(Player2,Id2),
    getIdPlayer(PlayerA,IdA),
    Id2==IdA,
    CurrentTurn==IdA,
    getColorPlayer(PlayerA,Color),
    append(Color,[IdA],Piece),
    play_piece(Board,Column,Piece,NewBoard),
    update_pieces(Player2,NewPlayer2),
    getIdPlayer(Player1,Id1),
    append(History,[[IdA,Column]],NewHistory),
    NewGame1=[NewBoard,Player1,NewPlayer2,Id1,NewHistory],
    end_game(NewGame1,NewGame2),
    NewGame2\==NewGame1.




% --------------- Caso Base del Jugador 2 -----------------%
player_play([Board,Player1,Player2,CurrentTurn,History],PlayerA,Column,NewGame):-
    can_play(Board),
    getIdPlayer(Player2,Id2),
    getIdPlayer(PlayerA,IdA),
    Id2==IdA,
    CurrentTurn==IdA,
    getColorPlayer(PlayerA,Color),
    append(Color,[IdA],Piece),
    play_piece(Board,Column,Piece,NewBoard),
    update_pieces(Player2,NewPlayer2),
    getIdPlayer(Player1,Id1),
    append(History,[[IdA,Column]],NewHistory),
    NewGame=[NewBoard,Player1,NewPlayer2,Id1,NewHistory].




















































































