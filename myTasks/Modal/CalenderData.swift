//
//  CalenderData.swift
//  myTasks
//
//  Created by Kavya Joshi on 3/17/21.
//

import Foundation

/*
1.Date represents a given day in a month.
2.The number to display on the collection view cell.
3.Keeps track of whether this date is selected.
4.Tracks if this date is within the currently-viewed month.
 
 */

struct Day {
  // 1
  let date: Date
  // 2
  let number: String
  // 3
  let isSelected: Bool
  // 4
  let isWithinDisplayedMonth: Bool
}

struct MonthMetadata {
  let numberOfDays: Int
  let firstDay: Date
  let firstDayWeekday: Int
}
