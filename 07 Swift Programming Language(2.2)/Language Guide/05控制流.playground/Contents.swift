

import UIKit

/**
 *  控制流
 */

//Swift提供了多种流程控制结构，包括可以多次执行任务的while循环，基于特定条件选择执行不同代码分支的if、guard和switch语句，还有控制流程跳转到其他代码的break和continue语句。

//Swift 还增加了for-in循环，用来更简单地遍历数组（array），字典（dictionary），区间（range），字符串（string）和其他序列类型。

//Swift 的switch语句比 C 语言中更加强大。在 C 语言中，如果某个 case 不小心漏写了break，这个 case 就会贯穿至下一个 case，Swift 无需写break，所以不会发生这种贯穿的情况。
//case 还可以匹配更多的类型模式，包括区间匹配（range matching），元组（tuple）和特定类型的描述。switch的 case 语句中匹配的值可以是由 case 体内部临时的常量或者变量决定，也可以由where分句描述更复杂的匹配条件。

/**
 *  For-in循环
 */
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

//如果你不需要知道区间序列内每一项的值，你可以使用下划线（_）替代变量名来忽略对值的访问：
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")

//使用for-in遍历一个数组所有元素：
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}

//你也可以通过遍历一个字典来访问它的键值对。遍历字典时，字典的每项元素会以(key, value)元组的形式返回，你可以在for-in循环中使用显式的常量名称来解读(key, value)元组。下面的例子中，字典的键（key）解读为常量animalName，字典的值会被解读为常量legCount：
let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}
//字典元素的遍历顺序和插入顺序可能不同，字典的内容在内部是无序的，所以遍历元素时不能保证顺序。

/**
 *  while循环
 */
//while循环运行一系列语句直到条件变成false。这类循环适合使用在第一次迭代前迭代次数未知的情况下。Swift 提供两种while循环形式：
//while循环，每次在循环开始时计算条件是否符合；
//repeat-while循环，每次在循环结束时计算条件是否符合。

/**
 *  while
 */
//while循环从计算单一条件开始。如果条件为true，会重复运行一系列语句，直到条件变为false。
//下面是一般情况下 while 循环格式：
//while condition {
//    statements
//}
let finalSquare = 25
var board = [Int](count: finalSquare + 1, repeatedValue: 0)

board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

var square = 0
var diceRoll = 0
while square < finalSquare {
    // 掷骰子
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    // 根据点数移动
    square += diceRoll
    if square < board.count {
        // 如果玩家还在棋盘上，顺着梯子爬上去或者顺着蛇滑下去
        square += board[square]
    }
}
print("Game over!")
//本例中使用了最简单的方法来模拟掷骰子。 diceRoll的值并不是一个随机数，而是以0为初始值，之后每一次while循环，diceRoll的值使用前置自增操作符(++i)来自增 1 ，然后检测是否超出了最大值。任何时候如果diceRoll的值等于 7 时，就超过了骰子的最大值，会被重置为1。

/**
 *  repeat-while
 */
//while循环的另外一种形式是repeat-while，它和while的区别是在判断循环条件之前，先执行一次循环的代码块，然后重复循环直到条件为false。
//下面是一般情况下 repeat-while循环的格式：
//repeat {
//    statements
//} while condition

let finalSquare1 = 25
var board1 = [Int](count: finalSquare1 + 1, repeatedValue: 0)
board1[03] = +08; board1[06] = +11; board1[09] = +09; board1[10] = +02
board1[14] = -10; board1[19] = -11; board1[22] = -02; board1[24] = -08
var square1 = 0
var diceRoll1 = 0

repeat {
    // 顺着梯子爬上去或者顺着蛇滑下去
    square1 += board1[square1]
    // 掷骰子
    diceRoll1 += 1
    if diceRoll1 == 7 { diceRoll1 = 1 }
    // 根据点数移动
    square1 += diceRoll1
} while square1 < finalSquare1
print("Game over!")

//循环条件（while square < finalSquare）和while方式相同，但是只会在循环结束后进行计算。
//在这个游戏中，repeat-while表现得比while循环更好。
//repeat-while方式会在条件判断square没有超出后直接运行square += board[square]，这种方式可以去掉while版本中的数组越界判断。

/**
 *  条件语句
 */
//Swift 提供两种类型的条件语句：if语句和switch语句。通常，当条件较为简单且可能的情况很少时，使用if语句。而switch语句更适用于条件较复杂、可能情况较多且需要用到模式匹配（pattern-matching）的情境。

/**
 *  if
 */
//if语句最简单的形式就是只包含一个条件，当且仅当该条件为true时，才执行相关代码：
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}

//当然，if语句允许二选一，也就是当条件为false时，执行 else 语句：
temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}

//你可以把多个if语句链接在一起，像下面这样：
temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}

//实际上，最后的else语句是可选的：
temperatureInFahrenheit = 72
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
}

/**
 *  Switch语句
 */

//switch语句会尝试把某个值与若干个模式（pattern）进行匹配。根据第一个匹配成功的模式，switch语句会执行对应的代码。当有可能的情况较多时，通常用switch语句替换if语句。
//switch语句最简单的形式就是把某个值与一个或若干个相同类型的值作比较：
//switch some value to consider {
//    case value 1:
//    respond to value 1
//    case value 2,
//    value 3:
//    respond to value 2 or 3
//    default:
//    otherwise, do something else
//}

//每一个 case 都是代码执行的一条分支，这与if语句类似。与之不同的是，switch语句会决定哪一条分支应该被执行。

//switch语句必须是完备的。这就是说，每一个可能的值都必须至少有一个 case 分支与之对应。在某些不可能涵盖所有值的情况下，你可以使用默认（default）分支满足该要求，这个默认分支必须在switch语句的最后面。

let someCharacter: Character = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter) is a consonant")
default:
    print("\(someCharacter) is not a vowel or a consonant")
}
//在这个例子中，第一个 case 分支用于匹配五个元音，第二个 case 分支用于匹配所有的辅音。
//由于为其它可能的字符写 case 分支没有实际的意义，因此在这个例子中使用了默认分支来处理剩下的既不是元音也不是辅音的字符——这就保证了switch语句的完备性。


/**
 *  不存在隐式的贯穿
 */
//与 C 语言和 Objective-C 中的switch语句不同，在 Swift 中，当匹配的 case 分支中的代码执行完毕后，程序会终止switch语句，而不会继续执行下一个 case 分支。这也就是说，不需要在 case 分支中显式地使用break语句。这使得switch语句更安全、更易用，也避免了因忘记写break语句而产生的错误。
//每一个 case 分支都必须包含至少一条语句。像下面这样书写代码是无效的，因为第一个 case 分支是空的：

//let anotherCharacter: Character = "a"
//switch anotherCharacter {
//case "a":
//case "A":
//    print("The letter A")
//default:
//    print("Not the letter A")
//}
//不像 C 语言里的switch语句，在 Swift 中，switch语句不会同时匹配"a"和"A"。相反的，上面的代码会引起编译期错误：case "a": does not contain any executable statements——这就避免了意外地从一个 case 分支贯穿到另外一个，使得代码更安全、也更直观。


//一个 case 也可以包含多个模式，用逗号把它们分开（如果太长了也可以分行写）：
//switch some value to consider {
//    case value 1,
//    value 2:
//    statements
//}
//如果想要贯穿至特定的 case 分支中，请使用fallthrough语句


/**
 *  区间匹配
 */
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
var naturalCount: String
switch approximateCount {
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
print("There are \(naturalCount) \(countedThings).")
//注意： 闭区间操作符(...)以及半开区间操作符(..<)功能被重载去返回IntervalType或Range。一个区间可以决定他是否包含特定的元素，就像当匹配一个switch声明的case一样。区间是一个连续值的集合，可以用for-in语句遍历它。


/**
 *  元组
 */

//我们可以使用元组在同一个switch语句中测试多个值。元组中的元素可以是值，也可以是区间。另外，使用下划线（_）来匹配所有可能的值。
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("(0, 0) is at the origin")
case (_, 0):
    print("(\(somePoint.0), 0) is on the x-axis")
case (0, _):
    print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}
//不像 C 语言，Swift 允许多个 case 匹配同一个值。实际上，在这个例子中，点(0, 0)可以匹配所有四个 case。但是，如果存在多个匹配，那么只会执行第一个被匹配到的 case 分支。考虑点(0, 0)会首先匹配case (0, 0)，因此剩下的能够匹配(0, 0)的 case 分支都会被忽视掉。

/**
 *  值绑定
 */
//case 分支的模式允许将匹配的值绑定到一个临时的常量或变量，这些常量或变量在该 case 分支里就可以被引用了——这种行为被称为值绑定（value binding）。
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}

/**
 *  where
 */
//case 分支的模式可以使用where语句来判断额外的条件
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}

/**
 *  控制转移语句
 */
//控制转移语句改变你代码的执行顺序，通过它你可以实现代码的跳转。Swift 有五种控制转移语句：
//continue
//break
//fallthrough
//return
//throw
//我们将会在下面讨论continue、break和fallthrough语句。return语句将会在函数章节讨论，throw语句会在错误抛出章节讨论。

/**
 *  continue
 */
//continue语句告诉一个循环体立刻停止本次循环迭代，重新开始下次循环迭代。就好像在说“本次循环迭代我已经执行完了”，但是并不会离开整个循环体。
//注意： 在一个带有条件和递增的 for 循环体中，调用continue语句后，迭代增量仍然会被计算求值。循环体继续像往常一样工作，仅仅只是循环体中的执行代码会被跳过。
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
for character in puzzleInput.characters {
    switch character {
    case "a", "e", "i", "o", "u", " ":
        continue
    default:
        puzzleOutput.append(character)
    }
}
print(puzzleOutput)


/**
 *  break
 */
//break语句会立刻结束整个控制流的执行。当你想要更早的结束一个switch代码块或者一个循环体时，你都可以使用break语句。

/**
 *  循环语句中的 break
 */
//当在一个循环体中使用break时，会立刻中断该循环体的执行，然后跳转到表示循环体结束的大括号(})后的第一行代码。不会再有本次循环迭代的代码被执行，也不会再有下次的循环迭代产生。

/**
 *  Switch 语句中的 break
 */

//当在一个switch代码块中使用break时，会立即中断该switch代码块的执行，并且跳转到表示switch代码块结束的大括号(})后的第一行代码。

//这种特性可以被用来匹配或者忽略一个或多个分支。因为 Swift 的switch需要包含所有的分支而且不允许有为空的分支，有时为了使你的意图更明显，需要特意匹配或者忽略某个分支。那么当你想忽略某个分支时，可以在该分支内写上break语句。当那个分支被匹配到时，分支内的break语句立即结束switch代码块。

//当一个switch分支仅仅包含注释时，会被报编译时错误。注释不是代码语句而且也不能让switch分支达到被忽略的效果。你总是可以使用break来忽略某个分支。

let numberSymbol: Character = "三"  // 简体中文里的数字 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value could not be found for \(numberSymbol).")
}
//在上面的例子中，想要把Character所有的的可能性都枚举出来是不现实的，所以使用default分支来包含所有上面没有匹配到字符的情况。由于这个default分支不需要执行任何动作，所以它只写了一条break语句。一旦落入到default分支中后，break语句就完成了该分支的所有代码操作，代码继续向下，开始执行if let语句。

/**
 *  贯穿
 */
//Swift 中的switch不会从上一个 case 分支落入到下一个 case 分支中。相反，只要第一个匹配到的 case 分支完成了它需要执行的语句，整个switch代码块完成了它的执行。
//相比之下，C 语言要求你显式地插入break语句到每个switch分支的末尾来阻止自动落入到下一个 case 分支中。Swift 的这种避免默认落入到下一个分支中的特性意味着它的switch 功能要比 C 语言的更加清晰和可预测，可以避免无意识地执行多个 case 分支从而引发的错误。

//如果你确实需要 C 风格的贯穿的特性，你可以在每个需要该特性的 case 分支中使用fallthrough关键字。下面的例子使用fallthrough来创建一个数字的描述语句。

let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)

//fallthrough关键字不会检查它下一个将会落入执行的 case 中的匹配条件。fallthrough简单地使代码执行继续连接到下一个 case 中的执行代码，这和 C 语言标准中的switch语句特性是一样的。

/**
 *  带标签的语句
 */
//在 Swift 中，你可以在循环体和switch代码块中嵌套循环体和switch代码块来创造复杂的控制流结构。然而，循环体和switch代码块两者都可以使用break语句来提前结束整个方法体。因此，显式地指明break语句想要终止的是哪个循环体或者switch代码块，会很有用。类似地，如果你有许多嵌套的循环体，显式指明continue语句想要影响哪一个循环体也会非常有用。

//为了实现这个目的，你可以使用标签来标记一个循环体或者switch代码块，当使用break或者continue时，带上这个标签，可以控制该标签代表对象的中断或者执行。

//产生一个带标签的语句是通过在该语句的关键词的同一行前面放置一个标签，并且该标签后面还需带着一个冒号。下面是一个while循环体的语法，同样的规则适用于所有的循环体和switch代码块。

//label name: while condition { statements }
//下面的例子是在一个带有标签的while循环体中调用break和continue语句，该循环体是前面章节中蛇和梯子的改编版本。这次，游戏增加了一条额外的规则：
//为了获胜，你必须刚好落在第 25 个方块中。
//如果某次掷骰子使你的移动超出第 25 个方块，你必须重新掷骰子，直到你掷出的骰子数刚好使你能落在第 25 个方块中。
let finalSquare2 = 25
var board2 = [Int](count: finalSquare2 + 1, repeatedValue: 0)
board2[03] = +08; board2[06] = +11; board2[09] = +09; board2[10] = +02
board2[14] = -10; board2[19] = -11; board2[22] = -02; board2[24] = -08
var square2 = 0
var diceRoll2 = 0

gameLoop: while square2 != finalSquare2 {
    diceRoll2 += 1
    if diceRoll2 == 7 { diceRoll2 = 1 }
    switch square2 + diceRoll2 {
    case finalSquare2:
        // 到达最后一个方块，游戏结束
        break gameLoop
    case let newSquare where newSquare > finalSquare2:
        // 超出最后一个方块，再掷一次骰子
        continue gameLoop
    default:
        // 本次移动有效
        square2 += diceRoll2
        square2 += board2[square2]
    }
}
print("Game over!")

//如果上述的break语句没有使用gameLoop标签，那么它将会中断switch代码块而不是while循环体。使用gameLoop标签清晰的表明了break想要中断的是哪个代码块。 
//同时请注意，当调用continue gameLoop去跳转到下一次循环迭代时，这里使用gameLoop标签并不是严格必须的。因为在这个游戏中，只有一个循环体，所以continue语句会影响到哪个循环体是没有歧义的。然而，continue语句使用gameLoop标签也是没有危害的。这样做符合标签的使用规则，同时参照旁边的break gameLoop，能够使游戏的逻辑更加清晰和易于理解。

/**
 *  提前退出
 */
//像if语句一样，guard的执行取决于一个表达式的布尔值。我们可以使用guard语句来要求条件必须为真时，以执行guard语句后的代码。不同于if语句，一个guard语句总是有一个else分句，如果条件不为真则执行else分句中的代码。

func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    print("Hello \(name)")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    print("I hope the weather is nice in \(location).")
}
greet(["name": "John"])
// 输出 "Hello John!"
// 输出 "I hope the weather is nice near you."
greet(["name": "Jane", "location": "Cupertino"])
// 输出 "Hello Jane!"
// 输出 "I hope the weather is nice in Cupertino."

//如果guard语句的条件被满足，则在保护语句的封闭大括号结束后继续执行代码。任何使用了可选绑定作为条件的一部分并被分配了值的变量或常量对于剩下的保护语句出现的代码段是可用的。

//如果条件不被满足，在else分支上的代码就会被执行。这个分支必须转移控制以退出guard语句出现的代码段。它可以用控制转移语句如return,break,continue或者throw做这件事，或者调用一个不返回的方法或函数，例如fatalError()。

//相比于可以实现同样功能的if语句，按需使用guard语句会提升我们代码的可靠性。它可以使你的代码连贯的被执行而不需要将它包在else块中，它可以使你处理违反要求的代码接近要求。

/**
 *  检测 API 可用性
 */
//Swift 有检查 API 可用性的内置支持，这可以确保我们不会不小心地使用对于当前部署目标不可用的 API。

if #available(iOS 9, OSX 10.10, *) {
    // 在 iOS 使用 iOS 9 的 API, 在 OS X 使用 OS X v10.10 的 API
} else {
    // 使用先前版本的 iOS 和 OS X 的 API
}

//if #available(`platform name` `version`, `...`, *) {
//    `statements to execute if the APIs are available`
//} else {
//    `fallback statements to execute if the APIs are unavailable`
//}