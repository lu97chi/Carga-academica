:- ensure_loaded(helpers).
:- ensure_loaded(materias).
:- ensure_loaded(finalCharge).

% funciona pero solo si tienes multiplos de dos para los especiales
chargeWithFailures([], [], [], _).
chargeWithFailures(ESPECIALS, RCS, REMANING, START):-
    append(ESPECIALS, RCS, EspRc),
    append(EspRc, REMANING, Final),
    ( ESPECIALS == 0 -> EVALLIST = []; EVALLIST = ESPECIALS),
    length(EVALLIST, SPL),
    (SPL >= 2 -> 
        RelativeTimes is SPL / 2,
        RealTimes is floor(RelativeTimes),
        justEspecials(RealTimes, ESPECIALS, START),
        delete(ESPECIALS, Final, FinalNoEspecial),
        StartOf is START + RealTimes,
        finalCharge(FinalNoEspecial, 0, [], StartOf)
        ;
        finalCharge(Final, 0, [], START)
    ).


justEspecials(0, _, _).
justEspecials(Times, Especials, Start):-
    NextTime is Times - 1,
    NextSemester is Start + 1,
    Times > 0,
    [ SP1, SP2 | RSP ] = Especials,
    wireN(Start),
    calcCreditsBySubjects([SP1,SP2 | []], Credits),
    formatWriteTotalCredits(Credits),
    materia(SP1, Credits1, Diff1, _),
    materia(SP2, Credits2, Diff2, _),
    (
        writeAllSubjectsWithCredits([[SP1, Credits1, Diff1 | _], [SP2, Credits2, Diff2 | _]]) ->
        writeAllSubjectsWithCredits([[SP1, Credits1, Diff1 | _], [SP2, Credits2, Diff2 | _]]) ;
        write('')
    ),
    justEspecials(NextTime, RSP, NextSemester).