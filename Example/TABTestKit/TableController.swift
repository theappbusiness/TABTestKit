//
//  TableController.swift
//  TABTestKit_ExampleUITests
//
//  Created by Kane Cheshire on 10/09/2019.
//  Copyright © 2019 Kin + Carta. All rights reserved.
//

import UIKit

final class TableController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 15
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Section numero \(section)"
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = "Cell number \(indexPath.row) in section \(indexPath.section)"
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let selectedRow = tableView.indexPathForSelectedRow else { return assertionFailure("No selection") }
    segue.destination.navigationItem.title = "Row \(selectedRow.row) section \(selectedRow.section)"
  }
  
  private func setup() {
    view.accessibilityIdentifier = "TableController"
  }
  
}
