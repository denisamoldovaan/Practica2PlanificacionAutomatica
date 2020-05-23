(define (domain building)
(:requirements :strips :typing :durative-actions :fluents :preferences)
(:types  lift - object 
           slowlift fastlift - lift
   	       person - object
           number - object
)
(:predicates (at_person ?person - person ?level - number)
             (at_lift ?lift - lift ?level - number)
             (connected-fast ?level1 ?level2 - number)
             (connected-slow ?level1 ?level2 - number)
             (reachable ?lift - lift ?level - number)
             (total_people ?lift - lift ?n - number)
             (next ?n1 ?n2 - number)
             (in_lift ?person - person ?lift - lift)
)

(:functions 
    (duration-move-fast ?l - lift)
    (duration-move-slow ?l - lift)
)

(:durative-action move-up-fast
:parameters (?lift - fastlift ?level1 ?level2 - number)
:duration (= ?duration (duration-move-fast ?lift))
:condition (and 
    (at start (at_lift ?lift ?level1))
    (over all (connected-fast ?level1 ?level2))
    (over all (reachable ?lift ?level2))
)
:effect (and 
    (at start (not (at_lift ?lift ?level1)))
    (at end (at_lift ?lift ?level2))
)
)

(:durative-action move-up-slow
:parameters (?lift - slowlift ?level1 ?level2 - number)
:duration (= ?duration (duration-move-slow ?lift))
:condition (and 
    (at start (at_lift ?lift ?level1))
    (over all (connected-slow ?level1 ?level2))
    (over all (reachable ?lift ?level2))
)
:effect (and 
    (at start (not (at_lift ?lift ?level1)))
    (at end (at_lift ?lift ?level2))
)
)

(:durative-action move-down-fast
:parameters (?lift - fastlift ?level1 ?level2 - number)
:duration (= ?duration (duration-move-fast ?lift))
:condition (and 
    (at start (at_lift ?lift ?level1))
    (over all (connected-fast ?level2 ?level1))
    (over all (reachable ?lift ?level2))
)
:effect (and 
    (at start (not (at_lift ?lift ?level1)))
    (at end (at_lift ?lift ?level2))
)
)

(:durative-action move-down-slow
:parameters (?lift - slowlift ?level1 ?level2 - number)
:duration (= ?duration (duration-move-slow ?lift))
:condition (and 
    (at start (at_lift ?lift ?level1))
    (over all (connected-slow ?level2 ?level1))
    (over all (reachable ?lift ?level2))
)
:effect (and 
    (at start (not (at_lift ?lift ?level1)))
    (at end (at_lift ?lift ?level2))
)
)

(:durative-action board
:parameters (?person - person ?lift - lift ?level ?num1 ?num2 - number)
:duration (= ?duration 1)
:condition (and 
                (at start (at_person ?person ?level))
                (at start (at_lift ?lift ?level))
                (at start (total_people ?lift ?num1)) 
                (at start (next ?num1 ?num2))
                )
:effect (and 
                (at end (not (at_person ?person ?level)))
                (at end (in_lift ?person ?lift))
                (at end (not (total_people ?lift ?num1)))
                (at end (total_people ?lift ?num2))
)
)

(:durative-action leave
:parameters (?person - person ?lift - lift ?level ?num1 ?num2 - number)
:duration (= ?duration 1)
:condition (and 
                ;(over all (at_person ?person ?level))
                (at start (in_lift ?person ?lift))
                (over all (at_lift ?lift ?level))
                (at start (total_people ?lift ?num1)) 
                (at start (next ?num2 ?num1))
                )
:effect (and 
                (at end (not(in_lift ?person ?lift)))
                (at end (at_person ?person ?level))
                (at end (not (total_people ?lift ?num1)))
                (at end (total_people ?lift ?num2))
)
)


)