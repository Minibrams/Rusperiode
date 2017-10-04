## Tjanseauktion

CLI, der sørger for at kunne holde tjanseauktion. Tager to tekstfiler og en integer ind som argument:

1. En liste af tjanser separeret med newline
2. En liste af hold separeret med newline
3. En integer der bestemmer hvor mange hemmelige tjanser, der skal være ud over fritjanser

Programmet regner ud, hvor mange tjanser hvert hold skal have ud fra antal hold og tjanser. Hvis dette ikke går lige op, fylder den tjanserne ud med fritjanser.
Programmet genkender følgende kommandoer:

* `:q` og `:quit` lukker programmet
* `:s` og `:start` starter auktionerne. Er auktionerne startet, bliver det skrevet i konsollen. 
* `:b` og `:break` stopper igangværende auktioner
* `:e` og `:end` afslutter igangværende auktion, opdaterer vinderens valuta og tjanser, og starter næste auktion
* `:l` og `:load` læser logfilen, og opdaterer stadiet af auktionerne til at matche det gemte

Tjansernes rækkefølge bliver randomiseret når de bliver indlæst. Hvis man loader fra log filen, indlæses samme rækkefølge som i logfilen. Når auktionerne startes, bliver de sekventielt afviklet i vilkårlig rækkefølge. Når en auktion afsluttes, opdateres logfilen med de nye resultater, så hvis programmet crasher, kan filen indlæses og intet er gået tabt. Når alle auktioner er afsluttet, laver programmet automatisk en PDF-output fil.

For at compile, skal Maven installeres, og Maven goal 'package' køres. For at køre programmet køres 'run.bat' filen.

##### Videre udvikling til næste år

* Chore-klasse, som indeholder tidsperiode, titel og ansvarlig tutor
