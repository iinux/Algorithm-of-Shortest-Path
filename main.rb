class Line
	attr_accessor :toPoint,:weight
	def initialize(toPoint,weight)
		@toPoint=toPoint
		@weight=weight
		self
	end
	def to_s
		"<"+@toPoint.to_s+":"+@weight.to_s+">"
	end
end

class Node
	attr_accessor :shortestWeight,:fromPoint
	def initialize(shortestWeight,fromPoint)
		@shortestWeight=shortestWeight
		@fromPoint=fromPoint
		self
	end
	def to_s
		"<ShortestWeight is "+@shortestWeight.to_s+",and its previous node is "+@fromPoint.to_s+".>"
	end
end

$table=Array.new

size=0
startPoint=0

File.open("data.txt") do |file|
	size=file.gets.to_i
	startPoint=file.gets.to_i
	(size+1).times{|i| $table.push(Array.new)}

	while line=file.gets
		linex=line.split(" ")
		$table[linex[0].to_i].push(Line.new(linex[1].to_i,linex[2].to_i))
	end
end

$resultTable=Array.new
(size+1).times{$resultTable.push(Node.new(999,-1))}
$resultTable[startPoint]=Node.new(0,-1)

def go(i)
	$table[i].map do |j|
		if ($resultTable[j.toPoint].shortestWeight>$resultTable[i].shortestWeight+j.weight)
			$duty=$duty|[j.toPoint]
			$resultTable[j.toPoint].shortestWeight=$resultTable[i].shortestWeight+j.weight
			$resultTable[j.toPoint].fromPoint=i
		end
	end
end

$duty=Array.new
$duty.push(startPoint)
while (!$duty.empty?)
	go($duty.shift)
end

$resultTable.shift
$resultTable.map { |e| puts e }
