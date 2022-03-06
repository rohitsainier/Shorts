//
//  LRUCache.swift
//  Shorts
//
//  Created by Rohit Saini on 07/03/22.
//

import Foundation


//struct LRUCache<K:AnyObject, V:AnyObject> {
//
//    private let _cache = NSCache<AnyObject, AnyObject>()
//
//    var countLimit:Int {
//        get {
//            return _cache.countLimit
//        }
//        nonmutating set(countLimit) {
//            _cache.countLimit = countLimit
//        }
//    }
//    subscript(key:K!) -> V? {
//        get {
//            let obj:AnyObject? = _cache.object(forKey: key)
//            return obj as! V?
//        }
//        nonmutating set(obj) {
//            if(obj == nil) {
//                _cache.removeObject(forKey: key)
//            }
//            else {
//                _cache.setObject(obj!, forKey: key)
//            }
//        }
//    }
//}

class Node<K, V> {
    var next: Node?
    var previous: Node?
    var key: K
    var value: V?
    
    init(key: K, value: V?) {
        self.key = key
        self.value = value
    }
}

class LinkedList<K, V> {
    
    var head: Node<K, V>?
    var tail: Node<K, V>?
    
    init() {
        
    }
    
    func addToHead(node: Node<K, V>) {
        if self.head == nil  {
            self.head = node
            self.tail = node
        } else {
            let temp = self.head
            
            self.head?.previous = node
            self.head = node
            self.head?.next = temp
        }
    }
    
    func remove(node: Node<K, V>) {
        if node === self.head {
            if self.head?.next != nil {
                self.head = self.head?.next
                self.head?.previous = nil
            } else {
                self.head = nil
                self.tail = nil
            }
        } else if node.next != nil {
            node.previous?.next = node.next
            node.next?.previous = node.previous
        } else {
            node.previous?.next = nil
            self.tail = node.previous
        }
    }
    
    func display() -> String {
        var description = ""
        var current = self.head
        
        while current != nil {
            description += "Key: \(current!.key) Value: \(current?.value) \n"
            
            current = current?.next
        }
        return description
    }
}


class SwiftlyLRU<K : Hashable, V> : CustomStringConvertible {
    
    let capacity: Int
    var length = 0
    
    private let queue: LinkedList<K, V>
    private var hashtable: [K : Node<K, V>]
    
    /**
     Least Recently Used "LRU" Cache, capacity is the number of elements to keep in the Cache.
     */
    init(capacity: Int) {
        self.capacity = capacity
        
        self.queue = LinkedList()
        self.hashtable = [K : Node<K, V>](minimumCapacity: self.capacity)
    }
    
    subscript (key: K) -> V? {
        get {
            if let node = self.hashtable[key] {
                self.queue.remove(node: node)
                self.queue.addToHead(node: node)
                
                return node.value
            } else {
                return nil
            }
        }
        
        set(value) {
            if let node = self.hashtable[key] {
                node.value = value
                
                self.queue.remove(node: node)
                self.queue.addToHead(node: node)
            } else {
                let node = Node(key: key, value: value)
                
                if self.length < capacity {
                    self.queue.addToHead(node: node)
                    self.hashtable[key] = node
                    
                    self.length = self.length + 1
                } else {
                    hashtable.removeValue(forKey: self.queue.tail!.key)
                    self.queue.tail = self.queue.tail?.previous
                    
                    if let node = self.queue.tail {
                        node.next = nil
                    }
                    
                    self.queue.addToHead(node: node)
                    self.hashtable[key] = node
                }
            }
        }
    }
    
    var description : String {
        return "SwiftlyLRU Cache(\(self.length)) \n" + self.queue.display()
    }
}
