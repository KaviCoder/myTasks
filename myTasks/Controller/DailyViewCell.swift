//
//  DailyViewCell.swift
//  myTasks
//
//  Created by Kavya Joshi on 3/10/21.
//

import Foundation
import UIKit

protocol YourCellDelegate : class {
  func  buttonClicked(_ sender : UIButton)
}



class DailyViewCell: UITableViewCell {
    
    var cellDelegate: YourCellDelegate?
    
    @IBOutlet weak var taskName: UITextView!
    
    @IBOutlet weak var taskDate: UILabel!
    @IBOutlet weak var categoryTag: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
     
        cellDelegate?.buttonClicked( sender)
        
//        var resultCompleted =   fetchedResultsController.object(at:  self.myTableView.indexPath).completed
//        resultCompleted = !resultCompleted
        
       
    }
    
   
}
