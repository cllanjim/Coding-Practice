//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**************************************************************/
/*:
 创建对象
 * OC:     alloc initWithXXX 方法
 * Swift:  (xxx:)
 */

/*:
 调用方法
 * OC:     [UIColor redColor];
 * Swift    UIColor.redColor()
 */

/*:
 枚举
 * OC:      UIButtonTypeContactAdd
 * Swift:   UIButtonType.ContactAdd
 */

let view = UIView(frame: CGRectMake(0, 0, 100, 100))
view.backgroundColor = UIColor.redColor()

let btn = UIButton(type: UIButtonType.ContactAdd)
btn.center = CGPoint(x: 50, y: 50)
view.addSubview(btn)

/**************************************************************/
/*:
 注释
 * Swift 的编译器将会在编译代码时自动忽略掉注释部分
 * 单行注释 //
 * 多行注释 /**/
 
 与 C 语言多行注释不同，Swift 的多行注释可以嵌套在其它的多行注释之中嵌套多行注释
 * 注释嵌套 /*/**/*/
 */
/**************************************************************/


/**************************************************************/
/*
 常量与变量的标识符
 let 常量:常量的值一旦设定就不能改变
 var 变量:变量的值可以随意改变
 注意点:
    为了保证数据的安全性,尽量优先使用let,只有需要的时候才使用var
 */

/*
 定义常量的格式
 声明符号 常量名称:类型标注
 举例: let number:NSInteger
 特点:一旦设定就无法改变
*/
let number01:NSInteger = 10
//更改常量会导致报错
//number01 = 11

/*
 定义变量的格式
 声明符号 变量名称: 类型标注
 var number:NSInteger
 特点:变量的值可以随意改变
 */
var number02:NSInteger = 10
number02 = 11
/*
 注意点:
    一般来说很少需要写类型标注,如果在声明常量或者变量的时候进行了赋值操作,Swift编译器会根据赋值类型自动判断出当前常量或者变量的数据类型
*/
/**************************************************************/


/**************************************************************/
/*
 类型推断:
        编译器可以在编译代码的时候自动推断出表达式的类型(其他语言没有类型推断)
        原理很简单,检查赋的值得类型
        如果没有指定表达类型,也没有赋予初值,编译器会报错(type annotation missing in pattern)
 */
//指定类型
let double01 :Double
double01 = 10.0

//let double02;
//double02 = 10.2;
/**************************************************************/


/**************************************************************/
/*
 类型安全
 
 * Swift 是一个类型安全（type safe）的语言, 它会在编译你的代码时进行类型检查（type checks），并把不匹配的类型标记为错误。这可以让你在开发的时候尽早发现并修复错误
 * swift 对数据类型要求异常严格, swift 中任何时候，都不会做 `隐式转换`，如果要对不同类型的数据进行计算，必须显示类型转换
 注意：
 * 结合数字类常量和变量不同于结合数字类字面量。字面量8可以直接和字面量3.1415926相加，因为数字字面量本身没有明确的类型。它们的类型只在编译器需要求值的时候被推测
 * Double和CGFloat也需要转换
 */

let intNumber: Int = 10
let doubleNumber: Double = 10.2
// 注意:Double()并不会修改intNumber的值, 而是通过intNumber的值生成一个临时的值赋值给doubleNumber
let resultDouble = Double(intNumber) + doubleNumber
let resultInt = intNumber + Int(doubleNumber)
//错误写法
//let result = intNumber + doubleNumber;

let cgfloatNumber:CGFloat = 10.9
let resultFloat = cgfloatNumber + CGFloat(doubleNumber)
//错误写法
//let resultFloat = cgfloatNumber + doubleNumber
/**************************************************************/


/**************************************************************/
/*:
 常量和变量的命名
 * 你可以用任何你喜欢的字符作为常量和变量名，包括 Unicode 字符
 * 常量与变量名不能包含数学符号，箭头，保留的（或者非法的）Unicode 码位，连线与制表符
 * 也不能以数字开头，但是可以在常量与变量名的其他地方包含数字
 * ... 和C和OC一样, no zuo no die
 
 注意:
 * 如果你需要使用与Swift保留关键字相同的名称作为常量或者变量名，你可以使用反引号（`）将关键字包围的方式将其作为名字使用。
 * 无论如何，你应当避免使用关键字作为常量或变量名，除非你别无选择。
 */
//var 🐶 = "张思琦"
//🐶 = "阿青"
let `int` = 10
/**************************************************************/


/**************************************************************/
/*
 元祖类型
 * 元组（tuples）把多个值组合成一个复合值
 * 将多个相同或者不同类型的值用一个小括号括起来就是一个元祖
 * 元组内的值可以是任意类型，并不要求是相同类型
 * 作为函数返回值时，元组非常有用
 
 注意：
 * 元组在临时组织值的时候很有用，但是并不适合创建复杂的数据结构。如果你的数据结构并不是临时使用，请使用类或者结构体而不是元组
 */

//定义元祖
let studentInfo = ("zsq", 201415926, 28)

//创建元祖和访问元祖中的数据
//方式一
let student01 = ("zsq", 25, 1.67)
student01
student01.0
student01.1

//方式二
let student02 = (name:"sq", age:18, height:1.60)
student02
student02.name
student02.age

//方式三
let (name, age, height) = ("hg", 30, 180)
name
age
/**************************************************************/


/**************************************************************/
/*
 输出
 * OC:
 * NSLog(@"Hello, World!");
 * Swift
 * 2.0以前:  println("Hello, World!")
 * 2.0开始:  print("Hello, World!")
 */
 print("Hello, World!")
/**************************************************************/


/**************************************************************/
/*
 Swift 提供了类似 C 语言的流程控制结构(if/switch/for/while/dowhile)
 分支if
 * 只能以Bool作为条件语句
 * 条件语句不需要加()
 * {}不能省略
 * Swift中if分支的模式可以使用where语句来判断额外的条件
 * 其它和OCif一样
 */

let value = 10
if value > 15{
    print("ok");
}

let testValue: Int? = 10
//使用where语句判断额外的条件
if let d = testValue where testValue > 9
{
    print("满足")
}

//等价于上面的代码块内容
if testValue >= 10 && testValue <= 20 {
    print("满足")
}


//错误代码
//必须为BOOL类型
//if 10 {
//    print("ok")
//}


// 这个是可选类型,因为只有声明成可选类型后,才可以判断是否为空
// 可选类型会在后续讲解,可先了解即可
let myView : UIView? = UIView()
// 判断如果view有值,则设置背景
// 错误写法
//if view {
//    view.backgroundColor = UIColor.redColor()
//}
if myView != nil {
    myView!.backgroundColor = UIColor.redColor()
}

/**************************************************************/

/**************************************************************/
/*
 Bool类型
 * C语言和OC并没有真正的Bool类型
 * OC语言的Bool类型YES/NO是`typedef signed char BOOL;`非0即真
 
 Swift引入了真正的Bool类型true/false
 * Swift中没有C和OC中非零即真的概念
 * Swfit中逻辑值只有两个true/false
 * 如果你在需要使用Bool类型的地方使用了非布尔值，Swift 的类型安全机制会报错
 */
//intValue == 10语句的返回值就是Bool类型
let intValue:Int = 11
if intValue == 10 {
    print(intValue)
}
/**************************************************************/

/**************************************************************/
/*
 三目运算符
 * 三目运算符的特殊在于它是有三个操作数的运算符, 它简洁地表达根据问题成立与否作出二选一的操作
 * 格式: 问题 ? 答案1 : 答案2
 
 提示:
 * Swift中三目运算符用得很多
 
 注意:
 * 过度使用三目运算符会使简洁的代码变的难懂。我们应避免在一个组合语句中使用多个三目运算符
 */
let result = intValue > 20 ? 20 : 10
/**************************************************************/

/**************************************************************/
/*
 分支Switch
 * OC中case后面必须加上break否则会贯穿, Swift不用
 * Swift中如果想贯穿必须使用fallthrough
 * OC中可以不写default,Swift中只有满足所有条件才能忽略default
 * OC中default位置可以随便放,Swift不可以
 * OC中在case中定义变量需要加大括号, 否则作用域混乱, Swift不用加大括号
 * Swift中的switch可以判断区间和元祖
 * Swift中case 分支的模式可以使用where语句来判断额外的条件
 */

let myName:NSString = "ZSQ"
switch myName{
case "WCF":
    print("mother")
case "ZPL":
    print("father")
default:
    print("other")
}

//使用fallThrough产生穿透效果,但是default中的内容不会生效
let myNumber:NSString = "ZSQ"
switch myNumber{
case "ZSQ":
    print("mother")
    fallthrough
case "ABC":
    print("father")
default:
    print("other")
}

/*:
 匹配区间
 * 闭区间操作符...   包含头包含尾
 * 半开区间操作符..< 包含头不包含尾
 */
let newAge = 18
switch age{
case 1..<18:
    print("未成年")
case 18..<30:
    print("成年人")
case 31...88:
    print("老炮")
default:
    print("老不死")
}

//: 匹配元祖
var point = (30, 50)
switch point{
// 只有where后面的条件表达式为真才赋值并执行case后的语句
case (0, 0):
    print("原点")
case (50, 50):
    print("中点")
default:
    print("Other")
}

//: 值绑定（Value Bindings）
switch point{
// 只有where后面的条件表达式为真才赋值并执行case后的语句
case var(x, y) where x > y:
    print("\(x) > \(y)")
case var(x, y) where x < y:
    print("\(x) < \(y)")
default:
    print("Other")
}

/*
注意:
 Swift中每一个 case 分支都必须包含至少一条语句, 不像 C 语言里的switch语句，
 在 Swift 中，switch语句不会同时匹配多个条件

//错误示例
 switch(rank){
    case "A":
    case "B":
        NSLog(@"还不错")
        break
    case "C":
        NSLog("差")
        break
}
*/
let rank = "A"
//正确示例
switch rank {
case "A", "B":
    print("还可以")
case "C":
    print("差")
default:
    print("回家吧")
}
/**************************************************************/


/**************************************************************/
/*
可选类型
* 可选类型表示变量可以有值, 也可以没有值
* C 和 Objective-C 中并没有可选类型这个概念
* Swift中只有可选类型才可以赋值为nil
* 如果你声明一个可选常量或者变量但是没有赋值，它们会自动被设置为nil

* 格式: Optional<类型>  或 在类型后面加上?号

可选类型的取值是一个枚举
* None 没有值
* Some 有值

* 由于可选类型在Swift中随处可见, 所以系统做了一个语法糖, 在类型后面加上?
注意：
* nil不能用于非可选的常量和变量。如果你的代码中有常量或者变量需要处理值缺失的情况，请把它们声明成对应的可选类型。
* Swift 的nil和 Objective-C 中的nil并不一样。在 Objective-C 中，nil是一个指向不存在对象的指针, 所以Objective-C只有对象类型才能被设置为nil(基本类型不行)。在 Swift 中，nil不是指针——它是一个确定的值，用来表示值缺失。任何类型的可选状态都可以被设置为nil，不只是对象类型。
*/

var optionalNumber01: Optional<Int> = 10
optionalNumber01 = nil
optionalNumber01 = 11

var optionalNumber02: Int? = 20
optionalNumber02 = nil
optionalNumber02 = 22

//不是可选类型的数据不能为空
//var notOptionalNumber: Int = 30
//notOptionalNumber = nil

/*
 解包
 Swift中可选类型的值不能当做普通类型的值来使用,如果想使用可选类型的值必须进行解包操作
 只需要在变量/常量后面加上! 就可以解包
 解包代表着告诉系统, 该变量/常量中一定有值,否则编译器会报错
 */

var number10 : Optional<Int> = 10
var number11 : Int = 11
let sum = number10! + number11
//let sum = number10 + number11
print(number10)
print(number11)

/*
 强制解析（forced unwrapping）
 * init? 构造函数, ?表示不一定能够实例化出对象
 * !表示告诉编译器一定有值, 编译能够通过, 如果运行时没有值就会直接崩溃
 * 提示: ? 和 ! 是所有刚刚接触Swift的OC程序员最最蛋疼的问题, 前期开发要注意多看文档和利用编译器提示解决(option + click)
 注意
 * 在Swift开发中, 尽量不要使用强制解包, 不安全
 */

//public convenience init?(string URLString: String)
//返回值为 init?
let url = NSURL(string: "http://www.520it.com")
print(url)

let url1 = NSURL(string: "http://www.520it.com/张思琦")
print(url1)




/*:
 可选绑定（optional binding）
 * 不需要考虑url是否有值, 能进入{}一定有值
 * 不仅可以用来判断可选类型中是否有值，同时可以将可选类型中的值赋给一个常量或者变量
 * 可选绑定可以用在if和while语句中
 
 提示:
 * 在实际开发中，使用频率很高
 
 注意:
 * 可选绑定中的变量/常量只能在if后面的{}中使用
 */
if let value = url{
    print(value)
}

/*:
 guard
 * guard语句是在Swift 2.0中引进的，它是用途是在未满足某个条件时，提供一个退出的路径
 * 格式: guard 表达式 else{}
 注意：
 * guard中的变量/常量 可以在guard后面使用
 * guard一般用于避免使用强制拆包, 优化代码结构
 */

//如下常景
let value1: Int? = 10
let value2: Int? = 20
let value3: Int? = 30
let value4: Int? = 40

//使用可选绑定会产生大量的嵌套
if let temp1 = value1 {
    if let temp2 = value2 {
        if let temp3 = value3 {
            if let temp4 = value4 {
                let sum = temp1 + temp2 + temp3 + temp4
            }
        }
    }
}

//使用gurad语句
func text(){
    
    let value1: Int? = 10
    let value2: Int? = 20
    let value3: Int? = 30
    let value4: Int? = 40
    
    guard let temp1 = value1 else{
        return
    }
    guard let temp2 = value2 else{
        return
    }
    guard let temp3 = value3 else{
        return
    }
    guard let temp4 = value4 else{
        return
    }
    let sum = temp1 + temp2 + temp3 + temp4
    print(sum)
}
text()

/*
 隐式解析可选类型（implicitly unwrapped optionals）
 * 有时候在程序架构中，第一次被赋值之后，可以确定一个可选类型_总会_有值。在这种情况下，每次都要判断和解析可选值是非常低效的，因为可以确定它总会有值
 * 隐式解析可选类型, 并不需要每次都使用解析来获取可选值, 一个隐式解析可选类型其实就是一个普通类型，但是可以被当做非可选类型来使用
 * 格式: 将可选类型后面的?改为!
 * let xmgButton: UIButton!
 
 注意：
 * 如果一个变量之后可能变成nil的话请不要使用隐式解析可选类型。如果你需要在变量的生命周期中判断是否是nil的话，请使用普通可选类型
 */
var unwrappedNumber0 : Int? = 10

//从可选类型获取值
//强制解析----判断非空
if unwrappedNumber0 != nil{
print(unwrappedNumber0!)
}

//可选绑定
if let myTemp = unwrappedNumber0{
    print(myTemp)
}

//从隐式可选类型中获取值
var unwrappedNumber : Int! = 10
print(unwrappedNumber)
/**************************************************************/


/**************************************************************/
/*:
 for循环-Swift
 * 闭区间: 包含区间内所有值  a...b 例如: 1...5
 * 半闭区间: 包含头不包含尾  a..<b  例如: 1..<5
 其它写法
 * Swift1.0版本写法 0..10
 */

//  0~9之间
for i in 0..<9{
    print(i)
}

// 0~10
for i in 0...10{
    print(i)
}

/*:
 忽略 _
 * 不关心下标可以使用 _ 忽略下标
 * 在Swift中 _ 使用非常广泛
 */
for _ in 0...10
{
    print("lnj")
}

//: while循环, 每次在循环开始时计算条件是否符合
var n = 0
while n < 10
{
    print(n)
    n += 1
}

//: repeat-while, 每次在循环结束时计算条件是否符合
var m = 0
repeat{
    print(m)
    m += 1
}while m < 10
/**************************************************************/


/**************************************************************/
/*:
 数组(有序数据集)
 * Swift 的Array类型被桥接到Foundation的NSArray类。
 *格式 : [] / [Int]() / Array<Int>()
 * let 不可变数组
 * var 可变数组
 注意：
 * 不需要改变集合的时候创建不可变集合是很好的实践。如此 Swift 编译器可以优化我们创建的集合。
 */

//创建一个空数组
//代表创建一个元素为string类型的数组
var array01 : [String] = []
var array02 : [String] = [String]()
var array03 : [String] = Array<String>()//使用了泛型

//创建带有默认值的数组
let array04 = ["zsq","sq"]
//代表数组中有5个元素,初始值为0
let array05 = Array(count:5, repeatedValue:0)

//遍历
var array06 : Array<Int> = [11,12,13,14,15,16,17,18,19,20]
for i in array06{
    print(i)
}

//遍历时拿到索引值
for (index, item) in array06.enumerate(){
    print("index = \(index), item = \(item)")
}

//获取元素
array06[1]
array06[2]

//添加元素

//1.不能向不可变数组中添加元素
let arrayLet = [0,1,2]
//arrayLet.append(3)

var arrayVar = [0,1,2]
arrayVar.append(3)

// 数组可以存放任意类型
var arrayM1 = ["lnj", "lmj", 123]
arrayM1.append("456")

// 如果需要添加其它类型必须提前声明为AnyObject
var arrayM2 : [AnyObject] = [AnyObject]()
//var arrayM : [String] = [String]()
arrayM2.append(123)

// 合并数组
var arrayM3 = ["zs", "ls", "ww", "zl"]
var arrayM4 = ["ab"]
arrayM4 += arrayM3

// 只有相同类型的数组才可以合并
//arrayM1 += arrayM3
print(arrayM1.count)

// 和区间搭配使用
arrayM4 += arrayM3[0...2]
print(arrayM4.count)

// 删除
arrayM4.removeAtIndex(1)
arrayM4

// 删除所有
//arrayM3.removeAll()

// 和区间搭配使用
//arrayM3.removeRange(Range(start: 0, end: 2))
arrayM4.removeRange(0..<2) // 其实Range就是半闭区间
arrayM3


// 删除并保留容量
arrayM3.removeAll(keepCapacity: true)
arrayM3.capacity
arrayM3.append("1")
arrayM3.capacity
arrayM3.append("2")
arrayM3.capacity
arrayM3.append("3")
arrayM3.capacity
arrayM3.append("4")
arrayM3.capacity
arrayM3.append("5")
// 超过容量, 容量会直接*2
arrayM3.capacity
/**************************************************************/


/**************************************************************/
/*:
 字典(无序数据集)
 * Swift 的Dictionary类型被桥接到Foundation的NSDictionary类。
 * 格式 [:] / Dictionary<Key, Value>
 * let 不可变字典
 * var 可变字典
 
 注意：
 * 一个字典的Key类型必须遵循Hashable协议
 */


// 创建一个空字典
var dict3: [String: AnyObject]

dict3 = [:]
var dict4 = [String: AnyObject]()

// 创建一个带有默认值字典
var dict5 = ["name": "lnj", "age": 30]

// 最常见的字典类型[String : AnyObject], 例如JSON
var dict = ["name":"lnj", "age": 30]

// 遍历字典
// k,v 可以随便写, 前面是key后面是value
for (key, value) in dict{
    print(key)
    print(value)
}

// 获取元素
dict["name"]

// 添加元素
// 如果key不存在会新增
dict["gender"] = "man"
dict

// 替换元素
// 如果key存在会替换
dict["name"] = "why"

// 删除元素
dict.removeValueForKey("name")
dict

// 合并字典
var dict2 = ["score": 123]
for (k, v) in dict2{
    dict[k] = v
}
dict
/**************************************************************/


/******************************************************/
/*:
 字符串
 * Swift 的String类型与 Foundation NSString类进行了无缝桥接
 * OC语言中的字符串也是以\0结尾, Swift不是
 * OC中字符串是一个对象, Swift中使用String是一个结构体,效率更高, 支持遍历
 注意
 * Swift 的String类型是值类型。 如果您创建了一个新的字符串，那么当其进行常量、变量赋值操作，或在函数/方法中传递时，会进行值拷贝。 任何情况下，都会对已有字符串值创建新副本，并对该新副本进行传递或赋值操作
 */

var string00:String = "abc\0def"
print(string00)
var string01:NSString = "abc\0def"
print(string01)

//遍历字符串
let string02 = "思琦很帅"
for c in string02.characters{
    print(c)
}

//字符串的拼接
let string04 = "siqi"
let string05 = "love"
let sumString = string04 + string05

//字符串插值
let string06 : Int?  = 18
let string07 = "zsq"
// 拼接字符串的时如果字符串是可选类型，要特别注意，会带上 Optional
let string08 = "age = \(string06!), name = \(string07)"


//当字符串要遵从某个特定格式时
let string09 = String(format: "%02d %02d %02d", arguments:[1,2,3])


//字符串截取
let string10 = "zsqcool"

//转换为NSString类型后截取
//方式一
let string11:NSString = string10
string11.substringToIndex(3)
//方式二
let string12 = string10 as NSString
string12.substringFromIndex(3)

//使用String类型的索引截取
//使用startIndex属性可以获取一个String的第一个Character的索引
//使用endIndex属性可以获取最后一个Character的后一个位置的索引
let string13 = string10.substringToIndex(string10.startIndex.advancedBy(3))
let string14 = string10.substringFromIndex(string10.endIndex.advancedBy(-4))

//该方法在swift3中被弃用
//let range0 = Range(start: string10.startIndex, end:string10.endIndex.advancedBy(-4))
//推荐使用该方法
let range = Range(string10.startIndex ..< string10.endIndex.advancedBy(-4) )
let string15 = string10.substringWithRange(range)
/******************************************************/


/******************************************************/
/*:
 函数:
 * 函数是用来完成特定任务的独立的代码块。你给一个函数起一个合适的名字，用来标识函数做什么，并且当函数需要执行的时候，这个名字会被用于“调用”函数
 * 格式:
 * func 函数名称(参数名:参数类型, 参数名:参数类型...) -> 函数返回值 {函数实现部分}
 */

/*
 没有参数没有返回值
 1. 可以写为 ->Void
 2. 可以写为 ->()
 3. 可以省略
 * Void。它其实是一个空的元组（tuple），没有任何元素，可以写成()
 */

//声明没有参数没有返回值类型的函数
//方式1
func myFunc01() -> Void{
    print("Hello,World")
}
myFunc01()

//方式2
func myFunc02() -> (){
    print("Hello,World")
}
myFunc02()

//方式3
func myFunc03(){
    print("Hello,World")
}
myFunc03()


/*:
 有参数没有返回值
 
 内部/外部参数
 * 内部参数: Swift2.0以前, 默认情况下的参数都是内部参数
 *          Swift2.0开始, 默认将第二个参数名称作为外部参数
 * 如果没有明确地指定外部参数, 那么系统默认会从第二个参数开始, 将参数的名称作为外部参数
 * 外部参数只能外部用, 函数内部不能使用, 函数内部只能使用内部参数
 * 忽略外部参数: 在内部参数前加_
 * Swift2.0之前, 默认是不会将第二个参数开始的参数名称作为外部参数的, 必须自己手动指定
 */
func myFunc04( i:Int, j:Int ){
    print(i + j)
}
myFunc04(10, j: 20)

func myFunc05( i:Int, _ j:Int){
    print( i + j)
}
myFunc05(20, 20)

//xy为外部参数,ab为内部参数
func myFunc06(x a:Int, y b:Int){
    print(a + b)
}
myFunc06(x: 10, y: 20)

/*:
 没有参数有返回值
 */
func myFunc07() ->(Int,Double){
    return (100, 100.2)
}
myFunc07()

func myFunc08() -> Int{
    return 100
}
myFunc08()

/*:
 有参数有返回值
 */
func myFunc09(x a:Int, y b:Int) -> (Int, Double){
    return (a + b, Double(a + b) / 3.0)
}
myFunc09(x: 10, y: 12)

/*:
 默认参数（Default Parameter Values）
 * 格式: func method(parameter: Int = 0){}
 * 当默认值被定义后，调用这个函数时可以忽略这个参数
 * 其它语言的默认参数必须写在最后面, Swift可以写在任意位置
 
 注意
 * 将带有默认值的参数放在函数参数列表的最后。这样可以保证在函数调用时，非默认参数的顺序是一致的，同时使得相同的函数在不同情况下调用时显得更为清晰。
 */

func loveFunc(nameA a:String, action what:String = "love", nameB b:String){
    print(a + what + b)
}
loveFunc(nameA: "zsq", nameB: "sq")
loveFunc(nameA: "zsq", action: "memeda", nameB: "sq")

/*:
 常量参数和变量参数（Constant and Variable Parameters）
 * 函数参数默认是常量, 在函数内部不能修改
 * 如果想在函数中修改参数, 必须在参数前加上var
 
 注意
 * 对变量参数所进行的修改在函数调用结束后便消失了，并且对于函数体外是不可见的。变量参数仅仅存在于函数调用的生命周期中
 */
func myFunc10(let name1 a:String, let name2 b:String ) -> String{
    return a + b
}
myFunc10(name1: "zsq", name2: "sq")

var number001 = 10
var number002 = 20

//func mySwapFunc01(number1 a:Int, number2 b:Int) {
//    let temp = a
//    a = b
//    b = temp
//}

//关键字var在swift3中取消了
//func mySwapFunc02(var number1 a:Int, var number2 b:Int) {
//    let temp = a
//    a = b
//    b = temp
//}


/*:
 输入输出参数（In-Out Parameters）
 * 变量参数，正如上面所述，仅仅能在函数体内被更改。如果你想要一个函数可以修改参数的值，并且想要在这些修改在函数调用结束后仍然存在，那么就应该把这个参数定义为输入输出参数（In-Out Parameters）
 * 定义一个输入输出参数时，在参数定义前加 inout 关键字
 
 注意
 * 输入输出参数不能有默认值，而且可变参数不能用 inout 标记。如果你用 inout 标记一个参数，这个参数不能被 var 或者 let 标记。
 */

func mySwapFunc03(inout value1:Int, inout value2:Int){
    print("交互前: value1 = \(value1), value2 = \(value2)")
    let temp = value1
    value1 = value2
    value2 = temp
    print("交互前: value1 = \(value1), value2 = \(value2)")

}
mySwapFunc03(&number001, value2: &number002)
number001
number002

/*:
 可变参数（Variadic Parameters）
 * 一个可变参数可以接收零个或多个值
 * 如果没有变参函数 , 并且函数的参数个数又不确定那么只能写多个方法或者用将函数参数改为集合
 * 格式 func method(parameter: Int...){}
 * 可变参数在函数中可以当做一个数组
 
 注意
 * 一个函数最多只能有一个可变参数
 * 变参只能是同种类型的数据
 * 变参必须指定数据类型
 * 如果函数有一个或多个带默认值的参数，而且还有一个可变参数，那么把可变参数放在参数表的最后
 */

func add(numbers: Int...) -> Int{
    var sum = 0
    for number in numbers{
        sum += number
    }
    return sum
}
add(1,12,2,334)

/*
 函数的嵌套使用(了解即可)
 swift中函数可以嵌套使用
 即函数中包含函数,但是不推荐该写法
 函数的嵌套
 */
let newValue = 55
func test() {
    func demo() {
        print("demo \(newValue)")
    }
    
    print("test")
    demo()
}

//demo() // 错误
test()

/******************************************************/
