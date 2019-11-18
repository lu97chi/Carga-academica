% :- dynamic(listKeeper/1).

:- ensure_loaded(helpers).
:- ensure_loaded(materias).
:- ensure_loaded(main).

% listKeeper([]).



finalCharge([], 0, [], 1).
finalCharge(Subjects, Counter, Semester, SemesterInNumber):-
    % retract(listKeeper(_)),
    totalCreditos(Y),
    length(Subjects, L),
    [ SubjectName | T ] = Subjects,
    materia(SubjectName, Credits, _, _),
    AuxCounter is Counter + Credits,
    AuxSubject = [SubjectName, Credits | _],
    (
        AuxCounter > Y -> 
        NextSemester is SemesterInNumber + 1,
        wireN(SemesterInNumber),
        formatWriteTotalCredits(AuxCounter),
        failed(FAILSUBJECTS),
        length(FAILSUBJECTS, FS),
        (writeAllSubjectsWithCredits(Semester) -> writeAllSubjectsWithCredits(Semester) ; write('')),
        % de alguna manera agregar a la lista las reprobadas
        ( FS >  0 -> 
            % assert(listKeeper(FAILSUBJECTS)),
            recoverListAndDeleteIt,
            pushToFront(FAILSUBJECTS, T, NEWT),
            flatt(NEWT, UNILIST),
            write(UNILIST),
            finalCharge(UNILIST, 0, [AuxSubject], NextSemester) 
            ; 
            finalCharge(T, 0, [AuxSubject], NextSemester)
        )
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

    finalCharge(T, AuxCounter, ActualCharge, SemesterInNumber).
