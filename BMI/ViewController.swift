//
//  ViewController.swift
//  BMI
//
//  Created by apple on 10/18/23.
//

import UIKit

enum Action {
    case IncreaseWeight
    case DecreaseWeight
    case IncreaseAge
    case DecreaseAge
    case None
}

class ViewController: UIViewController {

    @IBOutlet weak var maleView: UIView!
    @IBOutlet weak var femaleView: UIView!
    @IBOutlet weak var heightView: UIView!
    @IBOutlet weak var weightView: UIView!
    @IBOutlet weak var ageView: UIView!
    @IBOutlet weak var subtractionWeightImageView: UIImageView!
    @IBOutlet weak var plusWeightImageView: UIImageView!
    @IBOutlet weak var subtractionAgeImageView: UIImageView!
    @IBOutlet weak var plusAgeImageView: UIImageView!
    @IBOutlet weak var calculateButton: UIButton!
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    let radius: CGFloat = 10
    
    let minHeight: Int = 50
    let maxHeight: Int = 250
    let minWeight: Int = 10
    let maxWeight: Int = 150
    let minAge: Int = 1
    let maxAge: Int = 120
    
    var height: Int = 100
    var weight: Int = 50
    var age: Int = 20
    var gender: Gender = .Male
    var action: Action = .None
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        changeGender(gender)
        heightLabel.text = "\(height)"
    }
    
    func setupUI() {
        maleView.layer.cornerRadius = radius
        femaleView.layer.cornerRadius = radius
        heightView.layer.cornerRadius = radius
        weightView.layer.cornerRadius = radius
        ageView.layer.cornerRadius = radius
        calculateButton.layer.cornerRadius = radius
        
        subtractionWeightImageView.layer.cornerRadius = 15
        plusWeightImageView.layer.cornerRadius = 15
        subtractionAgeImageView.layer.cornerRadius = 15
        plusAgeImageView.layer.cornerRadius = 15
    }
    
    func changeGender(_ gender: Gender) {
        if gender == .Male {
            maleView.backgroundColor = UIColor(red: 38.0/255.0, green: 38.0/255.0, blue: 58.0/255.0, alpha: 1.0)
            femaleView.backgroundColor = UIColor(red: 0.21, green: 0.21, blue: 0.26, alpha: 1.00)
        } else { // Female
            maleView.backgroundColor = UIColor(red: 0.21, green: 0.21, blue: 0.26, alpha: 1.00)
            femaleView.backgroundColor = UIColor(red: 38.0/255.0, green: 38.0/255.0, blue: 58.0/255.0, alpha: 1.0)
        }
    }

    @IBAction func onPressMale(_ sender: Any) {
        gender = .Male
        changeGender(gender)
    }
    
    @IBAction func onPressFemale(_ sender: Any) {
        gender = .Female
        changeGender(gender)
    }
    
    @IBAction func onChangeHeight(_ sender: UISlider) {
        let height = Int(sender.value)
        self.height = height
        heightLabel.text = "\(height)"
        
    }
    
    @IBAction func onPressSubWeight(_ sender: Any) {
        decreaseWeight()
    }
    
    @IBAction func onPressPlusWeight(_ sender: Any) {
        increaseWeight()
    }
    
    @IBAction func onCalculate(_ sender: Any) {
        let bmi = BMI(gender: gender, height: height, weight: weight, age: age)
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let resultVC = mainStoryboard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        
        resultVC.bmi = bmi
        resultVC.modalPresentationStyle = .fullScreen
        self.present(resultVC, animated: true)
    }
    
    @IBAction func onLongPressSubWeight(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            action = .DecreaseWeight
            startTimer()
        } else if sender.state == .ended {
            action = .None
            stopTimer()
        }
    }
    
    
    @IBAction func onLongPressPlusWeight(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            action = .IncreaseWeight
            startTimer()
        } else if sender.state == .ended {
            action = .None
            stopTimer()
        }
    }
    
    func increaseWeight() {
        weight += 1
        if weight > 150 {
            weight = 150
        }
        weightLabel.text = "\(weight)"
    }
    
    func decreaseWeight() {
        weight -= 1
        if weight < 10 {
            weight = 10
        }
        weightLabel.text = "\(weight)"
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    @objc func runTimer() {
        switch action {
        case .DecreaseWeight:
            decreaseWeight()
            break
        case .IncreaseWeight:
            increaseWeight()
            break
        case .IncreaseAge:
            break
        case .DecreaseAge:
            break
        case .None:
            break
        }
    }
}

