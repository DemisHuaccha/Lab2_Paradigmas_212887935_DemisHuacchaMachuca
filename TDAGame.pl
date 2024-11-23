:-module(tdagame,[game_history/2,game/5,is_draw/1, get_current_player/2, game_get_board/2, game_get_board2/1, update_stats/3, player_play/4, end_game/2,getPlayer1G/2,getPlayer2G/2,getCurrentTurnG/2,getBoardG/2]).

:-use_module(tdaboard,[can_play/1,play_piece/4,who_is_winner/2,getC1/2,getC2/2,getC3/2,getC4/2,getC5/2,getC6/2,getC7/2]).

:-use_module(tdaplayer,[getIdPlayer/2,getColorPlayer/2,getRemainingPiecesPlayer/2,update_pieces/2,update_wins/2,update_losses/2,update_draws/2]).


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

my_member([A|_],A):-!.

my_member([_|B],A):-
    my_member(B,A).

revisarColumnas([C|_],Elem,Cont):-
    my_member(C,Elem),
    Cont is 1,
    !.

revisarColumnas([_|B],Elem,Cont):-
    revisarColumnas(B,Elem,Cont).

revisarColumnas([],_,0).


is_draw(Game):-
    getPlayer1G(Game,Player1),
    getPlayer2G(Game,Player2),
    getRemainingPiecesPlayer(Player1,R1),
    getRemainingPiecesPlayer(Player2,R2),
    R1==0,
    R2==0,
    !.

is_draw(Game):-
    getBoardG(Game,Board),
    revisarColumnas(Board,[0],Cont),
    Cont==0,
    !.



%------------------get_current_player--------------------%
%nos entrega al jugador cuyo turno corresponde
%Dominio:
%Recorrido:

get_current_player([_,Player1,_,CurrentTurn|_],Player1):-
    getIdPlayer(Player1,Id1),
    Id1==CurrentTurn.

get_current_player([_,_,Player2,CurrentTurn|_],Player2):-
    getIdPlayer(Player2,Id2),
    Id2==CurrentTurn.

%----------------------game_get_board----------------------%
%Retorna el TDA Board contenido en el TDA Game
%Domino:TDA Game
%Recorrido:TDA Board

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

update_stats([Board,Player1A,Player2A|L],[_,_],[NewPlayer1,NewPlayer2]):-
    once(is_draw([Board,Player1A,Player2A|L])),
    update_draws(Player1A,NewPlayer1),
    update_draws(Player2A,NewPlayer2),
    !.

update_stats(_,[Player1,Player2],[Player1,Player2]).


%----------------------------end_game--------------------------%
% Actualiza los jugadores dependiendo del resultado, en caso de que no
% exista una ganador o haya un empate, retorna el juego sin
% modificaciones
% Dominio:TDA Game, oldStats Recorrido:NewStats
% end_game(Game,EndGame):-

get1([A,_],A).
get2([_,B],B).

end_game([Board,Player1,Player2|L],[Board,NewP1,NewP2|L]):-
    once(update_stats([Board,Player1,Player2|L],[Player1,Player2],NewPlayers)),
    get1(NewPlayers,NewP1),
    get2(NewPlayers,NewP2).


%-----------------------------player_play---------------------------%
%
%Dominio: TDA Game, TDA Player, Int
%Recorrido: TDA Game
%player_play(Game,Player,Column,NewGame):-


% --------------- Caso del Jugador 1 ---------------------%

player_play([Board,Player1,Player2,CurrentTurn,History],PlayerA,Column,NewGame):-
    can_play(Board),
    getIdPlayer(Player1,Id1),
    getIdPlayer(PlayerA,IdA),
    Id1==IdA,
    CurrentTurn==IdA,
    getColorPlayer(PlayerA,Color),
    append([Color],[IdA],Piece),
    play_piece(Board,Column,Piece,NewBoard),
    update_pieces(Player1,NewPlayer1),
    getIdPlayer(Player2,Id2),
    append(History,[[IdA,Column]],NewHistory),
    NewGame1=[NewBoard,NewPlayer1,Player2,Id2,NewHistory],
    once(end_game(NewGame1,NewGame)).

% --------------- Caso del Jugador 2 -----------------%
player_play([Board,Player1,Player2,CurrentTurn,History],PlayerA,Column,NewGame):-
    can_play(Board),
    getIdPlayer(Player2,Id2),
    getIdPlayer(PlayerA,IdA),
    Id2==IdA,
    CurrentTurn==IdA,
    getColorPlayer(PlayerA,Color),
    append([Color],[IdA],Piece),
    play_piece(Board,Column,Piece,NewBoard),
    update_pieces(Player2,NewPlayer2),
    getIdPlayer(Player1,Id1),
    append(History,[[IdA,Column]],NewHistory),
    NewGame2=[NewBoard,Player1,NewPlayer2,Id1,NewHistory],
    once(end_game(NewGame2,NewGame)).

















































































