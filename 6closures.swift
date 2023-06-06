/*
    Closures are self-contained blocks of functionality that can be passed around and used in your code.
    Closures in Swift are similar to blocks in C and Objective-Cand to lambdas in other programming languages.
    Closures can capture and store references to any constants and variables from the context in which they’re defined.
    
    Closures take one of three forms:
        + Global functions are closures that have a name and don’t capture any values.
        + Nested functions are closures that have a name and can capture values from their enclosing function.
        + Closure expressions(lambdas, funcvtion literals as called in other languages) 
        are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.

    Closure expressions
        +Closure expressions are a way to write inline closures in a brief, focused syntax
    '''
        { (<#parameters#> : parameterType) -> returnType in
          <#statements#>
        }
        // In python lambda (param) => use params in a single expression
    '''
    '''
        reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
            // some other code
            return s1 > s2
        })

        reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in  return s1 > s2})
    '''
    
    Implicivt return
    '''
        reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in  s1 > s2})
    '''
    
    Type inference
    Type inference for both params and return type
    Because the sorting closure is passed as an argument to a method, Swift can infer the types of its parameters and the type of the value it returns. 
    The sorted(by:) method is being called on an array of strings, so its argument must be a function of type (String, String) -> Bool. 
    This means that the (String, String) and Bool types don’t need to be written as part of the closure expression’s definition. Because all of the types can be inferred, the return arrow (->) and the parentheses around the names of the parameters can also be omitted:
    '''       
        reversedNames = names.sorted(by: { s1, s2 in s1 > s2})
    '''
    It’s always possible to infer the parameter types and return type when passing a closure to a function or method as an inline closure expression

    Shorthand argument
    Swift automatically provides shorthand argument names to inline closures, 
    which can be used to refer to the values of the closure’s arguments by the names $0, $1, $2, and so on.
    '''
        reversedNames = names.sorted(by: { $0 > $1 } )
    '''

    Operator Methods
    There’s actually an even shorter way to write the closure expression above. 
    Swift’s String type defines its string-specific implementation of the greater-than operator (>) as a method that has two parameters of type String, and returns a value of type Bool
    '''
        reversedNames = names.sorted(by: >)
    '''
    
    Trailing Closures
    If you need to pass a closure expression to a function as the function’s final argument and the closure expression is long, 
    it can be useful to write it as a trailing closure instead. You write a trailing closure after the function call’s parentheses, 
    even though the trailing closure is still an argument to the function. 
    When you use the trailing closure syntax, you don’t write the argument label for the first closure as part of the function call
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


let customerProvider = { customersInLine.remove(at: 0) }  
// this is short hand for this closure expression
/*
let customerProvider: () -> String = { () -> String in 
    return customersInLine.remove(at: 0) 
}
*/ 
print(customersInLine.count)
// Prints "5"

print("Now serving \(customerProvider())")
// Prints "Now serving Chris"
print(customersInLine.count)

func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )