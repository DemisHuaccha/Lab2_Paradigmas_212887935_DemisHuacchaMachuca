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

game(Game,Board,Player,Player2,CurrentTurn):-
    CurrentHistory=[],
    Game=[Board,Player,Player2,CurrentTurn,CurrentHistory].

%----------------------------is_draw---------------------%
% Nos dice si en el juego hay un empate, es decir que no existan mas
% jugadas posibles y que haya un ganador
% Dominio:TDAGame
% Recorrido:Boolean

is_draw(Game):-
    getBoardG(Game,Board),
    who_is_winner(Board,Winner),
    Winner==0,
    not(can_play(Board)).

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
%Domino:
%Recorrido:

game_get_board([A|B]):-
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
    write(A1 ; A2 ; A3 ; A4 ; A5 ; A6 ; A7),
    nl,
    imprimirVertical(B1,B2,B3,B4,B5,B6,B7).






