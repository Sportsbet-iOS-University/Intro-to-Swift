//: [Previous Page: Basics](@previous)

/*:

# Numbers

We've worked with numbers a little bit in the previous chapter. Swift has two
fundamental number styles, *Integral* style numbers and *Floating-point* style
numbers. For integrals you can generally use `Int` and for real numbers (i.e
fractional, decimal) you can generally use `Double`.

*/

let integralNumber = 1337
let realNumber = 1.337

/*:

Here the type of `integralNumber` is *inferred* to be `Int`, and the type of
`realNumber` is *inferred* to be `Double`. You can check this yourself by
Option-clicking the constant names.

In American English, we normally group our numbers by thousands to make them
easier to read. For example:

    25,152,015

Is easier to read than

    25152015

When using large literals in Swift code you can group numbers by thousands
using underscores:

*/

let hugeNumber = 25_152_015

/*:
## Number Sizes

Depending on how large a number you need, there are many options for which
number type to use. For integrals:

    Int8: -128 to 127
    Int16: -32768 to 32767
    Int32: -2,147,483,648 to 2,147,483,647
    Int64: -9.223372037E18 to 9.223372037E18
    UInt8: 0 to 255
    UInt16: 0 to 65535
    UInt32: 0 to 4,294,967,296
    UInt64: 0 to 1.844674407E19

For real numbers, there's `Float` and `Double`. If you need to represent really
large numbers or really small numbers very precisely, use `Double`, otherwise
use `Float`. Note that you should never use `Float` or `Double` for currency
or transactional data!

You can explicitly specify the types:

*/

let tinyIntegralNumber = Int8(2)
let tinyIntegralNumber2 = 10 as Int8
let tinyIntegralNumber3: Int8 = 10

/*:

All three of these methods work, and you can again verify that by
Option-clicking.

*/

/*:

## Converting Numbers

Sometimes something will want a `Float` when all you have is a `Int`. You can
convert easily between numbers. For example, the function below expects a
`Float`:
*/
let num = 10

func giveMeDubs(number: Double) {
    
}

//giveMeDubs(num)
//^ Cannot convert value of type 'Int' to expected argument type 'Double'

/*:

If you try to pass `num` directly into `giveMeAFloat` you will get a compiler
error: "Cannot convert value of type '`Int`' to expected argument type
'`Float`'". Basically, the compiler is telling you that it was expecting a
`Float` but you gave it an `Int`. If you convert it to a `Double` first, it
works as expected:

*/

let numAsDouble = Double(num)
giveMeDubs(numAsDouble)

// Or, on a single line:
giveMeDubs(Double(num))

/*:

This can be useful particularly if you are doing math. For example: if you were
catering an event for seventeen attendees and provided four cakes, which can
be sliced in eight pieces, how many slices is there per attendee?

This can be expressed in Swift:

*/

let numberOfAttendees = 17
let numberOfCakes = 4
let slicesPerCake = 8
let numberOfSlices = numberOfCakes * slicesPerCake

/*:

So far we're only using whole numbers (`Int`s), but when we calculate the
number of slices per attendee, that'll result in a fractional number, so we
should use a `Double`:

*/

let slicesPerAttendee = Double(numberOfSlices) / Double(numberOfAttendees)

/*:

Which results in the expected 1.88 slices. Watch what happens if we didn't
convert the numbers to Double first:

*/

let withoutConversion = numberOfSlices / numberOfAttendees

/*:

Notice how it resulted in `1`? That's because it did an *integer division*,
which basically just rounds the result down, which may not be what you want.

*/

/*:

## Numbers Exercise

Given a hard drive, which receives backups from seventeen different users, each
user adds a certain number of bytes per day, write a function which returns how 
many days of backup is remaining on the drive before it is full.

- Hint: Since `numberOfUsers` is an `Int` and the other parameters are `Int64`,
you may want to consider converting it to an `Int64` first!

- Hint: For available bytes = 4TB (4 trillion), users = 17, spacedUsed = 168MB
(168 million), the expected days remaining is about 1400.56.

*/

func daysRemainingForAvailableBytes(available: Int64, numberOfUsers: Int, spaceUsedPerDay: Int64) -> Double {
    // Write your code here
    
    return 0.0
}

daysRemainingForAvailableBytes(4_000_000_000_000, numberOfUsers: 17, spaceUsedPerDay: 168_000_000)

/*:

# Booleans

Swift has a basic *Boolean* type called `Bool`. These can only ever be one of
two possible Swift constant values: `true` or `false`:

*/

let grootIsGroot = true
let rocketIsGroot = false

/*:

Boolean values are particularly useful when you work with conditional
statements such as the `if` statement:

*/

if grootIsGroot {
    print("I am groot!")
} else {
    print("Nothing makes sense any more :(")
}

/*:

- Note: In Swift you do *not* need parentheses around the condition in an
`if` statement.

You can use the equality operators `==` and `!=` to compare two values, which
returns a `Bool` indicating if the two compared values are equivalent. Swift
does not have an `===` operator; unlike in JavaScript and PHP, the regular
`==` is not useless.

*/

/*:

# Tuples

*Tuples* group multiple values into a single compound value. The values within
a tuple can be of any type and do not have to be the same as each other.

In this example, `(404, "Not Found")` is a tuple that describes an *HTTP status
code*. An HTTP status code is a special value returned by a web server whenever
you request a web page. A status code of `404 Not Found` is returned if you
request a webpage that doesn’t exist.

*/

let http404Error = (404, "Not Found")

/*:

Try Option-clicking the `http404Error` constant to see its type: 
`(Int, String)`, which is read as "a tuple of type (Int, String)". Tuples are
not limited to two values, but the length of a tuple is finite and must be
declared.

You can decompose a tuple's contents into separate constants or variables,
which can then be accessed as usual:

*/

let (statusCode, statusMessage) = http404Error
print("The status code: \(statusCode)")
print("The status message: \(statusMessage)")

/*:

You can ignore a value using an underscore:

*/

let (justTheStatusCode, _) = http404Error

/*:

You can access values using an index number:

*/

let statusCodeByIndex = http404Error.0
let statusMessageByIndex = http404Error.1

/*:

Individual values inside a tuple can be named when you define the tuple:

*/

let http200Status = (statusCode: 200, statusMessage: "OK")

/*:

When values are named, you can use those instead of index numbers:

*/

let statusCodeByName = http200Status.statusCode
let statusMessageByName = http200Status.statusMessage

/*:

Tuples are very useful if you want to return multiple values from a function.
Since functions can only have one return value, you can compound multiple
values into a tuple to allow multiple returns. Combine this with the
capabilities above to allow very expressive functions.

*/

/*:

## Tuples Exercise

Rewrite the cake slices example from above, but as a function that returns
the whole number of slices per person (rounding down), and the number of
remaining slices as a tuple.

- Hint: Use the modulo operator `%` to get the remainder of a division. For
example, `5 % 3` returns `2`.

*/

func cakeSlicesPerPerson(people: Int, slices: Int) -> (slicesPerPerson: Int, remainder: Int) {
    // Write your code here
    
    return (0, 0)
}

let (slices, remainder) = cakeSlicesPerPerson(17, slices: 32)

// Your solution is correct if both of the above return true!
let slicesCorrect = slices == 1
let remainderCorrect = remainder == 15

/*:

# Strings

Like most things in Swift, `String` is very powerful but also very complicated.
We've already seen `String`s in action, but here's a quick refresher:

*/

let emptyString = ""
emptyString.isEmpty

/*:

`String`s declared with `var` are mutable and you can append to them:

*/

var stringBuilder = ""
stringBuilder.appendContentsOf("test")
stringBuilder += " plus this"

/*:

You can include values from constants, variables, literals or expressions in a
`String` by writing them inside a pair of \() characters, like so:

*/

let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"

/*:

## String Escapes

String literals can include the following special characters:

- The escaped special characters \0 (null character), \\ (backslash), \t
(horizontal tab), \n (line feed), \r (carriage return), \" (double quote) and
\' (single quote)
- An arbitrary Unicode scalar, written as \u{n}, where n is a 1–8 digit
hexadecimal number with a value equal to a valid Unicode code point

The code below shows four examples of these special characters. The wiseWords
constant contains two escaped double quote characters. The dollarSign,
blackHeart, and sparklingHeart constants demonstrate the Unicode scalar format:

*/

let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496

/*:

## Unicode

Swift `String`s are *always* Unicode-compliant and you cannot opt-out of this.
Internally, they are represented in UTF-16 coding. Simple operations such as
"get the fourth character" are complicated because the definition of "the
fourth character" is ambiguous in Unicode.

For example, consider the following `String`:

    "Koala 🐨"

What is the "length" of this String? Intuition says that it's 7, since there
are 7 characters in the String.

Look at what JavaScript does:

    > var str = "Koala 🐨"
    > str.length
    8

JavaScript naïvely counts the number of UTF-16 code points in the String, and
since the 🐨 emoji contains *two* UTF-16 codepoints (0xD83D followed by 0xDC28)
it incorrectly gets to the answer 8. In Swift, if you want to get the "count"
of a String, you have to explicitly tell it what you think that means.

If you're like JavaScript and you think that means UTF-16 codepoints:

*/

"Koala 🐨".utf16.count

/*:

If you're a normal person and you think "the number of characters or glyphs":

*/

"Koala 🐨".characters.count

/*:

If you only speak C, you can even get a C-friendly UTF-8 version of the String:

*/

"Koala 🐨".utf8.count

/*:

## String Equality

String and Character equality can be checked using the standard `==` and `!=`
operators:

*/

let beatlesQuote = "I am the walrus, goo goo g'joob"
let absolutelyTimeless = "I am the walrus, goo goo g'joob"

beatlesQuote == absolutelyTimeless

/*:

Swift does not have an `equals` method; unlike in JavaScript, PHP, Java, and
C#, the regular `==` is not useless. Remember that Swift `String`s are always
completely Unicode-aware: two `String` values (or two `Character` values) are
considered equal if they are *canonically equivalent*. This means they're equal
if they have the same *linguistic meaning and appearance*, even if they are 
composed from different Unicode scalars behind the scenes.

For example, in Unicode you could construct the character é one of two ways:
- Using the `LATIN SMALL LETTER E WITH ACUTE` codepoint (U+00E9)
- Using `LATIN SMALL LETTER E` (U+0065) followed by the `COMBINING ACUTE 
ACCENT`
(U+0301).

Both of these render out to the screen as an é:

*/

let eAcute = "caf\u{E9}"
let combinedAcute = "caf\u{65}\u{301}"

eAcute == combinedAcute

/*:

Swift Strings are complicated and nuanced so I recommend bookmarking the page
in Apple's documentation for future reference:

[Strings and Characters](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/StringsAndCharacters.html)

*/

/*:

## Strings Exercise 1

Using *only* String Interpolation (i.e don't write any code outside of the
String literal), write out:

- `str1`'s length as UTF-8 codepoints
- `str2`'s length as Characters
- `str3`'s length as UTF-16 codepoints

Printing your output String should result in:

    str1: 4
    str2: 4
    str3: 4

*/

let str1 = "1234"
let str2 = "café"
let str3 = "💩🌪"

func myString() -> String {
    // Write your code inside the String below using String Interpolation
    return ""
}

let expectedString = "str1: 4\nstr2: 4\nstr3: 4"
myString() == expectedString // This will be true when you've solved it!

/*:

## Strings Exercise 2

Write *three* different ways you could glue these three Strings together
into a single String:

*/

let first = "😘👌 Mamma mia!"
let second = "That's a"
let third = "spicy meat-a-ball!"

// Write your code here



//: [Next Page: Collection Types](@next)
