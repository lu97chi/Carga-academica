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

wireN(Semester):- format("------Semestre ~a ---------", [Semester]), nl.

iterateOverSemesters(Start, [], End):-
    NextSemester is Start + 1,
    NextSemester =< End,
    getAllSubjects(Start, CarryList),
    length(CarryList, L),
    nl,
    (L > 0 -> NextList = CarryList ; NextList = []),
    (L > 0 -> wireN(Start) ; (
        NextAux is Start + 1,
        iterateOverSemesters(NextAux, [], End))),
    % ([ H | _ ] = CarryList ; CarryList),
    [H | _] = CarryList,
    write(H),
    nl,
    iterateOverSemesters(NextSemester, NextList, End).

getAllSubjects(X, Materias):-
    materiaSemestre(X, Materias).