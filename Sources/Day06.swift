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

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    return 0
    // Sum the maximum entries in each set of data
//    entities.map { $0.max() ?? 0 }.reduce(0, +)
  }
}
