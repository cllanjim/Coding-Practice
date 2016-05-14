//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//一个类可以继承（inherit）另一个类的方法（methods），属性（properties）和其它特性。当一个类继承其它类时，继承类叫子类（subclass），被继承类叫超类（或父类，superclass）。在 Swift 中，继承是区分「类」与其它类型的一个基本特征。
//在 Swift 中，类可以调用和访问超类的方法，属性和下标（subscripts），并且可以重写（override）这些方法，属性和下标来优化或修改它们的行为。Swift 会检查你的重写定义在超类中是否有匹配的定义，以此确保你的重写行为是正确的。
//可以为类中继承来的属性添加属性观察器（property observers），这样一来，当属性值改变时，类就会被通知到。可以为任何属性添加属性观察器，无论它原本被定义为存储型属性（stored property）还是计算型属性（computed property）。

/**
  * 定义一个基类
  */
//不继承于其它类的类，称之为基类（base class）。
//Swift 中的类并不是从一个通用的基类继承而来。如果你不为你定义的类指定一个超类的话，这个类就自动成为基类。
//下面的例子定义了一个叫Vehicle的基类。这个基类声明了一个名为currentSpeed，默认值是0.0的存储属性（属性类型推断为Double）。currentSpeed属性的值被一个String类型的只读计算型属性description使用，用来创建车辆的描述。
//Vehicle基类也定义了一个名为makeNoise的方法。这个方法实际上不为Vehicle实例做任何事，但之后将会被Vehicle的子类定制：
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // 什么也不做-因为车辆不一定会有噪音
    }
}
//您可以用初始化语法创建一个Vehicle的新实例，即类名后面跟一个空括号：
let someVehicle = Vehicle()

//现在已经创建了一个Vehicle的新实例，你可以访问它的description属性来打印车辆的当前速度：
print("Vehicle: \(someVehicle.description)")
//Vehicle类定义了一个通用特性的车辆类，实际上没什么用处。为了让它变得更加有用，需要完善它从而能够描述一个更加具体类型的车辆。


/**
 * 子类生成（Subclassing）
 */
//子类生成（Subclassing）指的是在一个已有类的基础上创建一个新的类。子类继承超类的特性，并且可以进一步完善。你还可以为子类添加新的特性。

//为了指明某个类的超类，将超类名写在子类名的后面，用冒号分隔：
//class SomeClass: SomeSuperclass {
//    // 这里是子类的定义
//}


class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true

bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")

//子类还可以继续被其它类继承，下面的示例为Bicycle创建了一个名为Tandem（双人自行车）的子类：
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")
// Tandem: traveling at 22.0 miles per hour


/**
 * 重写（Overriding）
 */

//子类可以为继承来的实例方法（instance method），类方法（class method），实例属性（instance property），或下标（subscript）提供自己定制的实现（implementation）。我们把这种行为叫重写（overriding）。

//如果要重写某个特性，你需要在重写定义的前面加上override关键字。这么做，你就表明了你是想提供一个重写版本，而非错误地提供了一个相同的定义。意外的重写行为可能会导致不可预知的错误，任何缺少override关键字的重写都会在编译时被诊断为错误。

//override关键字会提醒 Swift 编译器去检查该类的超类（或其中一个父类）是否有匹配重写版本的声明。这个检查可以确保你的重写定义是正确的。

/**
 * 访问超类的方法，属性及下标
 */

//当你在子类中重写超类的方法，属性或下标时，有时在你的重写版本中使用已经存在的超类实现会大有裨益。比如，你可以完善已有实现的行为，或在一个继承来的变量中存储一个修改过的值。

//在合适的地方，你可以通过使用super前缀来访问超类版本的方法，属性或下标：
//在方法someMethod()的重写实现中，可以通过super.someMethod()来调用超类版本的someMethod()方法。
//在属性someProperty的 getter 或 setter 的重写实现中，可以通过super.someProperty来访问超类版本的someProperty属性。
//在下标的重写实现中，可以通过super[someIndex]来访问超类版本中的相同下标。


/**
 * 重写方法
 */
//在子类中，你可以重写继承来的实例方法或类方法，提供一个定制或替代的方法实现。
//下面的例子定义了Vehicle的一个新的子类，叫Train，它重写了从Vehicle类继承来的makeNoise()方法：
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}
//如果你创建一个Train的新实例，并调用了它的makeNoise()方法，你就会发现Train版本的方法被调用：
let train = Train()
train.makeNoise()
// 打印 "Choo Choo"


/**
 * 重写属性
 */
//你可以重写继承来的实例属性或类型属性，提供自己定制的 getter 和 setter，或添加属性观察器使重写的属性可以观察属性值什么时候发生改变。

/**
 * 重写属性的 Getters 和 Setters
 */
//你可以提供定制的 getter（或 setter）来重写任意继承来的属性，无论继承来的属性是存储型的还是计算型的属性。子类并不知道继承来的属性是存储型的还是计算型的，它只知道继承来的属性会有一个名字和类型。你在重写一个属性时，必需将它的名字和类型都写出来。这样才能使编译器去检查你重写的属性是与超类中同名同类型的属性相匹配的。

//你可以将一个继承来的只读属性重写为一个读写属性，只需要在重写版本的属性里提供 getter 和 setter 即可。但是，你不可以将一个继承来的读写属性重写为一个只读属性。
//如果你在重写属性中提供了 setter，那么你也一定要提供 getter。如果你不想在重写版本中的 getter 里修改继承来的属性值，你可以直接通过super.someProperty来返回继承来的值，其中someProperty是你要重写的属性的名字。

//以下的例子定义了一个新类，叫Car，它是Vehicle的子类。这个类引入了一个新的存储型属性叫做gear，默认值为整数1。Car类重写了继承自Vehicle的description属性，提供包含当前档位的自定义描述：
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

//重写的description属性首先要调用super.description返回Vehicle类的description属性。之后，Car类版本的description在末尾增加了一些额外的文本来提供关于当前档位的信息。
//如果你创建了Car的实例并且设置了它的gear和currentSpeed属性，你可以看到它的description返回了Car中的自定义描述：
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")
// Car: traveling at 25.0 miles per hour in gear 3

/**
 * 重写属性观察器
 */
//你可以通过重写属性为一个继承来的属性添加属性观察器。这样一来，当继承来的属性值发生改变时，你就会被通知到，无论那个属性原本是如何实现的。关于属性观察器的更多内容，请看属性观察器。

//你不可以为继承来的常量存储型属性或继承来的只读计算型属性添加属性观察器。这些属性的值是不可以被设置的，所以，为它们提供willSet或didSet实现是不恰当。
//此外还要注意，你不可以同时提供重写的 setter 和重写的属性观察器。如果你想观察属性值的变化，并且你已经为那个属性提供了定制的 setter，那么你在 setter 中就可以观察到任何值变化了。


//下面的例子定义了一个新类叫AutomaticCar，它是Car的子类。AutomaticCar表示自动挡汽车，它可以根据当前的速度自动选择合适的挡位:

class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

//当你设置AutomaticCar的currentSpeed属性，属性的didSet观察器就会自动地设置gear属性，为新的速度选择一个合适的挡位。具体来说就是，属性观察器将新的速度值除以10，然后向下取得最接近的整数值，最后加1来得到档位gear的值。例如，速度为35.0时，挡位为4：
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")


/**
 * 防止重写
 */
//你可以通过把方法，属性或下标标记为final来防止它们被重写，只需要在声明关键字前加上final修饰符即可（例如：final var，final func，final class func，以及final subscript）。

//如果你重写了final方法，属性或下标，在编译时会报错。在类扩展中的方法，属性或下标也可以在扩展的定义里标记为 final 的。

//你可以通过在关键字class前添加final修饰符（final class）来将整个类标记为 final 的。这样的类是不可被继承的，试图继承这样的类会导致编译报错。