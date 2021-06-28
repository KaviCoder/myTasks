//
//  PopUpViewController.swift
//  myTasks
//
//  Created by Kavya Joshi on 2/24/21.
//

import UIKit

class PopUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    
    
    @IBOutlet weak var taskName: UITextField!
    
    @IBOutlet weak var categorySelected: UIPickerView!
    @IBOutlet weak var occurrence: UISegmentedControl!
    
    // My inputs
    var date = Date()
    var myCategory = MyConstants.categories[0]
    var alarm = false
    var  occur = "Daily"
    var  task = String()
    
    @IBAction func OccurrenceSelected(_ sender: UISegmentedControl) {
        
        print(sender.selectedSegmentIndex)
        switch sender.selectedSegmentIndex
        {
        case 0:
            occur = "daily"
        case 1:
            occur = "Monthly"
            
        default:
            occur = "daily"
        }
        
        
    }
    @IBAction func alarmOnOff(_ sender: UISwitch) {
        
    alarm = sender.isOn ? true : false
        
    }
   
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        taskName.delegate = self
        categorySelected.delegate = self
        
        
    }
    

    
    // MARK: - UI Picker View Delegate methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return MyConstants.categories.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return MyConstants.categories[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
        myCategory = MyConstants.categories[row]
    }
    
    // MARK: - Textfield Delagate Methods
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print(textField.text!)
        task = textField.text!
        textField.resignFirstResponder()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text as Any)
        
        if textField.text != ""
        {
            task = textField.text!
            textField.resignFirstResponder()
            
            return true
        }
        
       
        textField.resignFirstResponder()
     return true
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    // MARK: - Done Pressed
    @IBAction func donePressed(_ sender: UIButton) {
        if task != ""
        {
            
        
        print(MyData(dateCreated: date, category: myCategory, alarm: alarm, occurrence: occur, taskName: task))
            //save data
            //update UI
            //move to daily View Table
            
            //create object in a specific contex
            let newItem = Tasktable(context: self.context!)
            newItem.datecreated = date
            newItem.alarmForNextDay = alarm
            newItem.category = myCategory
            newItem.completed = false
            newItem.occurence = occur
            newItem.tasks = task
           do
           {
            try context?.save()
           
           }
           catch{
            print(error)
           }
        

            taskName.backgroundColor = UIColor.white
          //  taskName.attributedPlaceholder = NSAttributedString(string: "Please Enter Task Name" , attributes: [NSAttributedString.Key.foregroundColor: UIColor.red.withAlphaComponent(0.7)])
                
                taskName.placeholder = " "
            //self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
            self.dismiss(animated: true)
            
            
            
    }
        else{
           
            
           
           

            taskName.backgroundColor = UIColor.red.withAlphaComponent(0.2)
            taskName.attributedPlaceholder = NSAttributedString(string: "Please Enter Task Name" , attributes: [NSAttributedString.Key.foregroundColor: UIColor.red.withAlphaComponent(0.7)])
            
        }
}
    
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        print("cancel pressesd")
        self.dismiss(animated: true)
        
       // self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        
    }
}
