def fibs(f1, f2, n)
		
	to_be_written = []

	written_elements_count = 0;	
	
	if n >= 2
		written_elements_count += 2
		to_be_written << f1 << f2
	elsif n == 1
		written_elements_count += 1
		to_be_written << f1
	end	

	while written_elements_count < n
		
		f3 = f1 + f2
		f1 = f2
		f2 = f3
		
		to_be_written << f3
		written_elements_count += 1
				
	end

	puts to_be_written
end

def fibs_rec(n, to_be_written=[])
 	if n - 1 >= 0
		to_be_written << fib(n - 1)
		fibs_rec(n-1, to_be_written)
	end
	return to_be_written
end

def fib(n)
	return n if n <= 1
	return fib(n-1) + fib(n-2)
end

puts "Iterative fib test: "
fibs(0, 1, 5)
puts "Recursive fib test: "
to_be_written = fibs_rec(5)
puts to_be_written.sort

