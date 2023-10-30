//
//  ResultViewController.swift
//  BMI
//
//  Created by apple on 10/20/23.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    var bmi: BMI?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        noteLabel.numberOfLines = 0
        if let bmi = bmi {
            DispatchQueue.main.async {
                self.calculateBMI(bmi)
            }
        }
    }
    
    func calculateBMI(_ bmi: BMI) {
        let height = Float(bmi.height) / 100
        let weight = Float(bmi.weight)
        let bmiCal = weight / (height * height)
        
        resultLabel.text = String(format: "%.2f", bmiCal)
        
        if bmiCal < 18.5 {
            statusLabel.text = "Thiếu Cân"
            noteLabel.text = "Hãy bổ sung đầy đủ các dinh dưỡng cần thiết."
        } else if bmiCal < 25 {
            statusLabel.text = "Cân Đối"
            noteLabel.text = "Hãy bổ sung đầy đủ các dinh dưỡng cần thiết."
        } else if bmiCal < 30 {
            statusLabel.text = "Thừa Cân"
            noteLabel.text = "Hãy bổ sung đầy đủ các dinh dưỡng cần thiết."
        } else if bmiCal < 35 {
            statusLabel.text = "Béo Phì"
            noteLabel.text = "Hãy bổ sung đầy đủ các dinh dưỡng cần thiết."
        } else {
            statusLabel.text = "Béo Phì Nguy Hiểm"
            noteLabel.text = "Hãy bổ sung đầy đủ các dinh dưỡng cần thiết."
        }
    }
    
    @IBAction func onReCalculate(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
