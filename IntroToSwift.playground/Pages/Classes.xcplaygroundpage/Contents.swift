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

*/

/*:

# Extensions

*/

/*:

# References

*/

//: [Next: Optionals](@next)
