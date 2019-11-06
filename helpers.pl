:- ensure_loaded(materias).
:- ensure_loaded(materiasSemestre).

% [[inteligencia_artificial,4,3],[ingenieria_web,4,3],[proyecto_integrador_de_ingenieria_de_software,5,3],[residencias,0,3]]

member(X,[X|_]).
member(X,[_|T]):- member(X,T).

pushToFront(Item, List, [Item | List]).

% cable que separa cada semestre
wireN(Semester):- 
    ansi_format([underline,fg(red)], 
        '--------------- Semestre ~a ---------------', 
        [Semester]), nl.

% escritura de creditos totales
formatWriteTotalCredits(Total):-
    ansi_format([underline,fg(cyan)], 
        'Creditos obtenidos este semestre ~a', 
        [Total]),
    nl.

% formateador que escribe bonito el texto
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
% calcula los creditos de una lista de listas de materias
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
% calcMinimunCredits(0, MaxSemester, _) :- MaxSemester = 12 ; MaxSemester = 13.
% calcMinimunCredits(Acc, MaxSemster, CurrentSemester, MateriasSeleccionadas):-
%     NextSemester is CurrentSemester + 1,
%     NextSemester =< MaxSemster,
%     materiaSemestre(CurrentSemester, Materias),
%     [ Nombre | _ ] = Materias,
%     calcMinimunCredits(AuxAcc, MaxSemster, NextSemester, Nombre),
%     Acc is AuxAcc + 5,
%     MateriasSeleccionadas is Nombre.
% calcular creditos maximos


% regresa materia individualmente
getSubjects([], []).
getSubjects([ActualSubject | T]):-
    [ SubjectName | _ ] = ActualSubject,
    write(SubjectName),
    nl,
    getSubjects(T).

 % in progress
% addSubjectsToList(1, 1).
% addSubjectsToList(Start, End):-
%     Next is Start + 1,
%     Start =< End,
%     materiaSemestre(Start, Subjects),
%     length(Subjects, L),
%     L > 0,
%     getSubjects(Subjects),
%     nl,
%     % assert(actualSubjects(Subjects)),
%     addSubjectsToList(Next, End).


% obtenerMateriasPorDificultad(X1,X2,D,X4):- materia(X1,X2,D,X4).
% obtenerMateriasPorCreditos(X1, C, X3,X4):- materia(X1, C, X3,X4).
% obtenerMateriaPorSemestreMinimo(X1, X2, X3, M):- materia(X1,X2,X3,M).


isNonElement(_, []).
isNonElement(X, [H | T]) :- dif(X, H), isNonElement(X,T).

% eliminar materias cursadas
% listToDelete, listFromDelete, listWithDeletion
% con esta funcion me regresa la lista de las materias pendientes, solo resta iterar sobre ellas
% no hay que validar que una este seriada de otra, al estar en orden se tomara ese orden
delete(_, [], []).
delete(Y, [H | T], Z):- member(H, Y), delete(Y, T, Z).
delete(Y, [H | T], [H | Z]) :- isNonElement(H, Y), delete(Y, T, Z).
