/*

classes seem very similar to structs because we use them to create new data types with properties and methods. 
However, they introduce a new, important, and complex feature called inheritance – the ability to make one class build on the foundations of another

SwiftUI uses structs extensively for its UI design. Well, it uses classes extensively for its data: 
when you show data from some object on the screen, or when you pass data between your layouts, you’ll usually be using classes.

classes differ from structs in five key places:

* You can make one class build upon functionality in another class, gaining all its properties and methods as a starting point. 
    *If you want to selectively override some methods, you can do that too.

* Because of that first point, Swift won’t automatically generate a memberwise initializer for classes. 
    *This means you either need to write your own initializer, or assign default values to all your properties.

* Refence Type, not a value type - When you copy an instance of a class, both copies share the same data – if you change one copy, the other one also changes.

* When the final copy of a class instance is destroyed, Swift can optionally run a special function called a deinitializer.

* Even if you make a class instance a constant, you can still change its properties as long as they are variables. - not possible with structs

Why classes for data in swiftUI?
* SwiftUI uses classes extensively, mainly for point 3: all copies of a class share the same data. 
    *This means many parts of your app can share the same information, 
    *so that if the user changed their name in one screen all the other screens would automatically update to reflect that change.

Why no memberwise initializers?
* Lacking a memberwise initializer is annoying, but hopefully you can see why it would be tricky to implement given that 
    *one class can be based upon another – if class C added an extra property it would break all the initializers for C, B, and A.

Ability to chage internals of an instance/object even if we refere them with a let, this is a common behaviour in other lang like scala
* Being able to change a constant class’s variables links in to the multiple copy behavior of classes: 
    *a constant class means we can’t change what pot our copy points to, but if the properties are variable we can still change the data inside the pot. 
    *This is different from structs, where each copy of a struct is unique and holds its own data.    

Why deinitializers?
* Because one instance of a class can be referenced in several places, it becomes important to know when the final copy has been destroyed. 
    *That’s where the deinitializer comes in: it allows us to clean up any special resources we allocated when that last copy goes away.    

    
*/

/*
Syntax for inheritence
class child:Parent{}
*/
class Employee {
    let hours: Int
    init(hours: Int) {
        self.hours = hours
    }
    func printSummary() {
        print("I work \(hours) hours a day.")
    }
}

class Developer: Employee {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
}

class Manager: Employee {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

/*
Can access parents props and methods directly without the need of any sunscript, Eg hours and printSummary in the example
If the parent has an initializer, we need to pass in the params from child, notice we can write a child class with out initializer, => It uses the initializer form parent
*/
let robert = Developer(hours: 8)
let joseph = Manager(hours: 10)
robert.work()
joseph.work()

robert.printSummary()
joseph.printSummary()

/*
OVERRIDE
Inheriting from a inheritted class, overriding a method form parent/parents parent etc

We need to use the word override only when the modified function is taking the same type params and retruning the same type
If our new method in child has differences either in param types, param number or return type, there is no need of override keyweord

*/
final class JuniorDeveloper : Developer{
    override func printSummary() {
        print("I'm a developer who will sometimes work \(hours) hours a day, but other times spend hours arguing about whether code should be indented using tabs or spaces.")
    }
}

let jd = JuniorDeveloper(hours: 12)
jd.printSummary()

/*
FINAL
If you know for sure that your class should not support inheritance, you can mark it as final. 
This means the class itself can inherit from other things, but can’t be used to inherit from
*/

// class DeveloperIntern:JuniorDeveloper {}
class DeveloperIntern:Developer{}

let di = DeveloperIntern(hours:4)
di.printSummary()

/*
INITIALIZERS
* IF A CHILD DOES NOT HAVE ANY INITIALIZER, it will use the initializer from immediate parent, even if it doesn't have one it goes up the ladder
* if a child class has any custom initializers, it must always call the parent’s initializer after it has finished setting up its own properties, if it has any.


*/
class Vehicle {
    let isElectric: Bool

    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

class Car: Vehicle {
    let isConvertible: Bool

    // does not work
    // init(isConvertible: Bool) {
    //     self.isConvertible = isConvertible
    // }

    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}

let car: Car = Car(isElectric:false, isConvertible:true)
print(car)

/*
Reference type and deepcopy
Swift classes are reference type, when we assign a instance obj to a new variable, a new instance is not created, instead the new var/let 
refere to the same old instance obj, so if we make any changes to the obj referenced from the var/let 2, obj referenced from var/let 1 will also reflect those changes

If we don't want this and instead need a separate copy, we need to implemet it ourselves by making a new instance with the current state of the old instance 
*/

class User {
    var username: String = "A"

    func copy() -> User {
        let user: User = User()
        user.username = username
        return user
    }
}

let a: User = User()
let b: User = a
let c: User = a.copy()

print("a", a.username)
b.username = "B"
print("a", a.username)
c.username = "C"
print("a", a.username)

/*
DEINITIALIZER
It gets called when the object is destroyed rather than when it’s created
the deinitializer is only called when the last remaining reference to a class instance is destroyed
we use the word deinit without func, Deinitializers can never take parameters or return data, and as a result aren’t even written with parentheses.
Your deinitializer will automatically be called when the final copy of a class instance is destroyed.
We never call deinitializers directly; they are handled automatically by the system.
Structs don’t have deinitializers, because you can’t copy them.

When a value exits scope we mean the context it was created in is going away. 
In the case of structs that means the data is being destroyed, 
but in the case of classes it means only one copy of the underlying data is going away 
– there might still be other copies elsewhere. But when the final copy goes away 
– when the last constant or variable pointing at a class instance is destroyed 
– then the underlying data is also destroyed, and the memory it was using is returned back to the system.

Why Deinit for classes and not struct
The job of deinitializers is to tell us when a class instance was destroyed. For structs this is fairly simple: 
the struct is destroyed when whatever owns it no longer exists. 
So, if we create a struct inside a method and the methods ends, the struct is destroyed.

owever, classes have complex copying behavior that means several copies of the class can exist in various parts of your program.
 All the copies point to the same underlying data, and so it’s now much harder to tell when the actual class instance is destroyed 
– when the final variable pointing to it has gone away.

How swift calls deinit?
Behind the scenes Swift performs something called automatic reference counting, or ARC. 
ARC tracks how many copies of each class instance exists: every time you take a copy of a class instance Swift adds 1 
to its reference count, and every time a copy is destroyed Swift subtracts 1 from its reference count. 
When the count reaches 0 it means no one refers to the class any more, and Swift will call its deinitializer and destroy the object.

*/

class User1 {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }

    deinit {
        print("User \(id): I'm dead!")
    }
}


// for i: Int in 1...3 {
//     let user1 = User1(id: i)
//     print("User \(user1.id): I'm in control!")
// }

var users: [User1] = []
// var users = [User1]()

for i: Int in 1...3 {
    let user1 = User1(id: i)
    print("User \(user1.id): I'm in control and got appended to a list!")
    users.append(user1)
}

for user in users{
    print("User \(user.id): I'm in control again!")
}

print("Loop is finished!")
users.removeAll()
print("Array is clear!")

/*
Mutating variables:
* Variable classes can have variable properties changed
* Constant classes can have variable properties changed
* Variable structs can have variable properties changed
* Constant structs cannot have variable properties changed

The reason for this lies in the fundamental difference between a class and a struct: one points to some data in memory, 
whereas the other is one value such as the number 5, We can’t simply define the number 5 to be 6. 
Instead, that code removes the existing value assigned to number and gives it the number 6 instead.
That’s how structs work in Swift: when we change one of its properties, we are in fact changing the entire struct.
o, if changing one part of a struct effectively means destroying and recreating the entire struct, 
hopefully you can see why constant structs don’t allow their variable properties to be changed 
– it would mean destroying and recreating something that is supposed to be constant, which isn’t possible.
*/