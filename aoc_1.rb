def main
    puts calorieCounting(true)
    puts calorieCounting(false)
end

def getElves
    elves = []
    elf = []
    File.readlines('input/input1.txt').each do |line|
        input = line.chomp.to_i
        if input == 0
            elves.push elf
            elf = []
        else
            elf.push input
        end
    end
    return elves
end

def getTopCalories(elves)
    top_calories = []
    for e in elves
        cals = e.sum
        top_calories.push cals
    end
    return top_calories.sort.reverse
end

def calorieCounting(isPartOne)
    elves = getElves()
    top_calories = getTopCalories(elves)
    
    return top_calories[0] if isPartOne
    return top_calories[0..2].sum if not isPartOne
end

main