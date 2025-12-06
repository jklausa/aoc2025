import Algorithms

struct Day06: AdventDay {
  var data: String

  var entities: [[Substring.SubSequence]] {
    let lines = data.split(separator: "\n")
    let columns = lines.map { $0.split(separator: " ") }

    return columns
  }

  enum Operation {
    case multiplication
    case addition
  }

  func part1() -> Any {
    let operations: [Operation] = entities.last!.compactMap {
      if $0.contains("*") {
        return .multiplication
      } else if $0.contains("+") {
        return .addition
      } else {
        return nil
      }
    }

    var results: [Int] = []

    for (lineIdx, line) in entities.dropLast().enumerated() {
      for (columnIdx, column) in line.enumerated() {
        let number = Int(String(column.trimmingCharacters(in: .whitespaces)))!
        if lineIdx == 0 {
          results.append(number)
          continue
        }

        results[columnIdx] = if operations[columnIdx] == .multiplication {
          results[columnIdx] * number
        } else {
          results[columnIdx] + number
        }
      }
    }

    return results.reduce(0, +)
  }

  struct Problem {
    var operation: Operation
    var numbers: [Int]
  }

  func part2() -> Any {
    var problems: [Problem] = []
    let lines = data.split(separator: "\n")

    let longestLine = lines.map(\.count).max()

    var numbersForCurrentProblem = [Int]()

    for columnIndex in stride(from: longestLine! - 1, through: 0, by: -1) {
      let charactersAtIndex = lines
        .map(Array.init)
        .compactMap {
          if $0.indices.contains(columnIndex) {
            $0[columnIndex]
          } else {
            nil
          }
        }


      if charactersAtIndex.allSatisfy({ $0.isWhitespace }) {
        continue
      }

      let number = Int(String(charactersAtIndex.filter { $0.isNumber }))!
      
      numbersForCurrentProblem.append(number)

      if charactersAtIndex.last == "*" {
        problems
          .append(
            .init(operation: .multiplication, numbers: numbersForCurrentProblem)
          )
        numbersForCurrentProblem = []
      } else if charactersAtIndex.last == "+" {
        problems
          .append(
            .init(operation: .addition, numbers: numbersForCurrentProblem)
          )
        numbersForCurrentProblem = []
      }

    }

    return problems
      .map {
        if Operation.multiplication == $0.operation {
          return $0.numbers.reduce(1, *)
        } else {
          return $0.numbers.reduce(0, +)
        }
      }
      .reduce(0, +)

  }
}
