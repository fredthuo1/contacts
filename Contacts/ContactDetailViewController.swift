import UIKit
import class ObjectLibrary.Contact
import enum ObjectLibrary.State
import enum ObjectLibrary.InputField

protocol ContactDetailViewControllerDelegate: class {
    func add(_ contact: Contact)
}

final class ContactDetailViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var apartment: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var emergency: UISwitch!
    @IBOutlet weak var save: UIBarButtonItem!
    @IBOutlet weak var errorMessage: UILabel!
    
    // MARK: - Properties
    var delegate: ContactDetailViewControllerDelegate!
    var del: ContactDetailModelDelegate!
    var contact: Contact!
    var contactDetailModel: ContactDetailModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateState(with: State.allCases.first!)
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        state.inputView = pickerView
        save.isEnabled = false
        errorMessage.text = "Error saving contact! Invalid input!"
        errorMessage.textColor = UIColor.red
        errorMessage.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 1).isActive = true
        errorMessage.isHidden = true
    }
    // MARK: - IBActions

    @IBAction func saveAndClose(_ sender: UIBarButtonItem) {
        if ( contactDetailModel.validate(contact: contact) == true ) {
            contact.copy(withNewValue: firstName.text!, for: InputField.firstName)
            contact.copy(withNewValue: lastName.text!, for: InputField.lastName)
            contact.copy(withNewValue: phone.text!, for: InputField.phone)
            contact.copy(withNewValue: email.text!, for: InputField.email)
            contact.copy(withNewValue: street.text!, for: InputField.street)
            contact.copy(withNewValue: apartment.text!, for: InputField.apartment)
            contact.copy(withNewValue: city.text!, for: InputField.city)
            contact.copy(withNewValue: state.text!, for: InputField.state)
            contact.copy(withNewValue: zipCode.text!, for: InputField.zipcode)
            print(contact.value(for: InputField.firstName))
            if (emergency.isOn) {
                contact.copy(withNewValue: true.description, for: InputField.emergency)
            } else {
                contact.copy(withNewValue: false.description, for: InputField.emergency)
            }
            contact.copy(withNewValue: state.text!, for: InputField.state)
            delegate.add(contact)
            navigationController?.popViewController(animated: true)
        } else {
            contact.copy(withNewValue: firstName.text!, for: InputField.firstName)
            errorMessage.isHidden = false
        }
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func setup(model: ContactDetailModel, delegate: ContactDetailViewControllerDelegate) {
        if (model.contact.isEmpty) {
            self.contact = Contact.instance()
        } else {
            print(model.contact.id)
            self.contact = model.contact
            print(contact.id)
        }
        self.delegate = delegate
        self.contactDetailModel = model
    }
    
    // MARK: - Methods
    
    func updateState(with stateValue: State) {
        state.text = stateValue.rawValue
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension ContactDetailViewController: ContactDetailModelDelegate {
    func save(isEnabled: Bool) {
        
    }
}

extension ContactDetailViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    } // return NO to disallow editing.

    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorMessage.isHidden = true
    }// became first responder

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    } // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end

    func textFieldDidEndEditing(_ textField: UITextField) {
    } // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
    }// if implemented, called in place of textFieldDidEndEditing:

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    } // return NO to not change text

    func textFieldDidChangeSelection(_ textField: UITextField) {
        save.isEnabled = true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }// called when clear button pressed. return NO to ignore (no notifications)

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }// called when 'return' key pressed. return NO to ignore.
}

extension ContactDetailViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateState(with: State.allCases[row])
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return State.allCases[row].rawValue
    }
}

extension ContactDetailViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return State.allCases.count
    }
}
