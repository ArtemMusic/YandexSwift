//В далекой-далекой галактике в одном году N месяцев, в i-м из которых Di дней. В одной неделе там не 7, а целых L дней, пронумерованных от 1 до L. Недавно вы узнали, что в день d2 месяца m2 года y2 произошло уникальное солнечное затмение. Вы захотели узнать, на какой день недели пришлось затмение, однако, изучив все доступные вам источники, не смогли найти ответ на этот вопрос. Из-за этого вам самим придется вычислить этот день, основываясь на информации, которую вы знаете про сегодняшний день: сегодня d1-й день m1-го месяца y1-го года и t1-й день недели.

//Формат ввода:
//В первой строке ввода находятся два целых числа N и L(1<=N<=10(в степени 5),1<=L<=10(в степени 9)) — количество месяцев в году и количестводнейв неделе соответственно.В следующей строке находятся N целых чисел, i-е из которых равно Di(1<=Di<=10(в степени 5)) — количество дней в i-м месяце.

//В третьей строке ввода находятся 4 целых числа, разделенные пробелами: d1,m1,y1 и t1(1<=y1<=10(в степени 5),1<=m1<=N,1<=d1<=Dm1,1<=t1<=L) — день, месяц и год сегодняшнего дня, а также сегодняшний день недели.В четвертой строке ввода находятся 3 целых числа, задающих интересующую вас дату:d2,m2,y2(1<=y2<=10(в степени 5),1<=m2<=N,1<=d2<=Dm2) — день, месяц и год интересного вам дня.

//Формат вывода:
//Выведите единственное число — номер дня недели, на который пришлось затмение.

//Примечания:
//В первом тесте в одном году суммарно девять дней, поэтому, если год 1 начинается с дня недели 1, то и год 12 начинается с дня недели 1. Второй месяц года 12 начинается с дня недели 2, так как в первом месяце года 4 дня. Значит, солнечное затмение, произошедшее в третий день второго месяца года 12 пришлось на первый день недели.

import Foundation

func main() {
    // Чтение количества месяцев в году и количества дней в неделе
    let firstLine = readLine() ?? ""
    let inputs = firstLine.split(separator: " ").map { Int($0) ?? 0 }
    
    let L = inputs[1]
    
    // Чтение количества дней в каждом месяце
    let daysInput = readLine() ?? ""
    let daysInMonth = daysInput.split(separator: " ").map { Int($0) ?? 0 }
    
    // Чтение текущей даты и дня недели
    let dateInput = readLine() ?? ""
    let dateInputs = dateInput.split(separator: " ").map { Int($0) ?? 0 }
    
    let d1 = dateInputs[0]
    let m1 = dateInputs[1]
    let y1 = dateInputs[2]
    let t1 = dateInputs[3]
    
    // Чтение даты затмения
    let eclipseDateInput = readLine() ?? ""
    let eclipseDateInputs = eclipseDateInput.split(separator: " ").map { Int($0) ?? 0 }
    
    let d2 = eclipseDateInputs[0]
    let m2 = eclipseDateInputs[1]
    let y2 = eclipseDateInputs[2]
    
    // для вычисления общего количества дней с начала года до заданной даты
    func daysFromStartOfYear(day: Int, month: Int, year: Int) -> Int {
        var days = (year - 1) * daysInMonth.reduce(0, +)
        for i in 0..<month - 1 {
            days += daysInMonth[i]
        }
        days += day
        return days
    }
    
    let daysCurrentDate = daysFromStartOfYear(day: d1, month: m1, year: y1)
    let daysEclipseDate = daysFromStartOfYear(day: d2, month: m2, year: y2)
    
    let dayDifference = daysEclipseDate - daysCurrentDate
    
    // номер дня недели на который пришлось затмение
    let eclipseDayOfWeek = ((t1 + dayDifference - 1) % L + L) % L + 1
    
    print(eclipseDayOfWeek)
}

main()
