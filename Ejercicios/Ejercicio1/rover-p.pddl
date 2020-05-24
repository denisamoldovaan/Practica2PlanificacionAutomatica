(define (problem rover-p)
(:domain rover)
(:objects 
    r1 - robot
    p1 p2 p3 p4 p5 p6 - position
)
(:init
    (at p1 r1)
    (= (battery-level r1) 100)
    (= (battery-required p1 p2) 30)
    (= (battery-required p2 p3) 40)
    (= (battery-required p3 p4) 35)
    (= (battery-required p4 p5) 50)
    (= (battery-required p5 p6) 20)
    (= (battery-threshold r1) 20)
    (connected p1 p2)
    (connected p2 p3)
    (connected p3 p4)
    (connected p4 p5)
    (connected p5 p6)
)
(:goal (and
        (communicated-with-earth p2 r1)
        (analysed-sample p2 r1)
        (analysed-sample p3 r1)
        (taken-picture p4 r1)
        (drilled p5 r1)
        (at p6 r1)      
        )
)
)
