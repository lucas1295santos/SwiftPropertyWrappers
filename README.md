# Property Wrappers
 
 It is new(ish) Swift language feature that allows you to implement reusable getters and setters for a property.

 This example creates a `propertyWrapper` that adds Undo behaviour on a property, meaning that at any time the property can undo the last value modification, assuming its previous value.
 
 ## Important considerations
 - Property Wrappers are only available for Swift 5.1 or greater.
 - Overusing Propperty Wrappers might add too much complexity to the code.
 
 ## References
 - [Swift docs](https://docs.swift.org/swift-book/LanguageGuide/Properties.html#ID617)
 - [Swift by sundell](https://www.swiftbysundell.com/articles/property-wrappers-in-swift/)
 - [Yet another Swift blog](https://www.vadimbulavin.com/swift-5-property-wrappers/)

## Defining the `propertyWrapper` struct

```swift
@propertyWrapper
struct Undoable<Value: Equatable> {
    private var valueHistory: Stack<Value>
    
    init(wrappedValue: Value?) {
        valueHistory = Stack(top: wrappedValue)
    }
    
    var projectedValue: Undoable<Value> { return self }
    
    var wrappedValue: Value? {
        get {
            valueHistory.peek()
        }
        set {
            guard let value = newValue else { return }
            if value != valueHistory.peek() {
                valueHistory.push(value)
            }
        }
    }
    
    func undo() {
        valueHistory.pop()
    }
}
```

> Note: `projectedValue` allow the wrapper `Undoable` to expose funcionality beyond the getters and setters of `wrappedValue`. In this case, we want to make `undo()` accessible.

## Defining a class that contains the property

```swift
class TextHandler {
    @Undoable var text = ""
}
```

## Using the `proppertyWrapper`

```swift
let textHandler = TextHandler()

textHandler.text = "Hello"
textHandler.text = "Hello World"
print(textHandler.text!) // Hello World

textHandler.$text.undo()
print(textHandler.text!) // Hello

textHandler.$text.undo()
print(textHandler.text!) // (prints empty string)
```

> `$text` is a syntactic sugar to get the `projectedValue` of `@Unduable var text`. This provides access to the function `undo()`
