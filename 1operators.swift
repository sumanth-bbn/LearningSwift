/*
 SUMMARY
  + Arithmetic Operators -- + - * / %
  + Compound Operatos -- += -= *=
  + Comparison Operators -- == != > < >= <=
  + Logical operators -- NOT: ! and - &&, or - ||, can chain them, left most 2 elements evaluate in a recursive way, parenthese takes preference
  + Ternary Operator -- 2 > 4 ? 40 : 20
  + Ternary operator on Optionals -- a != nil ? a! : b
  + Nil-Coalescing Operator -- a ?? b
  + Range operators -- 1...5 , ...2 , 1..<4 , iterable[1...], iterable[...4] , iterable[2..4], iterable[..<4]
 */


// ternary operator

// short cut for something like this
//if question {
//    answer1
//} else {
//    answer2
//}

// conditional ? value for true : value for false
let hasHeader = true
let x = hasHeader ? 50 : 20
print( 20 + (hasHeader ? 50 : 20))
print(2 > 4 ? 40 : 20)
print((2 > 4) ? 40 : 20)

// We can use the ternary operator for  foreceful unwrapping using a default value

let a:String? = "dasdsadsa"
let a1:String? = nil
let b = "dad"

print(a != nil ? a! : b)
print(a1 != nil ? a1! : "-----")
print(a1 != nil ? a! : "-----") // this does not throw any error

// This is equivalent to writing this if block
let aReal:String
if a != nil {
    aReal = a!
} else {
    aReal = "____"
}
print(aReal)

//Nil-Coalescing Operator
//The nil-coalescing operator (a ?? b) unwraps an optional a if it contains a value,
// or returns a default value b if a is nil.
// The expression a is always of an optional type.
// The expression b must match the type that’s stored inside a.

print("Unwrapped : ", a ?? b)
print("Default : ", a1 ?? b)

//  a ?? b is equivalent to a != nil ? a! : b
print("----------------------------------------")
// Range operators

// Closed range
for index in 1...2 {
    print("\(index) times 5 is \(index * 5)")
}
// prints
// 1 times 5 is 5
// 2 times 5 is 10
print("----------------------------------------")
//Half-Open Range Operator
for index in 1..<2 {
    print("\(index) times 5 is \(index * 5)")
}
// prints
// 1 times 5 is 5
print("----------------------------------------")
// Range operators on iterables
let numbers = [1,2,3,4,5]
for index in numbers[1...] {
    print("\(index) times 5 is \(index * 5)")
}
print("----------------------------------------")

for index in numbers[...1] {
    print("\(index) times 5 is \(index * 5)")
}
print("----------------------------------------")
for index in numbers[..<2] {
    print("\(index) times 5 is \(index * 5)")
}

for index in numbers[..<2] {
    print("\(index) times 5 is \(index * 5)")
}

print("----------------------------------------")
for index in numbers[2...4] {
    print("\(index) times 5 is \(index * 5)")
}

// Logical operators
/*
 not: ! , and: && , or : ||
 The Swift logical operators && and || are left-associative,
 meaning that compound expressions with multiple logical operators evaluate the leftmost subexpression first.
 enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword
 explicit parentheses take preference in evaluating
 (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword
 using explicit parentheses is more readable and easy to reason
*/

//Comparison Operators
/*
Swift supports the following comparison operators:
Equal to (a == b)
Not equal to (a != b)
Greater than (a > b)
Less than (a < b)
Greater than or equal to (a >= b)
Less than or equal to (a <= b)
 */