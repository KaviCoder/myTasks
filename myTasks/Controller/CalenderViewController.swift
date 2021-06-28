//
//  CalenderViewController.swift
//  myTasks
//
//  Created by Kavya Joshi on 2/26/21.
//

import UIKit

class CalenderViewController: UIViewController {
    
    
    @IBOutlet weak var Calenderview: UICollectionView!
    
    /*
     Setting the calendar identifier as .gregorian means the Calendar API should use the Gregorian calendar. The Gregorian is the calendar used most in the world, including by Apple’s Calendar app.
     */
    private let calendar = Calendar(identifier: .gregorian)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Calenderview.isScrollEnabled = false
        


        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}


// MARK: - Day Generation
private extension CalenderViewController {
  // 1
  func monthMetadata(for baseDate: Date) throws -> MonthMetadata {
    // 2
    guard
      let numberOfDaysInMonth = calendar.range(
        of: .day,
        in: .month,
        for: baseDate)?.count,
      let firstDayOfMonth = calendar.date(
        from: calendar.dateComponents([.year, .month], from: baseDate))
      else {
        // 3
        throw CalendarDataError.metadataGeneration
    }

    // 4
    let firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth)

    // 5
    return MonthMetadata(
      numberOfDays: numberOfDaysInMonth,
      firstDay: firstDayOfMonth,
      firstDayWeekday: firstDayWeekday)
  }

  enum CalendarDataError: Error {
    case metadataGeneration
  }
}

