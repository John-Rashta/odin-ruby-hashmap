require_relative "lib/hashmap"

test = HashMap.new

test.set("apple", "red")
test.set("banana", "yellow")
test.set("carrot", "orange")
test.set("dog", "brown")
test.set("elephant", "gray")
test.set("frog", "green")
test.set("grape", "purple")
test.set("hat", "black")
test.set("ice cream", "white")
test.set("jacket", "blue")
test.set("kite", "pink")
test.set("lion", "golden")

p test.entries

p test.capacity

test.set("apple", "HERE")
test.set("banana", "NOW")

p test.entries

p test.capacity

test.set("moon", "silver")

p test.capacity

p test.length

test.set("jacket", "AGES")
test.set("kite", "AGO")
test.set("lion", "BYE")

p test.entries

p test.length

p test.get("jacket")
p test.get("asdsa")

p test.has?("kite")
p test.has?("fgdsgs")

p test.length
test.remove("lion")
test.remove("sadasfsa")
p test.length
p test.entries

p test.keys

p test.values

p test.clear

p test.capacity
p test.entries
p test.length
