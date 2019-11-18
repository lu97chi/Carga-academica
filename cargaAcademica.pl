% tienes la lista de las materias restantes, basado en eso generaras un numero aleatorio, si sale 9 - 10, reprobo, si no no
% si reprueba una materia se pone en una lista de materias reprobadas, para el siguiente semestre y esas seran las primeras en salir
% las que no repruebe se quitaran de la lista de las materias, entonces remaning tendra remaning - reprobadas

% el predicado delete me elimina una de lista de otra lista
% como quiero hacer esto...
% 
cargaAcademica([], 0, [], 1).
cargaAcademica(RESTANTES, COUNTER, ACTUAL, NUMSEMESTRE):-
    random_between(1, 10, PASO),
    (
        PASO > 8 -> write("reprobo") ; write("paso.")   
    ).