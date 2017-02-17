import UIKit

class MainViewController: UITableViewController {
  
  let items: [YardSale.Control] = [
//    .browseItemsView,
.aboutFBLAView,
                                      .donateView]
  
  override open var shouldAutorotate: Bool {
    return false
  }

}

extension MainViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: String(describing: ItemCell.self), for: indexPath)
  }
}

extension MainViewController {
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard case let cell as ItemCell = cell else { return }
    
    cell.itemTitle.text = items[indexPath.row].title
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  }
}
