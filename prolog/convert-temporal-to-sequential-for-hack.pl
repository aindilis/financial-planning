:- consult('util.pl').
:- consult('iem_parser.pl').
:- consult('parser.pl').
:- consult('flp_convert_temporal_pl_to_sequential_pddl.pl').
:- consult('normal_form.pl').

test :-
	parseCapsule([templateDir('/var/lib/myfrdcsa/codebases/internal/verber/data/worldmodel/templates/finance/current/'),capsule('tsimpleopticclp20170801'),parsed(Parsed),extension('verb')]),
	convertTemporalToSequential(Parsed,ConvertedParsed),
	halt.

convertTemporalToSequential(Parsed,ConvertedParsed) :-
	argt(Parsed,[domainFile(DomainFile),domain(Domain),problemFile(ProblemFile),problem(Problem),solutionFile(SolutionFile),solution(Solution),verbFile(VerbFile),verb(Verb)]),
	Problem = problem(ProblemName,DomainName,Objects,Init,Goal,Metric),
	convertTemporalToSequentialProblemObjects(Objects,ConvertedObjects),
	convertTemporalToSequentialProblemInit(Init,ConvertedInit),
	ConvertedProblem = problem(ProblemName,DomainName,Objects,ConvertedInit,Goal,Metric),
	view([convertedProblem,ConvertedProblem]),
	%% exportPDDLDomainAndSave([templateDir('/var/lib/myfrdcsa/codebases/minor/numeric-metric-planning/scripts/temporal_to_sequential/'),worldDir('/var/lib/myfrdcsa/codebases/minor/numeric-metric-planning/scripts/temporal_to_sequential/'),capsule('tsimpleopticclp20170801_sequential')]).
	flp_convert_temporal_pl_to_sequential_pddl([domain(Domain),problem(ConvertedProblem),solution(Solution),results(Results)]),
	%% output(problem(ConvertedProblem),ProblemResults),
	saveFiles([worldDir('/var/lib/myfrdcsa/codebases/minor/numeric-metric-planning/scripts/temporal_to_sequential/'),capsule('tsimpleopticclp20170801_sequential'),parsed(Parsed),results(Results)]).

convertTemporalToSequentialProblemObjects(Objects,ConvertedObjects) :-
	Objects = ConvertedObjects.

convertTemporalToSequentialProblemInit(Init,ConvertedInit) :-
	findall(Item,(member(Item,Init),Item \= at(_,_)),TmpConvertedInit),
	append([okay],TmpConvertedInit,ConvertedInit).

:- test.



