def bubble_sort(array)
  
  n = array.length

  for i in 0...n
    for j in i...n
      if array[i] > array[j]
        array[i], array[j] = array[j], array[i]
      end
    end
  end
  return  array
end

def bubble_sort_by(array)
  n = array.length

  for i in 0...n
    for j in i...n
      if yield array[i], array[j] >= 0
        array[i], array[j] = array[j], array[i]
      end
    end
  end

  return array
end
