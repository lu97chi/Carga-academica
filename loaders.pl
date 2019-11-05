% se encarga de manejar la configuracion inicial del programa
:- ensure_loaded(materias).
:- ensure_loaded(materiasSemestre).
:- ensure_loaded(helpers).
:- ensure_loaded(defaults).

% configuracion por defecto
% max semester
% obtenerCarga(0, []).
% obtenerCarga(Max, Result):-
%     AuxCounter is Max - 1,
%     AuxCounter > 0,
%     materia(NombreMateria, _,_,AuxCounter),
%     pushToFront(NombreMateria, Result, ResultPush),
%     write(ResultPush),
%     nl,
%     obtenerCarga(AuxCounter, Result).
    
% carga la informacion por defecto
loadDefaultData(X, Y):- 
    materiasCursadas(X),
    semestreActual(Y).

% inserta la informacion por teclado
insertData(X,Y):- 
    write("Inserte las materias cursadas, en formato de lista [nombre_materia]"),
    read(X),
    write("Inserte el semestre actual"),
    read(Y).
