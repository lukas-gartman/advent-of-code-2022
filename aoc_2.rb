def main
    puts rockPaperScissors(true)
    puts rockPaperScissors(false)
end

def rockPaperScissors(isPartOne)
    scores = Hash.new
    scores["X"] = 1
    scores["Y"] = 2
    scores["Z"] = 3
    scores["lose"] = 0
    scores["draw"] = 3
    scores["win"] = 6

    total = 0
    File.readlines('input/input2.txt').each do |line|
        choices = line.split(" ")
        opp1 = choices[0]
        opp2 = choices[1]

        total += getScore1(scores, opp1, opp2) if isPartOne
        total += getScore2(scores, opp1, opp2) if not isPartOne
    end

    return total
end

def getScore1(scores, opp1, opp2)
    if opp1 == "A"
        if opp2 == "X"
            return scores["draw"] + scores["X"]
        elsif opp2 == "Y"
            return scores["win"] + scores["Y"]
        elsif opp2 == "Z"
            return scores["lose"] + scores["Z"]
        end
    elsif opp1 == "B"
        if opp2 == "X"
            return scores["lose"] + scores["X"]
        elsif opp2 == "Y"
            return scores["draw"] + scores["Y"]
        elsif opp2 == "Z"
            return scores["win"] + scores["Z"]
        end
    elsif opp1 == "C"
        if opp2 == "X"
            return scores["win"] + scores["X"]
        elsif opp2 == "Y"
            return scores["lose"] + scores["Y"]
        elsif opp2 == "Z"
            return scores["draw"] + scores["Z"]
        end
    end
end

def getScore2(scores, opp1, opp2)
    if opp1 == "A"
        if opp2 == "X" # lose
            return scores["lose"] + scores["Z"]
        elsif opp2 == "Y" # draw
            return scores["draw"] + scores["X"]
        elsif opp2 == "Z" # win
            return scores["win"] + scores["Y"]
        end
    elsif opp1 == "B"
        if opp2 == "X"
            return scores["lose"] + scores["X"]
        elsif opp2 == "Y"
            return scores["draw"] + scores["Y"]
        elsif opp2 == "Z"
            return scores["win"] + scores["Z"]
        end
    elsif opp1 == "C"
        if opp2 == "X"
            return scores["lose"] + scores["Y"]
        elsif opp2 == "Y"
            return scores["draw"] + scores["Z"]
        elsif opp2 == "Z"
            return scores["win"] + scores["X"]
        end
    end
end

main