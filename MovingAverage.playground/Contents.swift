//Скоро Новый год, а значит купить много салютов», — так подумал мальчик Саша. Новый год — это важный праздник, поэтому одного салюта мало,и Саша решил купить K штук. В магазине продаются N видов салюта, при этом у i-го салюта высота, на которой он взрывается, равна hi.
//По мнению Саши, чем больше разброс по высоте, тем хуже выглядят взрывы, поэтому он хочет, чтобы разность между максимальной и минимальной высотой салютов была минимальна. Также ему очень нравится, как взрывается салют под номером t, поэтому он его обязательно купит. Помогите Саше посчитать, какую минимальную разность высот он может получить.

//Формат ввода:
//В первой строке находятся три целых числа N,K,t(1<=K,t<=N≤10(в степени5)), где N — количество салютов, которые есть в магазине, K — число салютов, которое нужно купить, t — номер салюта, который точно необходимо купить.В i-й из следующих N строк находится единственное число hi(1<=hi<=10(в степени 9)) — высота, на которой взрывается i-й фейерверк.

//Формат вывода:
//Выведите минимальную разность, которую можно получить.

import Foundation

func findMinDifference(N: Int, K: Int, t: Int, heights: [Int]) -> Int {
    let targetIndex = t - 1
    let targetHeight = heights[targetIndex]
    
    var otherHeights = [Int]()
    
    // высоты всех фейерверков, кроме обязательного
    for i in 0..<N {
        if i != targetIndex {
            otherHeights.append(heights[i])
        }
    }
    
    otherHeights.sort()
    
    var minDiff = Int.max
    
    // скользящее окно
    var left = 0
    let totalHeights = otherHeights.count
    let windowSize = K - 1
    
    for right in windowSize-1..<totalHeights {
        if right - left + 1 == windowSize {
            let minHeight = otherHeights[left]
            let maxHeight = otherHeights[right]
            let currentDiff = max(maxHeight, targetHeight) - min(minHeight, targetHeight)
            minDiff = min(minDiff, currentDiff)
            left += 1
        }
    }
    
    return minDiff
}

if let input = readLine() {
    let parts = input.split(separator: " ").map { Int($0)! }
    let N = parts[0]
    let K = parts[1]
    let t = parts[2]
    
    var heights = [Int]()
    for _ in 0..<N {
        if let height = Int(readLine()!) {
            heights.append(height)
        }
    }
    
    let result = findMinDifference(N: N, K: K, t: t, heights: heights)
    print(result)
}
