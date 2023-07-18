//
//  IntentHandler.swift
//  SimpleWidgetIntents
//
//  Created by 寺中 信行 on 2023/07/18.
//

import Intents
import Combine

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

class IntentHandler: INExtension, ConfigurationIntentHandling {
    private var imageListService = ImageListService()

    func provideNameOptionsCollection(for intent: ConfigurationIntent, searchTerm: String?, with completion: @escaping (INObjectCollection<NSString>?, Error?) -> Void) {

        var cancellables: [AnyCancellable] = []
        
        imageListService.fetch(keyword: nil)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Finish.")
                case .failure(let error):
                    print(error)
                }

            }, receiveValue: { response in
                let identifiers: [NSString] = response.map { $0.title as NSString }
                let allIdentifiers = INObjectCollection(items: identifiers)
                completion(allIdentifiers, nil)
            })
            .store(in: &cancellables)
    }
    
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }

}
