
import Foundation

// Step 1: Define the employee types with readable descriptions
enum EmployeeType: CaseIterable, CustomStringConvertible {
    case exempt       // Salaried full-time
    case nonExempt    // Hourly full-time
    case partTime     // Part-time employee
    
    // Step 2: Provide human-readable names for each type
    var description: String {
        switch self {
        case .exempt:
            return "Exempt Full Time"
        case .nonExempt:
            return "Non-exempt Full Time"
        case .partTime:
            return "Part Time"
        }
    }
}

// Step 3: Define the Employee model with name, birthdate, and type
struct Employee {
    var name: String
    var dateOfBirth: Date
    var employeeType: EmployeeType
}
