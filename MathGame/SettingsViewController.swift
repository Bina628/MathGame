//
//  SettingsViewController.swift
//  S
//
//  Created by LabAdmin on
//  Copyright LabAdmin. All rights reserved.
//


import UIKit

protocol SettingsViewDelegate {
    //func SettingsViewWillFinish(controller: SettingsViewController)
    func GameChanged(_ newgame: Int)
}

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var CalcSegmentedCont: UISegmentedControl!
    
    var delegate: ViewController? = nil
    var GameID: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NSLog("My GameId is %d ", GameID) // Another way to print
        CalcSegmentedCont.selectedSegmentIndex = GameID
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ChangeGameID(_ sender: AnyObject) {
        GameID = Int(CalcSegmentedCont.selectedSegmentIndex)
        NSLog("New value  is %d \n", GameID) // // Another way to print
    }
    
    @IBAction func DonePressed(_ sender: AnyObject) {
        // if (delegate != nil) {
        //delegate!.SettingsViewWillFinish(self)
        // }
        //[self dismissViewControllerAnimated:true completion:nil];
        
        self.dismiss(animated: true) {
            self.delegate?.GameChanged(self.GameID)
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

