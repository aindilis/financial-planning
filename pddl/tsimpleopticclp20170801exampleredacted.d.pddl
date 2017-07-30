(define (domain tsimpleopticclp20170801exampleredacted)

 (:requirements :typing :fluents :negative-preconditions :durative-actions :timed-initial-literals :derived-predicates)

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

 (:durative-action pay-on-time
  :parameters (?a1 ?a2 - accountHolder ?p - purpose)
  :duration (= ?duration 0.151)
  :condition (and
	      (at start (okay))
 	      (over all (can ?p))
 	      (over all (on-time ?p))
 	      (over all (unpaid ?a1 ?a2 ?p))
 	      (at start (>= (balance ?a1) (promiseToPayFor ?a1 ?a2 ?p)))
 	      )
  :effect (and
 	   (at start (decrease (balance ?a1) (promiseToPayFor ?a1 ?a2 ?p)))
 	   (at end (increase (balance ?a2) (promiseToPayFor ?a1 ?a2 ?p)))
 	   (at end (paid ?a1 ?a2 ?p))
 	   (at end (not (unpaid ?a1 ?a2 ?p)))
 	   (at end (increase (total-actions) 1))
 	   )
  )

 ;; (:durative-action pay-step-1
 ;;  :parameters (?a1 ?a2 - accountHolder ?p - purpose)
 ;;  :duration (= ?duration 0.05)
 ;;  :condition (and
 ;; 	      (at start (can ?p))
 ;; 	      (at start (on-time ?p))
 ;; 	      ;;(at start (not (paid ?a1 ?a2 ?p)))
 ;; 	      (at start (unpaid ?a1 ?a2 ?p))
 ;; 	      (at start (>= (balance ?a1) (promiseToPayFor ?a1 ?a2 ?p)))
 ;; 	      )
 ;;  :effect (and
 ;; 	   (at start (decrease (balance ?a1) (promiseToPayFor ?a1 ?a2 ?p)))
 ;; 	   (at end (payment-in-progress ?a1 ?a2 ?p))
 ;; 	   )
 ;;  )

 ;;  (:durative-action pay-step-2
 ;;  :parameters (?a1 ?a2 - accountHolder ?p - purpose)
 ;;  :duration (= ?duration 0.05)
 ;;  :condition (and
 ;; 	      (at start (payment-in-progress ?a1 ?a2 ?p))
 ;; 	      )
 ;;  :effect (and
 ;; 	   (at start (increase (balance ?a2) (promiseToPayFor ?a1 ?a2 ?p)))
 ;; 	   (at end (paid ?a1 ?a2 ?p))	   
 ;; 	   (at end (not (payment-in-progress ?a1 ?a2 ?p)))

 ;; 	   (at end (increase (total-actions) 1))
 ;; 	   )
 ;;  )

 ;; (:durative-action pay-late
 ;;  :parameters (?a1 ?a2 - accountHolder ?p - purpose)
 ;;  :duration (= ?duration 1.0)
 ;;  :precondition (and
 ;; 		 (or
 ;; 		  (can ?p)
 ;; 		  ;; (not (on-time ?p))
 ;; 		  )
 ;; 		 (not (paid ?a1 ?a2 ?p))
 ;; 		 (>= (balance ?a1) (promiseToPayFor ?a1 ?a2 ?p))
 ;; 		 )
 ;;  :effect (and
 ;; 	   (paid ?a1 ?a2 ?p)
 ;; 	   (decrease (balance ?a1) (promiseToPayFor ?a1 ?a2 ?p))
 ;; 	   (increase (balance ?a2) (promiseToPayFor ?a1 ?a2 ?p))
 ;; 	   (increase (total-actions) 1)
 ;; 	   )
 ;;  )

 ;; (:action obtain-permission-for-loan-from
 ;;  :parameters (?a1 ?a2 - accountHolder ?p - purpose)
 ;;  :precondition (and
 ;; 		 (> (loanRequestFor ?a1 ?a2 ?p) 0)
 ;; 		 )
 ;;  :effect (and
 ;; 	   (assign (promiseToPayFor ?a2 ?a1 ?p) (loanRequestFor ?a1 ?a2 ?p))
 ;; 	   (increase (total-actions) 1)
 ;; 	   )
 ;;  )

 )
