//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//析构器只适用于类类型，当一个类的实例被释放之前，析构器会被立即调用。析构器用关键字deinit来标示，类似于构造器要用init来标示。


/**
  * 析构过程原理
  */
//Swift 会自动释放不再需要的实例以释放资源。如自动引用计数章节中所讲述，Swift 通过自动引用计数（ARC）处理实例的内存管理。通常当你的实例被释放时不需要手动地去清理。但是，当使用自己的资源时，你可能需要进行一些额外的清理。例如，如果创建了一个自定义的类来打开一个文件，并写入一些数据，你可能需要在类实例被释放之前手动去关闭该文件。

//在类的定义中，每个类最多只能有一个析构器，而且析构器不带任何参数，如下所示：

//deinit {
//    // 执行析构过程
//}

//析构器是在实例释放发生前被自动调用。你不能主动调用析构器。

//子类继承了父类的析构器，并且在子类析构器实现的最后，父类的析构器会被自动调用。
//即使子类没有提供自己的析构器，父类的析构器也同样会被调用。
//因为直到实例的析构器被调用后，实例才会被释放，所以析构器可以访问实例的所有属性，并且可以根据那些属性可以修改它的行为（比如查找一个需要被关闭的文件）。


/**
 * 析构器实践
 */

//这是一个析构器实践的例子。这个例子描述了一个简单的游戏，这里定义了两种新类型，分别是Bank和Player。Bank类管理一种虚拟硬币，确保流通的硬币数量永远不可能超过 10,000。在游戏中有且只能有一个Bank存在，因此Bank用类来实现，并使用静态属性和静态方法来存储和管理其当前状态。
class Bank {
    static var coinsInBank = 10_000
    static func vendCoins(numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receiveCoins(coins: Int) {
        coinsInBank += coins
    }
}

//Bank使用coinsInBank属性来跟踪它当前拥有的硬币数量。Bank还提供了两个方法，vendCoins(_:)和receiveCoins(_:)，分别用来处理硬币的分发和收集。

//vendCoins(_:)方法在Bank对象分发硬币之前检查是否有足够的硬币。如果硬币不足，Bank对象会返回一个比请求时小的数字（如果Bank对象中没有硬币了就返回0）。vendCoins方法返回一个整型值，表示提供的硬币的实际数量。

//receiveCoins(_:)方法只是将Bank对象接收到的硬币数目加回硬币存储中。

//Player类描述了游戏中的一个玩家。每一个玩家在任意时间都有一定数量的硬币存储在他们的钱包中。这通过玩家的coinsInPurse属性来表示：
class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.vendCoins(coins)
    }
    func winCoins(coins: Int) {
        coinsInPurse += Bank.vendCoins(coins)
    }
    deinit {
        Bank.receiveCoins(coinsInPurse)
    }
}

//每个Player实例在初始化的过程中，都从Bank对象获取指定数量的硬币。如果没有足够的硬币可用，Player实例可能会收到比指定数量少的硬币.

//Player类定义了一个winCoins(_:)方法，该方法从Bank对象获取一定数量的硬币，并把它们添加到玩家的钱包。Player类还实现了一个析构器，这个析构器在Player实例释放前被调用。在这里，析构器的作用只是将玩家的所有硬币都返还给Bank对象：
var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// 打印 "A new player has joined the game with 100 coins"
print("There are now \(Bank.coinsInBank) coins left in the bank")
// 打印 "There are now 9900 coins left in the bank"

playerOne!.winCoins(2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
// 输出 "PlayerOne won 2000 coins & now has 2100 coins"
print("The bank now only has \(Bank.coinsInBank) coins left")
// 输出 "The bank now only has 7900 coins left"


playerOne = nil
print("PlayerOne has left the game")
// 打印 "PlayerOne has left the game"
print("The bank now has \(Bank.coinsInBank) coins")
// 打印 "The bank now has 10000 coins"