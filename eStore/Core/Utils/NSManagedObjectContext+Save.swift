//
//  NSManagedObjectContext+Save.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 11/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {

    // Save context ant its parents when context changed and should to be saved
    // in context.perform or performAndWait. It does not call context.perform and saves immediately.
    func saveAsyncInPerform(_ completion: @escaping (_ saved: Bool) -> Void) {
        if (try? self.save()) != nil {
            if let parent = self.parent {
                parent.saveAsync(completion)
            } else {
                DispatchQueue.main.async {
                    completion(true)
                }
            }
        } else {
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }

    //Used when need save anywhere but not in context.perform or performAndWait
    func saveAsync(_ completion: @escaping (_ saved: Bool) -> Void) {
        self.perform {
            self.saveAsyncInPerform(completion)
        }
    }

    //unsafe method. Is used only in updateStoreWithDefault.
    func saveSync() -> Bool {
        let isSaved = (try? self.save()) != nil
        if let parent = self.parent {
            return isSaved && parent.saveSync()
        } else {
            return isSaved
        }
    }

    func performAndWaitNonEscape(_ body: () -> Void) {
        func impl(execute work: () -> Void) {
            // performAndWait is marked @escaping as of iOS 10.0.
            typealias Fn = (() -> Void) -> Void
            let performAndWaitNoescape = unsafeBitCast(self.performAndWait, to: Fn.self)
            performAndWaitNoescape {
                work()
            }
        }

        impl(execute: body)
    }
}
