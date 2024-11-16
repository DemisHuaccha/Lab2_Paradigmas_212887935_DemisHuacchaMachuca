:-include("TDABoard").
:-include("TDAPlayer").
:-include("TDAPiece").


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
%
%Dominio:TDAGame
%Recorrido:Boolean

is_draw(Game):-
    getBoardG(Game,Board),
    who_is_winner(Board,Winner),
    Winner\==0.



















