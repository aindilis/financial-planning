%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  read_line
%%%  This is a modified version for parsing pddl files.
%%%  Read the input file character by character and parse it
%%%  into a list. Brackets, comma, period and question marks
%%%  are treated as separate words. White spaces separed 
%%%  words. 
%%%
%%%  Similar to read_sent in Pereira and Shieber, Prolog and
%%%        Natural Language Analysis, CSLI, 1987.
%%%
%%%  Examples:
%%%           :- read_line('input.txt', L).
%%%           input.txt> The sky was blue, after the rain.
%%%           L = [the, sky, was, blue, (','), after, the, rain, '.']
%%%
%%%           :- read_line('domain.pddl', L).
%%%           domain.pddl>
%%%           (define (domain BLOCKS)
%%%             (:requirements :strips :typing :action-costs)
%%%             (:types block)
%%%             (:predicates (on ?x - block ?y - block)
%%%           ...
%%%           L = ['(', define, '(', domain, blocks, ')', '(', :, requirements|...].
%
%read_file(+File, -List).

:- dynamic flag/1.

read_file(File, List) :- system:seeing(Old), system:see(File), read_line(List), system:seen, system:see(Old).

read_line(Words) :- get0(C),
                    read_rest(C,Words).
          
/* Ends the input. */
read_rest(-1,[]) :- !.

/* Spaces, tabs and newlines between words are ignored. */
read_rest(C,Words) :- ( C=32 ; C=10 ; C=9 ; C=13 ; C=92 ) , !,
                     get0(C1),
                     read_rest(C1,Words).

/* Brackets, comma, period or question marks are treated as separed words */
read_rest(C, [Char|Words]) :- ( C=40 ; C=41 ; C=44 ; C=45 ; C=46 ; C=63 ; C=58 ; C=60 ; C=62) , name(Char, [C]), !,
			get0(C1),
			read_rest(C1, Words).


/* Read comments to the end of line */
read_rest(59, Words) :- get0(Next), !, 
			      read_comment(Next, Last),
			      read_rest(Last, Words).

/* Otherwise get all of the next word. */
read_rest(C,[Word|Words]) :- read_word(C,Chars,Next),
	%% name(Word,Chars),
                             atom_codes(Word,Chars),
                             read_rest(Next,Words).

%% read_word(A,B,C) :-
%% 	view([a,A,b,B,c,C]),
%% 	fail.

/* Space, comma, newline, period, end-of-file or question mark separate words. */
read_word(C,[],C) :- ( C=32 ; C=44 ; C=10 ; C=9 ; C=13 ;
                         C=46 ; C=63 ; C=40 ; C=41 ; C=58 ; C=60 ; C=62 ; C= -1 ) , !.

/* Otherwise, get characters and convert to lower case. */
read_word(C,[LC|Chars],Last) :- not(flag(lower_case)),
	atom_codes(Atom,[C]),
	%% view([c,C,atom,Atom]),
				check_letter(C, LC),
				get0(Next),
                                read_word(Next,Chars,Last).

read_word(C,[LC|Chars],Last) :- flag(lower_case),
	atom_codes(Atom,[C]),
	%% view([c,C,atom,Atom]),
				lower_case(C, LC),
				get0(Next),
                                read_word(Next,Chars,Last).

/* Convert to lower case if necessary. */
check_letter(C,C) :- ( C <  65 ; C > 90 ) , !.
check_letter(C,C) :- ( C <  97 ; C > 122 ) , !.

/* Convert to lower case if necessary. */
lower_case(C,C) :- ( C <  65 ; C > 90 ) , !.
lower_case(C,LC) :- LC is C + 32.


/* Keep reading as long you dont find end-of-line or end-of-file */
read_comment(10, 10) :- !.
read_comment(-1, -1) :- !.
read_comment(_, Last) :- get0(Next),
			 read_comment(Next, Last).

/* for reference ... 
newline(10).
comma(44).
space(32).
period(46).
question_mark(63).
*/


