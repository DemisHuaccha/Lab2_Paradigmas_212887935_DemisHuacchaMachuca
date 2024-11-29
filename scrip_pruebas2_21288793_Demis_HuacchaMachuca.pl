:- use_module(tdapiece_21288793_HuacchaMachuca,[piece/2]).
:- use_module(tdaplayer_21288793_HuacchaMachuca,[player/8]).
:- use_module(tdaboard_21288793_HuacchaMachuca,[board/1,can_play/1,check_horizontal_win/2,check_vertical_win/2,check_diagonal_win/2,who_is_winner/2]).
:- use_module(tdagame_21288793_HuacchaMachuca,[game/5,is_draw/1, get_current_player/2, game_get_board/2, player_play/4,end_game/2,game_history/2]).

:-set_prolog_flag(answer_write_options, [max_depth(0)]).

main2:-
% 1.Crear jugadores (10 fichas cada uno para un juego corto)
    player(1, "Roberto", "naranjo", 0, 0, 0, 12, P1),
    player(2, "Ana", "purputa", 0, 0, 0, 12, P2),

% 2. Crear fichas
    piece("verde", GreenPiece),
    piece("dorado", GoldenPiece),
    write(GreenPiece),
    nl,
    write(GoldenPiece),
    nl,

% 3. Crear tablero inicial vacío
    board(EmptyBoard),
% 4. Crear nuevo juego
    game(P1, P2, EmptyBoard, 1, G0),
% 5. Realizando movimientos para crear una victoria diagonal

    player_play(G0, P1, 0, G1),      % Roberto juega en columna 0
    player_play(G1, P2, 1, G2),      % Ana juega en columna 1
    player_play(G2, P1, 2, G3),      % Roberto  juega en columna 2
    player_play(G3, P2, 3, G4),      % Ana  juega en columna 3
    player_play(G4, P1, 1, G5),      % Roberto  juega en columna 1
    player_play(G5, P2, 0, G6),      % Ana  juega en columna 0
    player_play(G6, P1, 1, G7),      % Roberto  juega en columna 1
    player_play(G7, P2, 4, G8),      % Ana  juega en columna 4
    player_play(G8, P1, 3, G9),      % Roberto  juega en columna 3
    player_play(G9, P2, 2, G10),     % Ana  juega en columna 2
    player_play(G10, P1, 2, G11),    % Roberto  juega en columna 2

    player_play(G11, P2, 5, G12),    % Roberto  juega en columna 5
    player_play(G12, P1, 4, G13),    % Ana  juega en columna 4
    player_play(G13, P2, 1, G14),    % Roberto  juega en columna 1
    player_play(G14, P1, 3, G15),    % Ana  juega en columna 3
    player_play(G15, P2, 3, G16),    % Roberto  juega en columna 3
    player_play(G16, P1, 1, G17),    % Ana  juega en columna 1
    player_play(G17, P2, 6, G18),    % Roberto  juega en columna 4, victoria horizontal

% 6. Verificaciones del estado del juego
    write('¿Se puede jugar en el tablero vacío? '),
    !,
    can_play(EmptyBoard),
    % Si se puede seguir jugando, el programa continuará
    nl,
    game_get_board(G18, CurrentBoard),
    write('Jugador actual después de 18 movimientos: '),
    get_current_player(G18, CurrentPlayer),
    write(CurrentPlayer),
    nl,
    write('¿Se puede jugar después de 18 movimientos? '),
    !,
    can_play(CurrentBoard),
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
   end_game(G18, EndedGame),

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


% 8. Verificación de empate por tablero lleno

    write('Es empate en el G18?'),
    !,
    is_draw(G18),
    nl.


