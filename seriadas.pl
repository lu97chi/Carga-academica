:- ensure_loaded(materias).

%calculos
seriada(calculoIntegral, calculoDiferencial).
seriada(calculoVectorial, calculoIntegral).
seriada(ecuacionesDiferenciales, calculoVectorial).

%programacion
seriada(programacionOrientadaObjectos, fundamentosProgramacion).
seriada(estructuraDatos, programacionOrientadaObjectos).
seriada(topicosAvanadosDeProgramacion, estructuraDatos).
seriada(simulacion, estructuraDatos).
seriada(simulacion, investigacionDeOperaciones).
seriada(simulacion, probabilidadEstadistica).
seriada(tallerBaseDeDatos, fundamentosBaseDeDatos).
seriada(tallerSistemasOperativos, sistemasOperativos).
seriada(administracionBaseDatos, tallerBaseDeDatos).
seriada(temasSelectosBaseDatos, tallerBaseDeDatos).
seriada(lenguagesYAtuomotas2, lenguagesYAtuomotas).
seriada(pruebasSoftware,fundamentosIngenieriaSoftware).
seriada(gestionProyectosSoftware,ingeneriaSoftware).
seriada(sistemasProgramables,lenguajesDeInterfaz).
seriada(programacionLogicaFuncional,estructuraDatos).
seriada(programacionWeb, tallerBaseDeDatos).
seriada(inteligenciaArtificial, programacionLogicaFuncional).
seriada(ingenieriaWeb, programacionWeb).
seriada(proyectoIntegrador, pruebasSoftware).
seriada(proyectoIntegrador, metodosAgiles).
seriada(proyectoIntegrador, temasSelectosBaseDatos).
%extras
seriada(culturaEmpresarial, contabilidadFinanciera).
seriada(investigacionDeOperaciones, algebraLineal).
seriada(ingeneriaSoftware, fundamentosIngenieriaSoftware).
seriada(tallerInvestigacion2, tallerInvestigacion1).
seriada(metodosAgiles, gestionProyectosSoftware).
seriada(arquitecturaSoftware, ingeneriaSoftware).
seriada(mantenimientoSoftware, fundamentosIngenieriaSoftware).
seriada(residencia, actividadesComplementarias).

%electrica
seriada(principiosEletectricos, fisica).
seriada(arquitecturaDeComputadoras, principiosEletectricos).
seriada(lenguajesDeInterfaz, principiosEletectricos).

%redes
seriada(redesComputadoras, fundamentosTelecomunicaciones).
seriada(conmutacionYEnrutamiento, redesComputadoras).
seriada(administracionRedes, conmutacionYEnrutamiento).

mismoSemestre(proyectoIntegrador, ingenieriaWeb).

