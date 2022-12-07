class Directory
    attr_accessor :parent, :children, :files, :size, :outermost_dir, :name

    def initialize(parent, name, outermost_dir = self)
        @parent = parent
        @children = []
        @files = []
        @size = 0
        @outermost_dir = outermost_dir
        @name = name
    end
end

class File
    attr_accessor :name, :size

    def initialize(name, size)
        @name = name
        @size = size
    end
end

def main
    puts noSpaceLeftOnDevice(true)
    puts noSpaceLeftOnDevice(false)
end

def noSpaceLeftOnDevice(isPartOne)
    directories = createTree()
    directories.size = getSize(directories)
    directories = setSize(directories)

    space_needed = 30000000 - (70000000 - directories.size)

    return sumOfDirsLessThan(directories, 100000) if isPartOne
    return freeUpSpace(directories, space_needed) if !isPartOne
end

def sumOfDirsLessThan(dir, size)
    sum = 0
    for child in dir.children
        sum += sumOfDirsLessThan(child, size)
        if child.size < size
            sum += child.size
        end
    end

    return sum
end

def freeUpSpace(dir, space_needed)
    min = dir.size
    for child in dir.children
        min = [min, freeUpSpace(child, space_needed)].min if child.size > space_needed
    end
    return min
end

def createTree
    dir = Directory.new(nil, "/")
    outermost_dir = Directory.new(nil, "/", dir)
    current_dir = outermost_dir
    File.readlines('input/input7.txt').each do |line|
        line = line.chomp.split(" ")
        if line[1] == "cd"
            next if line[2] == "/"
            if line[2] == ".."
                current_dir = current_dir.parent
            else
                new_dir = Directory.new(current_dir, line[2], outermost_dir)
                current_dir.children << new_dir
                current_dir = new_dir
            end
        elsif line[0] == "dir"
            current_dir.children
        elsif line[0].to_i != 0
            current_dir.files << File.new(line[1], line[0].to_i)
        end
    end

    return current_dir.outermost_dir
end

def getSize(dir)
    size = 0
    dir.files.map { |f| size += f.size }

    for child in dir.children
        size += getSize(child)
    end

    return size
end

def setSize(dir)
    for child in dir.children
        setSize(child)
        child.size = getSize(child)
    end

    return dir
end

main
