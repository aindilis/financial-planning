(define (problem tsimpleopticclp20170801exampleredacted_1)

 (:domain tsimpleopticclp20170801exampleredacted)

 (:objects homerSimpson socialSecurityAdministration
  springfieldFitness springfieldNuclearPower landlord
  springfieldCellular springfieldPetroleum springfieldBarber netflix
  springfieldAutoInsurance springfieldTelecom - accountHolder

  homerSimpsonSocialSecurity billForGym20170708 billForPower20170708
  billForRent20170708 billForCellPhone20170708 billForGasoline20170708
  billForHairCut20170708 billForNetflix20170708
  billForAutoInsurance20170708 billForLandline20170708 - purpose )

 (:init
  (= (total-actions) 0)

  (at 0.10 (okay))

  (= (balance homerSimpson) 0.00)

  (= (balance socialSecurityAdministration) 10001.00)
  (= (balance springfieldFitness) 10001.00)
  (= (balance springfieldNuclearPower) 10001.00)
  (= (balance landlord) 10001.00)
  (= (balance springfieldCellular) 10001.00)
  (= (balance springfieldPetroleum) 10001.00)
  (= (balance springfieldBarber) 10001.00)
  (= (balance netflix) 10001.00)
  (= (balance springfieldAutoInsurance) 10001.00)
  (= (balance springfieldTelecom) 10001.00)

  (= (promiseToPayFor socialSecurityAdministration homerSimpson homerSimpsonSocialSecurity) 693.00)
  (can homerSimpsonSocialSecurity)
  (on-time homerSimpsonSocialSecurity)
  (at 5 (not (on-time homerSimpsonSocialSecurity)))
  (unpaid socialSecurityAdministration homerSimpson homerSimpsonSocialSecurity)

  (= (promiseToPayFor homerSimpson springfieldFitness billForGym20170708) 40.00)
  (at 0 (can billForGym20170708))
  (on-time billForGym20170708)
  (at 5 (not (on-time billForGym20170708)))
  (unpaid homerSimpson springfieldFitness billForGym20170708)

  (= (promiseToPayFor homerSimpson springfieldNuclearPower billForPower20170708) 60.00)
  (at 0 (can billForPower20170708))
  (on-time billForPower20170708)
  (at 5 (not (on-time billForPower20170708)))
  (unpaid homerSimpson springfieldNuclearPower billForPower20170708)

  (= (promiseToPayFor homerSimpson landlord billForRent20170708) 190.00)
  (at 0 (can billForRent20170708))
  (on-time billForRent20170708)
  (at 5 (not (on-time billForRent20170708)))
  (unpaid homerSimpson landlord billForRent20170708)

  (= (promiseToPayFor homerSimpson springfieldCellular billForCellPhone20170708) 25.00)
  (at 0 (can billForCellPhone20170708))
  (on-time billForCellPhone20170708)
  (at 7 (not (on-time billForCellPhone20170708)))
  (unpaid homerSimpson springfieldCellular billForCellPhone20170708)

  (= (promiseToPayFor homerSimpson springfieldPetroleum billForGasoline20170708) 31.00)
  (at 0 (can billForGasoline20170708))
  (on-time billForGasoline20170708)
  (at 8 (not (on-time billForGasoline20170708)))
  (unpaid homerSimpson springfieldPetroleum billForGasoline20170708)

  (= (promiseToPayFor homerSimpson springfieldBarber billForHairCut20170708) 19.00)
  (at 0 (can billForHairCut20170708))
  (on-time billForHairCut20170708)
  (at 11 (not (on-time billForHairCut20170708)))
  (unpaid homerSimpson springfieldBarber billForHairCut20170708)

  (= (promiseToPayFor homerSimpson netflix billForNetflix20170708) 9.00)
  (at 0 (on-time billForNetflix20170708))
  (at 12 (can billForNetflix20170708))
  (unpaid homerSimpson netflix billForNetflix20170708)

  (= (promiseToPayFor homerSimpson springfieldAutoInsurance billForAutoInsurance20170708) 95.00)
  (at 0 (on-time billForAutoInsurance20170708))
  (at 17 (can billForAutoInsurance20170708))
  (unpaid homerSimpson springfieldAutoInsurance billForAutoInsurance20170708)

  (= (promiseToPayFor homerSimpson springfieldTelecom billForLandline20170708) 95.00)
  (at 0 (on-time billForLandline20170708))
  (at 22 (can billForLandline20170708))
  (unpaid homerSimpson springfieldTelecom billForLandline20170708)

  )

 (:goal
  (and
   (paid socialSecurityAdministration homerSimpson homerSimpsonSocialSecurity)
   (paid homerSimpson springfieldFitness billForGym20170708)
   (paid homerSimpson springfieldNuclearPower billForPower20170708)
   (paid homerSimpson landlord billForRent20170708)
   (paid homerSimpson springfieldCellular billForCellPhone20170708)
   (paid homerSimpson springfieldPetroleum billForGasoline20170708)
   (paid homerSimpson springfieldBarber billForHairCut20170708)
   (paid homerSimpson netflix billForNetflix20170708)
   (paid homerSimpson springfieldAutoInsurance billForAutoInsurance20170708)
   (paid homerSimpson springfieldTelecom billForLandline20170708)
   )   
  )

 (:metric minimize (total-actions))

 )
