def main
    puts tuningTrouble(4)
    puts tuningTrouble(14)
end

def tuningTrouble(dist_chars)
    File.readlines('input/input6.txt').each do |line|
        line = line.chomp
        i = 0
        while i < line.length
            if line[i..i + dist_chars - 1].split("").uniq.length == dist_chars
                return i + dist_chars
                break
            end
            i += 1
        end
    end
end

main
