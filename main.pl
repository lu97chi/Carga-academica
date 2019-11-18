:- dynamic(totalCreditos/1).

:- ensure_loaded(materias).
:- ensure_loaded(seriadas).
:- ensure_loaded(loaders).
:- ensure_loaded(carga).
:- ensure_loaded(anyPoint).
% :- ensure_loaded(cargaTrabajo).
:- ensure_loaded(finalCharge).
:- ensure_loaded(cargaEspecial).

totalCreditos(36).

% optimal charge is for not working and semester 1
% optimal Charge is done
start:-
    retract(totalCreditos(_)),
    write("¿El alumno trabaja? (responda si / no)"),
    read(WORK),
    (WORK == 'si' -> 
        MaxSemesters = 12, CreditsPerSemester = 20 ; 
        MaxSemesters = 13, CreditsPerSemester = 36),
    write("¿En que semestre empezaremos?"),
    read(START),
    (
        WORK == 'si' -> 
        assert(totalCreditos(20)),
        (
            START == 1 -> 
            allSubjectsInOrder(ALL),
            finalCharge(ALL, 0, [], START) 
            ;
            loadRequeriments(START, MaxSemesters, CreditsPerSemester, REMANING),
            % at this point the charge is valid, 
            %has the subjects and can end the school
            loadFailSubjects(RC, ESPECIAL),
            (RC = 0, ESPECIAL = 0 -> 
                finalCharge(REMANING, 0, [], START)
                ;
                % at this point we have a list of RCs !OR! a list of Especials
                chargeWithFailures(ESPECIAL, RC, REMANING, START, CreditsPerSemester)
            )
        ) 
    ; 
    assert(totalCreditos(30)),
        (
            START == 1 -> 
            optimalCharge(START, [], MaxSemesters) 
            ;
            loadRequeriments(START, MaxSemesters, CreditsPerSemester, REMANING),
            % at this point the charge is valid, has the subjects and can end the school
            loadFailSubjects(RC, ESPECIAL),
            (RC == 0, ESPECIAL == 0 -> 
                finalCharge(REMANING, 0, [], START)
                ;
                % at this point we have a list of RCs !OR! a list of Especials
                write("WORK IN PROGRESS")
            )
        )
    ).
