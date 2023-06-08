/*
    Closures are self-contained blocks of functionality that can be passed around and used in your code.
    Closures in Swift are similar to blocks in C and Objective-Cand to lambdas in other programming languages.
    Closures can capture and store references to any constants and variables from the context in which they’re defined.
    
    Closures take one of three forms:
        * Global functions are closures that have a name and don’t capture any values.
        * Nested functions are closures that have a name and can capture values from their enclosing function.
        * Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.
            * these are called lambdas, function literals, anonymous functions in other languages)
            * these are function definitions that are not bound to an identifier.

    Closure expressions
        * Closure expressions are a way to write inline closures in a brief, focused syntax, but code block need not 
            * restricted to a single line as in python
        '''
            { (param : paramType, ..) -> returnType in
            <#statements#>
            }
            
        '''
        * In Python: lambda param,.. : <#statement#>
        * In Scala: (param: paramType,..) => <#statement#> , retrun type is inferred
        * In swift if some thing opens with a '{',then it will be a closure expression -> we might see this in SWIfTUI extensively
    
    * Single line and multiline statements
    '''
        reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
            // some other code
            return s1 > s2
        })

        reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in  return s1 > s2})
    '''
    
    * Implicit return
    '''
        reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in  s1 > s2})
    '''
    
    * Type inference
    Type inference for both params and return type
    Because the sorting closure is passed as an argument to a method, 
    Swift can infer the types of its parameters and the type of the value it returns. 
    we can also ommit the parenthesis around params
    '''       
        reversedNames = names.sorted(by: { s1, s2 in s1 > s2})
    '''
    It’s always possible to infer the parameter types and return type when passing a closure to a function or method as an inline closure expression

    *good one to use in real world
        '''
            { param1,.. in <#statement#> }
                    or
            { param1,.. in 
                <#statements#> 
            }
        '''
    * Shorthand argument
    Swift automatically provides shorthand argument names to inline closures, 
    which can be used to refer to the values of the closure’s arguments by the names $0, $1, $2, and so on.
    Scala offers _ notations for this
    '''
        reversedNames = names.sorted(by: { $0 > $1 } )
    '''

    * Operator Methods
    There’s actually an even shorter way to write the closure expression above. 
    Swift’s String type defines its string-specific implementation of the greater-than operator (>) as a method that has two parameters of type String, and returns a value of type Bool
    '''
        reversedNames = names.sorted(by: >)
    '''
    
    * Trailing Closures
    If you need to pass a closure expression to a function as the function’s final argument and the closure expression is long, 
    it can be useful to write it as a trailing closure instead. You write a trailing closure after the function call’s parentheses, 
    even though the trailing closure is still an argument to the function. 
    When you use the trailing closure syntax, you don’t write the argument_label for the first closure as part of the function call
    '''
        func someFunctionThatTakesAClosure(closure: () -> Void) {
            // function body goes here
        }

        // Here's how you call this function without using a trailing closure:

        someFunctionThatTakesAClosure(closure: {
            // closure's body goes here
        })

        // Here's how you call this function with a trailing closure instead:

        someFunctionThatTakesAClosure() {
            // trailing closure's body goes here
        }
    '''
    *** This is what that is being used in swiftUI extensively and this really confused me when I saw them first time
    '''
        reversedNames = names.sorted(by: { $0 > $1 }) //normal call
        reversedNames = names.sorted() { $0 > $1 } // trailing closure call
        reversedNames = names.sorted { $0 > $1 } //if there are no other params apart from the closure

    '''
    Trailing closures are most useful when the closure is sufficiently long that it isn’t possible to write it inline on a single line
    A function call can include multiple trailing closures
    '''
        array.map({(params) in Expression})
        array.map{
            (params) in Expression
        }
    '''

    trailing closures can also be used with Class/struct initialization, 
    lets say a struct called StructName takes a unnamed param(we can get it in init funct with _ as argument_label) of type() -> Bool
    StructName({() in true})
    StructName({true})
    StructName{true}


    * Know more about @escaping closures, as this is need in creating a init function with _ as argument_label in the above case
 
 */

 /*
    Capturing Values
    A closure can capture constants and variables from the surrounding context in which it’s defined. 
    The closure can then refer to and modify the values of those constants and variables from within its body, 
    even if the original scope that defined the constants and variables no longer exists.

    In Swift, the simplest form of a closure that can capture values is a nested function, 
    written within the body of another function. A nested function can capture any of its outer function’s arguments and 
    can also capture any constants and variables defined within the outer function.

    Closures Are Reference Types
    Whenever you assign a function or a closure to a constant or a variable, 
    you are actually setting that constant or variable to be a reference to the function or closure.
    This also means that if you assign a closure to two different constants or variables, 
    both of those constants or variables refer to the same closure.

    These some advanced functional programming concepts
    Escaping Closures
    Autoclosures

 */

// Capturing Values
func getIncrementerOf(amount: Int) -> () -> Int {
    var currentCount: Int = 0
    func incrementer() -> Int {
        currentCount += amount
        return currentCount
    }
    return incrementer
}

// nested function closed amount and currentCount from its parent function getIncrementerOf 
// and they are always available to it even when we are using it elsewhere
let incrementOf5: () -> Int = getIncrementerOf(amount: 5)
for _ in 0...5{
    print(incrementOf5())
}

//  Autoclosures

var customersInLine: [String] = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"

let customerProvider: () -> String = { customersInLine.remove(at: 0) }  
print(customersInLine.count)
// Prints "5"

print("Now serving \(customerProvider())")
// Prints "Now serving Chris"
print(customersInLine.count)

func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
print(customersInLine.count)

// customersInLine is ["Ewa", "Barry", "Daniella"]
func serve1(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve1(customer: customersInLine.remove(at: 0))
// Prints "Now serving Ewa!"

// *Overusing autoclosures can make your code hard to understand. 
// *The context and function name should make it clear that evaluation is being deferred.


// Example for Trailing closures with Structs/classes and @escaping closures 
struct A {
    var a: () -> Bool

    // why @escaping ??
    // here the closure that is passes to init function is being copied to var a which is outside the init function
    // so we must allow the input closure expression to be escaped from init function
    init (_ f:@escaping  () -> Bool){
        self.a = f
    }
}

var x = A({() in true})
print(x.a())
var y = A({true})
print(y.a())
var z = A{true}
print(z.a())
print(A{true}.a())   

// Escaping closures  - More details

var completionHandlers: () -> Void = {print("random")}

func functionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers = completionHandler
}
completionHandlers()
functionWithEscapingClosure(completionHandler: {print("completing")})
completionHandlers()

// Escaping closures that capture self
print("ESCAPING CLOSURE")
/*
* Normally, a closure captures variables implicitly by using them in the body of the closure, but in case of self you need to be explicit. 
    * If you want to capture self, write self explicitly when you use it, or include self in the closure’s capture list
    * Writing self explicitly lets you express your intent, and reminds you to confirm that there isn’t a reference cycle
    * in the code below, the closure passed to someFunctionWithEscapingClosure(_:) refers to self explicitly. 
    * the closure passed to someFunctionWithNonescapingClosure(_:) is a nonescaping closure, which means it can refer to self implicitly.
*/

var completionHandler: () -> Void = {print("random")}

func someFunctionWithEscapingClosure(completionHandlerParam: @escaping () -> Void) {
    // we are moving the closure to outside of this function and it can be executed later using the external reference
    completionHandler = completionHandlerParam
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    // executes in this body itself
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        // if we donlt use self, it results in compilation error
        // reference to property 'x' in closure requires explicit use of 'self' to make capture semantics explicit
        someFunctionWithNonescapingClosure { x = 200 }
    }
}


let instance = SomeClass()
instance.doSomething()
print(instance.x)
// Prints "200"
completionHandler()
print(instance.x)
// Prints "100"

// Implicit capture of self by including it in the closure’s capture list, and then refers to self implicitly:



class SomeOtherClass {
    var x: Int = 10
    func doSomething() {
        someFunctionWithEscapingClosure { [self] in x = 100 }
        // someFunctionWithEscapingClosure { [self: SomeOtherClass] in x = 100 } //this don't work
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let someInstance: SomeOtherClass = SomeOtherClass()
someInstance.doSomething()
print(someInstance.x)
// Prints "200"
completionHandler()
print(someInstance.x)
// Prints "100"


// AUTO CLOSURE
print("AUTO CLOSURE")
func printTest1(_ result: () -> Void) {
    print("Before")
    result()
    print("After")
}

printTest1({ print("Hello") })
print("Using trailing closure")
printTest1{ print("Hello") }

func printTest2(_ result: @autoclosure () -> Void) {
    print("Before")
    result()
    print("After")
}
print("Using auto closure")
printTest2(print("Hello"))