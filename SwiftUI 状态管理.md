# SwiftUI 状态管理

## @State

`@State` 用于 `View` 中的私有状态值，一般来说它所修饰的都应该是 struct 值，并且不应该被其他的 view 看到。它代表了 SwiftUI 中作用范围最小，本身也最简单的状态，比如一个 `Bool`，一个 `Int` 或者一个 `String`。简单说，如果一个状态能够被标记为 `private` 并且它是值类型，那么 `@State` 是适合的。在内部，SwiftUI将会存储 @State修饰的属性值，然后贯穿整个渲染或重复渲染的生命周期中将持久化存储这个值，当在视图刷新或者重新创建的时候，该属性值可以很好地被视图自身管理。

## @Binding

和 @State 类似，@Binding 也是对属性的修饰，它做的事情是将值语义的属性“转换”为引用语义。对被声明为 @Binding 的属性进行赋值，改变的将不是属性本身，而是它的引用，这个改变将被向外传递.

# @ObservedObject

对于更复杂的一组状态，我们可以将它组织在一个 class 中，并让其实现 `ObservableObject` 协议。对于这样的 class 类型，其中被标记为 `@Published` 的属性，将会在变更时自动发出事件，通知对它有依赖的 `View` 进行更新。`View` 中如果需要依赖这样的 `ObservableObject` 对象，在声明时则使用 `@ObservedObject` 来订阅。`@ObservedObject` 不管存储，会随着 `View` 的创建被多次创建。

## @EnvironmentObject

针对那些需要传递到深层次的子 `View` 中的 `ObservableObject` 对象，我们可以在父层级的 `View` 上用 `.environmentObject` 修饰器来将它注入到环境中，这样任意子 `View` 都可以通过 `@EnvironmentObject` 来获取对应的对象。

## @StateObject

而 `@StateObject` 保证对象只会被创建一次。因此，如果是在 `View` 里自行创建的 `ObservableObject` model 对象，大概率来说使用 `@StateObject` 会是更正确的选择。`@StateObject` 基本上来说就是一个针对 class 的 `@State` 升级版。和 @State 一样，@StateObject 也只应该用于私有的视图状态；如果我们不能在声明属性的同时就为该属性分配初始值， 那么我们就不应该使用 @StateObject:

### @ObservedObject和@StateObject的注意事项

- 避免创建 `@ObservedObject var testObject = TestObject()` 这样的代码

原因上文中已经介绍了。ObservedObject 的正确用法为：`@ObservedObject var testObject:TestObject` 。通过从父视图传递一个可以保证存续期长于当前视图存续期的可观察对象，从而避免不可控的情况发生

- 避免创建 `@StateObject var testObject:TestObject` 这样的代码

与 `@ObservedObject var testObject = TestObject()` 类似， `@StateObject var testObject:TestObject` 偶尔也会出现与预期不符的状况。例如，在某些情况下，开发者需要父视图不断地生成全新的可观察对象实例传递给子视图。但由于子视图中使用了 StateObject ，它只会保留首次传入的实例的强引用，后面传入的实例都将被忽略。尽量使用 `@StateObject var testObject = TestObject()` 这样不容易出现歧义表达的代码



## Observation

从iOS 17、iPadOS 17、macOS 14、tvOS 17和watchOS 10开始，SwiftUI开始支持Observation，这是观察者设计模式的Swift特定实现。采用Observation会给您的应用带来如下好处：

* 跟踪可选项和对象的集合，这在使用ObservableObject时无法实现。

* 使用像State和Environment这样的现有数据流原语，而不是如StateObject和EnvironmentObject这样的基于对象的等价物。

* 基于视图主体读取的可观察属性的变化来更新视图，而不是基于可观察对象的任何属性变化，这有助于提高您的应用程序的性能。