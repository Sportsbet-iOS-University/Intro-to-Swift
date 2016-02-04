//: [Previous: Values](@previous)

import Foundation

/*:

# Classes

Classes are fundamentally very similar to structs, except that they have
a few key differences and extra features. Like structs, you can use a class
to group together related functions, variables and constants. Once you've
defined a class, you can create *instances* of it just like you would with
a struct.

However, unlike structs, classes do not get default initializers created, so
you have to explicitly create them.

Initializers are like functions, except you don't write *func*, and they don't
have a name, you just write `init` followed by the parameter list:

*/

class Animal {
    var commonName: String?
    let scientificName: String
    
/*:

In this example, the scientific name is not optional, so it *must* be provided
at initialization time. So we have to create an initializer that sets it:

*/
    
    init(scientificName: String) {
        self.scientificName = scientificName
    }
}

/*:

We can now create instances of it like we would for structs.

*/

let lion = Animal(scientificName: "Panthera leo")
lion.commonName = "Lion"

/*:

Even though the `lion` instance itself is a constant, because its `commonName`
field is a *variable* and not a *constant*, we can change its value.

*/

/*:

# References

So far we've used enums and structs to great effect, but these types are what
is known as *value types*, whereas classes are *reference types*. What does
this mean? It's pretty complicated so we'll learn by example.

First, let's create a struct version of the `Animal` class from above:

*/

struct AnimalStruct {
    var commonName: String?
    let scientificName: String
}

let lionStruct = AnimalStruct(commonName: "Lion",
    scientificName: "Panthera Leo")

/*:

First, notice how we *had* to set the common name during initialization for
this instance, since structs do not let us change its `var`s after we create
them if we declare the struct's instance with `let`? Go on, try it, try to
change `lionStruct`'s `commonName`:

*/

//lionStruct.commonName = "test"
//^ error: cannot assign to property: 'lionStruct' is a 'let' constant

/*:

Another property of structs is that, as value types, when we assign them to a
new variable, it *copies* its contents to the new variable. What does this mean
in practice? Consider the following:

*/

var anotherLionStruct = lionStruct

// Now we've made it a var, it should let us change it!
anotherLionStruct.commonName = "Test"

/*:

What's the value in `lionStruct.commonName` now?

*/

lionStruct.commonName

/*:

It's still Lion, because even though we made `anotherLionStruct` = `lionStruct`
earlier, all that did was copy the data from `lionStruct` into
`anotherLionStruct`, so changing values on `anotherLionStruct` doesn't affect
the original struct at all!

This is useful, but what if we wanted a function like this one:

*/

func makeCommonNameHappier(animal: AnimalStruct) {
    var animalVariable = animal
    animalVariable.commonName?.appendContentsOf("😀")
}

/*:

This won't work! Look what happens:

*/

makeCommonNameHappier(anotherLionStruct)
anotherLionStruct

/*:

Even though we passed a `var` into it, it *still* made a copy when passing it
to the function. This is just what structs do. You could make this work, but
you'd have to make the function return a new `AnimalStruct`, and then assign
this new instance back to the `anotherLionStruct` local variable...

This has advantages, particularly when dealing with threads, but it involves
a lot of copying.

Classes, since they work *by reference* do not have have this problem.

*/

func makeCommonNameHappier(animal: Animal) {
    animal.commonName?.appendContentsOf("😀")
}

lion
makeCommonNameHappier(lion)
lion

/*:

Since `Animal` is a class and not a struct, all instances of `Animal` are
*references*. This means that if you assign an instance to another variable,
changing that other variable *will affect* the value of the first one. This can
be compact in memory but dangerous if you have many parts of your application
writing data at the same time.

As a general rule, people tend to use classes over structs, even though they're
slower and come with more risk, because they have more features and being
reference based makes them more powerful.

Structs are still useful and should be used in situations where the *value* of
an instance **is** its data. Like a String, the *value* of a String is its data
points; if you change a character in a String, you can basically consider that
a totally different String. Classes, on the other hand, just contain references
to other bits of data; changing things in an instance of a class doesn't change
the instance itself, just the things it references.

This can be hard to understand, and is certainly not intuitive. If in doubt,
use a class. If you know you want a struct, use a struct. You should still
always use enums for data that can only ever be a specific value specified from
a definite list of possible states.

*/

/*:

# Inheritance

Classes can also be *extended* to provide, or override functionality from their
parent. For example:

*/

class Vehicle {
    var currentSpeed = 0.0
    
    func status() -> String {
        return "traveling at \(currentSpeed) metres per second"
    }
    
    func noise() -> String {
        // "Vehicle" isn't specific enough to know what kind of noise
        // is made...
        return "*crickets*"
    }
}

/*:

Since `Vehicle` doesn't inherit (aka extend) from any other class, it is what's
known as a *base* class. Let's create a subclass of it:

*/

class Bicycle: Vehicle {
    var hasBasket = false
}

/*:

This should look familiar to you if you've read the section on Protocols. You
subclass using the same syntax as conforming to a protocol, except that a class
can only inherit from *one* superclass, but it can conform to any number of
protocols.

This new `Bicycle` class automatically gains all of the characteristics of
`Vehicle`, such as its `currentSpeed` variable, and its `status()` and
`noise()` methods. In addition, it adds a new variable, `hasBasket`, which
defaults to `false`.

*/

let bike = Bicycle()
bike.hasBasket = true
bike.currentSpeed = 2.4
bike.status()

/*:

Subclasses can themselves be subclassed:

*/

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

/*:

`Tandem` inherits all of the properties and methods from `Bicycle`, which in
turn inherits all of the properties and methods from `Vehicle`. The Tandem
subclass also adds a new variable called `currentNumberOfPassengers`,
with a default value of `0`.

If you create an instance of `Tandem`, you can work with any of its new and
inherited properties, and query the `status()` function it inherits from
`Vehicle`:

*/

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 3.1
tandem.status()

/*:

A subclass can also override a function from its parents:

*/

class Train: Vehicle {
    override func noise() -> String {
        return "choo choo!"
    }
}

let genericVehicle = Vehicle()
genericVehicle.noise()

let train = Train()
train.currentSpeed = 39.34
train.noise()

/*:

This is useful: say we had a function that only understood `Vehicle`s, we could
still pass it our subclass `Train` and have it understand:

*/

func observeVehicle(vehicle: Vehicle) -> String {
    return "Vehicle drove through at \(vehicle.currentSpeed)m/s, " +
        "making noise '\(vehicle.noise())'"
}

observeVehicle(tandem)
observeVehicle(train)

/*:

And it lets us put disparate types into a collection, since they all derive
from the same parent:

*/

let vehicles: [Vehicle] = [
    Train(),
    Tandem(),
    Bicycle()
]

/*:

# Classes Exercise

Modify the following classes so that these requirements are met:

- Jedi will *only* fight dark-side force users. It should return 
"Fight refused." if enemy is light-side, and hitpoints will not change.
- Sith will fight anything. If fighting a dark-side user, the one with the
*lower* hitpoints wins.
  - Sith will recover hitpoints equal to *half* the hitpoints of the defeated
    enemy at the beginning of the fight.
  - If hitpoints are *equal*, "self" wins.
- Light Side vs Dark Side will fight. The one with the *higher* hitpoints wins.
  - Victor will lose hitpoints equal to the hitpoints of the defeated enemy at
    the beginning of the fight.
  - If hitpoints are *equal*, "self" wins.
- Someone with 0 or less hitpoints is "dead" and fighting them does nothing.
In this case `fight()` should return "Nothing happens.".
- In the case where a fight happens, the output text should be like:
  <name> fights <enemy> with <colour> lightsaber! <winner> wins!
- Jedi can have blue, green, or purple lightsabers. Which colour they get is
  totally random, but once a colour is picked for an instance, it shouldn't
  change again! Sith always have red lightsabers.
- Jedi are always Light Side.
- Sith are always Dark Side.

Hint: You can ⌘+click the ForceUser text to see the definition of
`ForceUser`, which will show you what you can override and what variables
are available on a class.

Hint: The checker is ***extremely*** pedantic. Make sure your fight strings
match EXACTLY the case, number of spaces, full stop at end, etc.

*/

class Jedi: ForceUser {
    override init() {
        super.init()
    }
    
    override func side() -> ForceUser.Side {
        return super.side()
    }
    
    override func lightsaberColours() -> [ForceUser.LightsaberColor] {
        return super.lightsaberColours()
    }
    
    override func fight(other: ForceUser) -> String {
        return super.fight(other)
    }
}

class Sith: ForceUser {
    override init() {
        super.init()
    }
    
    override func side() -> ForceUser.Side {
        return super.side()
    }
    
    override func lightsaberColours() -> [ForceUser.LightsaberColor] {
        return super.lightsaberColours()
    }
    
    override func fight(other: ForceUser) -> String {
        return super.fight(other)
    }
}

// Do not modify below, and yes, I know this is Star Wars sacrilege

let luke = Jedi()
let obiwan = Jedi()
let darthvader = Sith()
let darthmaul = Sith()
luke.hitPoints = 10
obiwan.hitPoints = 8
darthvader.hitPoints = 9
darthmaul.hitPoints = 10
luke.name = "Luke Skywalker"
obiwan.name = "Obi-Wan Kenobi"
darthvader.name = "Darth Vader"
darthmaul.name = "Darth Maul"

// When everything in the below array is 👍, you've solved it!
simulate([luke, obiwan, darthvader, darthmaul])

/*:

# Extensions

*/

/*:

# References

*/

//: [Next: Optionals](@next)
