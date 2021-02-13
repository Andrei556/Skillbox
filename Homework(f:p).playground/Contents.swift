
import Foundation

// 3. Отсортируйте массив чисел по возрастанию, используя функцию Sorted

var age = [14,30,16,44,21,66]
print(age.sorted())

// 4. Переведите массив чисел в массив строк с помощью функции Map.

let stringArray = age.map { String($0) }
print(stringArray)

// 5. Переведите массив строк с именами людей в одну строку, содержащую все эти имена, с помощью функции Reduce

var names = ["Andrey","Anton","Alexander","Sergey"]
var namesString =  names.map{$0 + " "}.reduce("", +)
print(namesString)

// 6. Напишите функцию, которая принимает в себя функцию c типом (Void) -&gt; Void, которая будет вызвана с задержкой в две секунды

func asyncAfterTwoSec(_ workItem: () -> Void) {
    print("hello")
}

DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {

    asyncAfterTwoSec {
        print("hello")
    }
}

// 7. Напишите функцию, которая принимает в себя две функции и возвращает функцию, которая при вызове выполнит первые две функции.

func printTextOne() {
    print("Функция 1 вызвана")
}

func printTextTwo() {
     print("Функция 2 вызвана")
    return printTextOne()
 }

func carry(_ a: @escaping () -> Void, _ b: @escaping () -> Void) -> (() -> Void) {
    printTextTwo
}

let newFunctionInLet = carry { printTextOne() } _: { printTextTwo() }
newFunctionInLet()

// 8. Напишите функцию, которая сортирует массив по переданному алгоритму: принимает в себя массив чисел и функцию, которая берёт на вход два числа, возвращает Bool (должно ли первое число идти после второго) и возвращает массив, отсортированный по этому алгоритму

func sorted(_ numberOne: Int, _ numberTwo: Int) -> Bool {
    return numberOne <= numberTwo
}

var numbers = [4,2,5,7,1,3,6]

func sortedArray(_ numbers:inout [Int], _ selector:(_ numberOne: Int, _ numberTwo: Int) -> Bool) -> [Int] {
    let size = numbers.count
    for i in 0..<size{
        let a = (size-1) - i
        for j in 0..<a{
            if selector(numbers[j + 1], numbers[j]){
                let t = numbers[j]
                numbers[j] = numbers[j + 1]
                numbers[j + 1] = t
            }
        }
    }
    return numbers
}

sortedArray(&numbers, sorted)
