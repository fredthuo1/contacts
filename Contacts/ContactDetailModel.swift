import struct Foundation.UUID
import class ObjectLibrary.Contact
import enum ObjectLibrary.State
import enum ObjectLibrary.InputField
import class Foundation.NSPredicate

protocol ContactDetailModelDelegate: class {
    /// A helper method to notify the delegate that a save operation is enabled/disabled.
    func save(isEnabled: Bool)
}

final class ContactDetailModel {
    
    // MARK: - Properties
    private(set) var contact: Contact
    private weak var delegate: ContactDetailModelDelegate?
    
    init(contact: Contact, delegate: ContactDetailModelDelegate) {
        self.contact = contact
        self.delegate = delegate
    }

    // MARK: - Public methods for use by `ContactDetailViewControllerz
    func validate(contact: Contact) -> Bool {
        isValid(contact: contact)
    }
    
}

// MARK: - Private helper methods

extension ContactDetailModel {
    private func isValid(contact: Contact) -> Bool {
        if ((contact.isEmpty) == true) {
            return false
        } else if (contact.value(for: InputField.firstName) != nil || ((contact.value(for: InputField.firstName)!.count) >= 2)) {
            return false
        } else if (contact.value(for: InputField.lastName) != nil || ((contact.value(for: InputField.lastName)!.count) >= 2)) {
            return false
        } else if (contact.value(for: InputField.street) != nil || ((contact.value(for: InputField.street)!.count) >= 3)) {
            return false
        } else if (contact.value(for: InputField.apartment) != nil || ((contact.value(for: InputField.apartment)!.count) >= 1)) {
            return false
        } else if (contact.value(for: InputField.city) != nil || ((contact.value(for: InputField.city)!.count) >= 3)) {
            return false
        } else if (contact.value(for: InputField.zipcode) != nil || ((contact.value(for: InputField.zipcode)!.count) >= 5)) {
            return false
        } else if (contact.value(for: InputField.email) != nil || ((contact.value(for: InputField.email)!.count) >= 2)) {
            return false
        } else if (contact.isEmpty == true ) {
            return false
        } else if ((InputField.email.isValidEmail(email: InputField.email.rawValue)) == false) {
            return false
        } else if ((InputField.phone.isValidInt(number: InputField.phone.rawValue)) == false) {
            return false
        } else if ((InputField.zipcode.isValidInt(number: InputField.zipcode.rawValue)) == false) {
            return false
        } else if ((InputField.city.isValidCity(input: InputField.city.rawValue)) == false) {
            return false
        } else if ((InputField.apartment.isValidInput(input: InputField.apartment.rawValue)) == false) {
            return false
        } else {
            return true
        }
        return false
    }

    
}
