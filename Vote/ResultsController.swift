//
//  ResultsController.swift
//  Vote
//
//  Created by Dylan Tasat on 01/03/2019.
//  Copyright © 2019 Dylan Tasat. All rights reserved.
//

import UIKit
import Charts
import Firebase

class ResultsController: UIViewController {
    
    @IBOutlet weak var resultsChart: PieChartView!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        var count : [PieChartDataEntry] = []
        
        ref.child("votos").observeSingleEvent(of: .value, with: {(snapshot) in
            let values = snapshot.value as? [String : Int]
            var total_votes = 0
            
            if (values != nil) {
                for (_, value) in values! {
                    total_votes += value
                }
                
                for (key, value) in values! {
                    count.append(PieChartDataEntry(value: (Double(value) / Double(total_votes)) * 100, label: key))
                }
            }
            
            let set = PieChartDataSet(values: count, label: "")
            set.colors = ChartColorTemplates.vordiplom()
            
            
            let data = PieChartData(dataSet: set)
            
            let pFormatter = NumberFormatter()
            pFormatter.numberStyle = .percent
            pFormatter.maximumFractionDigits = 1
            pFormatter.multiplier = 1
            pFormatter.percentSymbol = " %"
            data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
            
            data.setValueFont(.systemFont(ofSize: 11, weight: .light))
            data.setValueTextColor(.black)
            
            self.resultsChart.data = data
        })
        
    }

}
