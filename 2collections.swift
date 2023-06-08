/*
    collection types:
    + arrays - ordered collections of values,
    + sets - unordered collections of unique values,
    + dictionaries - unordered collections of key-value associations

    Collections are type safe - allows only one type for values and keys, they implement Generics
    Mutable collection - assign it to a variable, the collection that’s created will be mutable
    Immutable collection - assign it to a variable, collection can not be modified
    Advisable to use immutable collection when ever possible

    # ARRAYS
    var/let arrayName: [Type] = [] or var/let arrayName: [Type] = Array(.....)
    + arrayName.count, arrayName.isEmpty
    + Append values - arrayName.append(), Combine 2 arrays - arrayName + arrayName1,
    + Short hand notation - arrayName += value or arrayName += [..,..,..],
    + Element/s access - arrayName[i] // arrayName[i...j]
    + arrayName.insert(value, at: i)
    + arrayName.remove(at: 0), arrayName.removeLast()

    iterating
    for item in arrayName {
        print(item)
    }

     for (index, value) in arrayName {
        print("Item \(index + 1): \(value)")
    }
 */

/*
    # SETS
    A type must be hashable in order to be stored in a set — that is, the type must provide a way to compute a hash value for itself.
    declaration -  var setName = Set<Type>, then we can add elements or other sets to this
    initialization + declaration - var/let setName: Set<String> = ["", ., ., ., .]
    initialization + declaration with type inference - var/let setName: Set = ["", ., ., ., .]
    + setName.count, setName.isEmpty, setName.contains(value)
    + Append values - setName.append(value), Combine 2 sets - setName + setName1,
    + setName.insert(value), setName.remove(value)
    + setName.sorted() - return array with elements sorted using < operator
    + set operations - union(A+B), intersection(A+B - (A-B) - (B-A)), subtraction(A-B), symmetricDifference A + B - (A intersection B)
    + conditional checks between 2 sets - isSubset, isSuperset, isDisjoint

    iterating
    for item in setName {
        print(item)
    }
 */

/*
    # DICTIONARIES
    var/let dictName: [Type: Type] = [k:v, .:. , .:. ,], type of keys and values can be inferred if declared and initialized
    dictName[key] = value
    Assignment and updation - dictName[k] = value, this subscript updation does not return the old value if any
    dictName.updateValue(newValue, forKey: key), this return the old value if present in an optional which can be used with optional binding
    Accessing dictName[k] -> gives optional
    Removing using sunscript syntax - dictName[k] = nil
    Removing using removeValue dictName.removeValue(forKey: k), this returns the optional with removed value if present

    interations
    for (k, v) in dictName {
        print("\(k): \(v)")
    }

    for k in dictName.keys() {
        print("\(k)")
    }

    for v in dictName.values() {
        print("\(v)")
    }
 */
