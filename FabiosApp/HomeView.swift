//
//  HomeView.swift
//  FabiosApp
//
//  Created by Fabio Baser on 06.07.20.
//  Copyright © 2020 Fabio Baser. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    @Binding var showContent: Bool

    @State var showUpdate = false

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Watching")
                        .font(.system(size: 28, weight: .bold))

                    Spacer()

                    AvatarView(showProfile: $showProfile)

                    Button(action: { self.showUpdate.toggle() }) {
                        Image(systemName: "bell")
                            .foregroundColor(.primary)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 36, height: 36)
                            .background(Color("background3"))
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    }
                    .sheet(isPresented: $showUpdate) {
                        UpdateList()
                    }
                }
                .padding(.horizontal)
                .padding(.leading, 14)
                .padding(.top, 30)

                ScrollView(.horizontal, showsIndicators: false) {
                    WatchRingsView()
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                        .onTapGesture {
                            self.showContent = true
                        }
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(sectionData) { item in
                            GeometryReader { geometry in
                                SectionView(section: item)
                                    .rotation3DEffect(Angle(degrees:
                                        Double(geometry.frame(in: .global).minX - 30) / -20
                                    ), axis: (x: 0, y: 10, z: 0))
                            }
                            .frame(width: 275, height: 275)
                        }
                    }
                    .padding(30)
                    .padding(.bottom, 30)
                }
                .offset(y: -30)
                HStack {
                    Text("Courses")
                        .font(.title).bold()
                    Spacer()
                }
                .padding(.leading, 30)
                .offset(y: -60)

                SectionView(section: sectionData[2], width: screen.width - 60, height: 275)
                    .offset(y: -60)

                Spacer()
            }
            .frame(width: screen.width)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(true))
    }
}

struct SectionView: View {
    var section: Section
    var width: CGFloat = 275
    var height: CGFloat = 275

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                Spacer()
                Image(section.logo)
            }

            Text(section.text.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)

            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

let sectionData = [
    Section(title: "Prototype designs in SwiftUI", text: "18 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card4")), color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))),
    Section(title: "Build a SwiftUI app", text: "20 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Background1")), color: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))),
    Section(title: "SwiftUI Advanced", text: "20 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card2")), color: Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)))
]

struct WatchRingsView: View {
    var body: some View {
        HStack(spacing: 15) {
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1), color2: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), width: 44, height: 44, percent: 66, show: .constant(true))
                VStack(alignment: .leading, spacing: 4.0) {
                    Text("6 min left")
                        .fontWeight(.bold)
                        .modifier(FontModifier(style: .subheadline))
                    Text("watched 10 mins today")
                        .modifier(FontModifier(style: .caption))
                }
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())

            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), color2: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1), width: 32, height: 32, percent: 54, show: .constant(true))
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())

            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), color2: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), width: 32, height: 32, percent: 90, show: .constant(true))
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
        }
    }
}
