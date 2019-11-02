% se encarga de manejar la configuracion inicial del programa
:- ensure_loaded(materias).

% configuracion por defecto
materiasCursadas([tallerEtica, tallerAdministracion]).
semestreActual(2).


loadProposal(_, [], 0).
loadProposal(Max_Semester, Materias, Actual):- 
    [ H | T ] = Materias,
    materia(H, Credits, D, Sm),
    write(H),
    write(Credits),
    write(D),
    write(Sm),
    RemaningCounter is Actual - 1,
    RemaningCounter > 0,
    loadProposal(Max_Semester, T, RemaningCounter).


% done
calcCreditsBySubjects([], 0).
calcCreditsBySubjects(X, Counter):-
    length(X, Iterations),
    Iterations > 0,
    [H | T] = X,
    materia(H, Creditos, _, _),
    calcCreditsBySubjects(T, AuxC),
    Counter is AuxC + Creditos.

% actual, total, subjects
getSubjectsRemaning(0, _ ,[]).
getSubjectsRemaning(ActualSemester, TotalSemesters, X):-
    ActualSemester =< TotalSemesters,
    materia(Subject, ActualSemester, _, _),
    getSubjectsRemaning(AuxActual, TotalSemesters, Subject),
    AuxActual is ActualSemester + 1,
    X is Subject.

    
    

loadDefaultData(X, Y):- 
    materiasCursadas(X),
    semestreActual(Y).

insertData(X,Y):- 
    write("Inserte las materias cursadas, en formato de lista [nombre_materia]"),
    read(X),
    write("Inserte el semestre actual"),
    read(Y).
