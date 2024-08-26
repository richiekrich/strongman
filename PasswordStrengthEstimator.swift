import Foundation

enum PasswordStrength {
    case easy, medium, hard, veryHard
}

struct PasswordRequirement {
    let description: String
    var isMet: Bool = false
}

class PasswordStrengthAnalyzer {
    
    private var requirements: [PasswordRequirement] = []
    
    init() {
        setupRequirements()
    }
    
    private func setupRequirements() {
        requirements = [
            PasswordRequirement(description: "At least 6 characters"),
            PasswordRequirement(description: "At least 8 characters"),
            PasswordRequirement(description: "Contains a lowercase letter"),
            PasswordRequirement(description: "Contains an uppercase letter"),
            PasswordRequirement(description: "Contains a number"),
            PasswordRequirement(description: "Contains a special character")
        ]
    }
    
    func analyze(password: String) -> (strength: PasswordStrength, requirements: [PasswordRequirement]) {
        // Reset requirements
        setupRequirements()
        
        // Analyze password
        if password.count >= 6 { requirements[0].isMet = true }
        if password.count >= 8 { requirements[1].isMet = true }
        if password.rangeOfCharacter(from: .lowercaseLetters) != nil { requirements[2].isMet = true }
        if password.rangeOfCharacter(from: .uppercaseLetters) != nil { requirements[3].isMet = true }
        if password.rangeOfCharacter(from: .decimalDigits) != nil { requirements[4].isMet = true }
        if password.rangeOfCharacter(from: .punctuationCharacters) != nil { requirements[5].isMet = true }
        
        // Determine strength
        let strength: PasswordStrength
        switch password.count {
        case ..<6:
            strength = .easy
        case 6..<8:
            strength = .medium
        case 8..<10:
            strength = .hard
        default:
            strength = .veryHard
        }
        
        return (strength, requirements)
    }
}
