:- ensure_loaded(materias).
:- ensure_loaded(materiasSemestre).

% [[inteligencia_artificial,4,3],[ingenieria_web,4,3],[proyecto_integrador_de_ingenieria_de_software,5,3],[residencias,0,3]]

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

% calcCreditsBySubjects2([], 0).
% getSubjectsIndividual([], []).
% getSubjectsIndividual(List, []):-
%     [ Name | _ ] = List,
%     pushToFront(Name, [], Payload),
%     getSubjectsIndividual(L,Payload).

%[[a,s],[d,f],[g,h]]
calcCreditsBySubjectsList([], 0).
calcCreditsBySubjectsList(List, Counter):-
    length(List, L),
    L > 0,
    [ Current | Remaning ] = List,
    [ _ , Credits | _ ] = Current,
    calcCreditsBySubjectsList(Remaning, AuxC),
    Counter is AuxC + Credits.


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

