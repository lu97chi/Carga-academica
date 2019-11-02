:- ensure_loaded(materias).
:- ensure_loaded(seriadas).
:- ensure_loaded(parametros).
:- ensure_loaded(loaders).

obtenerMateriasPorDificultad(X1,X2,D,X4):- materia(X1,X2,D,X4).
obtenerMateriasPorCreditos(X1, C, X3,X4):- materia(X1, C, X3,X4).
obtenerMateriaPorSemestreMinimo(X1, X2, X3, M):- materia(X1,X2,X3,M).


% semestre, carga academica cursada
start:-
    write("¿El alumno trabaja?"),
    read(WORK),
    write("¿Usar por defecto?"),
    read(DEFAULT),
    (DEFAULT == 'si' -> 
        loadDefaultData(Materias, Actual) ; 
        insertData(Materias, Actual)),
    (WORK == 'si' -> 
        loadProposal(13, Materias, Actual) ;
        loadProposal(12, Materias, Actual)).