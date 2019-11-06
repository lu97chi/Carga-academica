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

validateIfCouldEnd(Start,Materias,End, CreditsPerSemester, SUBJECTS):- 
    write("Desea usar el ejemplo de materias? (si = usar por defecto, no = entrar por teclado)"),
    read(DEFAULT),
    (DEFAULT == 'si' -> 
        materiasCursadas(SUBJECTS) ; 
        insertSubjectsByKeyboard(SUBJECTS)),
    calcCreditsBySubjects(SUBJECTS, TotalCreditsSoFar),
    Remaning is End - Start,
    PosibleCredits is Remaning * 36,
    RemaningCredits is 260 - TotalCreditsSoFar,
    (PosibleCredits < RemaningCredits -> 
        write("No podras graduarte, sorry") ; 
        (validateSubjectsGiven(SUBJECTS) -> 
            % optimalChargeSemesterRuning(Start, SUBJECTS, End, CreditsPerSemester, TotalCreditsSoFar) ;
            write("OK, Empezemos") ;
            write("No es una carga valida"), 
            nl,
            validateIfCouldEnd(Start, Materias, End, CreditsPerSemester, SUBJECTS))).
        % optimalChargeSemesterRuning(Start, Materias, End, CreditsPerSemester, TotalCreditsSoFar)).

% toma la cabeza, buscala en la base de seriadas
% si la cabeza no esta en ninguna de las seriadas continua
% si no, busca la que esta antes en la lista de materias que
% tienes
validateSubjectsGiven([]).
validateSubjectsGiven(SUBJECTS):-
    length(SUBJECTS, L),
    L > 0,
    [ H | T] = SUBJECTS,
    (seriada(H, Requisite) -> 
        member(Requisite, SUBJECTS) ; 
        validateSubjectsGiven(T)),
    validateSubjectsGiven(T).

% en este punto la carga es valida, osea, lleva una carga con
% las materias seriadas respectivamente, es necesario
% eliminar de la lista las materias llevadas
% Materias = Materias cursadas y pasadas
optimalChargeSemesterRuning(Start, Materias, End, CreditsPerSemester, TotalCreditsSoFar):-
    materia(Nombre, Credits, _, _),
    actualSubjects(X),
    pushToFront(Nombre, X, NewList),
    assert(actualSubjects(NewList)).

% formateador de texto para que se vea bonito
writer(Semester, Name, Credits):-
    ansi_format([underline,fg(red)], 
        '--------------- Semestre ~a ---------------', 
        [Semester]), nl,
        format("Nombre de materia: ~a", [Name]),
        nl,
        format("Creditos de la materia: ~a", [Credits]),
        nl,
        write("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"),
        nl.