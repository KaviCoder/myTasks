//
//  TableViewController.swift
//  myTasks
//
//  Created by Kavya Joshi on 2/23/21.
//

//CoreData -> NSFetchedResultsController for observation
//Protocol and delegates
//Customized cell


import UIKit
import CoreData


class DailyViewTable: UITableViewController , YourCellDelegate {
    
    
    
    //Defined the context for core data
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    //Defined a button for marking either done or not
    var btn = UIButton(type: .custom)
  
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        btn.removeFromSuperview()
    }
    @IBOutlet weak var myTableView : UITableView!
    
    
    
    // MARK: - CoreData FRC- For Initial fetch request
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Tasktable> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Tasktable> = Tasktable.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "datecreated", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        floatingButton()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    
        // MARK: - load Items
        print(#function)
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
        //        tableView.rowHeight = UITableView.automaticDimension
        //        tableView.estimatedRowHeight = 600
        //        tableView.reloadData()
        //
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let obj = fetchedResultsController.fetchedObjects
        {
            self.tableView.restore()
            return obj.count
        }
        else{
            self.tableView.setEmptyMessage("Currently no tasks available. Please create some tasks")
            return 0
            
        }
        

        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyConstants.cellIden) as! DailyViewCell
        cell.cellDelegate = self
        print(indexPath.row)
        
        
        let results = fetchedResultsController.object(at: indexPath)
        print(results)
        
        
        let myDate = results.datecreated!.string(format: "yyyy-MM-dd")
        
        
        cell.taskName.text = results.tasks!
        cell.taskDate.text = myDate 
        cell.categoryTag.text = results.category ?? "myPersonal"
        
        DispatchQueue.main.async{
            if results.completed == true{
                
                cell.doneButton.setImage(#imageLiteral(resourceName: "CheckButtonChecked"), for: .normal)
            }
            else{
                print("here")
                
                cell.doneButton.setImage(#imageLiteral(resourceName: "CheckButtonUnchecked"), for: .normal)
                
            }
            
        }
        
        
        
        
        return cell
    }
    
    func buttonClicked(_ sender: UIButton)
    {
        if let indexPath = getCurrentCellIndexPath(sender)
        {
            print("button clicked")
            let results = fetchedResultsController.object(at: indexPath)
            results.completed = !results.completed
            print(results.completed)
            myTableView.reloadRows(at: [indexPath], with: .fade)
            
        }
        
        do
        {
            try context?.save()
            
        }
        catch{
            print(error)
        }
        
    }
    
    func getCurrentCellIndexPath(_ sender: UIButton) -> IndexPath? {
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        if let indexPath: IndexPath = tableView.indexPathForRow(at: buttonPosition) {
            return indexPath
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Fetch Quote
            let quote = fetchedResultsController.object(at: indexPath)
            
            // Delete Quote
            quote.managedObjectContext?.delete(quote)
        }
        do
        {
            try context?.save()
            
        }
        catch{
            print(error)
        }
        
        
    }
    
    
}
extension DailyViewTable: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        
        
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break;
        case .update:
            if let indexPath = indexPath {
                print("resultcontroller updated")
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
            break;
        default:
            print("...")
        }
    }
}


// MARK: - date extension

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

// MARK: - Extension for Empty Message
extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}


//MARK: - Floating add button
extension DailyViewTable
{
    
    
    func floatingButton(){
        btn.frame = CGRect(x:view.frame.size.width - 70, y: view.frame.size.height - 100, width: 50, height: 50)
        btn.setTitle("Add", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 25
        btn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btn.layer.borderWidth = 3.0
     
        btn.addTarget(self,action: #selector(floatingButtonTapped), for: .touchUpInside)
        view.addSubview(btn)
        
    }
    
    @objc func floatingButtonTapped()
    {
        performSegue(withIdentifier: "toPopUp", sender: self)
    }
    
}
//extension UIWindow {
//    static var key: UIWindow? {
//        if #available(iOS 13, *) {
//            return UIApplication.shared.windows.first { $0.isKeyWindow }
//        } else {
//            return UIApplication.shared.keyWindow
//        }
//    }
//}
