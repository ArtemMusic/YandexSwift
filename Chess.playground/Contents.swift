//Однажды мальчик Петя стал чемпионом Вселенной по шахматам, и он решил, что эта игра слишком простая для него. Поэтому он решил играть не на поле 8×8, а на поле 10(в степени 9)×(в степени 9). Прежде чем начать всех побеждать и здесь, он решил начать с чего-то простого. Для начала он расставил N пешек на этом поле. Затем он решил Q раз представить (то есть один запрос не влияет на все последующие), что на клетке (x,y) стоит одна из шахматных фигур и узнать, сколько пешек она бьет. Он, конечно, с этой задачей справился, а вы справитесь?

//Обратите внимание как ходят фигуры.
//Фигура слон бьет все пешки, которые с ней находятся на одной диагонали.
//Фигура ладья бьет все пешки, которые с ней находятся в одной строке или в одном столбце.
//Фигура конь бьет все пешки, которые находятся либо в двух клетках по горизонтали и одной по вертикали, либо в двух клетках по вертикали и одной по горизонтали.
//Фигура пешка бьет все пешки, которые находятся в следующей строке и в соседнем столбце.
//Фигура ферзь бьет одновременно как слон и ладья.

//Важно, что фигуры могут бить пешки насквозь, то есть, если на пути от фигуры до пешки стоит другая пешка, то она все равно бьет первую пешку.

//Формат ввода:
//В первой строке вводится целое число N (1<=N<=10(в степени 5)) — количество пешек на поле.В следующих Nстроках находятся по два целых числа xi,yi(1<=xi,yi<=10(в степени 9))— координаты клетки, где находится i-я пешка. Гарантируется, что нет двух пешек, которые находятся в однойклетке. Клетка с координатами (1,1) соответствует нижнему левому углу поля. Ось Ox направлена вдоль нижней стороны поля, ось Oy направлена вдоль левой стороны поля.В следующей строке вводится количество запросов Q (1<=Q<=10(в степени 5)).В i-й из следующих QQ строк находится i-й запрос. Он состоит из символа t и двух целых чиселxx и yy (1<=x,y<=10(в степени 9)), где x,y — координаты, на которые мы предположительно ставим фигуру, а t — заглавная буква английского алфавита, описывающая тип фигуры (K— конь, P — пешка, B — слон, Q—ферзь, R — ладья). Гарантируется, что в клетке (x,y) изначально не стоит пешка.

//Формат вывода:
//Для каждого запроса выведите количество пешек, которые будет бить фигура из запроса.


import Foundation

// Чтение входных данных
func readInts() -> [Int] {
    return readLine()!.split(separator: " ").map { Int($0)! }
}

let N = readInts()[0]
var pawns = [(Int, Int)]()

// Данные о пешках
var rowDict = [Int: Set<Int>]()
var colDict = [Int: Set<Int>]()
var diag1Dict = [Int: Set<Int>]() // x - y
var diag2Dict = [Int: Set<Int>]() // x + y

for _ in 0..<N {
    let pos = readInts()
    let x = pos[0]
    let y = pos[1]
    pawns.append((x, y))
    
    rowDict[x, default: Set()].insert(y)
    colDict[y, default: Set()].insert(x)
    diag1Dict[x - y, default: Set()].insert(x)
    diag2Dict[x + y, default: Set()].insert(x)
}

let Q = readInts()[0]

func countPawnsInRowAndCol(x: Int, y: Int) -> Int {
    let rowPawns = rowDict[x]?.count ?? 0
    let colPawns = colDict[y]?.count ?? 0
    return rowPawns + colPawns
}

func countPawnsInDiagonal(x: Int, y: Int) -> Int {
    let diag1Pawns = diag1Dict[x - y]?.count ?? 0
    let diag2Pawns = diag2Dict[x + y]?.count ?? 0
    return diag1Pawns + diag2Pawns
}

func isPawnAt(x: Int, y: Int) -> Bool {
    return pawns.contains(where: { $0.0 == x && $0.1 == y })
}

for _ in 0..<Q {
    let query = readLine()!.split(separator: " ")
    let piece = String(query[0])
    let x = Int(query[1])!
    let y = Int(query[2])!

    switch piece {
    case "P":
        // Пешка
        let count = isPawnAt(x: x, y: y + 1) ? 0 : 1
        print(count)
    case "K":
        // Конь
        let knightMoves = [
            (x + 2, y + 1), (x + 2, y - 1),
            (x - 2, y + 1), (x - 2, y - 1),
            (x + 1, y + 2), (x + 1, y - 2),
            (x - 1, y + 2), (x - 1, y - 2)
        ]
        let count = knightMoves.filter { isPawnAt(x: $0.0, y: $0.1) }.count
        print(count)
    case "B":
        // Слон
        let count = (diag1Dict[x - y]?.count ?? 0) + (diag2Dict[x + y]?.count ?? 0)
        print(count)
    case "R":
        // Ладья
        let count = countPawnsInRowAndCol(x: x, y: y) - (isPawnAt(x: x, y: y) ? 1 : 0)
        print(count)
    case "Q":
        // Ферзь
        let count = (countPawnsInRowAndCol(x: x, y: y) + countPawnsInDiagonal(x: x, y: y)) - (isPawnAt(x: x, y: y) ? 1 : 0)
        print(count)
    default:
        break
    }
}
