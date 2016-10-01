class Node
	def initialize(value=nil, next_node=nil)	
		@value = value
		@next = next_node
	end

	def value
		@value
	end

	def next
		@next
	end

	def setNext(n)
		@next = n
	end
end

class LinkedList
	
	def initialize
		@size = 0
		@head= nil
	end

	def append(n)
		if @size == 0
			@head = n
		else
			working_node = @head
			while working_node.next != nil
				working_node = working_node.next
			end

			working_node.setNext(n)
		end

		@size += 1
	end

	def prepend(n)
		if @size == 0
			@head = n
		else
			n.setNext(@head);
			@head = n;
		end

		@size += 1
	end

	def size
		@size
	end

	def head
		@head
	end

	def tail
		if @size == 0
			return @head
		else
			working_node = @head
			while working_node.next != nil				
				working_node = working_node.next
			end

			return working_node
		end	
	end

	def at(index)
		curr_index = 0
			
		working_node = @head
		while working_node != nil
			if curr_index == index
				return working_node
			end
			working_node = working_node.next
			curr_index += 1
		end	
	end
	
	def pop
		if @size <= 1
			@head = nil
			@size = 0
		end

		curr_node = @head

		while curr_node != nil
			if curr_node.next != nil && curr_node.next.next == nil
				@size -= 1

				curr_node.setNext(nil)

				return
			end

			curr_node = curr_node.next

		end
	end

	def contains?(value)
		if @size == 0 
			return false
		else
			working_node = @head
			while @working_node.next != nil
				if working_node.value == value || working_node.next == value
					return true
				end
				working_node = working_node.next
			end
		end
		return false
	end

	def find(data)
		index = 0

		working_node = @head
		while working_node != nil
			if working_node.value == data
				return index
			else
				index += 1
				working_node = working_node.next
			end
		end

		return nil
	end

	def to_s
		working_node = @head

		result = String.new 
		while working_node != nil
			result << "#{working_node.value}->"
			working_node = working_node.next
		end
		result << "nil"
		
		return result
	end

	def insert_at(index, data)
		return if index < 0 || index > @size

		n = Node.new(data, nil)

		if index == 0
			@size += 1

			n.setNext(@head)
			@head = n

			return
		end

		curr_index = 1
		curr_node  = @head
		next_node = @head.next

		while curr_node != nil

			if curr_index == index
				@size += 1

				curr_node.setNext(n)
				n.setNext(next_node)

				return
			end

			curr_index += 1

			curr_node = next_node
			next_node = next_node.next
		end

	end

	def remove_at(index)

		return if index < 0 || index > @size - 1 || @size == 0

		if index == 0
			if @size >= 1
				@size -= 1
				@head = @head.next
			end

			return
		end	

		curr_node = @head
		next_node = @head.next
		curr_index = 1

		while next_node != nil
			if curr_index == index
				@size -= 1

				curr_node.setNext(next_node.next)

				return
			end

			curr_index += 1

			curr_node = next_node
			next_node = next_node.next
		end
	end
end

linked_list = LinkedList.new
linked_list.append(Node.new(1))
puts linked_list.tail.value
linked_list.append(Node.new(3))
puts linked_list.tail.value
linked_list.append(Node.new(5))
puts linked_list.to_s
linked_list.insert_at(0, 8)
puts linked_list
linked_list.pop
puts linked_list
linked_list.pop
puts linked_list
linked_list.pop
