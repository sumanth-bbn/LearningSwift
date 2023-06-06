/*
    Enumerations in Swift are first-class types in their own right. 
    They adopt many features traditionally supported only by classes, 
    such as computed properties to provide additional information about the enumeration’s current value, 
    and instance methods to provide functionality related to the values the enumeration represents. 
    Enumerations can also define initializers to provide an initial case value; 
    can be extended to expand their functionality beyond their original implementation; 
    and can conform to protocols to provide standard functionality.

    **Matching Enumeration Values with a Switch Statement**
    a switch statement must be exhaustive when considering an enumeration’s cases. 
    If the case for .west is omitted, this code doesn’t compile, because it doesn’t consider the complete list of CompassPoint cases. 
    Requiring exhaustiveness ensures that enumeration cases aren’t accidentally omitted.

    When it isn’t appropriate to provide a case for every enumeration case, 
    you can provide a default case to cover any cases that aren’t addressed explicitly:

    **Iterating over Enumeration Cases**
    For some enumerations, it’s useful to have a collection of all of that enumeration’s cases. 
    You enable this by writing : CaseIterable after the enumeration’s name. 
    Swift exposes a collection of all the cases as an allCases property of the enumeration type. Here’s an example:

    **Associated Values**

*/

enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

var planet: Planet = Planet.mercury

print(planet, type(of: planet))

planet = .earth
print(planet, type(of: planet))


switch planet {
    case .mercury:
        print("Lots of planets have a north")
    case .venus:
        print("Watch out for penguins")
    case .earth:
        print("Where the sun rises")
    case .mars:
        print("Where the skies are blue")
    default:
        print()
}

// **Iterating over Enumeration Cases**
// This syntax marks the enumeration as conforming to the CaseIterable protocol.
enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices: Int = Beverage.allCases.count
print("\(numberOfChoices) beverages available")

// ASSOCIATED VALUES of cases in Enum
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
print(productBarcode, type(of: productBarcode ))
productBarcode = .qrCode("kdasbfjkabsjfbasjkfadskdfasjkfasjk")
print(productBarcode, type(of: productBarcode ))

// switch cases for associated types
switch productBarcode {
    case .upc(let numberSystem, let manufacturer, let product, let check):
        print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
    case .qrCode(let productCode):
        print("QR code: \(productCode).")
}

// If all of the associated values for an enumeration case are extracted as constants, 
// or if all are extracted as variables, you can place a single let or var annotation before the case name, for brevity:

switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}

/*
Barcode - Enum Type, similar to a class
upc and qrCode - Enum cases, different possible objects of this Enum type lly to how classes can have different obj based on initialization
(Int, Int, Int, Int) and String - Types of the values we can associate with different cases, each case can have its own type for 

*/

// RAW VALUES
/*
As an alternative to associated values, enumeration cases can come prepopulated with default values (called raw values), 
which are all of the same type.
Raw values can be strings, characters, or any of the integer or floating-point number types. 
Each raw value must be unique within its enumeration declaration.
*/

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

/*
Raw values are not the same as associated values. 
Raw values are set to prepopulated values when you first define the enumeration in your code, like the three ASCII codes above.
The raw value for a particular enumeration case is always the same. 
Associated values are set when you create a new constant or variable based on one of the enumeration’s cases, 
and can be different each time you do so.
*/

// IMPLICITLY ASSIGNED RAW VALUES

/* 
The enumeration below is a refinement of the earlier Planet enumeration, 
with integer raw values to represent each planet’s order from the sun:
*/

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

/*
The enumeration below is a refinement of the earlier CompassPoint enumeration, 
with string raw values to represent each direction’s name:
In the example above, CompassPoint.south has an implicit raw value of "south", and so on.

*/
enum CompassPoint: String {
    case north, south, east, west
}

// You access the raw value of an enumeration case with its rawValue property:

let earthsOrder = Planet.earth.rawValue
// earthsOrder is 3

let sunsetDirection = CompassPoint.west.rawValue
// sunsetDirection is "west"

/*
Initializing from a Raw Value
If you define an enumeration with a raw-value type, the enumeration automatically receives an initializer that takes a value of the raw value’s type (as a parameter called rawValue) and returns either an enumeration case or nil. You can use this initializer to try to create a new instance of the enumeration.

This example identifies Uranus from its raw value of 7:
*/
let possiblePlanet = Planet(rawValue: 7)
// possiblePlanet is of type Planet? and equals Planet.uranus

// VALUE TYPE
// Enums are value types => values are copied when we pass them to a function or rfe to them using a var/let
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