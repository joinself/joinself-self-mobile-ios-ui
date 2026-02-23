//
//  CustomRequestCell.swift
//  SelfUI
//
//  Created by Long Pham on 6/10/24.
//

import SwiftUI

// MARK: - Accepted State
// Shows a green-bordered card with a checkmark icon, message text, and "Approved" badge
private struct CustomRequestAcceptedView: View {
    let messageDTO: MessageDTO

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image("ic_accept_request", bundle: mainBundle)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)

            VStack(alignment: .leading, spacing: 6) {
                Text(messageDTO.text)
                    .multilineTextAlignment(.leading)
                    .font(.defaultBody)
                    .foregroundStyle(Color.textPrimary)

                StatusLabel(label: "label_agreed".localized, backgroundColor: .defaultGreen)
            }
        }
    }
}

// MARK: - Rejected State
// Shows a pink-bordered card with a checkmark icon, message text, and "Rejected" badge
private struct CustomRequestRejectedView: View {
    let messageDTO: MessageDTO

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image("ic_accept_request", bundle: mainBundle)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)

            VStack(alignment: .leading, spacing: 6) {
                Text(messageDTO.text)
                    .multilineTextAlignment(.leading)
                    .font(.defaultBody)
                    .foregroundStyle(Color.textPrimary)

                StatusLabel(label: "label_rejected".localized, backgroundColor: .defaultPink)
            }
        }
    }
}

// MARK: - Pending State
// Shows a plain card with message text, a divider, and a single "Agree" button
private struct CustomRequestPendingView: View {
    let messageDTO: MessageDTO
    let actionAccept: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(messageDTO.text)
                .multilineTextAlignment(.leading)
                .font(.defaultBody)
                .foregroundStyle(Color.textPrimary)

            Divider()

            CustomButton(
                buttonTitle: "button_agree".localized,
                buttonTitleColor: .defaultGreen
            ) {
                actionAccept?()
            }
        }
    }
}

// MARK: - Public Cell
public struct CustomRequestCell: View {
    @Binding var messageDTO: MessageDTO
    private var actionAccept: (() -> Void)?
    private var actionReject: (() -> Void)?

    public init(
        messageDTO: Binding<MessageDTO>,
        actionAccept: (() -> Void)? = nil,
        actionReject: (() -> Void)? = nil
    ) {
        self._messageDTO = messageDTO
        self.actionAccept = actionAccept
        self.actionReject = actionReject
    }

    public var body: some View {
        BaseCell(messageDTO: messageDTO) {
            switch messageDTO.status {
            case .accepted:
                CustomRequestAcceptedView(messageDTO: messageDTO)
            case .rejected:
                CustomRequestRejectedView(messageDTO: messageDTO)
            default:
                CustomRequestPendingView(messageDTO: messageDTO, actionAccept: actionAccept)
            }
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        CustomRequestCell(
            messageDTO: .constant(MessageDTO(
                id: UUID().uuidString,
                text: "You have completed the Admin application setup.",
                fromType: .receiver,
                status: .accepted,
                timestamp: "20:13"
            ))
        )
        CustomRequestCell(
            messageDTO: .constant(MessageDTO(
                id: UUID().uuidString,
                text: "You have completed the Controller Pairwise Identity Negotiation.",
                fromType: .receiver,
                status: .rejected,
                timestamp: "20:13"
            ))
        )
        CustomRequestCell(
            messageDTO: .constant(MessageDTO(
                id: UUID().uuidString,
                text: "You have received a request to create the Controller Identity.\nRequired: a selfie",
                fromType: .receiver,
                status: .pending,
                timestamp: "20:14"
            ))
        )
    }
    .padding()
}
