//
//  EmployeeTypeTableViewController.swift
//  EmployeeRoster
//
//  Created by Apple Inc on 1/7/20.
//
import UIKit

// Step 1: Protocol to pass back selected type (↩ Step 15 in EmployeeDetailTableViewController.swift)
protocol EmployeeTypeTableViewControllerDelegate: AnyObject {
    func employeeTypeTableViewController(_ controller: EmployeeTypeTableViewController, didSelect employeeType: EmployeeType)
}

// Step 2: Controller for selecting an employee type
class EmployeeTypeTableViewController: UITableViewController {

    // Step 3: Delegate and current selection
    var delegate: EmployeeTypeTableViewControllerDelegate?
    var employeeType: EmployeeType?

    // MARK: - Table View Data Source

    // Step 4: One section for employee types
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Step 5: Number of rows = number of employee types
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EmployeeType.allCases.count
    }

    // Step 6: Configure each cell with a type label and checkmark if selected
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeType", for: indexPath)
        let type = EmployeeType.allCases[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = type.description
        cell.contentConfiguration = content

        cell.accessoryType = (employeeType == type) ? .checkmark : .none

        return cell
    }

    // Step 7: Handle selection and notify delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = EmployeeType.allCases[indexPath.row]
        employeeType = type
        delegate?.employeeTypeTableViewController(self, didSelect: type)
        tableView.reloadData()
    }
}
