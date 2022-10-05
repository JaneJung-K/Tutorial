//
//  ContactsViewController.swift
//  Tutorial
//
//  Created by Leah on 2022/10/05.
//

import UIKit
import Contacts
import ContactsUI

class ContactsViewController: UIViewController {
    private lazy var btnShowContacts: UIButton = {
        let button = UIButton()
        button.setTitle("ShowContacts", for: .normal)
        button.titleLabel?.font = Fonts.text14()
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 20
        button.frame = CGRect(x: 0, y: 0, width: 135, height: 40)
        button.addTarget(self, action: #selector(didTapShowContacts), for: .touchUpInside)
        return button
    }()
    
    private lazy var btnGetContacts: UIButton = {
        let button = UIButton()
        button.setTitle("GetContacts", for: .normal)
        button.titleLabel?.font = Fonts.text14()
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 20
        button.frame = CGRect(x: 0, y: 0, width: 135, height: 40)
        button.addTarget(self, action: #selector(didTapGetContacts), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(btnShowContacts)
        view.addSubview(btnGetContacts)
        
        btnShowContacts.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        btnGetContacts.snp.makeConstraints { make in
            make.top.equalTo(btnShowContacts.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
    }
    
    // getContacts
    @objc func didTapGetContacts() {
        let store = CNContactStore()
        var contacts: [Contact] = []
        
        // 연락처에 요청할 항목
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        // Request 생성
        let request = CNContactFetchRequest(keysToFetch: keys)
        request.sortOrder = CNContactSortOrder.userDefault
        
        // 권한체크
        store.requestAccess(for: .contacts) { granted, error in
            guard granted else { return }
                do {
                    // 연락처 데이터 획득
                    try store.enumerateContacts(with: request) { (contact, stop) in
                        guard let phoneNumber = contact.phoneNumbers.first?.value.stringValue else { return }
                        let id = contact.identifier
                        let givenName = contact.givenName
                        let familyName = contact.familyName
                        
                        let contactToAdd = Contact(id: id, firstName: familyName, givenName: givenName, phoneNumber: phoneNumber)
                        contacts.append(contactToAdd)
                    }
                } catch let error {
                    print(error.localizedDescription)
                }

            DataManager.shared.contacts = contacts
        }
    }
    
    // showContacts
    @objc func didTapShowContacts() {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        let vc = CNContactPickerViewController()
        vc.delegate = self
        switch status {
        case .authorized:
            present(vc, animated: true, completion: nil)
        default:
            CNContactStore().requestAccess(for: .contacts) { [weak self] success, error in
                guard let self = self else { return }
                if success {
                    DispatchQueue.main.async {
                        self.present(vc, animated: true, completion: nil)
                    }
                } else {
                    guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    }

}

extension ContactsViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let store = CNContactStore()
        let keysToFetch = [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactPhoneNumbersKey,
            CNContactOrganizationNameKey,
        ] as [CNKeyDescriptor]
        
        do {
            let predicate = CNContact.predicateForContacts(withIdentifiers: [contact.identifier])
            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)
            guard let contact = contacts.first else { return }
            if contact.familyName.count == 0 && contact.givenName.count == 0 {
//                nameLabel.text = "\(contact.organizationName)"
            } else {
//                nameLabel.text = "\(contact.familyName)\(contact.givenName)"
            }
            
            if let phone = contact.phoneNumbers.first {
//                phoneLabel.text = "\(phone.value.stringValue)"
            }
            
            
        } catch {
            print("Failed to fetch, error: \\(error)")
        }
    }
}
