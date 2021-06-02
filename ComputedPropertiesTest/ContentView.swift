import SwiftUI

struct ContentView: View {
    var messages: [SomeStringsProtocol] = [SomeStringsOne(), SomeStringsTwo()]
    @StateObject var model = ContentViewModel()

    var body: some View {
        VStack {
            ForEach(messages.indices, id: \.self) {
                Text(messages[$0].defaultMessage).tag($0)
                Text(messages[$0].message).tag($0)
            }
            Picker(selection: $model.environment, label: EmptyView()) {
                ForEach(SomeEnum.allCases) {
                    Text($0.rawValue).tag($0)
                }
            }
        }
        .padding()
        .frame(width: 200, height: 150)
    }
}

class ContentViewModel: ObservableObject {
    @Published var environment: SomeEnum = .caseOne
}

enum SomeEnum: String, Identifiable, CaseIterable {
    public var id: String { rawValue }
    case caseOne
    case caseTwo
}

protocol SomeStringsProtocol {
    var defaultMessage: String { get }
    var message: String { get }
}

extension SomeStringsProtocol {
    var defaultMessage: String { "Default Message" }
}

class SomeStringsOne: SomeStringsProtocol {
    var message: String { "Message One" }
}

class SomeStringsTwo: SomeStringsProtocol {
    var message: String { "Message Two" }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
