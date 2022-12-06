def main
    puts supplyStacks(true)
    puts supplyStacks(false)
end

def getStack
    stack = []
    File.readlines('input/input5.txt').each do |line|
        line = line.chomp
        i = 1
        break if line[1].to_i == 1
        ary = []
        while i < line.length
            ary << line[i]
            i += 4
        end
        stack << ary
        ary = []
    end

    stack = stack.transpose
    for crates in stack
        crates.reject! { |crate| crate.strip.empty? }
        crates.reverse!
    end

    return stack
end

def getInstructions
    instructions = []
    File.readlines('input/input5.txt').each do |line|
        line = line.chomp.split(" ")
        i = 0
        ary = []
        while i < line.length
            if line[i] == "move"
                ary << line[i+1].to_i
                ary << line[i+3].to_i
                ary << line[i+5].to_i
            end

            i += 6
            instructions << ary if !ary.empty?
            ary = []
        end
    end

    return instructions
end

def supplyStacks(isPartOne)
    stack = getStack
    instructions = getInstructions

    i = 0
    ary = []
    for instruction in instructions
        num_of_moves = instruction[0]
        from_i = instruction[1] - 1
        to_i = instruction[2] - 1
        
        if isPartOne
            num_of_moves.times do
                crate = stack[from_i].pop
                stack[to_i].append crate
            end
        else
            crates = stack[from_i].pop(num_of_moves)
            stack[to_i].concat crates
        end
    end
    
    return stack.map { |crate| crate[-1] }.join("")
end

main
