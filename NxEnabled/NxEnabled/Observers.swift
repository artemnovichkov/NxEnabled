//
//  Observers.swift
//  NxEnabled
//
//  Created by Nikita Ermolenko on 12/01/2017.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit.UIControl

typealias EnabledHandler = (Bool) -> Void

public typealias ConfigurationHandler1 = (String) -> Bool
public typealias ConfigurationHandler2 = (String,String) -> Bool
public typealias ConfigurationHandler3 = (String,String,String) -> Bool
public typealias ConfigurationHandler4 = (String,String,String,String) -> Bool
public typealias ConfigurationHandler5 = (String,String,String,String,String) -> Bool
public typealias ConfigurationHandler6 = (String,String,String,String,String,String) -> Bool

// MARK: - NUIObserver

class NUIObserver: NSObject {
    
    fileprivate var enabledHandler: EnabledHandler
    fileprivate var textableValues: NSPointerArray
    
    deinit {
        textableValues.allObjects.forEach { value in
            let tuple = textableValueTuple(by: value)
            tuple.value.removeObserver(self, forKeyPath: tuple.key)
        }
    }
    
    init(textableValues: [NSObject], enabledHandler: @escaping EnabledHandler) {
        self.enabledHandler = enabledHandler
        self.textableValues = NSPointerArray(options: .weakMemory)
        
        super.init()
        
        let textableValuesTuples = textableValues.map { textableValueTuple(by: $0) }
        textableValuesTuples.forEach { tuple in
            self.textableValues.addPointer(Unmanaged.passUnretained(tuple.value).toOpaque())
        }

        textableValuesTuples.forEach { tuple in
            let key = tuple.key
            let textableValue = tuple.value
            
            textableValue.addObserver(self, forKeyPath: key, options: [.new, .initial], context: nil)

            switch tuple.value {
            case let value as UIControl:
                value.addTarget(self, action:#selector(textableValueChanged), for: .editingChanged)
                break
            default: break
            }
        }
    }
    
    // MARK: Text changing events
    
    @objc fileprivate func textableValueChanged() {
        configureEnabling()
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        configureEnabling()
    }
    
    // MARK: Helpers
    
    fileprivate func configureEnabling() {
        preconditionFailure("This method must be overridden")
    }
    
    fileprivate func text(at index: Int) -> String {
        let tuple = textableValueTuple(by: textableValues.allObjects[index])
        let value = tuple.value.value(forKey: tuple.key) as! String?
        return value ?? ""
    }
    
    private func textableValueTuple(by value: Any) -> (value:NSObject, key:String) {
        let textableValue = value as! NSObject
        let key = (textableValue as! Textable).textKey
        return (textableValue, key)
    }
}

// MARK: - NUIObserver1

final class NUIObserver1: NUIObserver {
    
    typealias ConfigurationHandler = ConfigurationHandler1
    private var configurationHandler: ConfigurationHandler
    
    init(textableValues: [NSObject],
         configurationHandler: @escaping ConfigurationHandler,
         enabledHandler: @escaping EnabledHandler) {
        
        self.configurationHandler = configurationHandler
        super.init(textableValues: textableValues, enabledHandler: enabledHandler)
    }

    fileprivate override func configureEnabling() {
        let text = self.text(at: 0)
        enabledHandler(configurationHandler(text))
    }
}

// MARK: - NUIObserver2

final class NUIObserver2: NUIObserver {
    
    typealias ConfigurationHandler = ConfigurationHandler2
    private var configurationHandler: ConfigurationHandler
    
    init(textableValues: [NSObject],
         configurationHandler: @escaping ConfigurationHandler,
         enabledHandler: @escaping EnabledHandler) {
        
        self.configurationHandler = configurationHandler
        super.init(textableValues: textableValues, enabledHandler: enabledHandler)
    }
    
    fileprivate override func configureEnabling() {
        let text0 = self.text(at: 0)
        let text1 = self.text(at: 1)
        enabledHandler(configurationHandler(text0, text1))
    }
}

// MARK: - NUIObserver3

final class NUIObserver3: NUIObserver {
    
    typealias ConfigurationHandler = ConfigurationHandler3
    private var configurationHandler: ConfigurationHandler
    
    init(textableValues: [NSObject],
         configurationHandler: @escaping ConfigurationHandler,
         enabledHandler: @escaping EnabledHandler) {
        
        self.configurationHandler = configurationHandler
        super.init(textableValues: textableValues, enabledHandler: enabledHandler)
    }

    fileprivate override func configureEnabling() {
        let text0 = self.text(at: 0)
        let text1 = self.text(at: 1)
        let text2 = self.text(at: 2)
        enabledHandler(configurationHandler(text0, text1, text2))
    }
}

// MARK: - NUIObserver4

final class NUIObserver4: NUIObserver {
    
    typealias ConfigurationHandler = ConfigurationHandler4
    private var configurationHandler: ConfigurationHandler
    
    init(textableValues: [NSObject],
         configurationHandler: @escaping ConfigurationHandler,
         enabledHandler: @escaping EnabledHandler) {
        
        self.configurationHandler = configurationHandler
        super.init(textableValues: textableValues, enabledHandler: enabledHandler)
    }
    
    fileprivate override func configureEnabling() {
        let text0 = self.text(at: 0)
        let text1 = self.text(at: 1)
        let text2 = self.text(at: 2)
        let text3 = self.text(at: 3)
        enabledHandler(configurationHandler(text0, text1, text2, text3))
    }
}

// MARK: - NUIObserver5

final class NUIObserver5: NUIObserver {
    
    typealias ConfigurationHandler = ConfigurationHandler5
    private var configurationHandler: ConfigurationHandler
    
    init(textableValues: [NSObject],
         configurationHandler: @escaping ConfigurationHandler,
         enabledHandler: @escaping EnabledHandler) {
        
        self.configurationHandler = configurationHandler
        super.init(textableValues: textableValues, enabledHandler: enabledHandler)
    }
    
    fileprivate override func configureEnabling() {
        let text0 = self.text(at: 0)
        let text1 = self.text(at: 1)
        let text2 = self.text(at: 2)
        let text3 = self.text(at: 3)
        let text4 = self.text(at: 4)
        enabledHandler(configurationHandler(text0, text1, text2, text3, text4))
    }
}

// MARK: - NUIObserver6

final class NUIObserver6: NUIObserver {
    
    typealias ConfigurationHandler = ConfigurationHandler6
    private var configurationHandler: ConfigurationHandler
    
    init(textableValues: [NSObject],
         configurationHandler: @escaping ConfigurationHandler,
         enabledHandler: @escaping EnabledHandler) {
        
        self.configurationHandler = configurationHandler
        super.init(textableValues: textableValues, enabledHandler: enabledHandler)
    }

    fileprivate override func configureEnabling() {
        let text0 = self.text(at: 0)
        let text1 = self.text(at: 1)
        let text2 = self.text(at: 2)
        let text3 = self.text(at: 3)
        let text4 = self.text(at: 4)
        let text5 = self.text(at: 5)
        enabledHandler(configurationHandler(text0, text1, text2, text3, text4, text5))
    }
}