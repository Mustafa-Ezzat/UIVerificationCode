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
    var codeInputView:UIVerificationCode!
    
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
        codeInputView = UIVerificationCode(frame: frame)
        codeInputView.delegate = self
        codeInputView.errorColor = UIColor.red
        codeInputView.textColor = UIColor.black
        codeInputView.maxTag = 4
        codeInputView.codeWidth = 64
        verifyCodeView.addSubview(codeInputView)
        let tapGesture = UITapGestureRecognizer(target: self, action:  #selector (self.showKeyboardAction (_:)))
        codeInputView.addGestureRecognizer(tapGesture)
        
        codeInputView.setupCode()
    }
    
    @objc func showKeyboardAction(_ sender:UITapGestureRecognizer)
    {
        // do other task
        codeInputView.becomeFirstResponder()
    }

}

extension ViewController: UIVerificationCodeDelegate{
    func verificationCode(_ verificationCode: UIVerificationCode, didFinishWithCode code: String) {
        codeInputView.showBorderColor()
    }
    
    func codeDeleteBackward() {
        codeInputView.hideBorderColor()
    }
    
    
}

