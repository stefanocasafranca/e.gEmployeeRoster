import UIKit

// Step 1: Controller for displaying the list of employees. Also inherits all the protocol down here
class EmployeeListTableViewController: UITableViewController, EmployeeDetailTableViewControllerDelegate {

    // Step 2: Data source – list of employees projected as an Array inside the var employees
    var employees: [Employee] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Best Practice: Setup UI here (if needed)
    }

    // MARK: - Table View Data Source

    // Step 3: Number of rows = number of employees. Returns the Array nummber
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }

    
    // Step 4: Build each row in the list to show an employee
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Step 4.1: Get a recycled cell (faster than making a new one)
        let cellForEmployee = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath)
        
        // Step 4.2: Get the employee for this row from the list
        let employee = employees[indexPath.row]

        // Step 4.3: Create a layout to hold text (name + job type)
        var content = cellForEmployee.defaultContentConfiguration()
        
        // Step 4.4: Set the name and job type to show in the cell
        content.text = employee.name
        content.secondaryText = employee.employeeType.description
        
        // Step 4.5: Apply that layout to the cell (makes it show up)
        cellForEmployee.contentConfiguration = content

        // Step 4.6: Return the ready-to-show cell to the table
        return cellForEmployee
    }
    

    // Step 5: Enable swipe-to-delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            employees.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // Step 6: Go (Segue) to Employee Detail (MAIN EDIT) screen (Step 1 in EmployeeDetailTableViewController.swift)
    @IBSegueAction func showEmployeeDetail(_ coder: NSCoder, sender: Any?) -> EmployeeDetailTableViewController? {
        let detailViewController = EmployeeDetailTableViewController(coder: coder)
        detailViewController?.delegate = self

        // Step 6.1: Pass selected employee to detail screen (if editing)
        guard
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell)
        else {
            return detailViewController
        }

        let employee = employees[indexPath.row]
        detailViewController?.employee = employee

        return detailViewController
    }

    // Step 7: Called when returning from detail view
    @IBAction func unwindToEmployeeList(segue: UIStoryboardSegue) {
        tableView.reloadData()
    }

    // MARK: - EmployeeDetailTableViewControllerDelegate

    // Step 8: Handle saving employee from detail view
    func employeeDetailTableViewController(_ controller: EmployeeDetailTableViewController, didSave employee: Employee) {
        if let indexPath = tableView.indexPathForSelectedRow {
            // Edit existing employee
            employees.remove(at: indexPath.row)
            employees.insert(employee, at: indexPath.row)
        } else {
            // Add new employee
            employees.append(employee)
        }

        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}
