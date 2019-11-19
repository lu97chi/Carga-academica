:- dynamic(failed/1).
:- ensure_loaded(materias).
:- ensure_loaded(materiasSemestre).

% [[inteligencia_artificial,4,3],[ingenieria_web,4,3],[proyecto_integrador_de_ingenieria_de_software,5,3],[residencias,0,3]]
failed([]).

member(X,[X|_]).
member(X,[_|T]):- member(X,T).

pushToFront(Item, List, [Item | List]).

% cable que separa cada semestre
wireN(Semester):- 
    ansi_format([underline,fg(blue)], 
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
    [ Name, Credits, Diff | _ ] = Current,
    random_between(1, 10, R),
    PassOrNot is R - Diff,
    (PassOrNot < 0 ->
            ansi_format([underline,fg(red)], 
            'MATERIA REPROBADA: ~a', 
            [Name]),
            nl,
            write("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"),
            nl,
            failed(FAILED),
            pushToFront(Name, FAILED, NewList),
            retract(failed(_)),
            assert(failed(NewList))
            ;
            writer(Name, Credits)
    ),
    writeAllSubjectsWithCredits(T).

recoverListAndDeleteIt():-
    retract(failed(_)),
    assert(failed([])).
    

% writeAllSubjectsWithCredits2(CarryList, _):-
%     length(CarryList, L),
%     L > 0,
%     [ Current | T] = CarryList,
%     [ Name, Credits | _ ] = Current,
%     random_between(1, 10, R),
%     (R > 8 ->
%             ansi_format([underline,fg(red)], 
%             'MATERIA REPROBADA: ~a', 
%             [Name]),
%             nl,
%             write("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"),
%             nl,
%             FailSubject = Name
%             ;
%             writer(Name, Credits)
%     ),
%     write(FailSubject),
%     writeAllSubjectsWithCredits2(T, FailSubject).

writer(Name, Credits):-
    format("Nombre de materia: ~a", [Name]),
    nl,
    format("Creditos de la materia: ~a", [Credits]),
    nl,
    write("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"),
    nl.

% calcular los creditos por materia
calcCreditsBySubjects([], 0).
calcCreditsBySubjects(X, Counter):-
    length(X, Iterations),
    Iterations > 0,
    [H | T] = X,
    materia(H, Creditos, _, _),
    calcCreditsBySubjects(T, AuxC),
    Counter is AuxC + Creditos.

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

% regresa materia individualmente
getSubjects([], []).
getSubjects([ActualSubject | T]):-
    [ SubjectName | _ ] = ActualSubject,
    write(SubjectName),
    nl,
    getSubjects(T).

isNonElement(_, []).
isNonElement(X, [H | T]) :- dif(X, H), isNonElement(X,T).

% eliminar materias cursadas
% listToDelete, listFromDelete, listWithDeletion
% con esta funcion me regresa la lista de las materias pendientes, solo resta iterar sobre ellas
% no hay que validar que una este seriada de otra, al estar en orden se tomara ese orden
delete(_, [], []).
delete(Y, [H | T], Z):- member(H, Y), delete(Y, T, Z).
delete(Y, [H | T], [H | Z]) :- isNonElement(H, Y), delete(Y, T, Z).

append(0, List, List).
append(List, 0, List).
append([], List, List).
append([Head|Tail], List, [Head|Rest]) :-
    append(Tail, List, Rest).

flatt([], []) :- !.
flatt([L|Ls], FlatL) :-
    !,
    flatt(L, NewL),
    flatt(Ls, NewLs),
    append(NewL, NewLs, FlatL).
flatt(L, [L]).