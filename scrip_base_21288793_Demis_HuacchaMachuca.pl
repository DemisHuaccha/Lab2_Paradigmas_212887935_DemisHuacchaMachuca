:- use_module(tdapiece_21288793_HuacchaMachuca,[piece/2]).
:- use_module(tdaplayer_21288793_HuacchaMachuca,[player/8]).
:- use_module(tdaboard_21288793_HuacchaMachuca,[board/1,can_play/1,check_horizontal_win/2,check_vertical_win/2,check_diagonal_win/2,who_is_winner/2]).
:- use_module(tdagame_21288793_HuacchaMachuca,[game/5,is_draw/1, get_current_player/2, game_get_board/2, player_play/4,end_game/2,game_history/2]).
:-set_prolog_flag(answer_write_options, [max_depth(0)]).


main0:-
% 1.Crear jugadores (10 fichas cada uno para un juego corto)
    player(1, "Juan", "red", 0, 0, 0, 10, P1),
    player(2, "Mauricio", "yellow", 0, 0, 0, 10, P2),

% 2. Crear fichas
    piece("red", RedPiece),
    piece("yellow", YellowPiece),
    write(RedPiece),
    nl,
    write(YellowPiece),
    nl,

% 3. Crear tablero inicial vacío
    board(EmptyBoard),
% 4. Crear nuevo juego
    game(P1, P2, EmptyBoard, 1, G0),
% 5. Realizando movimientos para crear una victoria diagonal
    player_play(G0, P1, 0, G1),    % Juan juega en columna 0
    player_play(G1, P2, 1, G2),    % Mauricio juega en columna 1
    player_play(G2, P1, 1, G3),    % Juan juega en columna 1
    player_play(G3, P2, 2, G4),    % Mauricio juega en columna 2
    player_play(G4, P1, 2, G5),    % Juan juega en columna 2
    player_play(G5, P2, 3, G6),    % Mauricio juega en columna 3
    player_play(G6, P1, 2, G7),    % Juan juega en columna 2
    player_play(G7, P2, 3, G8),    % Mauricio juega en columna 3
    player_play(G8, P1, 3, G9),    % Juan juega en columna 3
    player_play(G9, P2, 0, G10),   % Mauricio juega en columna 0
    player_play(G10, P1, 3, G11), % Juan juega en columna 3 (victoria diagonal)



% 6. Verificaciones del estado del juego
    write('¿Se puede jugar en el tablero vacío? '),
    can_play(EmptyBoard),
% Si se puede seguir jugando, el programa continuará
    nl,
    game_get_board(G11, CurrentBoard),
    write('¿Se puede jugar después de 11 movimientos? '),
    can_play(CurrentBoard),
    nl,
    write('Jugador actual después de 11 movimientos: '),
    get_current_player(G11, CurrentPlayer),
    write(CurrentPlayer),
    nl,

% 7. Verificaciones de victoria
    write('Verificación de victoria vertical: '),
    check_vertical_win(CurrentBoard, VerticalWinner),
    write(VerticalWinner),
    nl,
    write('Verificación de victoria horizontal: '),
    check_horizontal_win(CurrentBoard, HorizontalWinner),
    write(HorizontalWinner),
    nl,
    write('Verificación de victoria diagonal: '),
    check_diagonal_win(CurrentBoard, DiagonalWinner),
    write(DiagonalWinner),
    nl,
    write('Verificación de ganador: '),
    who_is_winner(CurrentBoard, Winner),
    write(Winner),
    nl,
% 9. Finalizar juego y actualizar estadísticas
   end_game(G11, EndedGame),

% 10. Mostrar historial de movimientos
   write('Historial de movimientos: '),
   game_history(EndedGame, History),
   write(History),
   nl,

% 11. Mostrar estado final del tablero
   write('Estado final del tablero: '),
   nl,
   game_get_board(EndedGame, FinalBoard),
   write(FinalBoard),
   nl,


% 8. Verificación de empate
    write('Es empate en el G11?'),
    !,
    is_draw(G11),
    nl.











