import Algorithms

struct Day01: AdventDay {
  var data: String

  var entities: [Move] {
    data
      .split(separator: "\n")
      .map {
        var mutableInput = $0
        let direction = mutableInput.popFirst()

        if direction == "L" {
          return Move.left(Int(String(mutableInput))!)
        } else {
          return Move.right(Int(String(mutableInput))!)
        }
      }
  }

  enum Move {
    case left(Int)
    case right(Int)

    var value : Int {
      switch self {
      case .left(let value):
        return -value
      case .right(let value):
        return value
      }
    }
  }

  func part1() -> Any {
    var currentValue = 50
    var counter = 0

    for entity in entities {
      var newValue = currentValue + (entity.value % 100)

      if newValue > 0 {
        newValue = newValue % 100
      } else if newValue < 0 {
        newValue = 100 - abs(newValue)
      }

      if newValue == 0 {
        counter += 1
      }

      currentValue = newValue
    }

    return counter
  }

  func part2() -> Any {
    var currentValue = 50
    var counter = 0

    for entity in entities {
      var newValue = currentValue + (entity.value % 100)

      counter += abs(entity.value / 100)

      switch newValue {
      case (..<0):
        newValue = 100 - abs(newValue)
        if currentValue != 0, newValue != 0 {
          counter += 1
        }
      case 0...99:
        break
      case 100:
        newValue = 0
      case 101... :
        newValue = newValue - 100
        if currentValue != 0, newValue != 0 {
          counter += 1
        }
      default:
        break
      }

      if newValue == 0 {
        counter += 1
      }

      currentValue = newValue
    }

    return counter
  }
}
