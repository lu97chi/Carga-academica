:- ensure_loaded(materias).
:- ensure_loaded(seriadas).
:- ensure_loaded(parametros).
:- ensure_loaded(loaders).

% semestre, carga academica cursada
% start:-
%     write("¿El alumno trabaja?"),
%     read(WORK),
%     write("¿Usar por defecto?"),
%     read(DEFAULT),
%     (DEFAULT == 'si' -> 
%         loadDefaultData(Materias, Actual) ; 
%         insertData(Materias, Actual)),
%     (WORK == 'si' -> 
%         loadProposal(13, Materias, Actual) ;
%         loadProposal(12, Materias, Actual)).