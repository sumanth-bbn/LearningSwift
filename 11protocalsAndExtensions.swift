/*
PROTOCOLS

* Protocols are a bit like contracts in Swift: they let us define what kinds of functionality we expect a data type to support, and Swift ensures that the rest of our code follows those rules.

* Syntax 
    protocol name {
        var/let declarations with their types
        method definitions with param types and return type
    } 

* After creating a protocol, we can design types that work with that protocol. 
    * This means creating new structs, classes, or enums that implement the requirements for that protocol, which is a process we call adopting or conforming to the protocol.
* The protocol doesn’t specify the full range of functionality that must exist, only a bare minimum. 
    * This means when you create new types that conform to the protocol you can add all sorts of other properties and methods as needed

* var name: String { get } - A string called name, which must be readable. That might mean it’s a constant, but it might also be a computed property with a getter.
* var currentPassengers: Int { get set } - An integer called currentPassengers, which must be read-write. That might mean it’s a variable, but it might also be a computed property with a getter and setter.
* We can accept protocols as parameters type, you can also return protocols type from a function if needed.


 * You can conform to as many protocols as you need, just by listing them one by one separated with a comma. 
 * If you ever need to subclass something and conform to a protocol, you should put the parent class name first, then write your protocols afterwards.

*/

/*
EXTENSIONS

Extensions add new functionality to an existing class, structure, enumeration, or protocol type. 
This includes the ability to extend types for which you don’t have access to the original source code (known as retroactive modeling)

* Extensions in Swift can:
    * Add computed instance properties and computed type properties, they can not add stored properties or property observers on stored properties
    * Define instance methods and type methods
    * Provide new initializers
    * Define subscripts
    * Define and use new nested types
    * Make an existing type(Class, Struct & Enum) conform to a protocol
    * Can’t make a Protocol type extend or inherit from another protocol


*/

// Extensions can add new computed properties, but they can’t add stored properties, or add property observers to existing properties.
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch: Double = 25.4.mm
print("One inch is \(oneInch) meters")

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")

// Extensions can add new initializers to existing types. This enables you to extend other types to accept your own custom types as initializer parameters, or to provide additional initialization options that were not included as part of the type’s original implementation.
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
    size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
    size: Size(width: 3.0, height: 3.0))

// extensions can add new INSTANCE METHODS and TYPE METHODS to existing types. 
// Instance methods added with an extension can also modify (or mutate) the instance itself. 
// Structure and enumeration methods that modify self or its properties must mark the instance method as mutating,
import Foundation
extension Int {
    // New instance method
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }

    // Instance methods added with an extension can also modify (or mutate) the instance itself. 
    // Structure and enumeration methods that modify self or its properties must mark the instance method as mutating,
    mutating func square() -> Int {
        self = self * self
        return self
    }

    static func square(_ value:Int) -> Int {
        value*value
    }

    // static or Type method
    static func asWord(_ value:Int) -> String {
        let numberValue = NSNumber(value: value)
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        return formatter.string(from: numberValue) ?? "Can not convert"
    }

    // subsrcript
    subscript(digitIndex: Int) -> Int {
        var decimalBase: Int = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }

    // nested types
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

3.repetitions {
    print("Hello!")
}

print(Int.asWord(5673))


//doesn't work as we are referencing 3 with a let, 
// so we can not call mutating function of it as Int are implemeted using structs
// let someInt: Int = 3
// print(someInt.square())

var someInt = 3
print(someInt.square())

// even this doesn't work, as literals are consts
// print(3.square)

print(Int.square(3))

print(746381295[8])

// NESTED TYPES
extension Int {

}

var negativeInt: Int = -4
print(negativeInt.kind)
print(4.kind, 0.kind, negativeInt.kind)

// Why this doesn't work?
// print(4.kind, 0.kind, negativeInt.kind)

func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])

/*
PROTOCOL EXTENSIONS
* Protocols can be extended to provide method, initializer, subscript, and computed property implementations to conforming types. 
    * This allows you to define behavior on protocols themselves, rather than in each type’s individual conformance or in a global function.

* By creating an extension on the protocol, all conforming types automatically gain this method implementation without any additional modification.

* Protocol extensions can add implementations to conforming types but can’t make a protocol extend or inherit from another protocol. Protocol inheritance is always specified in the protocol declaration itself.

* If you define an extension to add new functionality to an existing type, 
    * the new functionality will be available on all existing instances of that type, 
    * even if they were created before the extension was defined.

* You can use protocol extensions to provide a default implementation to any method or computed property requirement of that protocol. 
    * If a conforming type provides its own implementation of a required method or property, that implementation will be used instead .
    * no need to use the word override??

* Adding Constraints to Protocol Extensions ??    
*/
