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
    false
  }
}
