import Algorithms

struct Day05: AdventDay {
  var data: String

  var entities: ([ClosedRange<Int>], [Int]) {
    let sections = data.split(separator: "\n\n")

    let ranges = sections.first?.split(separator: "\n").map {
      let bounds = $0.split(separator: "-").compactMap { Int(String($0)) }
      return bounds.first! ... bounds.last!
    }

    let ids = sections.last?.split(separator: "\n").compactMap { Int(String($0)) }

    return (ranges ?? [], ids ?? [])
  }

  func part1() -> Any {
    let (ranges, ids) = self.entities

    var validIDs: Set<Int> = []
    for id in ids {
        for range in ranges {
        if range.contains(id) {
          validIDs.insert(id)
          break
        }
      }
    }

    return validIDs.count
  }

  func part2() -> Any {
    let (ranges, _) = self.entities

    var rangesToProcess = ranges
    var deduplicatedRanges: [ClosedRange<Int>] = []

    while true {
      var anyRemaining = false

      for i in rangesToProcess.indices {
        let currentRange = rangesToProcess[i]
        let overlapping = deduplicatedRanges.firstIndex {
          $0.overlaps(currentRange)
        }

        if let overlapping {
          let lowerBound = min(deduplicatedRanges[overlapping].lowerBound, currentRange.lowerBound)
          let upperBound = max(deduplicatedRanges[overlapping].upperBound, currentRange.upperBound)
          deduplicatedRanges[overlapping] = lowerBound ... upperBound

          anyRemaining = true
        } else {
          deduplicatedRanges.append(currentRange)
        }
      }

      if anyRemaining == false {
        break
      } else {
        rangesToProcess = deduplicatedRanges
        deduplicatedRanges = []
        anyRemaining = false
      }
    }

    return deduplicatedRanges.reduce(0) {
      return $0 + ($1.upperBound - $1.lowerBound) + 1
    }
  }
}
