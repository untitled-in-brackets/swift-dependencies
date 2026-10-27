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
    return name.replacing(#/\(unknown context at \$[0-9a-fA-F]+\)\./#, with: "")
  #endif
}
