(define (problem coop-p)
(:domain coop)
(:objects
n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 n13 n16 - coordinates
Leader - UGV
Follower0 - UAV
N0 N1 - NavMode
P_0 P_45 P_90 P_135 P_180 P_225 P_270 P_315 - Pan
T_0 T_45 T_90 T_270 T_315 - Tilt
)

(:init 
    (uv-base n6 n10 Leader)
    (at-uv n6 n10 Leader)
    ;(docked Leader)
    (uv-navmode N0 Leader)

    (uv-base n10 n2 Follower0)
    (at-uv n10 n2 Follower0)
    ;(docked Follower0)
    (uv-navmode N0 Follower0)

    (uv-orientation P_0 Leader)
    (uv-orientation T_0 Leader)

    (uv-orientation P_0 Follower0)
    (uv-orientation T_0 Follower0)

    (= (distance n1 n2) 1)(= (distance n2 n1) 1)
    (= (distance n1 n5) 4)(= (distance n5 n1) 4)
    (= (distance n1 n6) 1)(= (distance n6 n1) 1)
    (= (distance n1 n9) 8) (= (distance n9 n1) 8)
    (= (distance n1 n10) 9)(= (distance n10 n1) 9)
    (= (distance n1 n13) 12) (= (distance n13 n1) 12) 
    (= (distance n1 n16) 15) (= (distance n16 n1) 15)

    (= (distance n2 n5) 3) (= (distance n5 n2) 3)
    (= (distance n2 n6) 4) (= (distance n6 n2) 4)
    (= (distance n2 n9) 7) (= (distance n9 n2) 7)
    (= (distance n2 n10) 8) (= (distance n10 n2) 8)
    (= (distance n2 n13) 11) (= (distance n13 n2) 11)
    (= (distance n2 n16) 14) (= (distance n16 n2) 14)

    (= (distance n5 n6) 1) (= (distance n6 n5) 1)
    (= (distance n5 n9) 4) (= (distance n9 n5) 4)
    (= (distance n5 n10) 5) (= (distance n10 n5) 5)
    (= (distance n5 n13) 8) (= (distance n13 n5) 5)
    (= (distance n5 n16) 11) (= (distance n16 n5) 11)

    (= (distance n6 n9) 3) (= (distance n9 n6) 3)
    (= (distance n6 n10) 4) (= (distance n10 n6) 4)
    (= (distance n6 n13) 7) (= (distance n13 n6) 7)
    (= (distance n6 n16) 10) (= (distance n16 n6) 10)

    (= (distance n9 n10) 1) (= (distance n10 n9) 1)
    (= (distance n9 n13) 4) (= (distance n13 n9) 4)
    (= (distance n9 n16) 7) (= (distance n16 n9) 7)

    (= (distance n10 n13) 3) (= (distance n13 n10) 3)
    (= (distance n10 n16) 6) (= (distance n16 n10) 6)    

    (= (distance n13 n16) 3) (= (distance n16 n13) 3)

    (= (distance n1 n1) 0) (= (distance n9 n9) 0)
    (= (distance n13 n13) 0) (= (distance n16 n16) 0)
    (= (distance n5 n5) 0) (= (distance n2 n2) 0)
    (= (distance n6 n6) 0) (= (distance n10 n10) 0)   

    (= (speed N0) 1)
    (= (speed N1) 2)

    (= (total-duration) 0)
    (= (total-energy-used) 0)

    (= (total-distance) 0)
    ;(= (energy-level Leader) 100)
    ;(= (energy-level Follower0) 100)
)
(:goal (and 
    ;(preference NotAtBaseUav (not (docked ?uav)))
    ;(preference NotAtBaseUgv (not (docked ?ugv)))
    (taken-photo n5 n9 T_0 P_0)
    (taken-photo n16 n13 T_0 P_0)
    ;(docked Leader)
    ;(docked Follower0)
    ;(transmitted-photo n2 n10 T_0 P_0)
    ;(uv-navmode N1 Follower0)
    )
)

(:constraints 
    (and (sometime (not (docked Follower0)))
    (sometime (not (docked Leader))))
)


;(:metric minimize (+ (* 10 (is violated (not (docked ?uav))))(*15 (is violated (not (docked ?ugv))))))
;(:metric minimize (total-energy-used))
;(:metric minimize (total-distance))
) 