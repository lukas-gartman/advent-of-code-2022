def main
    p treeHouse(true)
    p treeHouse(false)
end

def treeHouse(isPartOne)
    trees = getTrees()
    visibility = checkVisibility(trees)

    return countVisibility(visibility) if isPartOne
    return getHighestScenicScore(visibility.each_slice(trees.length).to_a) if !isPartOne
end

def getTrees
    trees = []
    File.readlines('input/input8.txt').each do |line|
        line = line.chomp.split("")
        ary = []
        for t in line
            ary << t.to_i
        end
        trees << ary
    end

    return trees
end

def checkVisibility(trees)
    visibility = []
    i = 0
    while i < trees.length
        j = 0
        while j < trees[i].length
            ary = [trees[i][j]]
            ary << :right if check(trees[i], j, j == trees[i].length - 1)
            ary << :left  if check(trees[i].reverse, trees.length - j - 1, j == 0)
            ary << :up    if check(trees.transpose[j].reverse, trees.length - i - 1, i == 0)
            ary << :down  if check(trees.transpose[j], i, i == trees[i].length - 1)
            visibility << ary
            j += 1
        end
        i += 1
    end

    return visibility
end

def check(trees, i, isOuter)
    return true if isOuter

    tree = trees[i]
    i += 1
    while i < trees.length
        return false if trees[i] >= tree
        i += 1
    end

    return true
end

def countVisibility(visibility)
    count = 0
    for v in visibility
        count += 1 if v.length > 1
    end
    return count
end

def getHighestScenicScore(v)
    score = 0
    i = 1
    while i < v.length - 1
        j = 1
        while j < v.length - 1
            right_score = getScore(v[i], j)
            left_score  = getScore(v[i].reverse, v.length - j - 1)
            down_score  = getScore(v.transpose[j], i)
            up_score    = getScore(v.transpose[j].reverse, v.length - i - 1)
            new_score   = right_score * left_score * down_score * up_score
            score = new_score if new_score > score
            j += 1
        end
        i += 1
    end
    
    return score
end

def getScore(v, j)
    score = 0
    k = j
    while k < v.length - 1
        score += 1
        k += 1
        break if v[k][0] >= v[j][0]
    end
    return score
end

main