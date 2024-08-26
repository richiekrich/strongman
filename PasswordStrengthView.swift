import UIKit

class PasswordStrengthView: UIView {
    
    private let passwordField = UITextField()
    private let progressBar = UIProgressView(progressViewStyle: .default)
    private var checkBoxes = [UILabel]()
    
    private let analyzer = PasswordStrengthAnalyzer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // Setup passwordField
        passwordField.placeholder = "Enter your password"
        passwordField.isSecureTextEntry = true
        passwordField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        addSubview(passwordField)
        
        // Setup progressBar
        progressBar.progress = 0.0
        addSubview(progressBar)
        
        // Setup checkboxes
        for requirement in analyzer.analyze(password: "").requirements {
            let label = UILabel()
            label.text = requirement.description
            checkBoxes.append(label)
            addSubview(label)
        }
        
        // Layout the components
        // Layout code here (using AutoLayout or manual frames)
    }
    
    @objc private func textFieldDidChange() {
        let result = analyzer.analyze(password: passwordField.text ?? "")
        
        // Update progressBar
        switch result.strength {
        case .easy:
            progressBar.progress = 0.25
        case .medium:
            progressBar.progress = 0.5
        case .hard:
            progressBar.progress = 0.75
        case .veryHard:
            progressBar.progress = 1.0
        }
        
        // Update checkboxes
        for (index, requirement) in result.requirements.enumerated() {
            checkBoxes[index].text = requirement.isMet ? "✅ \(requirement.description)" : "⬜️ \(requirement.description)"
        }
    }
}
