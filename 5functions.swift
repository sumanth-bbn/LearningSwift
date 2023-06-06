/*
    Functions - Notes
    You can optionally define one or more named, typed values that the function takes as input, known as parameters.
    You can also optionally define a type of value that the function will pass back as output known as return type
    A function’s arguments must always be provided in the same order as the function’s parameter list.

    ArgumentLabels and parameter Names is a new concept for me in Swift -
        ``` func name(ArgumentLabel parameterName: Type) -> Type {} ```
    argumentLabel will be same as parameterName if we only define it
    ArgumentLabels are mandatory when calling functions in a default usage

    Omitting Argument Labels
    Use _ as argument label if you want no argument label while calling the fucntion, Eg: print("")
        ``` func name(_ parameterName: Type) -> Type {
                <#parameterName>
        } ```
    We still need to define parametername to access the input inside function

    Default values -
        ```
            func name(parameterName: Type = value) -> Type {}
            name() , name(parameterName: newValue) //both are valid
        ```

    Variadic Parameters -
        ```
            func name(parameterName : Type...){
                //parameterName is available as array
            }

            name(parameterName: value1, value2, value3)

        ```

    Function parameters are constants by default. Trying to change the value of a function parameter from within the body of that function results in a compile-time error. This means that you can’t change the value of a parameter by mistake
    if we want to make use the parameter value as a var, make a copy of it into a var inside the scope of function
    but the changes to this var wont have effect after the function execution unless we return it as output and assign it to the input var outside of the function scope

    In-Out Parameters -
    In-out parameter is a short cut for acheiving this,
    An in-out parameter has a value that’s passed in to the function, is modified by the function,
    and is passed back out of the function to replace the original value.
    You can only pass a variable as the argument for an in-out parameter.
    You can’t pass a constant or a literal value as the argument, because constants and literals can’t be modified.
        ```
            func name(parameterName : inout Type){

            }
        ```
    In-out parameters can’t have default values, and variadic parameters can’t be marked as inout.
    You place an ampersand (&) directly before a variable’s name when you pass it as an argument to an in-out parameter, to indicate that it can be modified by the function.
        ```
            var param:Type = value
            name(parameterName: &param)
        ```

 */
/*
 Function - Types
    We can assign functions to a variable/const
    Functions have their own type based on their parameters and return type
        (parameterType1 , ...) -> ReturnType

    ```
        var mathFunction: (Int, Int) -> Int = addTwoInts
    ```
    A different function with the same matching type can be assigned to the same variable, in the same way as
    ```
        mathFunction = multiplyTwoInts
    ```
    Swift cna also do type inference for function types if a function is assigned as a value to a var/let

    Function can be passed as parameters to other function, we need to declare the type signature of parameter function when defining other function
    ```
        func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
            print("Result: \(mathFunction(a, b))")
        }
        printMathResult(addTwoInts, 3, 5)
    ```

    Functions can also be returned from another function
    ```
        func stepForward(_ input: Int) -> Int {return input + 1}
        func stepBackward(_ input: Int) -> Int {return input - 1}

        func chooseStepFunction(backward: Bool) -> (Int) -> Int {
            return backward ? stepBackward : stepForward
        }

        // this is valid, name return a function whose return type is again a function of type (Int, Int) -> Int
        func name(input: Type) -> (Int, String) -> (Int, Int) -> Int

    ```

    Nested Functions
    All of the functions you have encountered so far in this chapter have been examples of global functions, which are defined at a global scope.
    You can also define functions inside the bodies of other functions, known as nested functions.
    Nested functions are hidden from the outside world by default,
    but can still be called and used by their enclosing function.
    An enclosing function can also return one of its nested functions to allow the nested function to be used in another scope.
    ```
        func chooseStepFunction(backward: Bool) -> (Int) -> Int {
            func stepForward(input: Int) -> Int { return input + 1 }
            func stepBackward(input: Int) -> Int { return input - 1 }
            return backward ? stepBackward : stepForward
        }
        var currentValue = -4
        let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
    ```
 */

func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

// print(greet("dasdas"))
// this does not work as swift always need named params unlike python

print(greet(person: "asdas"))
// Why does the function print doesnt require parameter name??

// if there is only one statement in a function nbody it is returned without the use of explicit return keyword
// this works only if the function contain one statement, it doesn't implicitly return the last line like scala
func greet_short(person: String) -> String {
    "Hello, " + person + "!"
}

print(greet_short(person: "asdas"))

/*
 Functions Without Parameters
 The function definition still needs parentheses after the function’s name,
 */
func sayHelloWorld() -> String {
    return "hello, world"
}
print(sayHelloWorld())

/*
 Functions With Multiple Parameters
 Functions can have multiple input parameters, which are written within the function’s parentheses, separated by commas.
 */
func greet(person: String, alreadyGreeted: Bool) -> String {
    func greetAgain(person: String) -> String {
        return "Hello again, " + person + "!"
    }

    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}
print(greet(person: "Tim", alreadyGreeted: true))

/*
    Functions Without Return Values
    Functions aren’t required to define a return type. Here’s a version of the greet(person:) function,
    which prints its own String value rather than returning it:
    Strictly speaking, this version of the greet(person:) function does still return a value,
    even though no return value is defined.
    Functions without a defined return type return a special value of type Void.
    This is simply an empty tuple, which is written as ().
 */
func greetOnly(person: String) {
    print("Hello, \(person)!")
}
greetOnly(person: "Dave")

/*
    Functions with Multiple Return Values
    You can use a tuple type as the return type for a function to return multiple values as part of one compound return value.

    Because the tuple’s member values are named as part of the function’s return type,
    they can be accessed with dot syntax to retrieve the minimum and maximum found values:
 */

func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")

/*
 Functions with Optional Tuple Return Types
 If the tuple type to be returned from a function has the potential to have “no value” for the entire tuple,
 you can use an optional tuple return type to reflect the fact that the entire tuple can be nil.
 You write an optional tuple return type by placing a question mark after the tuple type’s closing parenthesis, such as (Int, Int)? or (String, Int, Bool)?.

 An optional tuple type such as (Int, Int)? is different from a tuple that contains optional types such as (Int?, Int?).
 With an optional tuple type, the entire tuple is optional, not just each individual value within the tuple.
 */

func safeMinMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

if let bounds = safeMinMax(array: [8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}

/*
    Function Argument Labels and Parameter Names
        The argument label is used when calling the function; each argument is written in the function call with its argument label before it
        The parameter name is used in the implementation of the function
    most of the times we use only one name for both argumentLabel and parameter names, parameters use their parameter name as their argument label.


    The use of argument labels can allow a function to be called in an expressive, sentence-like manner, while still providing a function body that’s readable and clear in intent.

    func someFunction(argumentLabel parameterName: Int) {
        // In the function body, parameterName refers to the argument value
        // for that parameter.
    }
 */

func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}
print(greet(person: "Bill", from: "Cupertino"))

/*
 Omitting Argument Labels
 If you don’t want an argument label for a parameter, write an underscore (_) instead of an explicit argument label for that parameter.
 This is how print needs no named argument
 */

func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
    print("\(firstParameterName) ,  \(secondParameterName)")
}
someFunction(1, secondParameterName: 2)

/*
 Default Parameter Values

 You can define a default value for any parameter in a function by assigning a value to the parameter after that parameter’s type.
 If a default value is defined, you can omit that parameter when calling the function.
 */

func someFunction(_ parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // If you omit the second argument when calling this function, then
    // the value of parameterWithDefault is 12 inside the function body.
    print("\(parameterWithoutDefault) ,  \(parameterWithDefault)")
}
someFunction(3, parameterWithDefault: 6) // parameterWithDefault is 6
someFunction(4) // parameterWithDefault is 12

/*
 Variadic Parameters

 A variadic parameter accepts zero or more values of a specified type.
 You use a variadic parameter to specify that the parameter can be passed a varying number of input values when the function is called.
 Write variadic parameters by inserting three period characters (...) after the parameter’s type name

 The values passed to a variadic parameter are made available within the function’s body as an array of the appropriate type
 A function can have multiple variadic parameters. The first parameter that comes after a variadic parameter must have an argument label.
 */

func arithmeticMean(numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
//print(arithmeticMean(1, 2, 3, 4, 5))
print(arithmeticMean(numbers: 1, 2, 3, 4, 5))

func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
print(arithmeticMean(1, 2, 3, 4, 5))