:- ensure_loaded(helpers).
:- ensure_loaded(carga).
:- ensure_loaded(seriadas).
:- ensure_loaded(defaults).
:- ensure_loaded(materiasSemestre).
:- ensure_loaded(materias).

:- dynamic(actualSubjects/1).

actualSubjects.

materiaEspecialidad(ingeneriaSoftware).

% se usa este si no se quiere usar la carga por defecto
insertSubjectsByKeyboard(SUBJECTS):-
    write("Ingrese las materias cursadas, con el formato [nombre_materia, nombre_materia2]"),
    read(SUBJECTS).
%182
validateIfTSU([], _).
validateIfTSU(SUBJECTS, XP):-
    [H | T] = SUBJECTS,
    calcCreditsBySubjects(SUBJECTS, TOTAL),
    ((H == XP, TOTAL >= 4) -> 
        write("Deberias solicitar TSU"),
        false
        ;
    validateIfTSU(T, XP)),
    throw("NO PODRAS GRADUARTE, SORRY").
    



validateIfCouldEnd(Start,End, CreditsPerSemester, SUBJECTS):- 
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
        materiaEspecialidad(XP),
        validateIfTSU(SUBJECTS, XP)  
        ; 
        (validateSubjectsGiven(SUBJECTS, SUBJECTS) -> 
            write("OK, Empezemos") ;
            write("No es una carga valida"), 
            nl,
            validateIfCouldEnd(Start, End, CreditsPerSemester, _))).

validateSubjectsGiven(_, []).
validateSubjectsGiven(SUBJECTS, CarryList):-
    length(CarryList, L),
    L > 0,
    [ H | T] = CarryList,
    (seriada(H, Requisite) -> 
        member(Requisite, SUBJECTS), validateSubjectsGiven(SUBJECTS, T) ; 
        validateSubjectsGiven(SUBJECTS, T)).

