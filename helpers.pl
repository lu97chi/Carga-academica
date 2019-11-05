:- ensure_loaded(materias).
:- ensure_loaded(materiasSemestre).

member(X,[X|_]).
member(X,[_|T]):- member(X,T).

pushToFront(Item, List, [Item | List]).

% calcular los creditos por materia
calcCreditsBySubjects([], 0).
calcCreditsBySubjects(X, Counter):-
    length(X, Iterations),
    Iterations > 0,
    [H | T] = X,
    materia(H, Creditos, _, _),
    calcCreditsBySubjects(T, AuxC),
    Counter is AuxC + Creditos.

% calcular creditos minimos
% esta funcion se encarga de tomar las materias necesarias para completar los creditos
% minimos, los cuales son 20, como se hace eso, se toma de referencia el semestre
% que se encuentra y se agrupan en una lista y esa es una respuesta para ese semestre
% las siguientes respuestas no se toma en cuenta el semestre, ya que no importara eso
% pero no te puede dar una materia que aun no llevas
calcMinimunCredits(0, MaxSemester, _) :- MaxSemester = 12 ; MaxSemester = 13.
calcMinimunCredits(Acc, MaxSemster, CurrentSemester, MateriasSeleccionadas):-
    NextSemester is CurrentSemester + 1,
    NextSemester =< MaxSemster,
    materiaSemestre(CurrentSemester, Materias),
    [ Nombre | _ ] = Materias,
    calcMinimunCredits(AuxAcc, MaxSemster, NextSemester, Nombre),
    Acc is AuxAcc + 5,
    MateriasSeleccionadas is Nombre.

% calcular creditos maximos


% regresa materia individualmente
% getSubjects([]).
% getSubjects([ActualSubject | T]):-
%     [ SubjectName | _ ] = ActualSubject,
%     write(SubjectName),
%     nl,
%     getSubjects(T).
 

obtenerMateriasPorDificultad(X1,X2,D,X4):- materia(X1,X2,D,X4).
obtenerMateriasPorCreditos(X1, C, X3,X4):- materia(X1, C, X3,X4).
obtenerMateriaPorSemestreMinimo(X1, X2, X3, M):- materia(X1,X2,X3,M).

