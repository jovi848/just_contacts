import Flutter
import UIKit
import AddressBook
import AddressBookUI
import ContactsUI

public class SwiftJustContactsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "just_contacts", binaryMessenger: registrar.messenger())
    let instance = SwiftJustContactsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

    let contacts:JustAGroupOfContacts = ContactData.getAllContactsIOS9();
    result("\(contacts.toJson() ?? "{contacts:[]}")")

    
  }
}

public class JustAGroupOfContacts:Codable{
    var contacts:[JustAContact] = []
    
    init(contacts:[JustAContact])
    {
        self.contacts = contacts;
    }
    
    func toJson()->String?{
        
        do {
            let encodedData = try JSONEncoder().encode(self)
            let jsonString = String(data: encodedData,encoding: .utf8)
            return jsonString
        } catch {
                print("unable to serialize contact \(error), \(error.localizedDescription)")
                   }

        return nil
        
    }
}

public class JustAContact: Codable{
    
    var name = "";
    var firstName:String = "";
    var lastName:String = "";
    var phoneNumbers:[String] = [];
    var emails:[String] = [];

    init(name:String,phoneNumbers:[String],emails:[String]) {
        self.name = name;
        self.phoneNumbers = phoneNumbers;
        self.emails = emails;
    }
    
    func toJson()->String?{
        
        do {
            let encodedData = try JSONEncoder().encode(self)
            let jsonString = String(data: encodedData,encoding: .utf8)
            return jsonString
        } catch {
                print("unable to serialize contact \(error), \(error.localizedDescription)")
                   }

        return nil
        
    }
    
}

import AddressBook
import AddressBookUI
import ContactsUI

public class ContactData {
    @available(iOS 9.0, *)
    static func getAllContactsIOS9()->JustAGroupOfContacts
    {
        
        let contacts: [CNContact] = {
            let contactStore = CNContactStore()
            let keysToFetch:[Any] = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                CNContactEmailAddressesKey,
                CNContactPhoneNumbersKey,
                CNContactImageDataAvailableKey,
                CNContactThumbnailImageDataKey]
            
            // Get all the containers
            var allContainers: [CNContainer] = []
            do {
                allContainers = try contactStore.containers(matching: nil)
            } catch {
                print("Error fetching containers")
            }
            
            var results: [CNContact] = []
            
            // Iterate all containers and append their contacts to our results array
            for container in allContainers {
                let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
                
                do {
                    let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                    results.append(contentsOf: containerResults)
                } catch {
                    print("Error fetching results for container")
                }
            }
            
            return results
        }()
        
        var friends:[JustAContact] = []
        
        
        for contact in contacts
        {
            let name:String? = CNContactFormatter.string(from: contact, style: .fullName)
            var numbers:[String] = []
            var emails:[String] = []
            for phoneNumber in contact.phoneNumbers {
                numbers.append( phoneNumber.value.stringValue)
            }
            
            for email in contact.emailAddresses {
                emails.append(email.value as String)
            }

            var tempName = name;
            if(tempName == nil){
                if(numbers.count > 0){
                    tempName = numbers[0];
                }
                else if(emails.count > 0){
                    tempName = emails[0]
                }
            }
            
            let contact = JustAContact(name: tempName ?? "No Name", phoneNumbers:numbers,emails:emails)
            friends.append(contact)

        }
      
        friends = friends.sorted{ $0.name < $1.name }
       

        let aGroupOfContacts = JustAGroupOfContacts(contacts: friends);

        return aGroupOfContacts
    }
    
    
}

