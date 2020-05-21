(define (problem restaurante-p)
(:domain restaurante)
(:objects 
    p1 p2 - pedido
    mesa1 mesa2 c1 - localizacion    
    doraemon1 doraemon2 - robot
)
(:init
    (en-cocina-pedido p1)
    (en-cocina-pedido p2)
    (lugar-robot mesa1 doraemon1)
    (lugar-robot mesa2 doraemon2)
    (cocina c1)
)
(:goal 
   (and
    (entregado-pedido p1 mesa1)
    (entregado-pedido p2 mesa2))
)
(:metric minimize (total-time))
)