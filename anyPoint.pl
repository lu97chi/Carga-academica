:- ensure_loaded(helpers).
:- ensure_loaded(carga).
:- ensure_loaded(seriadas).
:- ensure_loaded(defaults).
:- ensure_loaded(materiasSemestre).
:- ensure_loaded(materias).

:- dynamic(actualSubjects/1).

actualSubjects.

% se usa este si no se quiere usar la carga por defecto
insertSubjectsByKeyboard(SUBJECTS):-
    write("Ingrese las materias cursadas, con el formato [nombre_materia, nombre_materia2]"),
    read(SUBJECTS).

validateIfCouldEnd(Start,End, CreditsPerSemester, SUBJECTS):- 
    write("Desea usar el ejemplo de materias? (si = usar por defecto, no = entrar por teclado)"),
    read(DEFAULT),
    (DEFAULT == 'si' -> 
        materiasCursadas(SUBJECTS) ; 
        insertSubjectsByKeyboard(SUBJECTS)),
    calcCreditsBySubjects(SUBJECTS, TotalCreditsSoFar),
    Remaning is End - Start,
    write(Remaning),
    PosibleCredits is Remaning * 36,
    RemaningCredits is 260 - TotalCreditsSoFar,
    (PosibleCredits < RemaningCredits -> 
        throw("No podras graduarte, sorry")
        ; 
        (validateSubjectsGiven(SUBJECTS, SUBJECTS) -> 
            write("OK, Empezemos") ;
            write("No es una carga valida"), 
            nl,
            validateIfCouldEnd(Start, End, CreditsPerSemester, _))).

% toma la cabeza, buscala en la base de seriadas
% si la cabeza no esta en ninguna de las seriadas continua
% si no, busca la que esta antes en la lista de materias que
% tienes
% validateSubjectsGiven([]).
% validateSubjectsGiven(SUBJECTS):-
%     length(SUBJECTS, L),
%     L > 0,
%     [ H | T] = SUBJECTS,
%     (seriada(H, Requisite) -> 
%         member(Requisite, SUBJECTS) ; 
%         validateSubjectsGiven(T)),
%     validateSubjectsGiven(T).

validateSubjectsGiven(_, []).
validateSubjectsGiven(SUBJECTS, CarryList):-
    length(CarryList, L),
    L > 0,
    [ H | T] = CarryList,
    (seriada(H, Requisite) -> 
        member(Requisite, SUBJECTS), validateSubjectsGiven(SUBJECTS, T) ; 
        validateSubjectsGiven(SUBJECTS, T)).


% [tallerEtica, calculoDiferencial, calculoIntegral]
% [tallerEtica, calculoIntegral, calculoDiferencial]