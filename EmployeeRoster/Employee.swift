
import Foundation

// Step 1: Define the employee types with readable descriptions
enum EmployeeType: CaseIterable, CustomStringConvertible {
    case exempt       // Soon: Exempt Full Time ⬇️
    case nonExempt    // Soon: Non-exempt Full Time ⬇️
    case partTime     // Soon: Part Time ⬇️
    
    // Step 2: Provide human-readable names for each type (This will Appear in labels for E.ListTVC.swift)
    //Beware that this var name is set to "description" because that is how it works...
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
