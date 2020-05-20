(define (domain coop)
(:requirements :strips :typing :durative-actions :fluents :constraints :preferences)
(:types 
    coordinates
    UGV UAV - UV 
    NavMode 
    Pan Tilt -Orientation
)

(:functions 
    ;(energy-level ?uv - UV)
    ;(battery-threshold ?r - robot)
    (distance ?c0 ?c1 - coordinates)
    (speed ?navmode - NavMode )
    (total-duration)
    (total-energy-used)
    (total-distance)
)

(:predicates 
    (uv-base ?x ?y - coordinates ?uv - UV)
    (at-uv ?x ?y - coordinates ?uv - UV)
    (docked ?uv -UV)
    ;(uv-tilt ?t - Tilt ?uv - UV)
    (uv-orientation ?o - Orientation ?uv - UV)
    (uv-navmode ?nv - NavMode ?uv - UV)
    (taken-photo ?x ?y - coordinates ?t - Tilt ?p - Pan)
    (took-photo ?x ?y - coordinates ?t - Tilt ?p - Pan ?uv - UV)
    (transmitted-photo ?x ?y - coordinates ?t - Tilt ?p - Pan)
)

(:durative-action dock
:parameters (?uv - UV ?x ?y - coordinates)
:duration (= ?duration 1)
:condition (and 
            (over all (uv-base ?x ?y ?uv))
            (over all (at-uv ?x ?y ?uv)))
:effect (and 
            (at end (docked ?uv))
            (at end (increase (total-duration) 1 ))
            (at end (increase (total-energy-used) 1))
            )
)

;añadir que no este dockeada si vemos que no hay problema

(:durative-action undock
:parameters (?uv - UV)
:duration (= ?duration 1)
:condition (over all (docked ?uv))
:effect (and (at end (not (docked ?uv)))
            (at end (increase (total-duration) 1))
            (at end (increase (total-energy-used) 1))
            )
)

(:durative-action move
:parameters (?uv - UV ?x0 ?y0 ?x1 ?y1 - coordinates ?navmode - NavMode)
:duration (= ?duration (*(/ (+ (distance ?x0 ?x1) (distance ?y0 ?y1)) (speed ?navmode)) 10 ))
:condition (and
            (over all (not (docked ?uv)))
            (at start (at-uv ?x0 ?y0 ?uv ))
            (at start (not (and (= ?x0 ?x1) (= ?y0 ?y1))))
            (at start (uv-navmode ?navmode ?uv))
            )
:effect (and
        (at end(not (at-uv ?x0 ?y0 ?uv)))
        (at end(at-uv ?x1 ?y1 ?uv))
        (at end(increase (total-energy-used)(* (speed ?navmode) (+ (distance ?x0 ?x1) (distance ?y0 ?y1)))))
        (at end (increase (total-duration)(*(/ (+ (distance ?x0 ?x1) (distance ?y0 ?y1)) (speed ?navmode)) 10 )))
        (at end (increase (total-distance) (+ (distance ?x0 ?x1) (distance ?y0 ?y1))))
    )
)

(:durative-action take-photo
:parameters (?uv - UV ?x ?y - coordinates ?t - Tilt ?p - Pan)
:duration (= ?duration 2)
:condition (and 
            (over all (at-uv ?x ?y ?uv))
            (over all (uv-orientation ?t ?uv))
            (over all (uv-orientation ?p ?uv))
            (over all (not (docked ?uv)))
            )
:effect (and (at end (taken-photo ?x ?y ?t ?p))
           (at end (increase (total-duration) 2))
           (at end (increase (total-energy-used) 2))
           (at end (took-photo ?x ?y ?t ?p ?uv))
           )     
)

(:durative-action change-orientation
:parameters (?o0 ?o1 - Orientation ?uv - UV)
:duration (= ?duration 1)
:condition (and (at start (uv-orientation ?o0 ?uv))
                (over all (not (= ?o0 ?o1))))
:effect (and 
        (at end (uv-orientation ?o1 ?uv))
        (at end (not (uv-orientation ?o0 ?uv)))
        (at end (increase (total-duration) 1))
        (at end (increase (total-energy-used) 1))
        )
)

(:durative-action change-navmode
:parameters (?n0 ?n1 - NavMode ?uv - UV)
:duration (= ?duration 1)
:condition (and (at start (uv-navmode ?n0 ?uv))
                (over all (not (= ?n0 ?n1))))
:effect (and 
        (at end (uv-navmode ?n1 ?uv))
        (at end (not (uv-navmode ?n0 ?uv)))
        (at end (increase (total-duration) 1))
        (at end (increase (total-energy-used) 1))
        )
)

(:durative-action transmit-photo
:parameters (?x ?y - coordinates ?t - Tilt ?p - Pan ?uv - UV)
:duration (= ?duration 20)
:condition (and (over all (took-photo ?x ?y ?t ?p ?uv))
                (at start (not (transmitted-photo ?x ?y ?t ?p))))
:effect (and 
        (at end (transmitted-photo ?x ?y ?t ?p))
        (at end (increase (total-duration) 20))
        (at end (increase (total-energy-used) 20))
        )
)

)