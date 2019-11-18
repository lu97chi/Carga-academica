% se encarga de manejar la configuracion inicial del programa
:- ensure_loaded(materias).
:- ensure_loaded(materiasSemestre).
:- ensure_loaded(helpers).
:- ensure_loaded(defaults).
:- ensure_loaded(anyPoint).

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
