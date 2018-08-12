# UIVerificationCode
Design your UI Verification Code with flexible number of digits. 

# Install via cocoapods

pod 'UIVerificationCode'

# Usage
1- In Your Stroyboard drag UIView in your UIViewController

2- Outlet This UIView in Your UIViewController.swift
    @IBOutlet weak var verifyCodeView: UIView!

3- In your UIViewController.swift add this line
    var verificationCode:UIVerificationCode!

4- In your UIViewController add this method for setup
   
   func setupCodeInput() 
    {
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

5- Then call it in viewDidLoad

6- Conform UIVerificationCodeDelegate

extension ViewController: UIVerificationCodeDelegate
{
    func verificationCode(_ verificationCode: UIVerificationCode, didFinishWithCode code: String) {
        //do somthing here for example show error
        verificationCode.showBorderColor()
    }
    
    func codeDeleteBackward() {
        //do somthing here for example hide error
        verificationCode.hideBorderColor()
    }
}

# Time to try let's go!
