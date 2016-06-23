def substrings(sentence, dictionary)
    results = Hash.new

    sentence = sentence.downcase

    dictionary.each do |word|
        if sentence.include?(word)
            if results.key?(word)
                results[word] += 1 
            else
                results[word] = 1
            end
        end
    end 
    results
end


dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts substrings("below", dictionary)
