//: [Previous Page: Introduction](@previous)

/*:
# Constants and Variables

A common operation in a programming language is to associate a name with some
value of a particular type. If this value never changes, you use a *constant*,
if you want to be able to change it later, you use a *variable*. To declare a
*constant*, you use the `let` keyword:
*/

let pi = 3.14159

/*:

To declare a *variable*, you use the `var` keyword:

*/

var currentTask = 1

/*:

In this example, the value of Pi is declared as a *constant* because it can
never change during the course of the program. The current task number is a 
variable because it needs to change during the course of the program.

You can change the value of a previously declared variable like so:

*/

currentTask = 2

/*:

You can even use other variables or constants on the right-hand-side of the `=`
sign:

*/

let numberOfTasks = 5
currentTask = numberOfTasks - 1

/*:

Try it yourself. Below I've declared a constant and a variable for you. Try
changing the value of the constant and seeing what happens. Then, try changing
the value of the variable. Make sure to delete the line where you try changing
a constant or the Playground will stop working, since all code in a Playground
must be valid!

*/

let constantValue = 10
var variableValue = 0



/*:

In general you should prefer to use *constants* over *variables* whenever you
can, as this makes your code easier to understand. Since values in a constant
never change it's easier for someone reading your code to reason about what it
will do when run. In fact, if you declare a *variable* but never change its
value, the Swift compiler will even warn you that you should've used a
*constant*!

*/

/*:

# Type Annotations

Swift is a *static*, *strongly-typed* language. The meaning of this is
complicated and deeply rooted in Computer Science nerdery, but basically it
means that the compiler *must* know the *Type* of absolutely everything at
compile-time. This is in contrast to JavaScript, which is a weakly-typed
language and is missing a compile step altogether. An example of this, in
JavaScript:

    function test(a) {
        return a + 1
    }

What is the *Type* of `a`? Nobody knows, not until the code is actually
executed! Intuition says it's probably a *number*, but you could just as easily
pass a *string* into it and the function would still work.

In Swift, such a function is invalid. The compiler *must* know what the *Type*
of `a` is at compile-time, which means you must provide a type annotation.

*/

func test(a: Int) -> Int {
    return a + 1
}

/*:

![Functions](2-1.png)

Here, the type annotation for the parameter `a` is `Int`, which tells the 
compiler that the parameter `a` *must* be a value of type `Int`. You can do
this for most values by using the format `: Type` after the name. Every
variable, constant, parameter, return type must have a *known Type* at the time
the code is compiled. This function also *returns* a value of type `Int`, which
is specified in the function by using the format `-> Type` after the parameter
list (i.e after the closing parenthesis).

"But what about the constants and variables we assigned above," you may ask,
"Those don't have type annotations, why do they work?"

*/

/*:

# Type Inference

In JavaScript, you are allowed to declare a variable *wihout a type* and
*without a default value*. That looks something like:

    var something;

That is illegal in Swift (uncomment to see error):
*/

//var something

/*:

Notice the error: "Type annotation missing in pattern"? Remember, in Swift, the
types for everything must be *known* at compile time. Emphasis on *known*,
because in certain situations, the compiler is able to *infer* the type if one
is not given. One such situation is when you provide a default value, as we
did earlier. This expression is valid:

*/

var something = "test"

/*:

This is valid because we provided a *default value* for it, which is the
`String` `"test"`. Since there's a default value, the compiler can *infer* the
type of `something` as `String`. In the cases where it's ambiguous or not
specified at all, you **must** provide a type annotation in the usual way:

*/

var noDefaultValue: String?

/*:

Notice how this is a valid declaration, even though we did not provide a
default value? That's because we explicitly specified the type as being a
`String?`.

- Note: You probably noticed the `?` at the end of the `String` type. This
signifies that the type is *Optional*. For now you can ignore this, we will
cover Optionals in more detail in the [Optionals](Optionals) page.

*/

/*:

# Semicolons

Semicolons are *optional* in Swift, and their use is *heavily discouraged*.
While this is technically valid:

*/

let i = 5;
let j = 6;

/*:

If you do this, you're a bad person, and you should feel bad. Don't put the
semicolons there, they're redundant and not necessary, no matter how much you
are used to putting semicolons at the end of lines.

Semicolons have a legitimate purpose, if you want to have multiple statements
on a single line:

*/

var x = 10; x += 1

/*:

However, you're not saving yourself anything doing this and you just make the
code harder to read. Separate those on to two lines. If you want to declare
multiple variables at once, you can use this syntax:

*/

var a, b, c: Int

/*:

# Numbers

We've worked with numbers a little bit above. Swift has two fundamental number
styles, *Integral* style numbers and *Floating-point* style numbers. For
integrals you can generally use `Int` and for real numbers you can generally
use `Float`.

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

## Converting Numbers

Sometimes something will want a `Float` when all you have is a `Int`. You can
convert easily between numbers. For example, the function below expects a
`Float`:
*/
let num = 10

func giveMeAFloat(number: Float) {
    
}

//giveMeAFloat(num)
//^ Cannot convert value of type 'Int' to expected argument type 'Float'

/*:
If you try to `num` directly into `giveMeAFloat` you will get a compiler error:
"Cannot convert value of type '`Int`' to expected argument type '`Float`'".
Basically, the compiler is telling you that it was expecting a `Float` but you
gave it an `Int`. If you convert it to a `Float` first, it works as expected:
*/

let numAsFloat = Float(num)
giveMeAFloat(numAsFloat)

// Or, on a single line:
giveMeAFloat(Float(num))


//: [Next Page: Simple Types](@next)
