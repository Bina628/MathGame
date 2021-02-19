//
//  ViewController.swift
// MathGAme - Two-View app //


import UIKit
//#import "SettingsViewController.m" // It is becuase we put the header file in .m file
class ViewController: UIViewController, SettingsViewDelegate {
    
    @IBOutlet var Question: UILabel!
    @IBOutlet var Score: UILabel!
    @IBOutlet var Answers: UISegmentedControl!
    @IBOutlet var GameCalcLabel: UILabel!
    var GameType: Int = 0
    var NoCorrect = 0
    var NoGuess = 0
    var CorAns = 0
    var correctSegIndex = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        srandom(UInt32(time(nil)))
        self.ResetGame()
    }
    
    func GameChanged(_ newgame: Int) {
        GameType = newgame
        self.NewQuestion()
    }
    
    func ResetGame() {
        NoCorrect = 0;  NoGuess = 0 // ; separates two expressions
        GameType = 0    // 0 For Add, 1 for Multiply, 2 for Substract
        self.NewQuestion()
    }
    
    func NewQuestion() {
         print("Gametype is now \(GameType)   \n");
        
        var opesign: String?
        
        // We need two numbers, a correct answer, two false answers, a location for correct answer
        // We need to update view/gui accordingly
        
        // Two numbers
        let fope: Int = Int(arc4random() % UInt32(100))
        let sope: Int = Int(arc4random() % UInt32(100))
        
        // A correct answer, update the view
        if GameType == 0 {
            GameCalcLabel.text = "Addition";        opesign = "+";   CorAns = fope + sope
        }
        if GameType == 1 {
            GameCalcLabel.text = "Multiplication" ; opesign = "*" ;  CorAns = fope * sope
        }
        if GameType == 2 {
            GameCalcLabel.text = "Subtraction";     opesign = "-" ;  CorAns = fope - sope
        }
        
        // Where to put correct Answer for question, a location for correct answer
        correctSegIndex = Int(arc4random() % UInt32(3))
        
        var tmptext: String = String(format: "\(fope) \(opesign!) \(sope)")
        Question.text = tmptext
        for i in 0...2 {
            if i == correctSegIndex {
                tmptext = String(format: "%d", CorAns)
                Answers.setTitle(tmptext, forSegmentAt: Int(i))
            }
            else {
                //two false answers,
                let falseAns =  CorAns +  Int(arc4random() % UInt32(10) + 1)
                //tmptext = String(format: "%d", falseAns)
                Answers.setTitle(String(falseAns), forSegmentAt: Int(i))
            }
        }
        tmptext = String(format: "%d correct out of %d", NoCorrect, NoGuess)
        Score.text = tmptext
        //[tmptext release];
    }
    
    @IBAction func CheckAnswer(_ sender: AnyObject) {
        NoGuess += 1
        //var anwIndex: Int = Int(sender as! UISegmentedControl.selectedSegmentIndex())
        let anwIndex: Int = sender.selectedSegmentIndex
        if anwIndex == correctSegIndex {  NoCorrect += 1  }
        if NoCorrect == 10 {
            let Umessage: String =  String(format: "  %.02f%% correct in \(NoGuess) questions", Double (1000.0 / Double(NoGuess)))
            // create an alert to display the message
            
            let alert = UIAlertController(title: "Alert", message: Umessage, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Reset", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            self.ResetGame()
        }
        else { self.NewQuestion() }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // https://stackoverflow.com/questions/25966215/whats-the-difference-between-all-the-selection-segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("First check who is this seque ")
        if segue.identifier == "ShowSettings"
        {
            let SettingsView = (segue.destination as! SettingsViewController)
            SettingsView.GameID = GameType
            SettingsView.delegate = self
            print("I will show SettingViewController and its GUI")
        }
    }
    
}
