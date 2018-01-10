//
//  Copyright © 2018 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation
import CoreBluetooth

internal extension Array {
    
    /// Utility method used for matching elements from two different arrays and returning an array of tuples. Matching is based
    /// on a return value from comparison handler.
    internal func matchingElementsWith<T>(_ array: [T], comparison: @escaping (Element, T) -> Bool) -> [(Element, T)] {
        return flatMap { element in
            guard let index = array.index(where: { comparison(element, $0) }) else { return nil }
            return (element, array[index])
        }
    }
}

internal extension Array where Element == Service {
    
    /// Convenience method for easier matching of Service and CBService objects.
    internal func matchingElementsWith(_ array: [CBService]) -> [(Service, CBService)] {
        return matchingElementsWith(array, comparison: { (service, cbService) -> Bool in
            return cbService.uuid == service.bluetoothUUID
        })
    }
}

internal extension Array where Element == Characteristic {
    
    /// Convenience method for easier matching of Characteristic and CBCharacteristic objects.
    internal func matchingElementsWith(_ array: [CBCharacteristic]) -> [(Characteristic, CBCharacteristic)] {
        return matchingElementsWith(array, comparison: { (characteristic, cbCharacteristic) -> Bool in
            return characteristic.bluetoothUUID == cbCharacteristic.uuid
        })
    }
}

internal extension Array where Element == Peripheral {
    
    /// Convenience method for easier matching of Peripheral and CBPeripheral objects.
    internal func matchingElementsWith(_ array: [CBPeripheral]) -> [(Peripheral, CBPeripheral)] {
        return matchingElementsWith(array, comparison: { (peripheral, cbPeripheral) -> Bool in
            return peripheral.deviceIdentifier == cbPeripheral.identifier.uuidString
        })
    }
}

