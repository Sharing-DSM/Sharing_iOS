import Foundation

public enum TagTypeEnum: String {
    case natural = "NATURAL"
    case social = "SOCIAL"
    case education = "EDUCATION"
    case culture = "CULTURE"
    case ect = "ETC"
    case none = "NONE"

    public var toTagName: String {
        switch self {
        case .natural:
            return "환경(자연)"
        case .social:
            return "사회"
        case .education:
            return "교육"
        case .culture:
            return "문화"
        case .ect:
            return "기타"
        case .none:
            return "없음"
        }
    }
}

//NATURAL(환경), SOCIAL(사회), EDUCATION(교육), CULTURE(문화), ETC(기타)
