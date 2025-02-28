//
//  TVOCallMessageDelegate.h
//  TwilioVoice
//
//  Copyright © 2022 Twilio, Inc. All rights reserved.
//

@class TVOCallMessage;

/**
 *  `TVOCallMessageDelegate` provides callbacks when call message is received or when the result of outbound message request is available.
 */
NS_SWIFT_NAME(CallMessageDelegate)
@protocol TVOCallMessageDelegate <NSObject>

@optional

/**
 * @brief Notifies the delegate that a message with the event type is received during a `<TVOCall>`.
 *
 * @param callSid The unique identifier of the `<TVOCall>` or `<TVOCallInvite>` that received the message.
 * @param callMessage The `<TVOCallMessage>`.
 *
 * @discussion This feature is currently in Beta.
 */
- (void)messageReceivedForCallSid:(nonnull NSString *)callSid message:(nonnull TVOCallMessage *)callMessage
NS_SWIFT_NAME(messageReceived(callSid:message:));

/**
 * @brief Notifies the delegate that a message was sent.
 *
 * @param callSid The unique identifier of the `<TVOCall>` or `<TVOCallInvite>` that successfully sent the message.
 * @param voiceEventSid The same unique identifier to be associated with the unique identifier returned from the
 * `[TVOCall sendMessage:]` or `[TVOCallInvite sendMessage:]` method.
 *
 * @discussion This feature is currently in Beta.
 */
- (void)messageSentForCallSid:(nonnull NSString *)callSid voiceEventSid:(nonnull NSString *)voiceEventSid
NS_SWIFT_NAME(messageSent(callSid:voiceEventSid:));

/**
 * @brief Notifies the delegate that a message was failed to be sent out.
 *
 * @param callSid The unique identifier of the `<TVOCall>` or `<TVOCallInvite>` that failed to send the message.
 * @param voiceEventSid The same unique identifier to be associated with the unique identifier returned from the
 * `[TVOCall sendMessage:]` or `[TVOCallInvite sendMessage:]` method.
 * @param error The `<NSError>` that occurred.
 *
 * @discussion This feature is currently in Beta.
 */

- (void)messageFailedForCallSid:(nonnull NSString *)callSid
                  voiceEventSid:(nonnull NSString *)voiceEventSid
                          error:(nonnull NSError *)error
NS_SWIFT_NAME(messageFailed(callSid:voiceEventSid:error:));

/**
 * @brief Notifies the delegate that a message with the event type is received during a `<TVOCall>`.
 *
 * @param call The `<TVOCall>` that received the message.
 * @param callMessage The `<TVOCallMessage>`.
 *
 * @discussion This feature is currently in Beta.
 */
- (void)call:(nonnull TVOCall *)call didReceiveMessage:(nonnull TVOCallMessage *)callMessage
NS_SWIFT_NAME(callDidReceiveMessage(call:message:))
__attribute__( (deprecated("Will not be supported in TwilioVoice v6.11+", "didReceiveMessage:message:")) );

/**
 * @brief Notifies the delegate that a message was sent.
 *
 * @param call The `<TVOCall>` that successfully sent the message.
 * @param voiceEventSid The same unique identifier to be associated with the unique identifier returned from the
 * `[TVOCall sendMessage:]` method.
 *
 * @discussion This feature is currently in Beta.
 */
- (void)call:(nonnull TVOCall *)call didSendMessage:(nonnull NSString *)voiceEventSid
NS_SWIFT_NAME(callDidSendMessage(call:voiceEventSid:))
__attribute__( (deprecated("Will not be supported in TwilioVoice v6.11+", "didSendMessage:voiceEventSid:")) );

/**
 * @brief Notifies the delegate that a message was failed to be sent out.
 *
 * @param call The `<TVOCall>` that failed to send the message.
 * @param voiceEventSid The same unique identifier to be associated with the unique identifier returned from the
 * `[TVOCall sendMessage:]` method.
 * @param error The `<NSError>` that occurred.
 *
 * @discussion This feature is currently in Beta.
 */
- (void)call:(nonnull TVOCall *)call
didFailToSendMessage:(nonnull NSString *)voiceEventSid
       error:(nonnull NSError *)error
NS_SWIFT_NAME(callDidFailToSendMessage(call:voiceEventSid:error:))
__attribute__( (deprecated("Will not be supported in TwilioVoice v6.11+", "didFailToSendMessage:voiceEventSid:error:")) );

/**
 * @brief Notifies the delegate that a message with the event type is received by the `<TVOCallInvite>`.
 *
 * @param callInvite The `<TVOCallInvite>` that received the message.
 * @param callMessage The `<TVOCallMessage>`.
 *
 * @discussion This feature is currently in Beta.
 */
- (void)callInvite:(nonnull TVOCallInvite *)callInvite
 didReceiveMessage:(nonnull TVOCallMessage *)callMessage
NS_SWIFT_NAME(callInviteDidReceiveMessage(callInvite:message:))
__attribute__( (deprecated("Will not be supported in TwilioVoice v6.11+", "didReceiveMessage:message:")) );

/**
 * @brief Notifies the delegate that a message was sent.
 *
 * @param callInvite The `<TVOCallInvite>` that successfully sent the message.
 * @param voiceEventSid The same unique identifier to be associated with the unique identifier returned from the
 * `[TVOCallInvite sendMessage:callMessageDelegate:]` method.
 *
 * @discussion This feature is currently in Beta.
 */
- (void)callInvite:(nonnull TVOCallInvite *)callInvite
    didSendMessage:(nonnull NSString *)voiceEventSid
NS_SWIFT_NAME(callInviteDidSendMessage(callInvite:voiceEventSid:))
__attribute__( (deprecated("Will not be supported in TwilioVoice v6.11+", "didSendMessage:voiceEventSid:")) );

/**
 * @brief Notifies the delegate that a message was failed to be sent out.
 *
 * @param callInvite The `<TVOCallInvite>` that failed to send the message.
 * @param voiceEventSid The same unique identifier to be associated with the unique identifier returned from the
 * `[TVOCallInvite sendMessage:callMessageDelegate:]` method.
 * @param error The `<NSError>` that occurred.
 *
 * @discussion This feature is currently in Beta.
 */
- (void)callInvite:(nonnull TVOCallInvite *)callInvite
didFailToSendMessage:(nonnull NSString *)voiceEventSid
             error:(nonnull NSError *)error
NS_SWIFT_NAME(callInviteDidFailToSendMessage(callInvite:voiceEventSid:error:))
__attribute__( (deprecated("Will not be supported in TwilioVoice v6.11+", "didFailToSendMessage:voiceEventSid:error:")) );

@end
