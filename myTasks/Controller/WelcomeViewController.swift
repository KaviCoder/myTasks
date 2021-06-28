//
//  ViewController.swift
//  myTasks
//
//  Created by Kavya Joshi on 2/23/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = ""
           
    let label = "Welcome"
        for i in label.enumerated()
{
    Timer.scheduledTimer(withTimeInterval: 0.2 * Double(i.offset), repeats: false) { (timer) in
    self.label.text?.append(i.element)
    }}
        
        UIView.animate(withDuration: 4, animations: {
            self.label.alpha = 0.5
        }
        ,completion: {
            done in
            if done{
                self.dismiss(animated: true)
                self.performSegue(withIdentifier: "Main", sender: self)
//                let sb = UIStoryboard(name: "Main", bundle: nil)
//                let VC = sb.instantiateViewController(withIdentifier: "DailyViewTable") as! DailyViewTable
//                let navRootView = UINavigationController(rootViewController: VC)
//                self.present(DailyViewTable(), animated: true, completion: nil)
                               }
        })


        
    
    }


}

