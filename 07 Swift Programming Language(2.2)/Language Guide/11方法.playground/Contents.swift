//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**
  * 方法
  */

//方法是与某些特定类型相关联的函数。
//类、结构体、枚举都可以定义实例方法；实例方法为给定类型的实例封装了具体的任务与功能。
//类、结构体、枚举也可以定义类型方法；类型方法与类型本身相关联。类型方法与 Objective-C 中的类方法（class methods）相似。

//结构体和枚举能够定义方法是 Swift 与 C/Objective-C 的主要区别之一。在 Objective-C 中，类是唯一能定义方法的类型。但在 Swift 中，你不仅能选择是否要定义一个类/结构体/枚举，还能灵活地在你创建的类型（类/结构体/枚举）上定义方法。


/**
 * 实例方法
 */
//实例方法是属于某个特定类、结构体或者枚举类型实例的方法。实例方法提供访问和修改实例属性的方法或提供与实例目的相关的功能，并以此来支撑实例的功能。实例方法的语法与函数完全一致，详情参见函数。

//实例方法要写在它所属的类型的前后大括号之间。实例方法能够隐式访问它所属类型的所有的其他实例方法和属性。实例方法只能被它所属的类的某个特定实例调用。实例方法不能脱离于现存的实例而被调用。

//下面的例子，定义一个很简单的Counter类，Counter能被用来对一个动作发生的次数进行计数
class Counter {
    var count = 0
    func increment() {
         count += 1
    }
    func incrementBy(amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}

let counter = Counter()
// 初始计数值是0
counter.increment()
// 计数值现在是1
counter.incrementBy(5)
// 计数值现在是6
counter.reset()
// 计数值现在是0


/**
 * 方法的局部参数名称和外部参数名称
 */
//函数参数可以同时有一个局部名称（在函数体内部使用）和一个外部名称（在调用函数时使用），详情参见指定外部参数名。方法参数也一样（因为方法就是函数，只是这个函数与某个类型相关联了）。

//Swift 中的方法和 Objective-C 中的方法极其相似。像在 Objective-C 中一样，Swift 中方法的名称通常用一个介词指向方法的第一个参数，比如：with，for，by等等。前面的Counter类的例子中incrementBy(_:)方法就是这样的。介词的使用让方法在被调用时能像一个句子一样被解读。

//具体来说，Swift 默认仅给方法的第一个参数名称一个局部参数名称；默认同时给第二个和后续的参数名称局部参数名称和外部参数名称。这个约定与典型的命名和调用约定相适应，与你在写 Objective-C 的方法时很相似。这个约定还让富于表达性的方法在调用时不需要再限定参数名称。

//看看下面这个Counter的另一个版本（它定义了一个更复杂的incrementBy(_:)方法）：
class Counter1 {
    var count: Int = 0
    func incrementBy(amount: Int, numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
}

let counter1 = Counter1()
counter1.incrementBy(5, numberOfTimes: 3)


/**
 * 修改方法的外部参数名称
 */
//有时为方法的第一个参数提供一个外部参数名称是非常有用的，尽管这不是默认的行为。你自己可以为第一个参数添加一个显式的外部名称。

//相反，如果你不想为方法的第二个及后续的参数提供一个外部名称，可以通过使用下划线（_）作为该参数的显式外部名称，这样做将覆盖默认行为。


/**
 * self 属性
 */
//类型的每一个实例都有一个隐含属性叫做self，self完全等同于该实例本身。你可以在一个实例的实例方法中使用这个隐含的self属性来引用当前实例。

//上面例子中的increment方法还可以这样写：
//func increment() {
//    self.count += 1
//}
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(1.0) {
    print("This point is to the right of the line where x == 1.0")
}
//如果不使用self前缀，Swift 就认为两次使用的x都指的是名称为x的函数参数。

/**
 * 在实例方法中修改值类型
 */
//结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改。
//但是，如果你确实需要在某个特定的方法中修改结构体或者枚举的属性，你可以为这个方法选择可变(mutating)行为，然后就可以从其方法内部改变它的属性；并且这个方法做的任何改变都会在方法执行结束时写回到原始结构中。方法还可以给它隐含的self属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例。

//要使用可变方法，将关键字mutating 放到方法的func关键字之前就可以了：
struct Point1 {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint1 = Point1(x: 1.0, y: 1.0)
somePoint1.moveByX(2.0, y: 3.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")

//注意，不能在结构体类型的常量（a constant of structure type）上调用可变方法，因为其属性不能被改变，即使属性是变量属性，
let fixedPoint = Point1(x: 3.0, y: 3.0)
//fixedPoint.moveByX(2.0, y: 3.0)
// 这里将会报告一个错误


/**
 * 在可变方法中给 self 赋值
 */
//可变方法能够赋给隐含属性self一个全新的实例。上面Point的例子可以用下面的方式改写：

struct Point2 {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        self = Point2(x: x + deltaX, y: y + deltaY)
    }
}
//新版的可变方法moveByX(_:y:)创建了一个新的结构体实例，它的 x 和 y 的值都被设定为目标值。调用这个版本的方法和调用上个版本的最终结果是一样的。

//枚举的可变方法可以把self设置为同一枚举类型中不同的成员：
enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off
        }
    }
}

var ovenLight = TriStateSwitch.Low
ovenLight.next()
// ovenLight 现在等于 .High
ovenLight.next()
// ovenLight 现在等于 .Off

//上面的例子中定义了一个三态开关的枚举。每次调用next()方法时，开关在不同的电源状态（Off，Low，High）之间循环切换。



/**
 * 类型方法
 */
//实例方法是被某个类型的实例调用的方法。你也可以定义在类型本身上调用的方法，这种方法就叫做类型方法（Type Methods）。在方法的func关键字之前加上关键字static，来指定类型方法。类还可以用关键字class来允许子类重写父类的方法实现。

//在 Objective-C 中，你只能为 Objective-C 的类类型（classes）定义类型方法（type-level methods）。在 Swift 中，你可以为所有的类、结构体和枚举定义类型方法。每一个类型方法都被它所支持的类型显式包含。

//类型方法和实例方法一样用点语法调用。但是，你是在类型上调用这个方法，而不是在实例上调用。下面是如何在SomeClass类上调用类型方法的例子：
class SomeClass {
    class func someTypeMethod() {
        // type method implementation goes here
    }
}
SomeClass.someTypeMethod()

//在类型方法的方法体（body）中，self指向这个类型本身，而不是类型的某个实例。这意味着你可以用self来消除类型属性和类型方法参数之间的歧义（类似于我们在前面处理实例属性和实例方法参数时做的那样）。

//一般来说，在类型方法的方法体中，任何未限定的方法和属性名称，可以被本类中其他的类型方法和类型属性引用。一个类型方法可以直接通过类型方法的名称调用本类中的其它类型方法，而无需在方法名称前面加上类型名称。类似地，在结构体和枚举中，也能够直接通过类型属性的名称访问本类中的类型属性，而不需要前面加上类型名称。

//下面的例子定义了一个名为LevelTracker结构体。它监测玩家的游戏发展情况（游戏的不同层次或阶段）。这是一个单人游戏，但也可以存储多个玩家在同一设备上的游戏信息。
//游戏初始时，所有的游戏等级（除了等级 1）都被锁定。每次有玩家完成一个等级，这个等级就对这个设备上的所有玩家解锁。LevelTracker结构体用类型属性和方法监测游戏的哪个等级已经被解锁。它还监测每个玩家的当前等级。
struct LevelTracker {
    static var highestUnlockedLevel = 1
    
    static func unlockLevel(level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    
    static func levelIsUnlocked(level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
   
    var currentLevel = 1
    mutating func advanceToLevel(level: Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}
//LevelTracker监测玩家已解锁的最高等级。这个值被存储在类型属性highestUnlockedLevel中。
//LevelTracker还定义了两个类型方法与highestUnlockedLevel配合工作。
//第一个类型方法是unlockLevel，一旦新等级被解锁，它会更新highestUnlockedLevel的值。
//第二个类型方法是levelIsUnlocked，如果某个给定的等级已经被解锁，它将返回true。（注意，尽管我们没有使用类似LevelTracker.highestUnlockedLevel的写法，这个类型方法还是能够访问类型属性highestUnlockedLevel）

//除了类型属性和类型方法，LevelTracker还监测每个玩家的进度。它用实例属性currentLevel来监测每个玩家当前的等级。
//为了便于管理currentLevel属性，LevelTracker定义了实例方法advanceToLevel。这个方法会在更新currentLevel之前检查所请求的新等级是否已经解锁。advanceToLevel方法返回布尔值以指示是否能够设置currentLevel。
//下面，Player类使用LevelTracker来监测和更新每个玩家的发展进度：
class Player {
    var tracker = LevelTracker()
    let playerName: String
    func completedLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    init(name: String) {
        playerName = name
    }
}
//Player类创建一个新的LevelTracker实例来监测这个用户的进度。它提供了completedLevel方法，一旦玩家完成某个指定等级就调用它。这个方法为所有玩家解锁下一等级，并且将当前玩家的进度更新为下一等级。（我们忽略了advanceToLevel返回的布尔值，因为之前调用LevelTracker.unlockLevel时就知道了这个等级已经被解锁了）。
//你还可以为一个新的玩家创建一个Player的实例，然后看这个玩家完成等级一时发生了什么：
var player = Player(name: "Argyrios")
player.completedLevel(1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
// 打印输出：highest unlocked level is now 2

//如果你创建了第二个玩家，并尝试让他开始一个没有被任何玩家解锁的等级，那么试图设置玩家当前等级将会失败：
player = Player(name: "Beto")
if player.tracker.advanceToLevel(6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}
// 打印输出：level 6 has not yet been unlocked
