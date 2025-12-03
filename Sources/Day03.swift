import Algorithms
import Foundation

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
      rowJoltage.append(maxJoltageForRowPart1(row))
    }

    return rowJoltage.reduce(0, +)
  }

  func maxJoltageForRowPart1(_ row: [Int]) -> Int {
    // Value: Indexes
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

  func part2() -> Any {
    var rowJoltage: [Int] = []

    for row in entities {
      rowJoltage.append(maxJoltageForRowPart2(row))
    }

    return rowJoltage.reduce(0, +)
  }

  func maxJoltageForRowPart2(_ row: [Int]) -> Int {
    // we search in a sliding window.
    // if we have 12 digits to pick, and the entire number is 16 digits,
    // it's always best to pick the biggest digit we can find in the first 4 digits.
    // then, we find the remaining 11 in the window created by adjusting the window ends
    var remainingDigits = 12
    var maxJoltage: Int = 0

    var sliceToSearch = 0...row.count - remainingDigits

    while remainingDigits > 0 {
      let (digit, index) = findBestDigit(row, range: sliceToSearch)

      maxJoltage += digit * Int(pow(10.0, Double(remainingDigits - 1)))
      
      remainingDigits -= 1

      sliceToSearch = index + 1 ... (row.count - remainingDigits)
    }

    return maxJoltage
  }

  private func findBestDigit(_ row: [Int], range: ClosedRange<Int>)
  -> (Int, Int) {
    let highestInRange = row[range].max()!

    return (highestInRange, row[range].firstIndex(of: highestInRange)!)
  }
}
