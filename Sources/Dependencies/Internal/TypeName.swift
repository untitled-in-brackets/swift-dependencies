#if canImport(FoundationEssentials)
  import FoundationEssentials
  #if Foundation
    import Foundation
  #endif
#else
  import Foundation
#endif

@usableFromInline
func typeName(_ type: Any.Type) -> String {
  var name = _typeName(type, qualified: true)
  if let index = name.firstIndex(of: ".") {
    name.removeSubrange(...index)
  }
  #if Foundation
    return name.replacingOccurrences(
      of: #"\(unknown context at \$[[:xdigit:]]+\)\."#,
      with: "",
      options: .regularExpression
    )
  #else
    let marker = "(unknown context at $"
    var sanitizedName = ""
    var index = name.startIndex
    while index < name.endIndex {
      if name[index...].starts(with: marker) {
        let hexStart = name.index(index, offsetBy: marker.count)
        var end = hexStart
        while end < name.endIndex, "0123456789abcdefABCDEF".contains(name[end]) {
          end = name.index(after: end)
        }
        if end > hexStart,
          end < name.endIndex,
          name[end] == ")",
          name.index(after: end) < name.endIndex,
          name[name.index(after: end)] == "."
        {
          index = name.index(after: name.index(after: end))
          continue
        }
      }
      sanitizedName.append(name[index])
      index = name.index(after: index)
    }
    return sanitizedName
  #endif
}
