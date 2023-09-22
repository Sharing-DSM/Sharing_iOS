import ProjectDescription

public extension TargetDependency {
    struct Module {}
    struct Feature {}
    struct Core {}
    struct Flow {}
}

public extension TargetDependency.Flow {
    static let flow = TargetDependency.project(
        target: "Flow",
        path: .relativeToRoot("Flow")
    )

    static func flow(name: String) -> TargetDependency {
        return .project(
            target: name,
            path: .relativeToRoot("Flow/\(name)")
        )
    }
}

public extension TargetDependency.Core {
    static let core = TargetDependency.project(
        target: "Core",
        path: .relativeToRoot("Core")
    )
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
