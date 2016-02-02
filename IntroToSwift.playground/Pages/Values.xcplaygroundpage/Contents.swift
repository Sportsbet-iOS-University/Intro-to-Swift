//: [Previous: Collection Types](@previous)

import Foundation

/*:

So far we've been defining functions, constants and variables in what's called
the *global scope*. You should almost *never* do this in a real project! It's 
fine, because we're in a playground right now, and there's very few 
consequences for bad code here, but in a real project, your functions, 
constants and variables should always be *scoped*.

This basically means that you should only write functions, constants and 
variables inside a struct, class or enum.

Forget about classes for now, we'll learn about those in the [Next](@next) 
section, let's talk about structs and enums.

*/

/*:

# Structs

A struct, short for *structure*, is a data type that is useful for organising
groups of data, constants and functions together. You didn't know it at the
time, but Array and String are examples of struct! You can define your own
struct like this:

*/

struct Example1 {
    
}

/*:

This is an empty struct so it doesn't hold any data and it doesn't do anything.
Not very exciting.

Here's an example struct which models an email:

*/

struct Email {
    let sender: String
    let recipient: String
    let subject: String
    let body: String
    
    func send() {
        // Send the email
    }
}

/*:

You can create an `Email` like this:

*/

let anEmail = Email(sender: "b.lumbergh@initech.com",
    recipient: "p.gibbons@initech.com",
    subject: "Working Saturday",
    body: "Mmyeah, I'm gonna need you to come in on Sunday too")

/*:

And you can call functions on that newly created struct:

*/

anEmail.send()

/*:

You can read values out of a struct:

*/

let theSubject = anEmail.subject

/*:

The first declaration, the `struct Email` one, defines the structure that
*every* email must have. You will also write all the functions that an email
can perform. The second part, where we created an email with `let`, this
creates an *instance* of an email. This particular email has particular values,
and is different from all other *instances* of emails.

When you call a function on an *instance* struct, it'll apply just to that
particular instance. This is obvious in this case because you're applying the
`send()` function on the `anEmail` instance. What if we want a function that's
still related to a struct but not to a particular instance?

*/

struct Time {
    static func currentTime() -> Time {
        return Time()
    }
}

/*:

You can use the keyword `static` to indicate that the function, variable, or
constant is attached to the `Time` struct as a concept, rather than any
specific instance of `Time`. Sorry, this is all pretty abstract and hard to
explain, but have a look at the usage below, and try fiddling with it yourself
to get a feel for what's happening here.

*/

let t1 = Time.currentTime()

/*:

Notice how we can call currentTime on Time, and not some instance of it? Here
we've also created a constant *instance* of a `Time`, called `t1`. Let's try
to call that static function on `t1` instead of `Time`:

*/

// let t2 = t1.currentTime()
// error: static member 'currentTime' cannot be used on instance of type 'Time'

/*:

In functions declared inside a struct, you can refer to fields in the *current 
instance* of the struct by using the keyword `self`. For example:

*/

struct Rectangle {
    let length: Double
    let width: Double
    func area() -> Double {
        return self.length * self.width
    }
    
    func differenceInArea(otherRectangle: Rectangle) -> Double {
        return self.area() - otherRectangle.area()
    }
}

/*:

This is actually *not required* though, you can also simply type `return length
* width` and Swift is smart enough to know you mean `self.length` and
`self.width` for you. Try it yourself, remove the `self.` and watch. Sometimes
it's helpful to explicit by including the `self.` but most of the time you can
omit it.

*/

/*:

# Structs Exercise

Create a struct called `Position`, which has two fields:

- x: `Double`
- y: `Double`

*/

// Write your code here



/*:

# Structs Exercise 2

Create a struct which uses the `Position` struct you just created, to create
another struct called `Circle`, which has the following fields:

- position: `Position`
- radius: `Double`

And it also has a function, `area()` which returns the area of the `Circle` as
a `Double`.

Hint: The area of a circle is π * r² -- You can get π in Swift with `M_PI`.

*/

// Write your code here



/*:

# Enums

Enums are similar to structs, but is used to model some data that can only ever
be a specific value specified from a definite list of possible states. For
example, unless there's a zombie apocalypse, there's only two states a living
thing can be:

*/

enum LifeStatus {
    case Alive
    case Dead
}

/*:

We can combine this with a struct to form powerful data types:

*/

struct Dog {
    let status: LifeStatus
    let name: String
    
    func bark() -> String {
        switch status {
        case .Alive:
            return "bark!"
        case .Dead:
            return "dead things can't bark :("
        }
    }
}

let fido = Dog(status: .Alive, name: "Fido")
fido.bark()

let rex = Dog(status: .Dead, name: "Rex")
rex.bark()

/*:

Enums themselves can even have functions:

*/

enum Weather {
    case Sunny, Overcast, Showers, Rain
    
    static func inMelbourne() -> Weather {
        let weathers: [Weather] = [.Sunny, .Overcast, .Showers, .Rain]
        let randomIndex = Int(arc4random()) % weathers.count
        return weathers[randomIndex]
    }
    
    func rainier() -> Weather {
        switch self {
        case .Sunny:
            return .Overcast
        case .Overcast:
            return .Showers
        case .Showers:
            return .Rain
        case .Rain:
            return .Rain
        }
    }
}

let sunny = Weather.Sunny
let melbourne = Weather.inMelbourne()
sunny.rainier()

/*:

Sometimes it's appropriate for an enum to have an underlying type. When the
type is an `Int`, Swift will automatically set the values for each case by
counting up from `0`, or you can specify the first number it starts counting
from:

*/

enum Planet: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

Planet.Earth.rawValue

/*:

In this case, `Mercury` is `1`, `Venus` is `2`, and so on.

Another special case is when the underlying type is `String`. In this case,
if you don't specify the value, it'll use the name of the case as its String
value:

*/

enum Greeting: String {
    case Hello, Bonjour, Hola
}

Greeting.Hello.rawValue

/*:

Which also has the advantage that you can get a `Greeting` enum from a 
`String`:

*/

let greet: Greeting? = Greeting(rawValue: "Bonjour")

/*:

This is appropriate when every case has the same underlying type. Sometimes you
want an enum where some cases have some attached value but others don't, or
perhaps they have an attached value of a different type. Here you can use
_associated values_:

*/

enum MediaItem {
    struct Resolution {
        let width, height: Double
    }
    
    case Audio(duration: Double)
    case Video(duration: Double, resolution: Resolution)
    case Book(pages: Int)
}

/*:

Here we did something fancy and defined a struct *inside* an enum. This just
tells Swift that the `Resolution` struct is intrinsically tied to the
`MediaItem` enum. Whilst you're inside the `MediaItem` declaration, any
reference to `Resolution` will always resolve to `MediaItem`'s `Resolution`.
If you wanted to reference it outside you'd have to do this:

*/

let res = MediaItem.Resolution(width: 640, height: 480)

/*:

Because it's declared inside the `MediaItem`, you have to access it *via* the
`MediaItem` enum first.

Since `MediaItem`'s cases have associated data, when creating an instance of
this enum we have to also provide the associated data:

*/

let video = MediaItem.Video(duration: 10, resolution: res)

/*:

If we want to read a value out of an enum, we first have to use a `switch` to
pick the correct enum case, then we can *bind the associated values to a local
constant*:

*/

switch video {
case .Video(let duration, let resolution):
    print("duration is \(duration)s, resolution is \(resolution)")
default:
    // "Break" means just drop out of the switch statement.
    break
}

/*:

# Enums Exercise

Create an enum called `BackyardItems`, with the following cases:

- `DogHouse`, with an associated value of type `Dog`, the struct from earlier.
- `SwingSet`, with an associated value of type `Int`, the number of swings.
- `ClothesLine`, with no associated type

You can also add cases for anything else you may have lying around in your
backyard. For fun, try creating an Array which contains all the stuff you've
actually got in your backyard (if you have one), or just make stuff up!

For an extra challenge, now try iterating through that array and printing out
a description of each of the items in the backyard.

*/
// Write your code here


/*:

# Protocols

A protocol defines a blueprint of functions, variables, and other requirements
that suit a particular task or piece of functionality. The protocol can then be
adopted by a class, structure, or enumeration to provide an actual 
implementation of those requirements. Any type that satisfies the
requirements of a protocol is said to conform to that protocol.

For example, we could assert that anything that "quacks" is a Duck:

*/

protocol Duck {
    func quack()
}

/*:

We've created a protocol called `Duck`. This allows us to specify that one of
our structs, enums or classes *conforms* to the `Duck` protocol. If we do that,
we *promise* that we'll provide an implementation of the `quack()` function,
since that is what the protocol requires.

Truthfully, we should probably call something like this "Quackable", since it
just says that anything that conforms to it can quack, but in this universe,
let's just say that anything that's quacks like a duck *is* a duck!

We could create a `Mallard` struct now which conforms to the `Duck` protocol:

*/

struct Mallard: Duck {
    func quack() {
        print("Quack!")
    }
}

/*:

Try removing the `quack()` function and seeing what error comes up. Because we
added the `: Duck` part in the declaration, that tells Swift that our
`Mallard` struct *conforms* to the `Duck` protocol, which means we promise that
we'll provide an implementation of the `quack()` function.

Protocols can also require conformers to provide variables, as well as
functions:

*/

protocol Named {
    var name: String { get }
    
    func sayName()
}

/*:

There are complex reasons why protocols require this syntax to specify
variables, for now just remember that if you want a protocol to require
conformers to provide a read-only variable, you use:

    var variable: Type { get }

For write-only:

    var variable: Type { set }

For read and write:

    var variable: Type { get set }

Structs, enums and classes can conform to more than one protocol at a time,
and therefore promise to implement *all* of its protocols' variables and
functions:

*/

struct Swan: Duck, Named {
    let name: String
    
    func quack() {
        print("Hooonk")
    }
    
    func sayName() {
        // You really expect a Swan to talk?
        quack()
    }
}

/*:

Protocols are useful because it provides the ability for libraries and third-
party code to interact with code you write. Say we wanted to work with a
library written by someone you've never seen or talked to before. They could
provide a protocol like `Named`, and in their functions they'd specify that
what they're looking for is something that conforms to that `Named` protocol:

*/

// Imagine this function was defined in some code you didn't write
func gimmeANamed(namedThing: Named) {
    namedThing.sayName()
}

// You'd still be able to use it with your struct
let swan = Swan(name: "John the Swan")
gimmeANamed(swan)

/*:

Because `Swan` conforms to `Named`, you can pass instances of it to anything
expecting a `Named`, or `Duck`. It's extremely important to get this right,
since this functionality is used *extensively* in the iOS and OS X frameworks.

*/

/*:

# Protocols Exercise

In a super-secret location, I've written the following protocol:

    protocol NSASpyable {
        var personalInformation: String { get }

        func sendInfoToNSA()
    }

Write a struct that conforms to this protocol. Then, create several instances
of your struct in an Array. You can then pass this array into a function I've
written also in a super-secret place. You can invoke this function like this:

    beginPRISMProgram(myArray)

*/

// Write your code here



//: [Next: Classes](@next)
