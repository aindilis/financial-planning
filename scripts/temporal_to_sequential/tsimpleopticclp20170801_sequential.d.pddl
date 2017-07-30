(define (domain tsimpleopticclp20170723_sequential)

 (:requirements :typing :fluents :negative-preconditions :timed-initial-literals :derived-predicates)

 (:types accountHolder product purpose - object)

 (:predicates
  (can ?p - purpose)
  (on-time ?p - purpose)
  (payment-in-progress ?a1 ?a2 - accountHolder ?p - purpose)
  (paid ?a1 ?a2 - accountHolder ?p - purpose)
  (unpaid ?a1 ?a2 - accountHolder ?p - purpose)
  (okay)
  )

 (:functions
  (balance ?a - accountHolder)
  (loanRequestFor ?a1 ?a2 - accountHolder ?p - purpose)
  (promiseToPayFor ?a1 ?a2 - accountHolder ?p - purpose)

  (total-actions)
  )
 
 (:action pay-on-time
  :parameters (?a1 ?a2 - accountHolder ?p - purpose)
  :precondition (and
	      (okay)
 	      (unpaid ?a1 ?a2 ?p)
 	      (>= (balance ?a1) (promiseToPayFor ?a1 ?a2 ?p))
 	      )
  :effect (and
 	   (decrease (balance ?a1) (promiseToPayFor ?a1 ?a2 ?p))
 	   (increase (balance ?a2) (promiseToPayFor ?a1 ?a2 ?p))
 	   (paid ?a1 ?a2 ?p)
 	   (not (unpaid ?a1 ?a2 ?p))
 	   (increase (total-actions) 1)
 	   )
  )
 )
