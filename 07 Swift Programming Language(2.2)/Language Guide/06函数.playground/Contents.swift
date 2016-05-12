import UIKit

//函数是用来完成特定任务的独立的代码块。你给一个函数起一个合适的名字，用来标识函数做什么，并且当函数需要执行的时候，这个名字会被用于“调用”函数。

/**
 *  函数的定义与调用
 */

//当你定义一个函数时，你可以定义一个或多个有名字和类型的值，作为函数的输入（称为参数，parameters），也可以定义某种类型的值作为函数执行结束的输出（称为返回类型，return type）。

//每个函数有个函数名，用来描述函数执行的任务。要使用一个函数时，你用函数名“调用”，并传给它匹配的输入值（称作实参，arguments）。一个函数的实参必须与函数参数表里参数的顺序一致。

func sayHello(personName: String) -> String {
    let greeting = "Hello, " + personName + "!"
    return greeting
}
//所有的这些信息汇总起来成为函数的定义，并以 func 作为前缀。指定函数返回类型时，用返回箭头 ->（一个连字符后跟一个右尖括号）后跟返回类型的名称的方式来表示。

//为了简化这个函数的定义，可以将问候消息的创建和返回写成一句：
func sayHelloAgain(personName: String) -> String {
    return "Hello again, " + personName + "!"
}
print(sayHelloAgain("Anna"))

/**
 *  函数参数与返回值
 */
//函数参数与返回值在 Swift 中极为灵活。你可以定义任何类型的函数，包括从只带一个未名参数的简单函数到复杂的带有表达性参数名和不同参数选项的复杂函数。

/**
 *  无参函数
 */
func sayHelloWorld() -> String {
    return "hello, world"
}
print(sayHelloWorld())

/**
 *  多参数函数
 */
//函数可以有多种输入参数，这些参数被包含在函数的括号之中，以逗号分隔。
func sayHello(personName: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return sayHelloAgain(personName)
    } else {
        return sayHello(personName)
    }
}
print(sayHello("Tim", alreadyGreeted: true))


/**
 *  无返回值函数
 */
func sayGoodbye(personName: String) {
    print("Goodbye, \(personName)!")
}
sayGoodbye("Dave")
//严格上来说，虽然没有返回值被定义，sayGoodbye(_:) 函数依然返回了值。没有定义返回类型的函数会返回特殊的值，叫 Void。它其实是一个空的元组（tuple），没有任何元素，可以写成()。

func printAndCount(stringToPrint: String) -> Int {
    print(stringToPrint)
    return stringToPrint.characters.count
}
func printWithoutCounting(stringToPrint: String) {
    printAndCount(stringToPrint)
}
printAndCount("hello, world")
printWithoutCounting("hello, world")
//第一个函数 printAndCount(_:)，输出一个字符串并返回 Int 类型的字符数。第二个函数 printWithoutCounting调用了第一个函数，但是忽略了它的返回值。当第二个函数被调用时，消息依然会由第一个函数输出，但是返回值不会被用到。
//返回值可以被忽略，但定义了有返回值的函数必须返回一个值，如果在函数定义底部没有返回任何值，将导致编译错误（compile-time error）。


/**
 *  多重返回值函数
 */
//你可以用元组（tuple）类型让多个值作为一个复合值从函数中返回。
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
//因为元组的成员值已被命名，因此可以通过点语法来检索找到的最小值与最大值：
let bounds = minMax([8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")
//需要注意的是，元组的成员不需要在元组从函数中返回时命名，因为它们的名字已经在函数返回类型中指定了。


/**
 *  可选元组返回类型
 */
//如果函数返回的元组类型有可能整个元组都“没有值”，你可以使用可选的（Optional） 元组返回类型反映整个元组可以是nil的事实。你可以通过在元组类型的右括号后放置一个问号来定义一个可选元组，例如(Int, Int)?或(String, Int, Bool)?

//可选元组类型如(Int, Int)?与元组包含可选类型如(Int?, Int?)是不同的.可选的元组类型，整个元组是可选的，而不只是元组中的每个元素值。

//为了安全地处理这个“空数组”问题，将minMax(_:)函数改写为使用可选元组返回类型，并且当数组为空时返回nil：
func minMax1(array: [Int]) -> (min: Int, max: Int)? {
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

if let bounds = minMax1([8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}


/**
 *  函数参数名称
 */
//函数参数都有一个外部参数名（external parameter name）和一个局部参数名（local parameter name）。外部参数名用于在函数调用时标注传递给函数的参数，局部参数名在函数的实现内部使用。
func someFunction(firstParameterName: Int, secondParameterName: Int) {
    // function body goes here
    // firstParameterName and secondParameterName refer to
    // the argument values for the first and second parameters
}
someFunction(1, secondParameterName: 2)
//一般情况下，第一个参数省略其外部参数名，第二个以及随后的参数使用其局部参数名作为外部参数名。所有参数必须有独一无二的局部参数名。尽管多个参数可以有相同的外部参数名，但不同的外部参数名能让你的代码更有可读性。


/**
 *  指定外部参数名
 */
//你可以在局部参数名前指定外部参数名，中间以空格分隔：
func someFunction(externalParameterName localParameterName: Int) {
    // function body goes here, and can use localParameterName
    // to refer to the argument value for that parameter
}

//如果你提供了外部参数名，那么函数在被调用时，必须使用外部参数名。
//这个版本的sayHello(_:)函数，接收两个人的名字，会同时返回对他俩的问候：

func sayHello(to person: String, and anotherPerson: String) -> String {
    return "Hello \(person) and \(anotherPerson)!"
}
print(sayHello(to: "Bill", and: "Ted"))
// prints "Hello Bill and Ted!"
//为每个参数指定外部参数名后，在你调用sayHello(to:and:)函数时两个外部参数名都必须写出来。

//使用外部函数名可以使函数以一种更富有表达性的类似句子的方式调用，并使函数体意图清晰，更具可读性。


/**
 *  忽略外部参数名
 */
//如果你不想为第二个及后续的参数设置外部参数名，用一个下划线（_）代替一个明确的参数名。
func someFunction(firstParameterName: Int, _ secondParameterName: Int) {
    // function body goes here
    // firstParameterName and secondParameterName refer to
    // the argument values for the first and second parameters
}
someFunction(1, 2)

/**
 *  默认参数值
 */
//你可以在函数体中为每个参数定义默认值（Deafult Values）。当默认值被定义后，调用这个函数时可以忽略这个参数。
func someFunction(parameterWithDefault: Int = 12) {
    // function body goes here
    // if no arguments are passed to the function call,
    // value of parameterWithDefault is 12
}
someFunction(6) // parameterWithDefault is 6
someFunction() // parameterWithDefault is 12
//将带有默认值的参数放在函数参数列表的最后。这样可以保证在函数调用时，非默认参数的顺序是一致的，同时使得相同的函数在不同情况下调用时显得更为清晰。


/**
 *  可变参数
 */
//一个可变参数（variadic parameter）可以接受零个或多个值。函数调用时，你可以用可变参数来指定函数参数可以被传入不确定数量的输入值。通过在变量类型名后面加入（...）的方式来定义可变参数。
//可变参数的传入值在函数体中变为此类型的一个数组。例如，一个叫做 numbers 的 Double... 型可变参数，在函数体内可以当做一个叫 numbers 的 [Double] 型的数组常量。
func arithmeticMean(numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
arithmeticMean(3, 8.25, 18.75)
//一个函数最多只能有一个可变参数。
//如果函数有一个或多个带默认值的参数，而且还有一个可变参数，那么把可变参数放在参数表的最后。



/**
 *  输入输出参数（In-Out Parameters）
 */
//函数参数默认是常量。试图在函数体中更改参数值将会导致编译错误。这意味着你不能错误地更改参数值。如果你想要一个函数可以修改参数的值，并且想要在这些修改在函数调用结束后仍然存在，那么就应该把这个参数定义为输入输出参数（In-Out Parameters）。

//定义一个输入输出参数时，在参数定义前加 inout 关键字。一个输入输出参数有传入函数的值，这个值被函数修改，然后被传出函数，替换原来的值。想获取更多的关于输入输出参数的细节和相关的编译器优化，请查看输入输出参数一节。

//你只能传递变量给输入输出参数。你不能传入常量或者字面量（literal value），因为这些量是不能被修改的。当传入的参数作为输入输出参数时，需要在参数名前加&符，表示这个值可以被函数修改。

//输入输出参数不能有默认值，而且可变参数不能用 inout 标记。
func swapTwoInts(inout a: Int, inout _ b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

//输入输出参数和返回值是不一样的。上面的 swapTwoInts 函数并没有定义任何返回值，但仍然修改了 someInt 和 anotherInt 的值。输入输出参数是函数对函数体外产生影响的另一种方式。


/**
 *  函数类型
 */
func addTwoInts(a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(a: Int, _ b: Int) -> Int {
    return a * b
}
//这两个函数的类型是 (Int, Int) -> Int，可以解读为“这个函数类型有两个 Int 型的参数并返回一个 Int 型的值。”。

func printHelloWorld() {
    print("hello, world")
}
//这个函数的类型是：() -> Void，或者叫“没有参数，并返回 Void 类型的函数”。


/**
 *  使用函数类型
 */
//在 Swift 中，使用函数类型就像使用其他类型一样。例如，你可以定义一个类型为函数的常量或变量，并将适当的函数赋值给它：
var mathFunction: (Int, Int) -> Int = addTwoInts
//这个可以解读为：“定义一个叫做 mathFunction 的变量，类型是‘一个有两个 Int 型的参数并返回一个 Int 型的值的函数’，并让这个新变量指向 addTwoInts 函数”。

//就像其他类型一样，当赋值一个函数给常量或变量时，你可以让 Swift 来推断其函数类型：
let anotherMathFunction = addTwoInts


/**
 *  函数类型作为参数类型
 */
//你可以用(Int, Int) -> Int这样的函数类型作为另一个函数的参数类型。这样你可以将函数的一部分实现留给函数的调用者来提供。
func printMathResult(mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)

//printMathResult(_:_:_:) 函数的作用就是输出另一个适当类型的数学函数的调用结果。
//它不关心传入函数是如何实现的，它只关心这个传入的函数类型是正确的。这使得 printMathResult(_:_:_:) 能以一种类型安全（type-safe）的方式将一部分功能转给调用者实现。

/**
 *  函数类型作为返回类型
 */
//你可以用函数类型作为另一个函数的返回类型。你需要做的是在返回箭头（->）后写一个完整的函数类型。
func stepForward(input: Int) -> Int {
    return input + 1
}
func stepBackward(input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    return backwards ? stepBackward : stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(currentValue > 0)

print("Counting to zero:")
// Counting to zero:
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// 3...
// 2...
// 1...
// zero!

/**
 *  嵌套函数
 */

//这章中你所见到的所有函数都叫全局函数（global functions），它们定义在全局域中。你也可以把函数定义在别的函数体中，称作嵌套函数（nested functions）。

//默认情况下，嵌套函数是对外界不可见的，但是可以被它们的外围函数（enclosing function）调用。一个外围函数也可以返回它的某一个嵌套函数，使得这个函数可以在其他域中被使用。

//你可以用返回嵌套函数的方式重写 chooseStepFunction(_:) 函数：

func chooseStepFunction1(backwards: Bool) -> (Int) -> Int {
    func stepForward1(input: Int) -> Int { return input + 1 }
    func stepBackward1(input: Int) -> Int { return input - 1 }
    return backwards ? stepBackward1 : stepForward1
}

var currentValue1 = -4
let moveNearerToZero1 = chooseStepFunction1(currentValue1 > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue1 != 0 {
    print("\(currentValue1)... ")
    currentValue1 = moveNearerToZero1(currentValue1)
}
print("zero!")
// -4...
// -3...
// -2...
// -1...
// zero!