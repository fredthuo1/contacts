import enum ObjectLibrary.InputField
import enum ObjectLibrary.State
import class Foundation.NSPredicate

extension InputField {
    
    func isValidEmail(email: String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format: "SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
    func isValidInt(number: String?) -> Bool {
        
        guard number != nil else { return false }
        
        let regEx = "[0-9]"
        
        let pred = NSPredicate(format: "SELF MATCHES numbers", regEx)
        return pred.evaluate(with: number)
    }
    
    func isValidInput(input: String?) -> Bool {
        
        guard input != nil else { return false }
        
        let regEx = "[A-Z0-9a-z]"
        
        let pred = NSPredicate(format: "SELF MATCHES numbers", regEx)
        return pred.evaluate(with: input)
    }
    
    func isValidCity(input: String?) -> Bool {
        
        guard input != nil else { return false }
        
        let regEx = "[A-Za-z]"
        
        let pred = NSPredicate(format: "SELF MATCHES numbers", regEx)
        return pred.evaluate(with: input)
    }
}
