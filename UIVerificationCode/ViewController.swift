//
//  ViewController.swift
//  UIVerificationCode
//
//  Created by Mustafa Ezzat on 8/11/18.
//  Copyright © 2018 Google. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var verifyCodeView: UIView!
    var verificationCode:UIVerificationCode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupCodeInput()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupCodeInput() {
        let frame = CGRect(x: 0, y: 0, width: verifyCodeView.frame.size.width, height: verifyCodeView.frame.size.height)
        verificationCode = UIVerificationCode(frame: frame)
        verificationCode.delegate = self
        verificationCode.errorColor = UIColor.red
        verificationCode.textColor = UIColor.black
        verificationCode.maxTag = 4
        verificationCode.codeWidth = 64
        verifyCodeView.addSubview(verificationCode)
        let tapGesture = UITapGestureRecognizer(target: self, action:  #selector (self.showKeyboardAction (_:)))
        verificationCode.addGestureRecognizer(tapGesture)
        verificationCode.setupCode()
    }
    
    @objc func showKeyboardAction(_ sender:UITapGestureRecognizer)
    {
        // do other task
        verificationCode.becomeFirstResponder()
    }

}

extension ViewController: UIVerificationCodeDelegate{
    func verificationCode(_ verificationCode: UIVerificationCode, didFinishWithCode code: String) {
        verificationCode.showBorderColor()
    }
    
    func codeDeleteBackward() {
        verificationCode.hideBorderColor()
    }
}

