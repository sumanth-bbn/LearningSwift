/*
 Summary
 if, while, guard, switch - to execute different branches of code based on certain conditions
 break, continue - to transfer the flow of execution to another point in your code
 for-in loop - iterate over arrays, dictionaries, ranges, strings, and other sequences that conforms to sequence protocal
 defer - which wrap code to be executed when leaving the current scope.
 Switch is very powerful pattern matching technique,
 Cases can match many different patterns, including interval matches, tuples, and casts to a specific type.
 Matched values in a switch case can be bound to temporary constants or variables for use within the case’s body
 */
/*
 Looping
 while condition {
    <#statements#>
 }
 repeat{
    <#statements#>
 }while condition

 */
/*
 If condition
 if {} elif {} else {}
 */
/*
 Switch condition
 switch <#value to consider#> {
    case <#value 1#>:
        <#respond to value 1#>
    case <#value 2#>, <#value 3#>:
        <#respond to value 2 or 3#>
    default:
        <#otherwise, do something else#>
    }
  the entire switch statement finishes its execution as soon as the first matching switch case is completed,
  without requiring an explicit break statement.
  switch can be use with value matching, tuples, interval matching, value binding, and where clause on value bindings
 */
 /*
 Control transfer
 continue - he continue statement tells a loop to stop what it’s doing and start again at the beginning of the next iteration through the loop.
 break - The break statement ends execution of an entire control flow statement immediately. The break statement can be used inside a switch or loop statement when you want to terminate the execution of the switch
 Labeled Statements -
    loops and conditional statements can both use the break statement to end their execution prematurely.
    <#label name#>: while <#condition#> {
       <#statements#>
        if {
            break <#label name#>
        }
        else {
            continue <#label name#>
        }
    }

 Early exit - guard
    A guard statement, like an if statement, executes statements depending on the Boolean value of an expression. You use a guard statement to require that a condition must be true in order for the code after the guard statement to be executed. Unlike an if statement, a guard statement always has an else clause — the code inside the else clause is executed if the condition isn’t true.
    guard let name = person["name"] else {
        return
    }
    print("Hello \(name)!")

 Deferred Actions
    Unlike control-flow constructs like if and while,
    which let you control whether part of your code is executed or how many times it gets executed,
    defer controls when a piece of code is executed.
    You use a defer block to write code that will be executed later, when your program reaches the end of the current scope
  */


var oldMark = 0
var mark = ""
// for cqna be used with something called as stride along with other iterables like arrays, sets etc
for tickMark in stride(from: 0, to: 60, by: 5) {
    for _ in oldMark...tickMark {
        mark = mark + "_"
    }
    oldMark = tickMark
    print(mark)
}


// Interval Matching
func test_switch(input:Int) -> String {
    var naturalCount = ""
    switch input {
        case 0:
            naturalCount = "no"
        case 1..<5:
            naturalCount = "a few"
        case 5..<12:
            naturalCount = "several"
        case 12..<100:
            naturalCount = "dozens of"
        case 100..<1000:
            naturalCount = "hundreds of"
        default:
            naturalCount = "many"
    }
    return naturalCount
}

let approximateCounts = [2,6,12,65,123,455,2345]
for approximateCount in approximateCounts{
    print(test_switch(input: approximateCount))
}

//Tuples
//You can use tuples to test multiple values in the same switch statement.
// Each element of the tuple can be tested against a different value or interval of values.
// Use the underscore character (_), also known as the wildcard pattern, to match any possible value.
let somePoint = (1, 1)
switch somePoint {
    case (0, 0):
        print("\(somePoint) is at the origin")
    case (_, 0):
        print("\(somePoint) is on the x-axis")
    case (0, _):
        print("\(somePoint) is on the y-axis")
    case (-2...2, -2...2):
        print("\(somePoint) is inside the box")
    default:
        print("\(somePoint) is outside of the box")
}

// Value Binding in switch
//A switch case can name the value or values it matches to temporary constants or variables,
// for use in the body of the case.
// This behavior is known as value binding,
// because the values are bound to temporary constants or variables within the case’s body.

let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}


// this is an example of using switch for forceful unwrapping
var x:String?

switch x {
case nil:
    print("Its a nil")
default:
    print(x!)
}

x = "ada"
print(x ?? "Its a nil")

// but this is not elegant, this is more like a hack. lets use it with value binding
// this is not exactly equivalent to optional binding as we can not use the temp directly as value,
// we still neef to forcefully unwrap it with !

var y:String? = "sdcdas"

switch y {
case nil:
    print("Its a nil")
case let temp:
    print(temp!)
}

//Where
//A switch case can use a where clause to check for additional conditions.
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
    case let (x, y) where x == y:
        print("(\(x), \(y)) is on the line x == y")
    case let (x, y) where x == -y:
        print("(\(x), \(y)) is on the line x == -y")
    case let (x, y):
        print("(\(x), \(y)) is just some arbitrary point")
}
