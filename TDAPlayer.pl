getIdPlayer([A|_],A).

getNamePlayer([_,B|_],B).

getColorPlayer([_,_,C|_],C).

getWinsPlayer([_,_,_,D|_],D).

getLossesPlayer([_,_,_,_,E|_],E).

getDrawsPlayer([_,_,_,_,_,F|_],F).

getRemainigPiecesPlayer([_,_,_,_,_,_,G],G).

player(Id, Name, Color, Wins, Losses, Draws, RemainingPieces, Player):-
    Player = [Id,Name,Color,Wins,Losses,Draws,RemainingPieces].
