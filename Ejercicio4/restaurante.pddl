(define (domain restaurante)
(:requirements :strips :typing :durative-actions :fluents)

(:types robot pedido localizacion)

(:predicates 
    (en-cocina-pedido ?p - pedido)
    (cocina ?l - localizacion)
    (lugar-robot ?l - localizacion ?r - robot)
    (llevando-pedido ?p - pedido ?r -robot)
    (ocupado ?r - robot)
    (entregado-pedido ?p - pedido ?l - localizacion)
)

(:durative-action coger-pedido
:parameters (?p - pedido ?l - localizacion ?r - robot)
:duration (= ?duration 1)
:condition (and 
            (at start (cocina ?l))
            (at start (lugar-robot ?l ?r))
            (at start (en-cocina-pedido ?p))
            (at start (not (ocupado ?r)))
            )
:effect (and 
            (at end (llevando-pedido ?p ?r))
            (at end (ocupado ?r))
            (at end (not (en-cocina-pedido ?p)))
            )
)

(:durative-action dejar-pedido
:parameters (?p - pedido ?l - localizacion ?r - robot)
:duration (= ?duration 2)
:condition (and 
            (at start (lugar-robot ?l ?r))
            (at start (llevando-pedido ?p ?r))
            )
:effect (and 
            (at end (not (llevando-pedido ?p ?r)))
            (at end (not (ocupado ?r)))
            (at end (entregado-pedido ?p ?l))
            )
)

(:durative-action moverse
:parameters (?l0 ?l1 - localizacion ?r - robot)
:duration (= ?duration 10)
:condition (and 
            (at start (lugar-robot ?l0 ?r))
            (over all (not (= ?l0 ?l1)))
            )
:effect (and 
            (at end (not (lugar-robot ?l0 ?r)))
            (at end (lugar-robot ?l1 ?r))
            )
)

)