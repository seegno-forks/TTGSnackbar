//
//  ViewController.swift
//  TTGSnackbarExample
//
//  Created by zekunyan on 15/10/5.
//  Copyright © 2015年 tutuge. All rights reserved.
//

import UIKit
import TTGSnackbar

class ViewController: UIViewController {
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var actionTextField: UITextField!
    @IBOutlet weak var durationSegmented: UISegmentedControl!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var animationTypeSegmented: UISegmentedControl!

    let durationTypes = [TTGSnackbarDuration.Short, TTGSnackbarDuration.Middle, TTGSnackbarDuration.Long]
    let animationTypes = [TTGSnackbarAnimationType.SlideFromBottomBackToBottom, TTGSnackbarAnimationType.FadeInFadeOut, TTGSnackbarAnimationType.SlideFromLeftToRight, TTGSnackbarAnimationType.Flip]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func show(sender: UIButton) {
        let snackbar: TTGSnackbar = TTGSnackbar.init(message: messageTextField.text!, duration: durationTypes[durationSegmented.selectedSegmentIndex])
        snackbar.animationType = animationTypes[animationTypeSegmented!.selectedSegmentIndex]
        snackbar.show()
    }

    @IBAction func showWithAction(sender: UIButton) {
        outputLabel?.text = "";
        let snackbar: TTGSnackbar = TTGSnackbar.init(message: messageTextField.text!, duration: durationTypes[durationSegmented.selectedSegmentIndex],
                actionText: actionTextField.text!, actionBlock: { (TTGSnackbar snackbar) in self.outputLabel?.text = "Click action !" })

        // Change message text color
        snackbar.messageTextColor = UIColor.yellowColor()

        snackbar.animationType = animationTypes[animationTypeSegmented!.selectedSegmentIndex]
        snackbar.show()
    }

    @IBAction func showWithActionAndDismissManually(sender: UIButton) {
        outputLabel?.text = "";
        let snackbar: TTGSnackbar = TTGSnackbar.init(message: messageTextField.text!, duration: TTGSnackbarDuration.Forever,
                actionText: actionTextField.text!) {
            (TTGSnackbar snackbar) in

            // Dismiss manually after 3 seconds
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                () -> Void in
                snackbar.dismiss()
            }
        }

        // Add dismiss callback
        snackbar.dismissBlock = {
            (snackbar: TTGSnackbar) -> Void in self.outputLabel?.text = "Dismiss !"
        }
        
        // Change action text color
        snackbar.actionTextColor = UIColor.yellowColor()

        snackbar.animationType = animationTypes[animationTypeSegmented!.selectedSegmentIndex]
        snackbar.show()
    }

}

