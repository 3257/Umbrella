public protocol ProviderType {
  func log(_ eventName: String, parameters: [String: Any]?)
}

public protocol EventType {
  func name(for provider: ProviderType) -> String
  func parameters(for provider: ProviderType) -> [String: Any]?
}

final public class Analytics<Event: EventType> {
  private var providers: [ProviderType] = []

  public init() {
    // I'm Analytics 👋
  }

  public func register(provider: ProviderType) {
    self.providers.append(provider)
  }

  public func log(event: Event) {
    for provider in self.providers {
      let eventName = event.name(for: provider)
      let parameters = event.parameters(for: provider)
      provider.log(eventName, parameters: parameters)
    }
  }
}
