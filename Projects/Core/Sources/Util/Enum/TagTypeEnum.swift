import Foundation

public enum TagTypeEnum {
    case NATURAL
    case SOCIAL
    case EDUCATION
    case CULTURE
    case ETC
    case NONE

    public var toString: String {
        switch self {
        case .NATURAL:
            return "NATURAL"
        case .SOCIAL:
            return "SOCIAL"
        case .EDUCATION:
            return "EDUCATION"
        case .CULTURE:
            return "CULTURE"
        case .ETC:
            return "ETC"
        case .NONE:
            return "NONE"
        }
    }
}

//NATURAL(환경), SOCIAL(사회), EDUCATION(교육), CULTURE(문화), ETC(기타)
