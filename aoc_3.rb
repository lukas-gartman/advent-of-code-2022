alphabet_low = [*('a'..'z')]
alphabet_up  = [*('A'..'Z')]
@alphabet = alphabet_low + alphabet_up

def main
    puts rucksackReorganization(true)
    puts rucksackReorganization(false)
end

def getPriority(letter)
    return @alphabet.find_index(letter) + 1
end

def findCommon(rucksack)
    comp_length = rucksack.length / 2
    rucksack[0..comp_length].split("").each do |c|
        return c if rucksack[comp_length..rucksack.length - 1].include? c
    end
end

def findBadge(elf1, elf2, elf3)
    elf1.split("").each do |c|
        return c if elf2.include? c and elf3.include? c
    end
end

def rucksackReorganization(isPartOne)
    sum = 0
    input = File.readlines('input/input3.txt')
    if isPartOne
        input.each do |line|
            line = line.chomp
            itemBoth = findCommon(line)
            priority = getPriority(itemBoth)
            sum += priority
        end
    else
        input.each_slice(3) do |group|
            badge = findBadge(group[0], group[1], group[2])
            sum += getPriority(badge)
        end
    end

    return sum
end

main