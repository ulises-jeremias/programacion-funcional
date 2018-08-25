--ejercicio 9
esBisiesto x = (mod (mod x 100) 4 == 0 && mod x 100 /= 0) || mod x 400 == 0

--ejercicio 10
between x y z =
  if x < (max x (max y z )) && x > (min x (min y z ))
    then x
    else if y < (max x (max y z )) && y > (min x (min y z ))
      then y
      else z
      
sort3 x y z = (min x (min y z), between x y z, max x (max y z))
