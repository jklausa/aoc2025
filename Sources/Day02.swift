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
    var candidates: [Int] = []

    for range in entities {
      for number in range {
        let string = String(number)

        // it's only possible for the pattern to be repeating, if it takes half (or less)
        // of the entire string, otherwise it won't be able to repeat.
        let maximalLength = string.count / 2

        for currentLength in stride(from: 1, through: maximalLength, by: 1) {
          // then we iterate over possible prefix lengths to see if they are repeating.
          let prefix = string[string.startIndex ..< string.index(string.startIndex, offsetBy: currentLength)]

          // if after removing the occurences of the patern there's only empty string left, that means that the pattern is repeating
          // and we got a match.
          let result = string.replacingOccurrences(of: prefix, with: "")

          if result.isEmpty {
            candidates.append(number)
            break
          }
        }
      }
    }

    return candidates.reduce(0, +)
  }
}
