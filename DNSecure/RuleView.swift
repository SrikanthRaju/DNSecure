//
//  RuleView.swift
//  DNSecure
//
//  Created by Kenta Kubo on 10/27/20.
//

import NetworkExtension
import SwiftUI

struct RuleView {
    @Binding var rule: OnDemandRule
}

extension RuleView: View {
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("Name")
                    TextField("Name", text: self.$rule.name)
                        .multilineTextAlignment(.trailing)
                }
                Picker("Action", selection: self.$rule.action) {
                    ForEach(NEOnDemandRuleAction.allCases, id: \.self) {
                        Text($0.description)
                    }
                }
            }

            Section(
                header: Text("Interface Type Match"),
                footer: Text("If the current primary network interface is of this type and all of the other conditions in the rule match, then the rule matches.")
            ) {
                Picker("Interface Type", selection: self.$rule.interfaceType) {
                    ForEach(NEOnDemandRuleInterfaceType.allCases, id: \.self) {
                        Text($0.description)
                    }
                }
            }

            if self.rule.interfaceType == .wiFi {
                Section(
                    header: Text("SSID Match"),
                    footer: Text("If the Service Set Identifier (SSID) of the current primary connected network matches one of the strings in this array and all of the other conditions in the rule match, then the rule matches.")
                ) {
                    ForEach(0..<self.rule.ssidMatch.count, id: \.self) { i in
                        TextField("SSID", text: self.$rule.ssidMatch[i])
                    }
                    .onDelete { self.rule.ssidMatch.remove(atOffsets: $0) }
                    .onMove { self.rule.ssidMatch.move(fromOffsets: $0, toOffset: $1) }
                    Button("Add SSID") {
                        self.rule.ssidMatch.append("")
                    }
                }
            }

            Section(
                header: Text("DNS Search Domain Match"),
                footer: Text("If the current default search domain is equal to one of the strings in this array and all of the other conditions in the rule match, then the rule matches.")
            ) {
                ForEach(0..<self.rule.dnsSearchDomainMatch.count, id: \.self) { i in
                    TextField("Search Domain", text: self.$rule.dnsSearchDomainMatch[i])
                }
                .onDelete { self.rule.dnsSearchDomainMatch.remove(atOffsets: $0) }
                .onMove { self.rule.dnsSearchDomainMatch.move(fromOffsets: $0, toOffset: $1) }
                Button("Add DNS Search Domain") {}
            }

            Section(
                header: Text("DNS Server Address Match"),
                footer: Text("If each of the current default DNS servers is equal to one of the strings in this array and all of the other conditions in the rule match, then the rule matches.")
            ) {
                ForEach(0..<self.rule.dnsServerAddressMatch.count, id: \.self) { i in
                    TextField("IP Address", text: self.$rule.dnsServerAddressMatch[i])
                }
                .onDelete { self.rule.dnsSearchDomainMatch.remove(atOffsets: $0) }
                .onMove { self.rule.dnsSearchDomainMatch.move(fromOffsets: $0, toOffset: $1) }
                Button("Add DNS Server Address") {}
            }

            Section(
                header: Text("Probe URL Match"),
                footer: Text("If a request sent to this URL results in a HTTP 200 OK response and all of the other conditions in the rule match, then the rule matches.")
            ) {
                Toggle("Use Probe URL", isOn: self.$rule.useProbeURL)
                if self.rule.useProbeURL {
                    HStack {
                        Text("Probe URL")
                        TextField("URL", text: self.$rule.probeURL)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
        }
        .navigationTitle(self.rule.name)
    }
}

struct RuleView_Previews: PreviewProvider {
    static var previews: some View {
        RuleView(rule: .constant(OnDemandRule(name: "Preview Rule")))
    }
}
