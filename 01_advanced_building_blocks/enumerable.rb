module Enumerable
  def my_each
    for i in 0...self.length
      yield self[i]
    end
    return self
  end

  def my_each_with_index
    for i in 0...self.length
      yield self[i], i
    end
    return self
  end
  
  def my_select
    results = Array.new
    self.my_each do |item|
      if yield item
        results << item
      end
    end 
    return results
  end

  def my_all?
    self.my_each do |item|
      if !(yield item)
        return false
      end
    end
    return true
  end
  
  def my_any?
    self.my_each do |item|
      if yield item 
        return true
      end
    end
    return false
  end
  
  def my_none?
    self.my_each do |item|
      if yield item 
        return false
      end
    end
    return true
  end
  
  def my_count(*args) 
    if args.length > 1
      raise ArgumentError, 'Only one element may be counted'
    elsif
      args.length == 0
      return 0
    end
    
    my_each do |item|
      if item == args[0]
        find_count += 1
      end
    end
    return find_count
  end
  
  def my_map(*args)
    if args.length > 1
      raise ArgumentError, 'Only one proc may be passed'
    elsif args.length == 0 && !block_given?
      raise ArgumentError, 'A proc or block is required'
    end

    result = Array.new
    
    # Call either the proc or the block; proc when both are passed
    for i in 0...length
      if args.length == 1
        result[i] = args[0].call(self[i])
      else
        result[i] = yield(self[i])
      end
    end
    
    return result
  end

  def my_inject(*args)
   if args.length > 1
      raise ArgumentError.new("Only one default memo may be specified")
    elsif args.length == 0
      memo = 0
    end

    memo = args[0]

    my_each do |item|
      memo = yield memo, item
    end

    return memo
  end
end
