def stock_picker(stocks)
    i = 0
    best_i = 0
    best_j = 0

    max = 0

    while (i < stocks.count) do
        j = i
        while (j < stocks.count) do
           if (stocks[j] - stocks[i] > max)
               best_i = i
               best_j = j
               max = stocks[j] - stocks[i]
           end
           j = j + 1
        end
        i = i + 1
    end
    a = [best_i, best_j]

end

best_days_to_buy = stock_picker([17,15,8,6,1])

if best_days_to_buy[0] == best_days_to_buy[1]
    p "No purchases can be made"
else
    p best_days_to_buy
end
