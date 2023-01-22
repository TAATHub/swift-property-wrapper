import Foundation

@propertyWrapper
struct UserDefault<Value> {
    private let key: String
    private let defaultValue: Value

    init(_ key: String, default defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: Value {
        get {
            UserDefaults.standard.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
}

final class ViewModel {
    @UserDefault("color", default: "black") var color: String
}

UserDefaults.standard.set("white", forKey: "color")

let viewModel = ViewModel()
print(viewModel.color) // white

viewModel.color = "red"
print(UserDefaults.standard.string(forKey: "color")) // Optional("red")
