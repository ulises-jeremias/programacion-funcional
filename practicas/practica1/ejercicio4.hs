fib 0 = 1
fib 1 = 1
fib n
  | n < 0 = error "The first argument must be a natural number"
  | otherwise = fib (n - 1) + fib (n - 2)
