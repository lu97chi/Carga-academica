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