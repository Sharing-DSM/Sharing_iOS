import Foundation

public enum DateFormatIndicated: String {
    /// yyyy-MM-dd'T'HH:mm:ss
    case fullDateAndTime = "yyyy-MM-dd'T'HH:mm:ss"

    /// yyyy-MM-dd'T'HH:mm:ss.SSSSSSSSS
    case fullDateAndTimeWithMillisecond = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSSS"

    /// yyyy-MM-dd
    case fullDate = "yyyy-MM-dd"
}
