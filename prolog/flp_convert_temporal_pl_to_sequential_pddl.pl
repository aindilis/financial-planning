:- use_module(library(lists)).

:- consult('pddl_wrapper.pl').
:- consult('args.pl').

flp_convert_temporal_pl_to_sequential_pddl(Arguments) :-
	argt(Arguments,[domain(Domain),problem(Problem),solution(Solution),results(Results)]),
	outputSequential(domain(Domain),DomainResults),
	outputSequential(problem(Problem),ProblemResults),
	outputSequential(solution(Solution),SolutionResults),
	Results = [domainResults(DomainResults),problemResults(ProblemResults),solution(Solution,SolutionResults)],
	Arguments = [domain(Domain),problem(Problem),solution(Solution),results(Results)].

outputSequential(domain(Domain),DomainResults) :-
	Domain = domain(DomainName,TmpRequirements,TmpTypes,TmpPredicates,TmpFunctions,TmpActions),
	view([1]),
	Derived = [],

	findall(Requirement,(member(TmpRequirement,TmpRequirements),atom_concat(':',TmpRequirement,Requirement)),Tmp2Requirements),
	append([[':requirements'],Tmp2Requirements],Requirements),
	view([requirements,Requirements]),

	view([tmpTypes,TmpTypes]),
	setof([SubTypes,['-'],[SuperType]],member(genls(SubTypes,SuperType),TmpTypes),Tmp2Types),
	append(Tmp2Types,Tmp3Types),
	append(Tmp3Types,Tmp4Types),
	append([[':types'],Tmp4Types],Types),
	view([types,Types]),

	fixPredicatesSequential(TmpPredicates,Tmp2Predicates),
	append([[':predicates'],Tmp2Predicates],Predicates),
	view([predicates,Predicates]),

	view([tmpFunctions,TmpFunctions]),
	fixFunctionsSequential(TmpFunctions,Tmp2Functions),
	append([[':functions'],Tmp2Functions],Functions),
	view([functions,Functions]),

	TmpArgumentList = [domain(DomainName),Requirements,Types,Predicates,Functions],
	fixActions(TmpActions,Actions),
	append([TmpArgumentList,Derived,Actions],ArgumentList),
	view([argumentList,ArgumentList]),
	
	append([[define],ArgumentList],PDDLDomain),
	Atom = pddl_domain(PDDLDomain),

	convert_temporal_pl_to_sequential_pddl([input(PDDLDomain),inputType('Prolog'),outputType('KIF String'),results(DomainResults)]),
	displayResultsSequential(DomainResults).

fixPredicatesSequential(TmpPredicates,Predicates) :-
	findall(Predicate,
		(   
		    member(TmpPredicate,TmpPredicates),
		    view([tmpPredicate,TmpPredicate]),
		    TmpPredicate =.. [PredicateName|AllTypeSpecs],
		    view([predicateName,PredicateName]),
		    view([allTypeSpecs,AllTypeSpecs]),
		    findall(Output,
			    (	
				member(are(Variables,Type),AllTypeSpecs),
				view([type,Type,typeSpecs,Variables]),
				findall(NewVariableName,
					(   
					    member('$VAR'(VariableName),Variables),
					    atom_concat('?',VariableName,NewVariableName)
					),
					NewVariableNames),
				append([NewVariableNames,[-],[Type]],Output)
			    ),
			    TmpOutputs),
		    append(TmpOutputs,Outputs),
		    append([[PredicateName],Outputs],Predicate)
		),
		Predicates),
	view([predicates,Predicates]).

fixFunctionsSequential(TmpFunctions,Functions) :-
	findall(Function,
		(   
		    member(TmpFunction,TmpFunctions),
		    view([tmpFunction,TmpFunction]),
		    TmpFunction =.. [f|[FunctionName|[AllTypeSpecs]]],
		    view([functionName,FunctionName]),
		    view([allTypeSpecs,AllTypeSpecs]),
		    findall(Output,
			    (	
				member(are(Variables,Type),AllTypeSpecs),
				view([type,Type,typeSpecs,Variables]),
				findall(NewVariableName,
					(   
					    member('$VAR'(VariableName),Variables),
					    atom_concat('?',VariableName,NewVariableName)
					),
					NewVariableNames),
				append([NewVariableNames,[-],[Type]],Output)
			    ),
			    TmpOutputs),
		    view([tmpOutputs,TmpOutputs]),
		    append(TmpOutputs,Outputs),
		    view([outputs,Outputs]),
		    append([[FunctionName],Outputs],Function)
		),
		Functions),
	view([functions,Functions]).

fixPreconditions(InputPreconditions,OutputPreconditions) :-
	findall(Precondition,
		(
		 member(TmpPrecondition,InputPreconditions),
		 view([precondition,TmpPrecondition]),
		 TmpPrecondition =.. [TmpPred|TmpRest],
		 findall(Term,
			 (   
			     member(TmpTerm,TmpRest),
			     (	 atomic(TmpTerm) ->
				 Term = [TmpTerm] ;
				 Term = TmpTerm)
			 ),
			 Tmp2Rest),
		 Pred = TmpPred,
		 [Tmp3Rest] = Tmp2Rest,
		 (   Tmp3Rest =.. [compare|Tmp4Rest] -> 
		     Subterm =.. Tmp4Rest ;
		     Subterm = Tmp3Rest),
		 Precondition = Subterm
		),
		TmpPreconditions),
	append([['and'],TmpPreconditions],Tmp2Preconditions),
	renderVariablesSequential(Tmp2Preconditions,OutputPreconditions).

fixEffects(InputEffects,OutputEffects) :-
	findall(Effect,
	 	(   
		    member(TmpEffect,InputEffects),
		    view([effect,TmpEffect]),
		    TmpEffect =.. [TmpPred|TmpRest],
		    findall(Term,
			    (
			     member(TmpTerm,TmpRest),
			     (	 atomic(TmpTerm) ->
				 Term = [TmpTerm] ;
				 Term = TmpTerm)
			    ),
			    Tmp2Rest),
		    [Tmp3Rest] = Tmp2Rest,
		    (	is_list(Tmp3Rest) ->
			[Rest] = Tmp3Rest ;
			Rest = Tmp3Rest ),
		    Pred = TmpPred,
		    Effect = Rest
	 	),
		TmpEffects),
	append([['and'],TmpEffects],Tmp2Effects),
	renderVariablesSequential(Tmp2Effects,OutputEffects).

%% fixPreconditions(InputPreconditions,OutputPreconditions) :-
%% 	findall(Precondition,
%% 		(
%% 		 member(TmpPrecondition,InputPreconditions),
%% 		 view([precondition,TmpPrecondition]),
%% 		 TmpPrecondition =.. [TmpPred|TmpRest],
%% 		 findall(Term,
%% 			 (   
%% 			     member(TmpTerm,TmpRest),
%% 			     (	 atomic(TmpTerm) ->
%% 				 Term = [TmpTerm] ;
%% 				 Term = TmpTerm)
%% 			 ),
%% 			 Tmp2Rest),
%% 		 Pred = TmpPred,
%% 		 [Tmp3Rest] = Tmp2Rest,
%% 		 (   Tmp3Rest =.. [compare|Tmp4Rest] -> 
%% 		     Subterm =.. Tmp4Rest ;
%% 		     Subterm = Tmp3Rest),
%% 		 Precondition =.. [Pred|[Subterm]]
%% 		),
%% 		TmpPreconditions),
%% 	append([['and'],TmpPreconditions],Tmp2Preconditions),
%% 	renderVariablesSequential(Tmp2Preconditions,OutputPreconditions).

%% fixEffects(InputEffects,OutputEffects) :-
%% 	findall(Effect,
%% 	 	(   
%% 		    member(TmpEffect,InputEffects),
%% 		    view([effect,TmpEffect]),
%% 		    TmpEffect =.. [TmpPred|TmpRest],
%% 		    findall(Term,
%% 			    (
%% 			     member(TmpTerm,TmpRest),
%% 			     (	 atomic(TmpTerm) ->
%% 				 Term = [TmpTerm] ;
%% 				 Term = TmpTerm)
%% 			    ),
%% 			    Tmp2Rest),
%% 		    [Tmp3Rest] = Tmp2Rest,
%% 		    (	is_list(Tmp3Rest) ->
%% 			[Rest] = Tmp3Rest ;
%% 			Rest = Tmp3Rest ),
%% 		    Pred = TmpPred,
%% 		    Effect =.. [Pred|[Rest]]
%% 	 	),
%% 		TmpEffects),
%% 	append([['and'],TmpEffects],Tmp2Effects),
%% 	renderVariablesSequential(Tmp2Effects,OutputEffects).

fixActions(TmpActions,Actions) :-
	findall(Action,
		(   
		    member(TmpAction,TmpActions),
		    view([tmpAction,TmpAction]),
		    TmpAction =.. [durativeAction|[ActionName|[AllTypeSpecs,TmpDuration,TmpPreconditions,TmpEffects]]],
		    view([actionName,ActionName,variables,AllTypeSpecs,duration,TmpDuration,preconditions,TmpPreconditions,effects,TmpEffects]),
		    findall(Parameter,
			    (	
				member(are(Variables,Type),AllTypeSpecs),
				view([type,Type,variables,Variables]),
				findall(NewVariableName,
					(   
					    member('$VAR'(VariableName),Variables),
					    atom_concat('?',VariableName,NewVariableName)
					),
					NewVariableNames),
				append([NewVariableNames,[-],[Type]],Parameter)
			    ),
			    TmpParameters),
		    append(TmpParameters,Parameters),
		    renderVariablesSequential(TmpDuration,Duration),
		    fixPreconditions(TmpPreconditions,Preconditions),
		    fixEffects(TmpEffects,Effects),
		    Action = ':action'(ActionName,':parameters',Parameters,':precondition',Preconditions,':effect',Effects)
		),
		Actions),
	view([actions,Actions]).

fixObjects(TmpObjects,Objects) :-
	view([alpha,TmpObjects]),
	findall(NewList,
		(   
		    member(are(ObjectList,Type),TmpObjects),
		    append([ObjectList,['-',Type]],NewList),
		    view([beta,NewList])
		),
		Lists),
	view([alpha,Lists]),
	append(Lists,Objects),
	view([alpha]),
	view([objects,Objects]).

fixInit(TmpInits,Init) :-
	findall(TmpInit,
		(   
		    member(Tmp,TmpInits),
		    (	atomic(Tmp) ->
			(   TmpInit = [Tmp]) ;
			(   Tmp =.. [TmpPred|TmpRest],
			    (	TmpPred = set ->
				Pred = '=' ;
				Pred = TmpPred),
			    (	TmpRest = [TmpFluent,Value] ->
				(   fixFormula(TmpFluent,Fluent),
				    Rest = [Fluent,Value]) ;
				Rest = TmpRest),
			    TmpInit =.. [Pred|Rest]))
		),
		Init),
	view([init,Init]).

fixFormula(Formula,CorrectedFormula) :-
	(   atomic(Formula) ->
	    CorrectedFormula = [Formula] ;
	    CorrectedFormula = Formula).

outputSequential(problem(Problem),ProblemResults) :-
	(   Problem = problem(ProblemName,ProblemDomainName,TmpObjects,TmpInit,TmpGoal) ;
	    Problem = problem(ProblemName,ProblemDomainName,TmpObjects,TmpInit,TmpGoal,TmpMetric)),
	view([problemItems,[ProblemName,ProblemDomainName,TmpObjects,TmpInit,TmpGoal]]),

	view([tmpObjects,TmpObjects]),
	fixObjects(TmpObjects,Tmp2Objects),
	append([[':objects'],Tmp2Objects],Objects),
	view([objects,Objects]),

	view([tmpInit,TmpInit]),
	fixInit(TmpInit,Tmp2Init),
	append([[':init'],Tmp2Init],Init),
	view([init,Init]),

	view([tmpGoal,TmpGoal]),
	append([[and],TmpGoal],Tmp2Goal),
	append([[':goal'],[Tmp2Goal]],Goal),
	view([goal,Goal]),

	view([tmpMetric,TmpMetric]),
	(   
	    nonvar(TmpMetric) ->
	    (	TmpMetric = metric(Type,TmpFunction),
		(
		 atomic(TmpFunction) ->
		 Function = [TmpFunction] ;
		 Function = TmpFunction
		),
		Metric =.. [':metric',Type,Function]
	    ) ;
	    Metric = ':metric'(minimize,'total-time'())
	),
	view([metric,Metric]),
	
	PDDLProblem = define(
			     problem(ProblemName),
			     ':domain'(ProblemDomainName),
			     Objects,
			     Init,
			     Goal,
			     Metric
			    ),
	Atom = pddl_problem(PDDLProblem),
	convert_temporal_pl_to_sequential_pddl([input(PDDLProblem),inputType('Prolog'),outputType('KIF String'),results(ProblemResults)]),
	displayResultsSequential(ProblemResults).

outputSequential(solution(Solution),SolutionResults) :-
	Atom = pddl_solution(Solution),
	convert_temporal_pl_to_sequential_pddl([input(Solution),inputType('Prolog'),outputType('KIF String'),results(SolutionResults)]),
	displayResultsSequential(SolutionResults).

convert_temporal_pl_to_sequential_pddl(Arguments) :-	
	%% kbs2_import_export(Arguments),
	temporal_prolog_to_sequential_pddl_pretty_print(Arguments),
	true.

temporal_prolog_to_sequential_pddl_pretty_print([input(Input),inputType(InputType),outputType(OutputType),results(Results)]) :-
	%% Generate it and if we have a connection to formalog use it,

	%% otherwise, write it to a file, and get the output.
	InputFile = '/tmp/kbs2-import-export-input.txt',
	OutputFile = '/tmp/kbs2-import-export-output.txt',
	writeq_data_to_file(Input,InputFile),
	atomic_list_concat([
			    '../scripts/prolog-to-pddl-pretty-print -i \'',
			    InputType,
			    '\' -o \'',
			    OutputType,
			    '\' -f \'',
			    InputFile,'\' > ',
			    OutputFile
			   ],'',Command),
	shell(Command),
	read_data_from_file(OutputFile,Results).

displayResultsSequential(Results) :-
	%% view([atom,Results]),
	nl,nl,
	write(Results),
	nl,nl,
	true.

renderVariablesSequential(Pre,Post) :-
	view([pre,Pre]),
	is_list(Pre) ->
	findall(Item,(member(SubPre,Pre),renderVariablesSequential(SubPre,Item)),Post) ;
	Pre =.. ['$VAR',VariableName] ->
	atom_concat('?',VariableName,Post) ;
	Pre =.. [PredicateName|Args] ->	
	(   
	    findall(Item,(member(SubArgs,Args),renderVariablesSequential(SubArgs,Item)),Items),
	    Post =.. [PredicateName|Items]
	) ;
	Post = Pre.
