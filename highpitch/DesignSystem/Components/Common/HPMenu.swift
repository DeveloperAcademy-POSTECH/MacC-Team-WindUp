//
//  HPMenu.swift
//  highpitch
//
//  Created by yuncoffee on 10/20/23.
//

import SwiftUI

struct HPMenu: View {
    @State
    var displayName: String?
    
    @Binding
    var selected: String
    
    @Binding
    var options: [String]

    var maxWidth: CGFloat = 148
    var maxHeight: CGFloat = 22
    
    var body: some View {
        ZStack {
            HStack {
                let label = if let displayName {displayName} else {selected}
                Text(label)
                    .lineLimit(1)
                    .systemFont(.caption2)
                    .foregroundStyle(Color.HPTextStyle.darker)
                    .padding(.vertical, 3)
                    .frame(maxWidth: maxWidth - (16) - (10) - (7 + 3))
                Label("열기", systemImage: "chevron.right")
                    .labelStyle(.iconOnly)
                    .font(.system(size: 7))
                    .fontWeight(.heavy)
                    .frame(width: 16, height: 16)
            }
            .frame(alignment: .leading)
            NSPopUpButtonView(selectedOption: $selected, options: options)
        }
        .padding(.vertical, 3)
        .padding(.leading, 7)
        .padding(.trailing, 3)
        .background(Color.white)
        .frame(maxWidth: maxWidth, maxHeight: maxHeight)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.3), radius: 2.5, y: 0.5)
    }
}

struct MenubarExtraMenuStyle: MenuStyle {
    func makeBody(configuration: Configuration) -> some View {
        Menu(configuration)
            .padding(.vertical, 24)
            .background(Color.yellow)
        
    }
}

#Preview {
    @State var selected = "sample"
    @State var options = ["sample", "sample2", "sample3123456"]
    return HPMenu(selected: $selected, options: $options)
            .padding(24)
}

struct NSPopUpButtonView: NSViewRepresentable {
    @Binding var selectedOption: String
    var options: [String]
    
    func makeNSView(context: Context) -> NSPopUpButton {
        let popUpButton = NSPopUpButton(frame: .zero, pullsDown: false)
        let cell = NSPopUpButtonCell()
        cell.arrowPosition = .noArrow
        popUpButton.isTransparent = true
        popUpButton.cell = cell
        popUpButton.isBordered = false
        popUpButton.bezelColor = .audiocontroller
        popUpButton.addItems(withTitles: options)
        popUpButton.target = context.coordinator
        popUpButton.action = #selector(Coordinator.popUpButtonAction(_:))
        
        for index in 0..<options.count {
            popUpButton.menu?.items[index].attributedTitle = NSAttributedString(
                string: options[index],
                attributes: [.font: NSFont.systemFont(ofSize: 13, weight: .medium)])
        }
        
        return popUpButton
    }
    
    func updateNSView(_ nsView: NSPopUpButton, context: Context) {
        let selectedMenuItem = nsView.selectedItem
        nsView.isTransparent = true
        let selectedFont = NSFont.systemFont(ofSize: 13)
        let attributes: [NSAttributedString.Key: Any] = [.font: selectedFont]
        selectedMenuItem?.attributedTitle = NSAttributedString(
            string: selectedMenuItem?.title ?? "",
            attributes: attributes
        )
        nsView.selectItem(withTitle: selectedOption)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: NSPopUpButtonView
        
        init(_ parent: NSPopUpButtonView) {
            self.parent = parent
        }
        
        @objc func popUpButtonAction(_ sender: NSPopUpButton) {
            if let selectedOption = sender.titleOfSelectedItem {
                parent.selectedOption = selectedOption
            }
        }
    }
}
