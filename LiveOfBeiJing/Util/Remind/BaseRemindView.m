//
//  BaseRemindView.m
//  LiveOfBeiJing
//
//  Created by Bingo on 2018/11/29.
//

#import "BaseRemindView.h"
#import <SFDraggableDialogView.h>
@interface BaseRemindView ()<SFDraggableDialogViewDelegate>

@property (nonatomic, strong) SFDraggableDialogView *dialogView;

@end
@implementation BaseRemindView


-(instancetype)instanceViewWithFrame:(CGRect)frame

{
    if ([self init]) {
        self.frame = frame;
        [self configUi];
    }
    return self;
}

- (void)configUi
{
    SFDraggableDialogView *dialogView = [[[NSBundle mainBundle] loadNibNamed:@"SFDraggableDialogView" owner:self options:nil] firstObject];
   
    dialogView.frame = self.frame;
    dialogView.delegate = self;
    dialogView.dialogBackgroundColor = [UIColor whiteColor];
    dialogView.cornerRadius = 8.0;
    dialogView.backgroundShadowOpacity = 0.2;
    dialogView.hideCloseButton = YES;
    dialogView.showSecondBtn = NO;
    dialogView.contentViewType = SFContentViewTypeDefault;
    dialogView.firstBtnBackgroundColor = RGBColor(102, 102, 102);
    [dialogView createBlurBackgroundWithImage:[self jt_imageWithView:self] tintColor:[[UIColor blackColor] colorWithAlphaComponent:0.35] blurRadius:60.0];
    
    [self addSubview:dialogView];
    self.dialogView = dialogView;
}
- (NSMutableAttributedString *)exampleAttributeString:(NSString *)string color:(UIColor *)color {
    
    NSDictionary *attributeDict = @{
                                    NSFontAttributeName:[UIFont fontWithName:fFont size:15.f],
                                    NSForegroundColorAttributeName:color
                                    };
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:attributeDict];

    return attributedString;
}


-(void)setTitleString:(NSString *)titleString
{
    self.dialogView.titleText = [[NSMutableAttributedString alloc] initWithString:titleString];
}
-(void)setMessageString:(NSString *)messageString
{
    self.dialogView.messageText = [self exampleAttributeString:messageString color:RGBColor(102, 102, 102)];
}
-(void)setFirstButtonString:(NSString *)firstButtonString
{
    self.dialogView.firstBtnText = [firstButtonString uppercaseString];
}
-(void)setRemindImgString:(NSString *)remindImgString
{
    self.dialogView.photo = [UIImage imageNamed:remindImgString];
}
-(void)setCannelButtonString:(NSString *)cannelButtonString
{
    self.dialogView.cancelArrowText = [self exampleAttributeString:cannelButtonString color:RGBColor(102, 102, 102)];
}
#pragma mark - SFDraggableDialogViewDelegate
- (void)draggableDialogView:(SFDraggableDialogView *)dialogView didPressFirstButton:(UIButton *)firstButton {
    
    self.hidden = YES;
    if (self.remindViewDelegate && [self.remindViewDelegate respondsToSelector:@selector(remindView:didPressFirstButton:)]) {
        [self.remindViewDelegate remindView:self didPressFirstButton:firstButton];
    }
}

- (void)draggingDidBegin:(SFDraggableDialogView *)dialogView {
    NSLog(@"Dragging has begun");
}

- (void)draggingDidEnd:(SFDraggableDialogView *)dialogView {
    NSLog(@"Dragging did end");
}

- (void)draggableDialogViewWillDismiss:(SFDraggableDialogView *)dialogView {
    NSLog(@"Will be dismissed");
}

- (void)draggableDialogViewDismissed:(SFDraggableDialogView *)dialogView {
    self.hidden = YES;
}

#pragma mark - Snapshot
- (UIImage *)jt_imageWithView:(UIView *)view {
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, scale);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:true];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
