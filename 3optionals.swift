
//Declaration
let optionalNameNil: String? = nil
let optionalName: String? = "realValue"
var optionalNameUnasigned: String?

//Optional Binding
if let temp = optionalName {
print("#using optional binding to a temp const:", temp)
}

if var temp =  optionalName {
    print("#using optional binding to a temp variable:", temp)
    temp = "asdasds"
    print("#using optional binding to a temp variable with changed value:", temp)
}

if let optionalName = optionalName {
    print("#using optional binding to a same name const/variable, note we can still the optional with same name after this block:", optionalName)
}

if let optionalName {
    print("#short hans notation for using the same name:", optionalName)
}

if let optionalNameNil {
    print("#short hans notation for using the same name:", optionalNameNil)
} else {
    print("#Matched Nil")
}

optionalNameUnasigned = nil
if let optionalNameUnasigned {
    print("#short hans notation for using the same name:", optionalNameUnasigned)
} else {
    print("#Matched Nil")
}

optionalNameUnasigned = "assigned"
if let optionalNameUnasigned {
    print("#short hans notation for using the same name:", optionalNameUnasigned)
} else {
    print("#Matched Nil")
}

//Forced unwrapping

if optionalName != nil{
    print("#Got a real value through forced unwrapping \(optionalName!)")
} else {
    print("#Can not forcefully unwrap an optional if it contains nil, if we still try to do it we wil end up in runtime error")
}

if optionalNameNil != nil{
    print("#Got a real value through forced unwrapping \(optionalNameNil!)")
} else {
    print("#Can not forcefully unwrap an optional if it contains nil, if we still try to do it we wil end up in runtime error")
}

// Implicitly unwrapped
// I don't see any usecase for this, to put it in simple words, these are optionals but with with reral values
// There is no need to unpack them either forcefully or using bindings, we can use them as normals variables or constants
// At the same time we can also use them as optionals in their special syntax like bindings & forecefull unwrapping
// We can declare them using Type! instead of Type?

let ImplicitOptionalName: String! = "implicitOptional"
let valueFromImplicitOptional: String = ImplicitOptionalName // We need to give a type, else it will be a copy of optional
print("This is an optional used as normal type: \(valueFromImplicitOptional)")

//let valueFromImplicitOptionalWithoutType = ImplicitOptionalName
//print("without type: \(valueFromImplicitOptionalWithoutType)")

// ternary operator

//this is a short cut notation for foreceful unwrapping using a default value
let a:String? = "dasdsadsa"
let aReal:String
if a != nil {
    aReal = a!
} else {
    aReal = "____"
}
print(aReal)

// shortcut notion using ternary Operator
let aReal1 = a != nil ? a! : "____"
print(aReal1)

// Nil-Coalescing Operator
//The nil-coalescing operator (a ?? b) unwraps an optional a if it contains a value,
// or returns a default value b if a is nil.
// The expression a is always of an optional type.
// The expression b must match the type that’s stored inside a.

print("Unwrapped : ", a ?? b)
//  a ?? b is equivalent to a != nil ? a! : b



