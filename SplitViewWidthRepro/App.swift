import SwiftUI

@main
struct SplitViewWidthReproApp: App {
    var body: some Scene {
        Window("NavigationSplitView Width Reproduction", id: "main") {
            NavigationSplitView {
                column("Sidebar", color: .blue)
                    .navigationSplitViewColumnWidth(min: 200, ideal: 300, max: 400)
            } content: {
                column("Content", color: .orange)
            } detail: {
                column("Detail", color: .green)
                    .navigationSplitViewColumnWidth(min: 300, ideal: 480, max: .infinity)
            }
        }
        .defaultSize(width: 1_400, height: 700)
    }

    private func column(_ title: String, color: Color) -> some View {
        ZStack {
            color.opacity(0.12)
            Text(title)
                .font(.title)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
