import ProjectDescription

public extension TargetDependency {
    struct Module {}
    struct Feature {}
    struct Core {}
}

public extension TargetDependency.Core {
    static let sharingFlow = core(name: "SharingFlow")

    static func core(name: String) -> TargetDependency {
        return .project(
            target: name,
            path: .relativeToRoot("Core/\(name)")
        )
    }
}

public extension TargetDependency.Feature {
    static let exFeature = feature(name: "ExFeature")

    static func feature(name: String) -> TargetDependency {
        return .project(
            target: name,
            path: .relativeToRoot("Features/\(name)")
        )
    }
}

public extension TargetDependency.Module {
    static let thiredPartyLib = module(name: "ThiredPartyLib")

    static func module(name: String) -> TargetDependency {
        return .project(
            target: name,
            path: .relativeToRoot("Modules/\(name)")
        )
    }
}
