//: [Back to home](Intro)

import Foundation

protocol CacheProtocol: class {
    associatedtype Key
    associatedtype Value
    
    func get(key: Key) -> Value?
    func put(value: Value?, forKey key: Key)
    func removeAll()
}

extension CacheProtocol {
    subscript(key: Key) -> Value? {
        get { return get(key) }
        set { put(newValue, forKey: key) }
    }
}

final class MyMemCache<Key: Hashable, Value>: CacheProtocol {
    
    var dic = [Key: Value]()
    
    func get(key: Key) -> Value? {
        return dic[key]
    }
    
    func put(value: Value?, forKey key: Key) {
        return dic[key] = value
    }
    
    func removeAll() {
        dic.removeAll()
    }
}

final class AnyCache<Key, Value>: CacheProtocol {
    let _get: (Key) -> Value?
    let _put: (Value?, Key) -> Void
    let _removeAll: () -> Void
    
    init(get: (Key) -> Value?, put: (Value?, Key) -> Void, removeAll: () -> Void) {
        _get = get
        _put = put
        _removeAll = removeAll
    }
    
    func get(key: Key) -> Value? {
        return _get(key)
    }
    
    func put(value: Value?, forKey key: Key) {
        _put(value, key)
    }
    
    func removeAll() {
        _removeAll()
    }
}

extension AnyCache where Key: Hashable {
    static func memCache() -> AnyCache {
        var dictionary = [Key: Value]()
        return AnyCache<Key, Value>(
            get: { return dictionary[$0] },
            put: { dictionary[$1] = $0 },
            removeAll: { dictionary.removeAll() }
        )
    }
}

extension CacheProtocol {
    func debug(name: String) -> AnyCache<Key, Value> {
        return AnyCache(
            get: {
                if let value = self.get($0) {
                    print("\(name) -- GET @\($0) returned \(value)")
                    return value
                } else {
                    print("\(name) -- GET @\($0) missed")
                    return nil
                }
            },
            put: {
                if let v = $0 {
                    self.put(v, forKey: $1)
                    print("\(name) -- PUT \($0) @\($1)")
                } else {
                    print("\(name) -- REMOVE @\($1)")
                }
                
                
            },
            removeAll: {
                self.removeAll()
                print("\(name) -- REMOVEALL")
        })
    }
}

// ----- Testing Area -----
let c = AnyCache<String, String>.memCache()
let d = c.debug("cache1")

d["joe"] = "bob1"
d["joe"]
d["joe"] = nil
d["joe"]


//: [Next](@next)
