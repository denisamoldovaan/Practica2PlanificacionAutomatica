(define (domain res2)
(:requirements :strips :typing :durative-actions :fluents)

(:types robot pedido mesa cocina )

(:predicates 
    (en-cocina-pedido ?p - pedido)
    (en-cocina-robot ?r - robot)
    (llevando-pedido ?p - pedido ?r -robot)
    (ocupado ?r - robot)
    (at-mesa ?m - mesa ?r - robot)
    (at-mesa-pedido ?m - mesa ?p - pedido)
    (nota-mesa ?m)
)
(:functions 
    (distancia ?m0 ?m1 - mesa)
    (distancia-cocina ?m - mesa)

)

(:durative-action coger-nota
:parameters (?m - mesa  ?r - robot)
:duration (= ?duration 100)
:condition (and 
            (at start (nota-mesa ?m))
            (at start (at-mesa ?m ?r))
            )
:effect (and 
            (at end (not(nota-mesa ?m)))
            )
)

(:durative-action coger-pedido
:parameters (?p - pedido  ?r - robot)
:duration (= ?duration 1)
:condition (and 
            (at start (en-cocina-pedido ?p))
            (at start (en-cocina-robot ?r))
            (at start (not (ocupado ?r)))
            )
:effect (and 
            (at end (llevando-pedido ?p ?r))
            (at end (ocupado ?r))
            (at end (not (en-cocina-pedido ?p)))
            )
)
(:durative-action dejar-pedido
:parameters (?p - pedido  ?r - robot ?m - mesa)
:duration (= ?duration 1)
:condition (and 
            (at start (llevando-pedido ?p ?r))
            (at start (at-mesa ?m ?r))
            )
:effect (and 
            (at end (not (llevando-pedido ?p ?r)))
            (at end (not (ocupado ?r)))
            (at end (at-mesa-pedido ?m ?p))
            )
)
(:durative-action mover-de-cocina
:parameters (?m - mesa ?r - robot)
:duration (= ?duration (distancia-cocina ?m))
:condition (and 
            (at start (not (at-mesa ?m ?r)))
            (at start (en-cocina-robot ?r))
            )
:effect (and 
            (at end (at-mesa ?m ?r))
            (at end (not (en-cocina-robot ?r)))
            )
)
(:durative-action mover-a-cocina
:parameters (?m - mesa ?r - robot)
:duration (= ?duration (distancia-cocina ?m))
:condition (and 
            (at start (at-mesa ?m ?r))
            (at start (not (en-cocina-robot ?r)))
            )
:effect (and 
            (at end (not (at-mesa ?m ?r)))
            (at end (en-cocina-robot ?r))
            )
)
(:durative-action mover-a-mesa
:parameters (?m1 - mesa ?m2 - mesa ?r - robot)
:duration (= ?duration (distancia ?m1 ?m2))
:condition (and 
            (at start (at-mesa ?m1 ?r))
            (at start (not (at-mesa ?m2 ?r)))
            )
:effect (and 
            (at start (at-mesa ?m2 ?r))
            (at start (not (at-mesa ?m1 ?r)))
            )
)

)