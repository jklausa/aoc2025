import Algorithms

struct Day04: AdventDay {
  var data: String

  enum Cell {
    case emptySpace
    case roll
  }

  var entities: [[Cell]] {
    data
      .split(separator: "\n")
      .map {
        $0.compactMap {
          if $0 == "." {
            return .emptySpace
          } else if $0 == "@" {
            return .roll
          } else {
            return nil
          }
      }
    }
  }

  struct Point: Hashable {
    var row: Int
    var column: Int
  }


  func part1() -> Any {
    let map = entities
    var accessiblePoints: Set<Point> = []


    for (rowIndex, row) in map.enumerated() {
      for (columnIndex, column) in row.enumerated() {
        // empty space can't be picked up
        if column == .emptySpace { continue }

        let up = rowIndex > 0 ? map[rowIndex - 1][columnIndex] : .emptySpace
        let down = rowIndex < map.count - 1 ? map[rowIndex + 1][columnIndex] : .emptySpace
        let left = columnIndex > 0 ? map[rowIndex][columnIndex - 1] : .emptySpace
        let right = columnIndex < row.count - 1 ? map[rowIndex][columnIndex + 1] : .emptySpace
        let topLeft = rowIndex > 0 && columnIndex > 0 ? map[rowIndex - 1][columnIndex - 1] : .emptySpace
        let topRight = rowIndex > 0 && columnIndex < row.count - 1 ? map[rowIndex - 1][columnIndex + 1] : .emptySpace
        let bottomLeft = rowIndex < map.count - 1 && columnIndex > 0 ? map[rowIndex + 1][columnIndex - 1] : .emptySpace
        let bottomRight = rowIndex < map.count - 1 && columnIndex < row.count - 1 ? map[rowIndex + 1][columnIndex + 1] : .emptySpace

        let neighbors: [Cell] = [up, down, left, right, topLeft, topRight, bottomLeft, bottomRight]
        let rollsCount = neighbors.filter { $0 == .roll }.count

        if rollsCount < 4 {
          accessiblePoints.insert(Point(row: rowIndex, column: columnIndex))
        }
      }
    }

    return accessiblePoints.count
  }

  func part2() -> Any {
    return 0
  }
}
