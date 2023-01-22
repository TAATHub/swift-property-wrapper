import Foundation

@propertyWrapper
struct Email {
    var value: String?

    init(wrappedValue value: String?) {
        self.value = value
    }

    var wrappedValue: String? {
        get {
            return validate(email: value) ? value : nil
        }
        set {
            value = newValue
        }
    }

    private func validate(email: String?) -> Bool {
        guard let email = email else { return false }
        let regex = /^[a-zA-Z0-9_.+-]+@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}$/
        return email.firstMatch(of: regex) != nil
    }
}

struct User {
    @Email var mail: String?
}

var user = User(mail: "xxx")
print(user.mail) // nil

user.mail = "test@xxx"
print(user.mail) // nil

user.mail = "test@test.com"
print(user.mail) // Optional("test@test.com")
