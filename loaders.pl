% se encarga de manejar la configuracion inicial del programa
:- ensure_loaded(materias).
:- ensure_loaded(materiasSemestre).
:- ensure_loaded(helpers).
:- ensure_loaded(defaults).
:- ensure_loaded(anyPoint).
:- ensure_loaded(finalCharge).


loadRequeriments(START, MaxSemesters,CreditsPerSemester,REMANING):-
    allSubjectsInOrder(ALL), 
    validateIfCouldEnd(START, MaxSemesters, CreditsPerSemester, SUBJECTS),
    nl,
    % at this point the charge is valid and has the subjects
    delete(SUBJECTS, ALL, REMANING).


loadFailSubjects(RC, ESPECIAL):-
    write("¿Tienes materias en RC?"),
    read(RCSTATUS),
    (RCSTATUS == 'si' -> 
        write("¿Quieres cargar los rc por defecto?"),
        read(DEFAULTRCSTATUS),
        (DEFAULTRCSTATUS == 'si' -> 
            materiasReprobadas(RC)
            ;
            write("Ingrese las materias en rc"),
            read(RC)
        )
        ;
        RC = 0
    ),
    write("¿Tienes materias especiales?"),
    read(ESPECIALSTATUS),
    (ESPECIALSTATUS == 'si' -> 
        write("¿Quieres cargar los especiales por defecto?"),
        read(DEFAULTSPECIALSTATUS),
        (DEFAULTSPECIALSTATUS == 'si' ->
            especiales(ESPECIAL)
            ;
            write("Ingrese las materias especiales"),
            read(ESPECIAL)
        )
        ;
        ESPECIAL = 0 
    ).

loadForSemester(START):-
    allSubjectsInOrder(ALL),
    finalCharge(ALL, 0, [], START).


loadFinal(START, MaxSemesters, CreditsPerSemester):-
    (START > 1 -> 
        loadRequeriments(START, MaxSemesters, CreditsPerSemester, REMANING),
        ActualSubjects = REMANING,
        loadFailSubjects(RC, ESPECIAL)
    ;
        allSubjectsInOrder(ALL),
        ActualSubjects = ALL
    ),
    % at this point the charge is valid, has the subjects and can end the school
    (RC = 0, ESPECIAL = 0 -> 
        finalCharge(ActualSubjects, 0, [], START)
    ;
    % at this point we have a list of RCs !OR! a list of Especials
        chargeWithFailures(ESPECIAL, RC, ActualSubjects, START)
    ).