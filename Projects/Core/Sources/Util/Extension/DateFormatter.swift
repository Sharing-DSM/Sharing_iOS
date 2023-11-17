import Foundation

public extension DateFormatter {
    func formatDateString(dateString: String, inputFormat: String, outputFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        
        let replaceDate = dateFormatter.date(from: dateString) ?? Date()
        dateFormatter.dateFormat = outputFormat
        
        let formattedDate = dateFormatter.string(from: replaceDate)
        return formattedDate
    }
}
