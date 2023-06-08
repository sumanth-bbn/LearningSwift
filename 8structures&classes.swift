/*
Commonamlities between structures and classes
    + Define properties to store values
    + Define methods to provide functionality
    + Define subscripts to provide access to their values using subscript syntax
    + Define initializers to set up their initial state
    + Be extended to expand their functionality beyond a default implementation
    + Conform to protocols to provide standard functionality of a certain kind

Additional capabilities of classes
    + Inheritance enables one class to inherit the characteristics of another - structs can be extended, can't they inherit?
    + Type casting enables you to check and interpret the type of a class instance at runtime.
    + Deinitializers enable an instance of a class to free up any resources it has assigned.
    + Reference counting allows more than one reference to a class instance.

The additional capabilities that classes support come at the cost of increased complexity. 
As a general guideline, prefer structures because they’re easier to reason about, 
and use classes when they’re appropriate or necessary.


*/

// Definition syntax
struct SomeStructure {
    // structure definition goes here
}
class SomeClass {
    // class definition goes here
}

// Structs and classes with variables
struct Resolution {
    var width: Int = 0
    var height: Int = 0
}
class VideoMode {
    var resolution: Resolution = Resolution()
    var interlaced: Bool = false
    var frameRate: Double = 0.0
    var name: String?
}

// Struct and class instances
// *Structures and classes both use initializer syntax for new instances. 
// *The simplest form of initializer syntax uses the type name of the class or structure followed by empty parentheses, 
// *such as Resolution() or VideoMode(). This creates a new instance of the class or structure, 
// *with any properties initialized to their default values. 

let someResolution: Resolution = Resolution()
let someVideoMode: VideoMode = VideoMode()

// Accessing and setting  properties 
print("The width of someResolution is \(someResolution.width)")
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")

// Memberwise Initializers for Structure Types NOT for CLASSES
// *All structures have an automatically generated memberwise initializer, 
// *which you can use to initialize the member properties of new structure instances. 
// *Initial values for the properties of the new instance can be passed to the memberwise initializer by name:

let vga = Resolution(width: 640, height: 480)
print(vga)

// ***Unlike structures, class instances don’t receive a default memberwise initializer***

// VALUE TYPE vs REFERENCE TYPE
// * Structures and Enumerations Are Value Types, Classes are Reference Type

// * A value type is a type whose value is copied when it’s assigned to a variable or constant, 
// * or when it’s passed to a function.

// * This means that any structure and enumeration instances you create — 
// * and any value types they have as properties — are always copied when they’re passed around in your code.

// * all of the basic types in Swift — integers, floating-point numbers, Booleans, strings, arrays and dictionaries — are value types, 
// * and are implemented as structures behind the scenes.

// * Collections defined by the standard library like arrays, dictionaries, and strings use an optimization to reduce the performance cost of copying. 
// * Instead of making a copy immediately, these collections share the memory where the elements are stored between the original instance and any copies. 
// * If one of the copies of the collection is modified, the elements are copied just before the modification

// * Unlike value types, reference types are not copied when they’re assigned to a variable or constant, or when they’re passed to a function. Rather than a copy, a reference to the same existing instance is used.



// Structure examples
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")
print("hd is still \(hd.width) pixels wide")

// Enums example
enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()

print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")

// Classes example
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")

// *This example also shows how reference types can be harder to reason about. 
// *If tenEighty and alsoTenEighty were far apart in your program’s code, 
// *it could be difficult to find all the ways that the video mode is changed. 
// *Wherever you use tenEighty, you also have to think about the code that uses alsoTenEighty, and vice versa. 
// *&In contrast, value types are easier to reason about because all of the code that interacts with the same value is close together in your source files.

// Identity Operators
// *Because classes are reference types, 
// *it’s possible for multiple constants and variables to refer to the same single instance of a class behind the scenes. 
// *(The same isn’t true for structures and enumerations, 
// *because they’re always copied when they’re assigned to a constant or variable, or passed to a function.)

// Use these identity operators === and !== operators to check whether two constants or variables refer to the same single instance:

if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}

// *Note that identical to (represented by three equals signs, or ===) doesn’t mean the same thing as equal to (represented by two equals signs, or ==). 
// *Identical to means that two constants or variables of class type refer to exactly the same class instance. 
// *Equal to means that two instances are considered equal or equivalent in value, for some appropriate meaning of equal, as defined by the type’s designer

