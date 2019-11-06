:- ensure_loaded(materias).
:- ensure_loaded(seriadas).
:- ensure_loaded(parametros).
:- ensure_loaded(loaders).
:- ensure_loaded(carga).
:- ensure_loaded(anyPoint).

% optimal charge is for not working and semester 1
% optimal Charge is done
start:-
    write("¿El alumno trabaja? (responda si / no)"),
    read(WORK),
    % write("¿Usar por defecto?"),
    % read(DEFAULT),
    % (DEFAULT == 'si' -> 
    %     loadDefaultData(Materias, Actual) ; 
    %     insertData(Materias, Actual)),
    (WORK == 'si' -> 
        MaxSemesters = 12 ; MaxSemesters = 13),
    (WORK == 'si' -> 
        CreditsPerSemester = 20 ; CreditsPerSemester = 36),
    write("¿En que semestre empezaremos?"),
    read(START),
    (START == 1 -> optimalCharge(START, [], MaxSemesters) ;
    validateIfCouldEnd(START, [], MaxSemesters, CreditsPerSemester)).