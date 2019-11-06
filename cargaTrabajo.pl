% una funcion que obtenga una lista de materias, sobre esa lista vamos a iterar
% cada iteracion llevaremos un acumulado, cuando el acumulado sea mayor que 20
% impriremos en pantalla las materias que lleva y el semestre que se encuentra
% hacemos que sea 0 el acumulado y sumamos 1 al semestre
:- ensure_loaded(helpers).
:- ensure_loaded(materias).
:- ensure_loaded(helpers).

:- dynamic(counting/1).
counting().

% recorre la lista, cuando sea mayor a 20, toma los elementos pasados
% y ese sera tu semestre

% test -> 
% workCharge([calculoDiferencial, fundamentosProgramacion, tallerEtica, matematicasDiscretas, tallerAdministracion, fundamentosInvestigacion, calculoIntegral, programacionOrientadaObjectos, contabilidadFinanciera, quimica, algebraLineal, probabilidadEstadistica, calculoVectorial, estructuraDatos, culturaEmpresarial], 0, [], 3).
% workCharge([calculoDiferencial, fundamentosProgramacion, tallerEtica, matematicasDiscretas, tallerAdministracion, fundamentosInvestigacion, calculoIntegral, programacionOrientadaObjectos, contabilidadFinanciera, quimica, algebraLineal, probabilidadEstadistica, calculoVectorial, estructuraDatos, culturaEmpresarial, investigacionDeOperaciones,desarrolloSustentable,fisica,ecuacionesDiferenciales,metodosNumericos,topicosAvanadosDeProgramacion,fundamentosBaseDeDatos,simulacion,principiosEletectricos,graficacion,fundamentosTelecomunicaciones,sistemasOperativos,tallerBaseDeDatos,fundamentosIngenieriaSoftware,arquitecturaDeComputadoras,lenguagesYAtuomotas,redesComputadoras,tallerSistemasOperativos,administracionBaseDatos,ingeneriaSoftware,lenguajesDeInterfaz,temasSelectosBaseDatos,lenguagesYAtuomotas2,conmutacionYEnrutamiento,tallerInvestigacion1,pruebasSoftware,gestionProyectosSoftware,sistemasProgramables,programacionLogicaFuncional,administracionRedes,tallerInvestigacion2,programacionWeb,metodosAgiles,arquitecturaSoftware,mantenimientoSoftware,inteligenciaArtificial,ingenieriaWeb,proyectoIntegrador ], 0, [], 3).

% worst case, work and semester is any
workCharge([], 0, [], 1).
workCharge(Subjects, Counter, Semester, SemesterInNumber):-
    length(Subjects, L),
    L > 0,
    [ SubjectName | T ] = Subjects,
    materia(SubjectName, Credits, _, _),
    AuxCounter is Counter + Credits,
    AuxSubject = [SubjectName, Credits | _],
    (AuxCounter > 20 -> 
        NextSemester is SemesterInNumber + 1,
        wireN(SemesterInNumber),
        formatWriteTotalCredits(AuxCounter),
        (writeAllSubjectsWithCredits(Semester) -> 
            writeAllSubjectsWithCredits(Semester) ; write('')),
        workCharge(T, 0, [AuxSubject], NextSemester);
        pushToFront(AuxSubject, Semester, ActualCharge)
        ),
    workCharge(T, AuxCounter, ActualCharge, SemesterInNumber).
