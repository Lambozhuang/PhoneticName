//
//  main.swift
//  Phonetic Name
//
//  Created by LamboZhuang on 2023/9/28.
//

import Foundation
import AddressBook

extension String {
    func phonetic() -> String {
        let src = NSMutableString(string: self) as CFMutableString
        CFStringTransform(src, nil, kCFStringTransformMandarinLatin, false)
        return String(src)
    }

}

let ab = ABAddressBook()
ab.people().forEach {
    guard let people = $0 as? ABPerson else {
        return
    }

    if let lastName = people.value(forProperty: kABLastNameProperty) as? String {
        _ = try? people.setValue(
            lastName.phonetic(),
            forProperty: kABLastNamePhoneticProperty,
            error: ()
        )
    }

    if let firstName = people.value(forProperty: kABFirstNameProperty) as? String {
        _ = try? people.setValue(
            "",
            forProperty: kABFirstNamePhoneticProperty,
            error: ()
        )
    }
}
ab.save()
