/*


*/

func getRandomNumber() -> Int {
    Int.random(in: 1...6)
}

func getRandomBool() -> Bool {
    Bool.random()
}

// Both types Bool and Int conforms to the protocal Equitable, similar to how Car and Bike conforms to a protocal like Vehicle

// So can we do some thing like this

func getRandom(number:Bool = true) -> some Equatable {
    if number {
        return Int.random(in: 1...6)
    } else {
        // return Bool.random() // does not work with some but owrks with any
        return Int.random(in: 1...9)
    }
    
}

// print(getRandom() == getRandom())

func getRN() -> any Equatable {
    Int.random(in: 1...6)
}

func getRB() -> any Equatable {
    Bool.random()
}

print(getRN() == getRB())