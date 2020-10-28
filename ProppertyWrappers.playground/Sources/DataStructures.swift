import Foundation

public class Stack<T: Equatable> {
    
    private var linkedList: LinkedList<T>
    
    public init(top: T? = nil) {
        if let topValue = top {
            self.linkedList = LinkedList(head: .init(value: topValue))
        } else {
            self.linkedList = LinkedList<T>()
        }
    }
    
    public func push(_ value: T) {
        linkedList.addFirst(node: .init(value: value))
    }
    
    @discardableResult
    public func pop() -> T? {
        let head = linkedList.head
        linkedList.head = head?.next
        return head?.value
    }
    
    public func peek() -> T? {
        return linkedList.head?.value
    }
}

public class Node<T: Equatable> {
    public var value: T
    public var next: Node?
    
    public init(value: T) {
        self.value = value
    }
}

public class LinkedList<T: Equatable> {
    public var head: Node<T>?
    
    public init(head: Node<T>? = nil) {
        self.head = head
    }
    
    public func addFirst(node: Node<T>) {
        node.next = head
        head = node
    }
    
    public func addLast(node: Node<T>) {
        guard var currentNode = head else {
            head = node
            return
        }
        while let nextNode = currentNode.next {
            currentNode = nextNode
        }
        currentNode.next = node
    }
    
    public func addBefore(_ node: Node<T>, nodeWithValue value: T) {
        var currentNode = head
        if currentNode?.value == value {
            node.next = head
            head = node
        } else {
            while currentNode?.next != nil {
                if currentNode?.next?.value == value {
                    node.next = currentNode?.next
                    currentNode?.next = node
                    return
                } else {
                    currentNode = currentNode?.next
                }
            }
        }
    }
    
    public func addAfter(_ node: Node<T>, nodeWithValue value: T) {
        var currentNode = head
        while currentNode != nil {
            if currentNode?.value == value {
                let next = currentNode?.next
                currentNode?.next = node
                node.next = next
                return
            } else {
                currentNode = currentNode?.next
            }
        }
    }
    
    public func deleteFirst(nodeWithValue value: T) {
        var currentNode = head
        if currentNode?.value == value {
            head = currentNode?.next
        } else {
            while currentNode?.next != nil {
                if currentNode?.next?.value == value {
                    let newNext = currentNode?.next?.next
                    currentNode?.next?.next = nil
                    currentNode?.next = newNext
                    return
                } else {
                    currentNode = currentNode?.next
                }
            }
        }
    }
}

