:- ensure_loaded(helpers).
:- ensure_loaded(materias).
:- ensure_loaded(cargaTrabajo).


% especials is a list
% rcs is a list
% remaning is a list
% funciona pero solo si tienes multiplos de dos para los especiales
chargeWithFailures(ESPECIALS, RCS, REMANING, START, CreditsPerSemester):-
    append(ESPECIALS, RCS, EspRc),
    append(EspRc, REMANING, Final),
    length(ESPECIALS, SPL),
    (SPL >= 2 -> 
        RelativeTimes is SPL / 2,
        RealTimes is floor(RelativeTimes),
        justEspecials(RealTimes, ESPECIALS, START),
        delete(ESPECIALS, Final, FinalNoEspecial),
        StartOf is START + RealTimes,
        workCharge(FinalNoEspecial, 0, [], StartOf)
        ;
        write("In progress")
    ),
    write(Final).


justEspecials(0, _, _).
justEspecials(Times, Especials, Start):-
    NextTime is Times - 1,
    NextSemester is Start + 1,
    Times > 0,
    [ SP1, SP2 | RSP ] = Especials,
    wireN(Start),
    calcCreditsBySubjects([SP1,SP2 | []], Credits),
    formatWriteTotalCredits(Credits),
    materia(SP1, Credits1, _, _),
    materia(SP2, Credits2, _, _),
    (
        writeAllSubjectsWithCredits([[SP1, Credits1 | _], [SP2, Credits2 | _]]) ->
        writeAllSubjectsWithCredits([[SP1, Credits1 | _], [SP2, Credits2 | _]]) ;
        write('')
    ),
    justEspecials(NextTime, RSP, NextSemester).

% the output of both, handleRcs and handleEspecials
% should be a list with the previous order -> specials, rcs, normals
% so...
% grab the Remaming list
% put each element of Rc's list at the head of the final list
% put each element of the Specials list at the head of the final list
% after that validate if specials is greater than 2
% if so, divide the number of specials / 2, and thats the number of
% times there only be two specials
% then, grab the first two elements of the final list, and that's one semester
% increment semester, use the remaning tail as the list, increment indexOfSpecials
% after that, only print the elements until you are close the CreditsPerSemester
% and that's it
handleEspecials.


cargaEspecial(Especiales):-
    write(Especiales).