:- ensure_loaded(materias).
:- ensure_loaded(seriadas).
:- ensure_loaded(parametros).
:- ensure_loaded(loaders).
:- ensure_loaded(carga).
:- ensure_loaded(anyPoint).
:- ensure_loaded(cargaTrabajo).


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
        MaxSemesters = 12, CreditsPerSemester = 20 ; 
        MaxSemesters = 13, CreditsPerSemester = 36),
    write("¿En que semestre empezaremos?"),
    read(START),
    (WORK == 'si' -> 
        (
            START == 1 -> 
            allSubjectsInOrder(ALL),
            workCharge(ALL, 0, [], START) ;
            % START != 1
            write("¿Usar carga por defecto?"),
            read(DEFAULTDATA),
            (
                DEFAULTDATA == 'si' -> 
                validateIfCouldEnd(START, [], MaxSemesters, CreditsPerSemester),
                materiasCursadas(COURSED),
                delete(COURSED, ALL, REMANING),
                workCharge(REMANING, 0, [], START) ;
                write("STill in progress to insert materias cursadas y trabajo")
            )
        ) ; 
        (
            START == 1 -> 
            optimalCharge(START, [], MaxSemesters) ; 
            write("Still on progress")
        )
    ).
    % Load optimal charge

% validateIfCouldEnd(START, [], MaxSemesters, CreditsPerSemester)

% if (!work) {
%     if (semester == 1) {
%         optimalCharge()
%     } else {
%         chargeWithoutSubjectsDone(36)
%     }
% } else {
%     if (semester == 1) {
%         worstCharge()
%     } else {
%         chargeWithoutSubjectsDone(20)
%     }
% }