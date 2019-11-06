% una funcion que obtenga una lista de materias, sobre esa lista vamos a iterar
% cada iteracion llevaremos un acumulado, cuando el acumulado sea mayor que 20
% impriremos en pantalla las materias que lleva y el semestre que se encuentra
% hacemos que sea 0 el acumulado y sumamos 1 al semestre
:- ensure_loaded(helpers).
:- dynamic(counting/1).
counting().

% recorre la lista, cuando sea mayor a 20, toma los elementos pasados
% y ese sera tu semestre

workCharge([], 0, []).
workCharge(Subjects, Counter, Semester):-
    length(Subjects, L),
    L > 0,
    % this head will be removed
    [ H | T] = Subjects,
    AuxCounter is Counter + H,
    (AuxCounter > 20 -> 
        write("Carga academica"),
        nl,
        write(Semester),
        nl,
        workCharge(T, 0, [H]);
        pushToFront(H, Semester, ActualCharge)
        ),
    write("REST"),nl,
    write(T),
    nl,
    workCharge(T, AuxCounter, ActualCharge).
