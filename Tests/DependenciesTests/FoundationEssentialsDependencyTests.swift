#if !Foundation && canImport(FoundationEssentials)
  import Dependencies

  struct FoundationEssentialsDependencyReferences {
    @Dependency(\.date) var date
    @Dependency(\.uuid) var uuid
    @Dependency(\.calendar) var calendar
    @Dependency(\.locale) var locale
    @Dependency(\.timeZone) var timeZone
  }
#endif
