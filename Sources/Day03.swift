import Algorithms

struct Day03: AdventDay {
  var data: String

  var entities: [[Int]] {
    data
      .split(separator: "\n")
      .map {
        $0
          .compactMap { Int(String($0)) }
      }
  }

  func part1() -> Any {
    var rowJoltage: [Int] = []

    for row in entities {
      rowJoltage.append(maxJoltageForRow(row))
    }

    return rowJoltage.reduce(0, +)
  }

  func maxJoltageForRow(_ row: [Int]) -> Int {
    // Value: Indexes,
    let position: [Int: [Int]] = row.enumerated().reduce(into: [:]) { result, pair in
      result[pair.element, default: []].append(pair.offset)
    }

    firstDigit: for firstDigit in (0...9).reversed() {
      guard let firstDigitIndexes = position[firstDigit] else {
        continue
      }


      secondDigit: for secondDigit in (0...9).reversed() {
        guard let secondDigitIndexes = position[secondDigit] else {
          continue secondDigit
        }

        for firstIndex in firstDigitIndexes {
          if secondDigitIndexes.contains(where: { $0 >= firstIndex + 1 }) {
            return firstDigit * 10 + secondDigit
          }
        }
      }
    }

    fatalError()
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    // Sum the maximum entries in each set of data
    entities.map { $0.max() ?? 0 }.reduce(0, +)
  }
}
