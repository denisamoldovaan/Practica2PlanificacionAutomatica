(define (problem building-p2)
(:domain building)
(:objects 
    n0 n1 n2 n3 n4 n5 n6 n7 n8 - number
    p1 p2 p3 p4 p5 - person
    fl1 fl2 - fastlift
    sl1 sl2 - slowlift
)
(:init 
    (at_person p1 n4)
    (at_person p2 n1)
    (at_person p3 n7)
    (at_person p4 n6)
    (at_person p5 n7)

    (at_lift fl1 n0)
    (at_lift fl2 n4)
    (at_lift sl1 n3)
    (at_lift sl2 n4)

    (connected-slow n0 n1) (connected-slow n1 n2) (connected-slow n2 n3) (connected-slow n3 n4) (connected-slow n4 n5) (connected-slow n5 n6)(connected-slow n6 n7) (connected-slow n7 n8)
    (connected-fast n0 n2) (connected-fast n2 n4) (connected-fast n4 n6) (connected-fast n6 n8)  

    (reachable fl1 n0) (reachable fl1 n2) (reachable fl1 n4) (reachable fl1 n6) (reachable fl1 n8)
    (reachable fl2 n0) (reachable fl2 n2) (reachable fl2 n4) (reachable fl2 n6) (reachable fl2 n8)

    (reachable sl1 n0) (reachable sl1 n1) (reachable sl1 n2) (reachable sl1 n3) (reachable sl1 n4)
    (reachable sl1 n5) (reachable sl1 n6) (reachable sl1 n7) (reachable sl1 n8)
    (reachable sl2 n0) (reachable sl2 n1) (reachable sl2 n2) (reachable sl2 n3) (reachable sl2 n4)
    (reachable sl2 n5) (reachable sl2 n6) (reachable sl2 n7) (reachable sl2 n8)

    (total_people fl1 n0) (total_people fl2 n0)
    (total_people sl1 n0) (total_people sl2 n0)

    (next n0 n1) (next n1 n2) (next n2 n3) (next n3 n4) (next n4 n5) (next n5 n6) (next n6 n7) (next n7 n8)

    (= (duration-move-fast fl1) 20)
    (= (duration-move-fast fl2) 10)
    (= (duration-move-slow sl1) 20)
    (= (duration-move-slow sl2) 20)
    
)
(:goal (and
    (at_person p1 n0)
    (at_person p2 n3)
    (at_person p3 n0)
    (at_person p4 n5)
    (at_person p5 n8)
))
(:metric minimize (total-time))

)