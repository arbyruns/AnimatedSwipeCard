# AnimatedSwipeCard

AnimatedSwipeCard is a custom swipe card with animation and can be used with `confirmationDialog` or `alert`.


# Installation

AnimatedSwipeCard is available through [Swift Package Manager](https://swift.org/package-manager/).

# Usage

Using `AnimatedSwipeCard` is easy 

```swift
struct ContentView: View {

    @State var showCardAlert = false
    @State var selectedText = ""
    @State var bindingID = ""
    @State var bindingText = ""
    @State var bindingSubText = ""

    var body: some View {
        VStack {
            List {
                ForEach(RowItems, id:\.self){ item in
                    //add binding for a string for ID that can be passed
                    CardRowView(animationShakeAmount: 5.0,
                                titleText: item.text,
                                subText: item.subText,
                                cardID: String(bindingID),
                                color: "StatusCard",
                                imageName: "rocket_green",
                                showCardAlert: $showCardAlert,
                                bindingID: $bindingID,
                                bindingText: $bindingText,
                                bindingSubText: $bindingSubText)
                        .frame(height: 150)
                        .padding(.vertical)
                        .listRowBackground(Color.clear)
                }
            }
            .alert(isPresented: $showCardAlert) {
                   Alert(
                       title: Text("Greatest Band Is: \(bindingText)"),
                       message: Text(bindingSubText)
                   )
               }
        }
        .listStyle(.plain)
    }
}
```

# Parameters

- `animationShakeAmount`: higher the number the more of an angle of the card. Defaults at 5.0
- `swipeScale`: Scales the card to 0.8 as the default
- `titleText`: Main text
- `subText`: subtext
- `cardID` - `optional`: passed ID
- `color` - `optional`: asset color as a string 
- `imageName - `optional`: image name as a string
- `showCardAlert`: State to show alert

Binding parameters can be used with an `alert` or `confirmationDialog`

- `bindingID`: pass State to store ID.
- `bindingText`: pass State to store text. This maybe the same as titleText
- `bindingSubText`: pass State to store text. This maybe the same as subText

## Example

```swift
   .alert(isPresented:$showCardAlert) {
            Alert(
                title: Text("Are you sure you want to delete \(bindingText)?"),
                message: Text("There is no undo"),
                primaryButton: .destructive(Text("Delete")) {
                    deleteitem(bindingID)
                },
                secondaryButton: .cancel()
            )
        }
```
