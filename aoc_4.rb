def main
    puts campCleanup(true)
    puts campCleanup(false)
end

def campCleanup(isPartOne)
    num_of_pairs = 0
    File.readlines('input/input4.txt').each do |line|
        line = line.chomp
        sections = line.split(",")
        s1 = sections[0].split("-")
        s2 = sections[1].split("-")
        s1r1 = s1[0].to_i
        s1r2 = s1[1].to_i
        s2r1 = s2[0].to_i
        s2r2 = s2[1].to_i

        if isPartOne
            if s1r1 >= s2r1 and s1r2 <= s2r2
                num_of_pairs += 1
                next
            end

            if s2r1 >= s1r1 and s2r2 <= s1r2
                num_of_pairs += 1
                next
            end
        else
            if s2r1.between?(s1r1,s1r2) or s2r2.between?(s1r1,s1r2)
                num_of_pairs += 1
                next
            end

            if s1r1.between?(s2r1,s2r2) or s1r2.between?(s2r1,s2r2)
                num_of_pairs += 1
                next
            end
        end
    end
    return num_of_pairs
end

main
