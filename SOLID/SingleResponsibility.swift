//
//  SingleResponsibility.swift
//  SOLID
//
//  Created by Piyush Sharma on 07/07/24.
//
//  Definition: A class should have only one reason to change, meaning it should have only one job or responsibility.

import Foundation

//Example : User and related operations like CRUD

//MARK: Not Recommended
//class User {
//    var name : String
//    var email : String
//    
//    init(name: String, email: String) {
//        self.name = name
//        self.email = email
//    }
//    
//    //Opeartions like validatons and CRUD
//    func validateEmail() -> Bool{
//        return self.email.contains("@")
//    }
//    
//    func performCrudOperations(){
//        //save, delete, update, etc
//    }
//}

//MARK: Recommended according to SRP
@propertyWrapper
struct EmailValidator {
    private var value: String = ""
    
    var wrappedValue: String {
        get { value }
        set {
            if EmailValidator.isValidEmail(newValue) {
                value = newValue
            } else {
                print("Invalid email address")
            }
        }
    }
    
    init(wrappedValue initialValue: String) {
        self.wrappedValue = initialValue
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

@propertyWrapper
struct NameValidator {
    
    private var value : String = ""
    
    var wrappedValue : String {
        get { value }
        set{
            if NameValidator.isValidName(newValue){
                value = newValue
            }
            else
            {
                print("Invalid name")
            }
        }
    }
    
    init(wrapperValue : String)
    {
        self.wrappedValue = wrapperValue
    }
    
    static func isValidName(_ name: String) -> Bool{
        let nameRegex = "^[A-Za-z\\s]+$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: name)
    }
}

class User {
    @NameValidator var name : String
    @EmailValidator var email : String
    
    init?(name: String, email: String) {
            guard NameValidator.isValidName(name), EmailValidator.isValidEmail(email) else {
                return nil
            }
        self._name = NameValidator(wrapperValue: name)
        self._email = EmailValidator(wrappedValue: email)
    }
}

class UserCrudManager {
    func saveUser(user : User)
    {
        
    }
    
    func deleteUser(user : User){
        
    }
}
