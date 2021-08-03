//
//  DailyViewCell.swift
//  myTasks
//
//  Created by Kavya Joshi on 3/10/21.
//

import Foundation
import UIKit


//Protocol/Delegate concept used.

protocol YourCellDelegate  {
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
        
        
       
    }
    
   
}
