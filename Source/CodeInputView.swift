import UIKit

open class CodeInputView: UIView, UIKeyInput {
    open var delegate: CodeInputViewDelegate?
    private var nextTag = 1
    private var maxTag = 4
    var codeLabelList = [UILabel]()

    // MARK: - UIResponder
    open var codeEmptyStype = ""
    open var backGrounded = UIColor.white
    open var errorColor = UIColor.red
    open var textColor = UIColor.black
    open var cornerRounded: CGFloat = 4.0
    open var borderStrock: CGFloat = 2.0
    open var codeWidth: CGFloat = 64.0
    open var codeHeight: CGFloat = 40.0
    open var codeGap: CGFloat = 15.0

    open override var canBecomeFirstResponder : Bool {
        return true
    }

    // MARK: - UIView

    public override init(frame: CGRect) {
        super.init(frame: frame)

        // Add six digitLabels
        var frame = CGRect(x: 0, y: 0, width: codeWidth, height: codeHeight)
        for index in 1...maxTag {
            let digitLabel = UILabel(frame: frame)
            digitLabel.textColor = textColor
            digitLabel.font = .systemFont(ofSize: 42)
            digitLabel.tag = index
            digitLabel.text = codeEmptyStype
            digitLabel.layer.cornerRadius = cornerRounded
            digitLabel.layer.borderWidth = borderStrock
            digitLabel.layer.borderColor = backGrounded.cgColor
            digitLabel.backgroundColor = backGrounded
            digitLabel.textAlignment = .center
            addSubview(digitLabel)
            frame.origin.x += codeWidth + codeGap
            codeLabelList.append(digitLabel)
        }
    }
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") } // NSCoding

    // MARK: - UIKeyInput

    public var hasText : Bool {
        return nextTag > 1 ? true : false
    }

    open func insertText(_ text: String) {
        if nextTag < maxTag+1 {
            (viewWithTag(nextTag)! as! UILabel).text = text
            nextTag += 1

            if nextTag == maxTag+1 {
                var code = ""
                for index in 1..<nextTag {
                    code += (viewWithTag(index)! as! UILabel).text!
                }
                delegate?.codeInputView(self, didFinishWithCode: code)
            }
        }
    }

    open func deleteBackward() {
        delegate?.codeDeleteBackward()
        if nextTag > 1 {
            nextTag -= 1
            (viewWithTag(nextTag)! as! UILabel).text = codeEmptyStype
        }
    }

    open func clear() {
        while nextTag > 1 {
            deleteBackward()
        }
    }

    // MARK: - UITextInputTraits

    open var keyboardType: UIKeyboardType { get { return .numberPad } set { } }
    
    open func showBorderColor() {
        for label in codeLabelList {
            label.layer.borderColor = errorColor.cgColor
        }
    }
    
    open func hideBorderColor() {
        for label in codeLabelList {
            label.layer.borderColor = backGrounded.cgColor
        }
    }
}

public protocol CodeInputViewDelegate {
    func codeInputView(_ codeInputView: CodeInputView, didFinishWithCode code: String)
    func codeDeleteBackward()
}
