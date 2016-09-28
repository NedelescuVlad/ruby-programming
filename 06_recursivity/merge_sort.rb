def merge_sort(array)
	n = array.size
	
	return array if n <= 1

	left = merge_sort(array[0..n/2])
	right = merge_sort(array[n/2..-1])	
	
	return merge(left, right)
end

def merge(left, right) 
	
	final_array = []
	
	until left.empty? || right.empty?
		if left.first < right.first
			final_array << left.shift
		else 
			final_array << right.shift
		end	
	end

	final_array += left
	final_array += right	
	return final_array

end

# p merge([5,4,3,2], [1,2,3,4])
