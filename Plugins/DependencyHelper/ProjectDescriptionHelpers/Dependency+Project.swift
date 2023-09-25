import ProjectDescription

public extension TargetDependency {
    struct Module {}
    struct Project {}
}

public extension TargetDependency.Project {
    static let appFlow = project(name: "AppFlow")
    static let core = project(name: "Core")
    static let presentation = project(name: "Presentation")
    static let data = project(name: "Data")
    static let domain = project(name: "Domain")
    
    static func project(name: String) -> TargetDependency {
        return .project(
            target: name,
            path: .relativeToRoot("Projects/\(name)")
        )
    }
}

public extension TargetDependency.Module {
    static let thirdPartyLib = module(name: "ThirdPartyLib")
    static let appNetwork = module(name: "AppNetwork")
    static let sharingKit = module(name: "SharingKit")

    static func module(name: String) -> TargetDependency {
        return .project(
            target: name,
            path: .relativeToRoot("Modules/\(name)")
        )
    }
}
