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

/*:

# Functions

Given a simple function:

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

A more complex example:

*/

func doThing(onThis thing: Int, consideringThat otherThing: Int) {
    
}

/*:

![Complex function](2-2.png)

This function returns nothing, so it simply omits the return type. This
function specifies both *local* **and** *external* parameter names.

### Parameter Names

As above there are two kinds of parameters names, *external* parameter name
and *local* parameter name. *Only* the *local* parameter name is mandatory,
but you can specify a custom *external* parameter name if it will aid
readability of your function at its call site. If you do not specify an
external parameter name for the **first** parameter, it is omitted entirely
at the call site!

For example, here's a simple kind of function:

*/

func simple(a: Int) {
    _ = a + 1
}

/*:

This specifies only a **local** parameter name for its first parameter. This
parameter `a` can be accessed inside the function like any other constant by
using its *local parameter name*.

Since it doesn't specify an *external parameter name* for its first parameter,
the parameter name can be omitted entirely at the call site:

*/

simple(1)

/*:

If you want to force the parameter name to be written at the call site, include
an *external parameter name* in the first parameter:

*/

func jump(height height: Int) {
    
}

jump(height: 1)

/*:

Notice how we were *forced* to include the `height:` when calling this
function? This can be useful for writing self-documenting code.

Things are different with the *second* parameter in a function. By default, you
*must* write out the parameter name for the second parameter onwards, whether
you specify an *external parameter name* or not:

*/

func jumpHeight(height: Int, times: Int) {
    
}

jumpHeight(1, times: 2)

/*:

Notice how the parameter name `times:` is required at the call site, whether we
declared an external parameter name or not? You could also write this function
using *external parameter names* like:

*/

func jump(height height: Int, times: Int) {
    
}

jump(height: 1, times: 2)

/*:

While this is possible, the `jumpHeight(height: Int, times: Int)` way is
considered more *idiomatic*.

If you absolutely do not want the parameter names to be written at the call
site, you can mark them as such by declaring an *external parameter name* as an
underscore:

*/

func add(a: Int, _ b: Int) -> Int {
    return a + b
}

add(1, 2)

/*:

"What about the constants and variables we assigned above," you may ask,
"Those don't have type annotations, why do they work?"

*/

/*:

# Type Inference

In JavaScript, you are allowed to declare a variable *without a type* and
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

# Comments

Swift uses C++ style comments.

*/

// This comment runs to the end of the line.

/*

This block comment runs from the opening forward slash + asterisk, and runs 
to the closing asterisk + forward slash.

*/

/*:

Comments which generate documentation look like:

*/

/// This is a documentation comment that runs to the end of the line.

/**

This is a documentation comment that runs from the opening forward slash + 
asterisk, and runs to the closing asterisk + forward slash.

*/

/*:

Documentation comments use a subset of the Markdown (specifically, CommonMark)
syntax. More documentation can be found on the Apple site:

[Markup Overview](https://developer.apple.com/library/ios/documentation/Xcode/Reference/xcode_markup_formatting_ref)

*/

//: [Next Page: Simple Types](@next)
