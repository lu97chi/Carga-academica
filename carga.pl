:- ensure_loaded(materiasSemestre).
:- ensure_loaded(materias).
:- ensure_loaded(helpers).

% cargaSemestre(X, Materias):- materiaSemestre(X,Materias).

% cargaTotal(SemestreActual, SemestresTotales, Materias):-
%     NextSemester is SemestreActual + 1,
%     SemestreActual =< SemestresTotales,
%     cargaSemestre(SemestreActual, MateriasSemestre),
%     cargaTotal(NextSemester, SemestresTotales, _).

% writeOnly([], []).
% writeOnly(Subjects, Printed):-
%     length(Subjects, Iterations),
%     Iterations > 0,
%     [ Materia | Tail ] = Subjects,
%     pushToFront(Materia, Printed, Result),
%     write(Result),
%     nl,
%     writeOnly(Tail, Result).

% iterator(0,0).
% iterator(Start, End):-
%     Next is Start + 1,
%     Start =< End,
%     getSubjects(Start, ReturnMaterias),
%     materia(Materia, _,_,Start),
%     format('Semestre : ~a', [Start]),
%     format('~a', [Materia]),
%     nl,   
%     iterator(Next, End).

% writeNonEmpty(List):- 
%     length(List, Materias),
%     Materias > 0,
%     write(Materias).

writeAllSubjectsWithCredits(CarryList):-
    length(CarryList, L),
    L > 0,
    [ Current | T] = CarryList,
    [ Name, Credits | _ ] = Current,
    format("Nombre de materia: ~a", [Name]),
    nl,
    format("Creditos de la materia: ~a", [Credits]),
    nl,
    write("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"),
    nl,
    writeAllSubjectsWithCredits(T).

wireN(Semester):- 
    ansi_format([underline,fg(red)], 
        '--------------- Semestre ~a ---------------', 
        [Semester]), nl.

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
    ansi_format([underline,fg(cyan)], 
        'Creditos obtenidos este semestre ~a', 
        [Total]),
    nl,
    writeAllSubjectsWithCredits(CarryList),
    nl,
    optimalCharge(NextSemester, NextList, End).

getAllSubjects(X, Materias):-
    materiaSemestre(X, Materias).