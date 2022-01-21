//
//  CommonViews.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-10-03.
//

import SwiftUI

struct Generalize<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    let content: () -> Content
    var body: some View {
        ZStack {
            Color(colorScheme == .light ? backgroundColor : backgroundDarkMode)
                .edgesIgnoringSafeArea(.all)
            
            content()
                .frame(maxWidth: screenWidth)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarHidden(true)
    }
}

// MARK: Capsulize
struct Capsulize<Content: View>: View {
    let capsuleColor: Color
    let capsulePaddingSize: CGFloat = 10
    let content: () -> Content
    var isTranslucent: Bool = false

    
    init(capsuleColor: Color, isTranslucent: Bool = true, content: @escaping () -> Content) {
        self.capsuleColor = capsuleColor
        self.content = content
        self.isTranslucent = isTranslucent
    }
    
    var body: some View {
        content()
            .lineLimit(1)
            .padding([.leading, .trailing], capsulePaddingSize/0.5)
            .padding([.top, .bottom], capsulePaddingSize/1.2)
            .background(
                Capsule()
                    .foregroundColor(capsuleColor)
                    .opacity(isTranslucent ? 0.1 : 1)

            )
    }
}
// MARK: Rectanglize
struct Rectanglize<Content: View>: View {
    let rectangleColor: Color
    let rectanglePaddingSize: CGFloat = 10
    let cornerRadius: CGFloat = 10
    let content: () -> Content
    var isTranslucent: Bool = false
    
    init(rectangleColor: Color,isTranslucent: Bool = true, content: @escaping () -> Content) {
        self.rectangleColor = rectangleColor
        self.content = content
        self.isTranslucent = isTranslucent
    }

    var body: some View {
        content()
            .lineLimit(1)
            .padding(rectanglePaddingSize)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(rectangleColor)
                    .opacity(isTranslucent ? 0.1 : 1)
            )
    }
}

// MARK: DropdownTextField
struct DropdownTextField: View {
    let title: String
    let prompt: String
    @Binding var searchInput: String
    private var maximumLength: Int
    private var keyboardType: UIKeyboardType
    private var uppercaseOnly: Bool
    let dropDownList: [String]
    let removeButtonSize: CGFloat = 18
    let fieldHeight: CGFloat = 45
    let cornerRadius: CGFloat = 10
    let lineWidth: CGFloat = 0.8
    
    init(title:String, prompt: String, searchInput: Binding<String>, dropDownList: [String], maximumLength: Int = 999, keyboardType: UIKeyboardType = .default, uppercaseOnly: Bool = false) {
        self.title = title
        self.prompt = prompt
        self.dropDownList = dropDownList
        self._searchInput = searchInput
        self.maximumLength = maximumLength
        self.keyboardType = keyboardType
        self.uppercaseOnly = uppercaseOnly
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .bold()
            
            ZStack(alignment: .leading){
                let binding = Binding<String>(get: {
                    self.searchInput
                }, set: {
                    self.searchInput = $0
                    if (searchInput.count > maximumLength) {
                        searchInput = String(searchInput.dropLast())
                    }
                })

                if searchInput.isEmpty {
                    Text(prompt)
                        .foregroundColor(.gray)
                }

                TextField("", text: binding)
                    .keyboardType(keyboardType)
                    .disableAutocorrection(true)
                    .autocapitalization(uppercaseOnly ? .allCharacters : .words)
            }
            .padding()
            .frame(height: fieldHeight)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.gray, lineWidth: lineWidth)
            )
            
            if searchInput != "" && !dropDownList.contains(searchInput) {
                ScrollView {
                    ForEach(dropDownList.filter{$0.capitalized.contains(searchInput.capitalized) || searchInput == ""}, id: \.self) {
                        suggestion in
                        
                        VStack(alignment: .leading) {
                            Button(action: {
                                searchInput = suggestion
                            }) {
                                Text(suggestion)
                                    .foregroundColor(.primary)
                            }
                            .padding(3)
                            
                            Divider()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

// MARK: CustomTextField
struct CustomTextField: View {
    private var prompt: String
    @Binding var input: String
    let fieldHeight: CGFloat = 45
    let cornerRadius: CGFloat = 10
    let lineWidth: CGFloat = 0.8
    private var forcedPlaceHolder: String
    private var maximumLength: Int
    private var keyboardType: UIKeyboardType
    private var uppercaseOnly: Bool
    private var lowercaseOnly: Bool
    private var strokeColor: Color
    
    init(_ prompt: String, input: Binding<String>, forcedPlaceHolder: String = "", maximumLength: Int = 999, keyboardType: UIKeyboardType = .default, uppercaseOnly: Bool = false, lowercaseOnly: Bool = false, strokeColor : Color = Color.gray) {
        self.prompt = prompt
        self._input = input
        self.forcedPlaceHolder = forcedPlaceHolder
        self.maximumLength = maximumLength
        self.keyboardType = keyboardType
        self.uppercaseOnly = uppercaseOnly
        self.lowercaseOnly = lowercaseOnly
        self.strokeColor = strokeColor
    }

    var body: some View {
        ZStack(alignment: .leading){
            let binding = Binding<String>(get: {
                self.input
            }, set: {
                self.input = $0
                if (input.count > maximumLength) {
                    input = String(input.dropLast())
                }
                if (lowercaseOnly) {
                    input = input.lowercased()
                }
            })

            if (input.isEmpty) {
                Text(prompt)
                    .foregroundColor(.secondary)
                    .opacity(0.5)
            }

            HStack {
                TextField("", text: binding)
                    .keyboardType(keyboardType)
                    .disableAutocorrection(true)
                    .autocapitalization(uppercaseOnly ? .allCharacters : .words)
                
                if (!forcedPlaceHolder.isEmpty) {
                    Text(forcedPlaceHolder)
                        .foregroundColor(.primary)
                }
            }
            
        }
        .padding()
        .frame(height: fieldHeight)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius).stroke(strokeColor, lineWidth: lineWidth)
        )
    }
}

// MARK: PasswordTextField_Secure
struct PasswordTextField_Secure: View {
    private var prompt: String
    @Binding var password: String
    @State private var isSecured: Bool = true
    let eyeButtonWidth: CGFloat = 18
    let eyeButtonHeight: CGFloat = 13
    let fieldHeight: CGFloat = 45
    let cornerRadius: CGFloat = 10
    let lineWidth: CGFloat = 0.8
    private let strokeColor: Color

    init(_ prompt: String, password: Binding<String>, strokeColor: Color = Color.gray) {
        self.prompt = prompt
        self._password = password
        self.strokeColor = strokeColor
    }
    
    var body: some View {
        HStack{
            if isSecured {
                SecureField(prompt, text: $password)
            } else {
                TextField(prompt, text: $password)
            }
            
            if (!password.isEmpty) {
                Button(action: {
                    isSecured.toggle()
                }) {
                    Image(systemName: self.isSecured ? "eye.slash" : "eye")
                        .resizable()
                        .accentColor(.primary)
                        .frame(width: eyeButtonWidth, height: eyeButtonHeight)
                }
            }
        }
        .padding()
        .frame(height: fieldHeight)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius).stroke(strokeColor, lineWidth: lineWidth)
        )
    }
}

// MARK: ReenterPasswordTextField
struct ReenterPasswordTextField: View {
    private var prompt: String
    private var password: String
    @Binding var passwordInput: String
    let removeButtonSize: CGFloat = 18
    let fieldHeight: CGFloat = 45
    let cornerRadius: CGFloat = 10
    let lineWidth: CGFloat = 0.8
    private let warning: Bool

    init(_ prompt: String, password: String, passwordInput: Binding<String>, warning: Bool = false) {
        self.prompt = prompt
        self.password = password
        self._passwordInput = passwordInput
        self.warning = warning
    }
    
    var strokeColor: Color {
        if passwordInput.isEmpty {
            return Color.gray
        } else {
            return (password == passwordInput ? Color.green : Color.red)
        }
    }
    
    var body: some View {
        SecureField(prompt, text: $passwordInput)
        .padding()
        .frame(height: fieldHeight)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(cornerRadius)
        .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(warning ? Color.red : strokeColor, lineWidth: lineWidth))
    }
}

// MARK: TITLE HEADER
struct TitleHeader: View {
    let mainTitle: String
    let subTitle: String
    let subTitle2: String
    
    init (mainTitle: String, subTitle : String = "", subTitle2: String = "") {
        self.mainTitle = mainTitle
        self.subTitle = subTitle
        self.subTitle2 = subTitle2
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(mainTitle)
                .foregroundColor(.primary)
                .fontWeight(.bold)
                .font(.title)
                .minimumScaleFactor(0.01)
                .lineLimit(1)
            
            if (!subTitle.isEmpty) {
                Text(subTitle)
                    .foregroundColor(.secondary)
                    .fontWeight(.regular)
                    .font(.subheadline)
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
            }
            
            if (!subTitle2.isEmpty) {
                Text(subTitle2)
                    .foregroundColor(.secondary)
                    .fontWeight(.regular)
                    .font(.subheadline)
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
            }
        }
    }
}

// MARK: NextButton_OnlyTextExists
struct NextButton_OnlyTextExists: View {
    @Binding var text: String
    
    var body: some View {
        NavigationLink(destination: Text("DONE")) {
            Capsulize(capsuleColor: .green, isTranslucent: text.isEmpty) {
                Text("Next")
                    .foregroundColor(.white)
            }
        }
        .disabled(text.isEmpty)
    }
}

struct Header_TitleDismiss: View {
    @Environment(\.presentationMode) var presentationMode
    let boardTitle: String
    let dismissName: String
    
    init(boardTitle: String = "", dismissName: String = "") {
        self.boardTitle = boardTitle
        self.dismissName = dismissName
    }
    
    var body: some View {
        VStack() {
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    if dismissName.isEmpty {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.primary)
                            .padding(.leading)
                    } else {
                        Text(dismissName)
                            .foregroundColor(.primary)
                    }
                }
                if !boardTitle.isEmpty {
                    Spacer()
                    Text(boardTitle)
                        .foregroundColor(.primary)
                        .font(.title3)
                        .fontWeight(.regular)
                    Spacer()
                    Text("")
                        .padding(.trailing)
                } else {
                    Spacer()
                }
            }
            
            Divider()
        }
    }
}

struct Dropdown: View {
    let height: CGFloat
    let options: [String]
    @Binding var selection: String
    @State var showDropDown: Bool = false
    
    var body: some View {
        Button(action: {
            self.showDropDown.toggle()
        }) {
            HStack {
                Text(selection)
                    .font(.system(size: 14))
                    .foregroundColor(.primary)

                Spacer()

                Image(systemName: self.showDropDown ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                    .resizable()
                    .frame(width: 9, height: 5)
                    .font(Font.system(size: 9, weight: .medium))
                    .foregroundColor(.primary)
            }
        }
        .padding(.horizontal)
        .cornerRadius(5)
        .frame(width: .infinity, height: 20)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 1)
        )
        .overlay(
            VStack {
                if self.showDropDown {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(self.options, id: \.self) { option in
                                DropdownRow(option: option, selection: $selection, showDropDown: $showDropDown)
                            }
                        }
                    }
                    .frame(height: height)
                    .padding(.vertical, 5)
                    .background(Color.white)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
            }
                .offset(y: 30)
            , alignment: .topLeading
        )
        .background(
            RoundedRectangle(cornerRadius: 5).fill(Color(backgroundColor))
        )
    }
}

struct DropdownRow: View {
    var option: String
    @Binding var selection: String
    @Binding var showDropDown: Bool

    var body: some View {
        Button(action: {
            self.selection = self.option
            self.showDropDown.toggle()
        }) {
            HStack {
                Text(self.option)
                    .font(.system(size: 14))
                    .foregroundColor(Color.black)
                Spacer()
            }
        }
        .background(Color.white)
        .padding(.horizontal, 16)
        .padding(.vertical, 5)
    }
}

// MARK: Popover
struct Popover<Content: View>: View {
    
    @Binding var showPopover: Bool
    let prompt: String
    let content: () -> Content
    
    var body: some View {
        content()
            .background(
                Wrapper(showPopover: $showPopover) {
                    VStack(alignment: .center) {
                        Text(prompt)
                    }
                    .onTapGesture {
                        self.showPopover = false
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
    }
    
    struct Wrapper<PopoverContent: View> : UIViewControllerRepresentable {
        
        @Binding var showPopover: Bool
        let popoverContent: () -> PopoverContent
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<Wrapper<PopoverContent>>) -> WrapperViewController<PopoverContent>{
            return WrapperViewController(popoverContent: popoverContent)
        }
        
        func updateUIViewController(_ uiViewController: WrapperViewController<PopoverContent>,
                                    context: UIViewControllerRepresentableContext<Wrapper<PopoverContent>>) {
            if showPopover {
                uiViewController.showPopover()
            }
            else {
                uiViewController.hidePopover()
            }
        }
    }
    
    class WrapperViewController<PopoverContent: View>: UIViewController, UIPopoverPresentationControllerDelegate {
        
        let popoverContent: () -> PopoverContent
        
        var popoverVC: UIViewController?
        
        required init?(coder: NSCoder) { fatalError("") }
        init(popoverContent: @escaping () -> PopoverContent) {
            self.popoverContent = popoverContent
            super.init(nibName: nil, bundle: nil)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        func showPopover() {
            guard popoverVC == nil else { return }
            let vc = UIHostingController(rootView: popoverContent())
            vc.preferredContentSize = CGSize(width: screenWidth * 0.8, height: screenHeight * 0.07)
            vc.modalPresentationStyle = UIModalPresentationStyle.popover
            if let popover = vc.popoverPresentationController {
                popover.sourceView = view
                popover.delegate = self
            }
            popoverVC = vc
            self.present(vc, animated: true, completion: nil)
        }
        
        func hidePopover() {
            guard let vc = popoverVC, !vc.isBeingDismissed else { return }
            vc.dismiss(animated: true, completion: nil)
            popoverVC = nil
        }
        
        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            popoverVC = nil
        }
        
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }
    }
}

// MARK: PickerField
struct PickerField: UIViewRepresentable {
    @Binding var selectionIndex: Int?

    init<S>(_ title: S, data: [String], selectionIndex: Binding<Int?>) where S: StringProtocol {
        self.placeholder = String(title)
        self.data = data
        self._selectionIndex = selectionIndex

        textField = PickerTextField(data: data, selectionIndex: selectionIndex)
    }

    func makeUIView(context: UIViewRepresentableContext<PickerField>) -> UITextField {
        textField.placeholder = placeholder
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<PickerField>) {
        if let index = selectionIndex {
            uiView.text = data[index]
        } else {
            uiView.text = ""
        }
    }

    private var placeholder: String
    private var data: [String]
    private let textField: PickerTextField
}

// MARK: PickerTextField
class PickerTextField: UITextField {
    var data: [String]
    @Binding var selectionIndex: Int?

    init(data: [String], selectionIndex: Binding<Int?>) {
        self.data = data
        self._selectionIndex = selectionIndex
        super.init(frame: .zero)

        self.inputView = pickerView
        self.tintColor = .clear
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
            
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        self.inputAccessoryView = toolBar
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    @objc private func donePressed() {
        if selectionIndex == nil {
            selectionIndex = 0
        }
        self.resignFirstResponder()
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            false
    }
        
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        []
    }

    override func caretRect(for position: UITextPosition) -> CGRect {
        .zero
    }
}

extension PickerTextField: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.data.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.data[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectionIndex = row
    }
}

struct CommonView_Previes: PreviewProvider {
    static var previews: some View {
        Group {
            Header_TitleDismiss()
                .preview(with: "Header Title Dismiss")
            Header_TitleDismiss(boardTitle: "adfsdfs")
                .preview(with: "Header Title Dismiss")
            CustomTextField("", input: .constant(""))
                .preview(with: "Custom Text Field")
        }
    }
}
