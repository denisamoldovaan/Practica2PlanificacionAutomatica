(define (problem res2-p)
(:domain res2 )
(:objects 
    p1 p2 p3 - pedido
    mesa1 mesa2 mesa3 mesa4 - mesa  
    doraemon1 doraemon2 doraemon3 - robot
)
(:init

    (= (distancia mesa1 mesa1) 0) 
    (= (distancia mesa1 mesa2) 3) (= (distancia mesa2 mesa1) 3)
    (= (distancia mesa1 mesa3) 3) (= (distancia mesa3 mesa1) 3)
    (= (distancia mesa1 mesa4) 5) (= (distancia mesa4 mesa1) 5)

    (= (distancia mesa2 mesa2) 0) 
    (= (distancia mesa2 mesa3) 5) (= (distancia mesa3 mesa2) 5)
    (= (distancia mesa2 mesa4) 3) (= (distancia mesa4 mesa2) 3)

    (= (distancia mesa3 mesa3) 0) 
    (= (distancia mesa4 mesa3) 3) (= (distancia mesa3 mesa4) 3)

    (= (distancia mesa4 mesa4) 0) 

    (= (distancia-cocina mesa1 ) 4) 
    (= (distancia-cocina mesa2 ) 4) 
    (= (distancia-cocina mesa3 ) 6) 
    (= (distancia-cocina mesa4 ) 6) 

    (en-cocina-robot doraemon1)
    (en-cocina-robot doraemon2)
    (en-cocina-robot doraemon3)
    (en-cocina-pedido p1)
    (en-cocina-pedido p2)
    (en-cocina-pedido p3)
    (nota-mesa mesa4)
    (nota-mesa mesa1)

    
)
(:goal 
   (and 
        (at-mesa-pedido mesa1 p1)
        (at-mesa-pedido mesa2 p2)
        (at-mesa-pedido mesa3 p3)
        (not(nota-mesa mesa4))
        (not(nota-mesa mesa1))
        
    )

)
(:metric minimize (total-time))
)