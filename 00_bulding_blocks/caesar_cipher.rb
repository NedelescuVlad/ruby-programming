def caesar_cipher(word, key)

    encoded_word = ''

    word.split('').map(&:ord).each do |letter|
        i = 0
        if (letter >= 97 && letter <= 122)
            while i < key do
                letter = letter + 1

                if letter == 123
                    letter = 97
                end

                i = i + 1
            end
        elsif (letter >= 65 && letter <= 90)    
            while i < key do 
                letter = letter + 1

                if letter == 91
                    letter = 65
                end

                i = i + 1
            end
        end

        encoded_word << letter.chr
    end

    encoded_word 
end

puts caesar_cipher("What a string!", 5)
