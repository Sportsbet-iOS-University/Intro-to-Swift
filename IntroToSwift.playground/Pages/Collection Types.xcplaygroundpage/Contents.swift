//: [Previous: Simple Types](@previous)

import Foundation

/*:

# Arrays

Swift ships with a *single*, highly performant type for handling lists of data:
the `Array`. This is in contrast to 
[other](https://en.wikipedia.org/wiki/Java_collections_framework )
[languages](https://en.wikipedia.org/wiki/C_Sharp_(programming_language) )
which can ship with dozens of different implementations of list, making it
difficult for code to share data since there isn't a single consistent way
to represent lists of data.

The `Array` type stores values *of the same type* in an ordered list. The same
value can appear in an array multiple times at different positions.

Swift has a special shorthand syntax for defining Array types:

*/

let strings: [String] = [String]()

/*:

Or you can use Type Inference to shorten this to:

*/

let stringsShorter = [String]()

/*:

This creates an empty array of `String`s. The Array part is `[String]`, and the
`()` is the initializer, just like how you would use `Int64(10)` to initialize
an `Int64`.

Arrays declared with `let` are immutable and cannot have elements added or
removed from them. Mutable versions can be declared using `var` as usual. As
always, you should always create immutable (constant) versions whenever
possible as this allows the Swift compiler to generate the fastest code.

There is a special syntax for constructing an Array of values at
compile-time from given values, the array literal:

*/

let immutableArray = [4, 8, 15, 16, 23, 42]

/*:

You can even include Swift expressions inside an array literal:

*/

let twoTimesTable = [2*1, 2*2, 2*3, 2*4, 2*5, 2*6, 2*7, 2*8, 2*9, 2*10]

/*:

Mutable arrays can have their values change:

*/

var mutableArray = [Int]()

mutableArray += immutableArray
mutableArray.append(100)
mutableArray.count

/*:

With immutable arrays, you can still define a new array whose value is derived
from other arrays:

*/

let firstArray = [1, 2, 3]
let secondArray = [4, 5, 6]
let joinedArray = firstArray + secondArray

/*:

You can modify values in a mutable array:

*/

var toDoList = ["get keys to roof",
    "ask for permission",
    "go to roof",
    "jump off"
]

/*:

You can access and modify values at a specific index in an Array using the
subscripting syntax:

*/

toDoList[1] = "leave a note"

toDoList

/*:

Actually, if you decided to live:

*/

toDoList[3] = "admire the view"

toDoList

/*:

What was that first thing again?

*/

let firstItem = toDoList[0]

/*:

When you remove an item, all the preceding items move back a place:

*/

toDoList.removeAtIndex(1)

toDoList

/*:

And the opposite happens when you insert an item:

*/

toDoList.insert("stare wistfully out the window", atIndex: 0)

toDoList

/*:

If you're doing stack-like things, you can even retrieve-and-remove the last or
first element all in one operation:

*/

let poppedItem = toDoList.removeLast()

toDoList

/*:

## Iterating Over an Array

You can iterate over the entire set of values in an array with the for-in
loop:

*/

var tasksInList = ""
for task in toDoList {
    tasksInList += ", \(task)"
}

tasksInList

/*:

Well that doesn't look very good, if only we could do something different for
the first element:

*/

tasksInList.removeAll()
for (index, task) in toDoList.enumerate() {
    if index == 0 {
        tasksInList += task
    } else {
        tasksInList += ", \(task)"
    }
}

tasksInList

/*:

Much better! If you remember Tuples from the [Simple Types](Simple%20Types)
page, this `for` loop works by *decomposing* each tuple returned by
`toDoList.enumerate()` into two constants, `index` and `task`.

*/

/*:

## Arrays Exercise 1

Write a function that accepts a tuple of `(Int, Int, Int)` and returns an Array
containing each of the elements of the tuple in order, as well as the sum of
the numbers (as the 4th item in the Array) and the rounded-down mean (average,
as the 5th item in the Array).

- Hint: If you end up with a `Float` or `Double` for the mean, remember you can
round down using `floor(myDouble)`, and you convert it back to an `Int` by
using `Int(flooredDouble)`. You can avoid this by sticking to `Int` divisions!

*/

func arrayFromTuple(tuple: (Int, Int, Int)) -> [Int] {
    // Write your code here
    return []
}

arrayFromTuple((5,10,15)) == [5,10,15,30,10] // This is true when solved!

/*:

# Dictionaries

A dictionary stores associations between keys of the same type and values of
the same type in a collection with no defined ordering. Each value is 
associated with a unique key, which acts as an identifier for that value within
the dictionary. Unlike items in an array, items in a dictionary do not have a 
specified order. You use a dictionary when you need to look up values based on 
their identifier, in much the same way that a real-world dictionary is used to 
look up the definition for a particular word.

Swift has a special shorthand syntax for defining Dictionary types:

*/

let dictOfStringsToStrings: [String : String] = [String : String]()

/*:

Or you can use Type Inference to shorten this to:

*/

let dictOfStringsToStrings2 = [String : String]()

/*:

The type to the left of the `:` is the _key_ type, and the type to the right of
the `:` is the _value_ type. The _key_ is something you use to lookup a _value_
in the dictionary. For example:

*/

let memes = [
    "rekt": "A slang version of the word 'wrecked'",
    "kek": "Like 'lol', but more edgy",
    "lel": "Like 'kek', but more edgy"
]

/*:

I can now retrieve a value from this dictionary by looking it up using its key:

*/

let rektMeaning = memes["rekt"]

/*:

You can iterate over a Dictionary the same way you do for Arrays. However, this
time notice how the order is _not_ the same as the order they were added?

*/

var memesAndMeanings = ""
for (meme, meaning) in memes {
    memesAndMeanings.appendContentsOf("\(meme): \(meaning)\n")
}
memesAndMeanings

/*:

Unlike Array, you cannot derive a Dictionary from other Dictionaries, you must
use a mutable one:

*/

var moreMemes = memes
moreMemes["maymay"] = "An phonetic mispronunciation of meme"

moreMemes

/*:

# Sets

*/



//: [Next: Classes](@next)
