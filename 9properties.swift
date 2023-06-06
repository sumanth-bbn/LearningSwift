/*
CONCEPTS
* Properties - var/lets, how referenceing to object have impact on them
* Mutable functions - mutating func 
* Computed properties - syntax, get, set
* Property observers - syntax, willSet, didSet
* Initializers - default memberwise initializers, custom initializers, using extensions to have both
* access control - if there is a private var, default memberwise initializer is also set to private as it can not advertize the existence of this private var
*                 - but if a private property is initialized, default memberwise initializer does not require to have it in its parameters, 
*                 - and it can keep it still hidden from outer world. Because of this memberwise initializer is available and not set to private
*                 - if we use private(set) instead of private, the property is know to the outer world as it can read the value, so the memberwise init is available and not private
*                - We need to create a custom initializer which is not private if the variable is private or use a default initializations for private properties
* static properties - 
*/

// NORMAL PROPERTIES - CAN BE VAR OR LET
struct Race {
	let distance: Int
	var runners = 0
}
// this works as we can assign the properties during initialization of a const obj(even when the prop has a default value)
//  This is because, this is equivalent to calling a init function
// let londonMarathon = Race.init(distance: 42, runners: 40_000)
let londonMarathon = Race(distance: 42, runners: 40_000)

// Since londonMarathon is a const, we can not change the props of it after initialization
// londonMarathon.runners = 990 



// Computed properties
struct Employee {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0

    // computed properties have a syntax similar to normal properties without a value assignment, then a function like syntax
    var vacationRemaining: Int {
        get {
            vacationAllocated - vacationTaken
        }

        set {
            vacationAllocated = vacationTaken + newValue
        }
    }
}

// Property observers
struct App {
    // property observers have a syntax of a regular property with a value assignment, then a functionlike syntax
    var contacts: [String] = [String]() {
        willSet {
            print("Current value is: \(contacts)")
            print("New value will be: \(newValue)")
        }

        didSet {
            print("There are now \(contacts.count) contacts.")
            print("Old value was \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Adrian E")
app.contacts.append("Allen W")
app.contacts.append("Ish S")


// we can use property observers along with the uninitialized properties as well
// property observers are not called when the value are first initialized
struct NewApp {
    // var name: String
    var contacts: [String] {
        didSet {
            print("There are now \(contacts.count) contacts.")
            print("Old value was \(oldValue)")
        }
    }
}

let inita: [String] = ["dasdas"]
var newApp = NewApp(contacts: inita)
newApp.contacts.append("Adrian E")

/*
We can not observe const properties, as they can not be changed after initialization
and property observers doesnot run on property initialization

struct FootballMatch {
	let homeTeamScore: Int {
		didSet {
			print("Yay - we scored!")
		}
	}
	let awayTeamScore: Int {
		didSet {
			print("Boo - they scored!")
		}
	}
}

var fm = FootballMatch(homeTeamScore: 4, awayTeamScore:3)
*/

// INITIALIZATION
/*
* memberwise initializers
By default, all Swift structs get a synthesized memberwise initializer by default, 
which means that we automatically get an initializer that accepts values for each of the struct’s properties. 
This initializer makes structs easy to work with and also Swift does two further things that make it especially clever 
-  if any of your properties have default values, then they’ll be incorporated into the initializer as default parameter values
- Swift does is remove the memberwise initializer if you create an initializer of your own.



*/

// struct User {
//     var name: String
//     var yearsActive = 0
// }
//  this is same as 
struct User {
    var name: String
    var yearsActive = 0
    init(name:String, yearsActive:Int = 0 ) {
        self.name = name
        self.yearsActive = yearsActive
    }
}

var user = User(name:"Dafk", yearsActive:6)
print(user.name, user.yearsActive)
// Note using self is important to distinguish paramaeter name and properties. If we use a different parameter name we can do without self

/*

struct User {
    var name: String
    var yearsActive = 0
    init(name n:String, yearsActive y:Int = 0 ) {
        self.name = n
        self.yearsActive = y
    }
}

var user = User(name:"Dafk", yearsActive:6)
print(user.name, user.yearsActive)
*/

// lets modify the init and make it a custom init
struct Employee1 {
    var name: String
    var yearsActive = 0

    init() {
        self.name = "Anonymous"
        print("Creating an anonymous employee…")
    }
}
// let roslin = Employee1(name: "Laura Roslin")
// this does not work as our custom initializer does not take param and the default memberwise initiallizer is removed by swift


// If you want it to stay, move your custom initializer to an extension
struct Employee2 {
    var name: String
    var yearsActive = 0
}

extension Employee2 {
    init() {
        self.name = "Anonymous"
        print("Creating an anonymous employee…")
    }
}

// creating a named employee now works
let roslin = Employee2(name: "Laura Roslin")
print(roslin)
// as does creating an anonymous employee
let anon = Employee2()


// Static Properties and access control
// Both static properties and access control are extensively used in swift UI - kind of frontend framework on top of swift to build UI

// ACESS CONTROL
// use private keyword to make sure a variable/method is accessible only to methods, observables and computed properties inside a struct
/*
* Use private for “don’t let anything outside the struct use this.”
* Use private(set) for “let anyone read this property, but only let my methods write it
* Use fileprivate for “don’t let anything outside the current file use this.”
* Use public for “let anyone, anywhere use this.”
*/
struct BankAccount {
    // private var funds = 0
    private(set) var funds:Int

    mutating func deposit(amount: Int) {
        funds += amount
    }

    mutating func withdraw(amount: Int) -> Bool {
        if funds >= amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account = BankAccount(funds:0)
account.deposit(amount: 100)
let success = account.withdraw(amount: 200)

if success {
    print("Withdrew money successfully")
} else {
    print("Failed to get the money")
}

// account.funds -= 1000
// this is not allowed

/*
* this doesn't work as swift won't generate memberwise initializers when there is an uninitialized private property
struct Doctor {
	var name: String
	var location: String
	private var currentPatient = "No one"
}
let drJones = Doctor(name: "Esther Jones", location: "Bristol")
*/

// doesn't work, because of default memberwise initializer is not available because of uninitialized privatePosts
/*
struct FacebookUser {
    private var  privatePosts: [String] //doesn't work
	public var publicPosts: [String]
}
let fbUser = FacebookUser(privatePosts:[""],publicPosts:[""])
print(fbUser)
*/

// works with private(set) both with memberwise and custom initializer
struct FacebookUser {
	private(set) var privatePosts: [String] //works
    // private var  privatePosts: [String] //doesn't work
	public var publicPosts: [String]
}
let fbUser = FacebookUser(privatePosts:[""],publicPosts:[""])
print(fbUser)

/*
* Memberwise initialization is possible for private(set) then why not for  private properties?
* If you use private access control for one or more properties, chances are you’ll need to create your own initializer or 
* use default values as in the above example
*/

// works because of custom initializer
struct Order {
	private var id: Int
	
    init(id: Int) {
		self.id = id
	}
}
let order = Order(id: 1)
print(order)

// works with private(set) both with memberwise and custom initializer
struct FacebookUser {
	private(set) var privatePosts: [String] //works
    // private var  privatePosts: [String] //doesn't work
	public var publicPosts: [String]
}
let fbUser = FacebookUser(privatePosts:[""],publicPosts:[""])
print(fbUser)

// STATIC PROPERTIES & METHODS
// these are similar to class variable and methods in python

struct School {
    static var studentCount = 0

    static func add(student: String) {
        print("\(student) joined the school.")
        studentCount += 1
    }
}

School.add(student: "Taylor Swift")
print(School.studentCount)

//  Notice the keyword static in there, which means both the studentCount property and add() method belong to the School struct itself, 
// rather than to individual instances of the struct.

// This should also explain why we’re able to modify the studentCount property without marking the method as mutating – 
// that’s only needed with regular struct functions for times when an instance of struct was created as a constant, 
// and there is no instance when calling add()

// Mixing statis and non static
// static properties and methods can’t refer to non-static properties and methods because it just doesn’t make sense
// To access static code from non-static code, always use your type’s name such as School.studentCount. 
// You can also use Self to refer to the current type - self refers to the current value of the struct, and Self refers to the current type.

// “why the heck is this needed?”
// use static properties to organize common data in my apps

struct AppData {
    static let version = "1.3 beta 2"
    static let saveFilename = "settings.json"
    static let homeURL = "https://www.hackingwithswift.com"
}

// we can use the AppData at multiple places in our app
print(AppData.version)

// use static data is to create examples of a struct, this can come handy when dealing with swiftUI and showing some dummy data to get the real feel of UI
struct Employee {
    let username: String
    let password: String

    static let example = Employee(username: "cfederighi", password: "hairforceone")
}

print(Employee.example)