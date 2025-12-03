import Algorithms

struct Day02: AdventDay {
  var data: String

  var entities: [ClosedRange<Int>] {
    data
      .filter { !$0.isWhitespace }
      .split(separator: ",")
      .map {
        let ranges = $0.split(separator: "-")
        let lowerBound = Int(String(ranges[0]))
        let upperBound = Int(String(ranges[1]))

        return lowerBound!...upperBound!
      }
  }

  func part1() -> Any {
    var candidates: [Int] = []

    for range in entities {
      for number in range {
        let string = String(number)
        if string.count % 2 != 0 {
          continue
        }
        
        let firstHalf = string[string.startIndex..<string.index(string.startIndex, offsetBy: string.count / 2)]
        let secondHalf = string[string.index(string.startIndex, offsetBy: string.count / 2)...]

        if firstHalf == secondHalf {
          candidates.append(number)
        }

      }
    }

    return candidates.reduce(0, +)
  }

  func part2() -> Any {
    return false
  }
}
