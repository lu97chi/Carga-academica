:- ensure_loaded(materiasSemestre).
:- ensure_loaded(materias).
:- ensure_loaded(helpers).


% este se encarga de dar la mejor carga posible, cuando un alumno no trabaja y esta en semestre 1
optimalCharge(Start, [], End):-
    NextSemester is Start + 1,
    NextSemester =< End,
    getAllSubjects(Start, CarryList),
    length(CarryList, L),
    nl,
    (L > 0 -> NextList = CarryList ; NextList = []),
    (L > 0 -> wireN(Start) ; (
        NextAux is Start + 1,
        optimalCharge(NextAux, [], End))),
    % from here CarryList is never empty
    calcCreditsBySubjectsList(CarryList, Total),
    formatWriteTotalCredits(Total),
    writeAllSubjectsWithCredits(CarryList),
    nl,
    optimalCharge(NextSemester, NextList, End).



% funcion que regresa todas las materias de X semestre
getAllSubjects(X, Materias):-
    materiaSemestre(X, Materias).

chargeNonWork([], 0, [], 1).
chargeNonWork(Subjects, Counter, Semester, SemesterInNumber):-
    length(Subjects, L),
    [ SubjectName | T ] = Subjects,
    materia(SubjectName, Credits, _, _),
    AuxCounter is Counter + Credits,
    AuxSubject = [SubjectName, Credits | _ ],
    (
        AuxCounter > 30 -> 
        NextSemester is SemesterInNumber + 1,
        wireN(SemesterInNumber),
        formatWriteTotalCredits(AuxCounter),
        (
            writeAllSubjectsWithCredits(Semester) -> 
            writeAllSubjectsWithCredits(Semester) 
            ; 
            write('')
        ),
        chargeNonWork(T, 0, [AuxSubject], NextSemester)
        ;
        pushToFront(AuxSubject, Semester, ActualCharge)
    ),
    (
        L == 1 -> 
        NextSemester is SemesterInNumber + 1,
        wireN(SemesterInNumber),
        [ _, RelativeCredit | _ ] = AuxSubject,
        RelativeSum is RelativeCredit + AuxCounter,
        formatWriteTotalCredits(RelativeSum),
        pushToFront(AuxSubject, Semester, ActualCharge),
        (
            writeAllSubjectsWithCredits(ActualCharge) -> 
            writeAllSubjectsWithCredits(ActualCharge) 
            ; 
            write('')
        );
        write('')
    ),
    L > 0,
    chargeNonWork(T, AuxCounter, ActualCharge, SemesterInNumber).