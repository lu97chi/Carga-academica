:- ensure_loaded(helpers).
:- ensure_loaded(carga).
:- ensure_loaded(seriadas).
:- ensure_loaded(defaults).

insertSubjectsByKeyboard(SUBJECTS):-
    write("Ingrese las materias cursadas, con el formato [nombre_materia, nombre_materia2]"),
    read(SUBJECTS).

validateIfCouldEnd(Start,Materias,End, CreditsPerSemester):- 
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
            optimalChargeSemesterRuning(Start, SUBJECTS, End, CreditsPerSemester, TotalCreditsSoFar) ;
            write("No es una carga valida"), 
            nl,
            validateIfCouldEnd(Start, Materias, End, CreditsPerSemester))).
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
    write(Start).