//
//  TJChatListCell.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/5/10.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "TJChatListCell.h"
#import "NSDate+Category.h"
#import "ConvertToCommonEmoticonsHelper.h"

@interface TJChatListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *chatterAvatar;
@property (weak, nonatomic) IBOutlet UILabel *chatterNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailMsgLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation TJChatListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setCellWithConversation:(EMConversation *)conversation {
    self.chatterAvatar.image = [UIImage imageNamed:@"chatListCellHead.png"];
    self.chatterNameLabel.text = conversation.chatter;
    self.detailMsgLabel.text = [self subTitleMessageByConversation:conversation];
    self.timeLabel.text = [self lastMessageTimeByConversation:conversation];
}

// 得到最后消息时间
-(NSString *)lastMessageTimeByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];;
    if (lastMessage) {
        ret = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    
    return ret;
}

// 得到未读消息条数
- (NSInteger)unreadMessageCountByConversation:(EMConversation *)conversation
{
    NSInteger ret = 0;
    ret = conversation.unreadMessagesCount;
    
    return  ret;
}

// 得到最后消息文字或者类型
-(NSString *)subTitleMessageByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];
    if (lastMessage) {
        id<IEMMessageBody> messageBody = lastMessage.messageBodies.lastObject;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Image:{
                ret = NSLocalizedString(@"message.image1", @"[image]");
            } break;
            case eMessageBodyType_Text:{
                // 表情映射。
                NSString *didReceiveText = [ConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                ret = didReceiveText;
            } break;
            case eMessageBodyType_Voice:{
                ret = NSLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case eMessageBodyType_Location: {
                ret = NSLocalizedString(@"message.location1", @"[location]");
            } break;
            case eMessageBodyType_Video: {
                ret = NSLocalizedString(@"message.vidio1", @"[vidio]");
            } break;
            default: {
            } break;
        }
    }
    
    return ret;
}

@end
