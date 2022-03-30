![](https://img.shields.io/bower/l/boot)
# AnimatedSwipeCard
                                                                                                                                      
AnimatedSwipeCard is a custom swipe card with animation and can be used with `confirmationDialog` or `alert`.


https://user-images.githubusercontent.com/2520545/160837700-916c3355-17c0-4ee8-a86e-b9cd033e4863.mp4





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

- `animationShakeAmount` - `optional`: higher the number the more of an angle of the card. Defaults at 5.0
- `swipeScale` - `optional`: `Double` Scales the card to 0.8 as the default
- `titleText`: `String` Main text
- `subText`: `String` subtext
- `cardID` - `optional`: `String` passed ID
- `color` - `optional`: `String` asset color as a string 
- `imageName` - `optional`: `String` image name as a string to be used in card
- `imageHeight` - `optional`: `CGFloat` image height. Defaults to 50
- `imageHeight` - `optional`: `CGFloat` image width. Defaults to 50
- `showCardAlert`: `Bool` State to show alert

Binding parameters can be used with an `alert` or `confirmationDialog`

- `bindingID`: `String` pass State to store ID.
- `bindingText`: `String` pass State to store text. This maybe the same as titleText
- `bindingSubText`: `String` pass State to store text. This maybe the same as subText

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
                                                                                                                                    
# Credits

Credit to https://lukaszadam.com/ for rocket image

# Author

Rob Evans, robert.evansii@gmail.com

# License

CloudKitStatus is available under the MIT license. See the LICENSE file for more info.

