//
//  ViewController.m
//  CardView
//
//  Created by Thabresh on 9/8/16.
//  Copyright © 2016 VividInfotech. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#define kLENGTH 4
@interface ViewController ()
{
    BOOL clickFlip;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.blackCoting setHidden:YES];
    [self.txtCVV setHidden:YES];
    // Do any additional setup after loading the view, typically from a nib.
}
- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    return CGRectZero;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    }];
    return [super canPerformAction:action withSender:sender];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.tag == 0) {        
        if (range.location>=19) {
            return NO;
        }
        if (range.location == 18 && string.length>0) {
            self.txtCard.text = [self.txtCard.text stringByReplacingCharactersInRange:NSMakeRange(range.location, 1) withString:string];
            NSString *str = [textField.text stringByAppendingString:[NSString stringWithFormat:@"%@", string]];
            textField.text = str;
            [textField resignFirstResponder];
            [self.CVVDig becomeFirstResponder];
            return NO;
        }
        if (string.length > 0) {
            self.txtCard.text = [self.txtCard.text stringByReplacingCharactersInRange:NSMakeRange(range.location, 1) withString:string];
            NSUInteger length = textField.text.length;
            int cntr = (int)((length - (length/kLENGTH)) / kLENGTH);
            if (!(((length + 1) % kLENGTH) - cntr)) {
                NSString *str = [textField.text stringByAppendingString:[NSString stringWithFormat:@"%@ ", string]];
                textField.text = str;
                return NO;
            }
        }else {
            if ([textField.text hasSuffix:@" "]) {
                textField.text = [textField.text substringToIndex:textField.text.length - 2];
                self.txtCard.text = [self.txtCard.text stringByReplacingCharactersInRange:NSMakeRange(range.location-1, 1) withString:@"●"];
                return NO;
            }else{
                self.txtCard.text = [self.txtCard.text stringByReplacingCharactersInRange:NSMakeRange(range.location, 1) withString:@"●"];
            }
        }
        return YES;
    }else if (textField.tag == 1) {
        if (range.location>=5) {
            return NO;
        }
        if (range.location == 4 && string.length>0) {
            self.txtMonthYear.text = [self.txtMonthYear.text stringByReplacingCharactersInRange:NSMakeRange(range.location, 1) withString:string];
            textField.text = [textField.text stringByAppendingString:string];
            [textField resignFirstResponder];
            [self.txtCVVCVC becomeFirstResponder];
            return NO;
        }
        if (string.length > 0) {
            self.txtMonthYear.text = [self.txtMonthYear.text stringByReplacingCharactersInRange:NSMakeRange(range.location, 1) withString:string];
            NSUInteger length = textField.text.length;
            int cntr = (int)((length - (length/2)) / 2);
            if (!(((length + 1) % 2) - cntr)) {
                textField.text = [textField.text stringByAppendingString:[NSString stringWithFormat:@"%@/",string]];
                return NO;
            }
        }else {
            if ([textField.text hasSuffix:@"/"]) {
                textField.text = [textField.text substringToIndex:textField.text.length - 2];
                self.txtMonthYear.text = [self.txtMonthYear.text stringByReplacingCharactersInRange:NSMakeRange(range.location-1, 1) withString:@"●"];
                return NO;
            }else{
                self.txtMonthYear.text = [self.txtMonthYear.text stringByReplacingCharactersInRange:NSMakeRange(range.location, 1) withString:@"●"];
            }
        }
        return YES;
    }else{
        if (range.location>=3) {
            return NO;
        }
        if (string.length > 0) {
             self.txtCVV.text = [self.txtCVV.text stringByAppendingString:[NSString stringWithFormat:@"%@", string]];
         }else{
             self.txtCVV.text = [self.txtCVV.text stringByReplacingCharactersInRange:NSMakeRange(range.location, 1) withString:@""];
         }
        return YES;
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.txtCard setHidden:NO];
    [self.txtMonthYear setHidden:NO];
    [self.txtMonthTitle setHidden:NO];
    if (textField.tag == 0) {
        clickFlip = NO;
        [self FlipAnimationWithLeft];
        [self.blackCoting setHidden:YES];
        [self.txtCVV setHidden:YES];
    }else if (textField.tag == 1) {
        clickFlip = NO;
        [self FlipAnimationWithLeft];
        [self.blackCoting setHidden:YES];
        [self.txtCVV setHidden:YES];
    }else{
        clickFlip = YES;
        [self.txtCard setHidden:YES];
        [self.txtMonthYear setHidden:YES];
        [self.txtMonthTitle setHidden:YES];
        [self.blackCoting setHidden:NO];       
        [self FlipAnimationWithRight];
    }
}
-(void)FlipAnimationWithRight
{
    UIViewAnimationOptions curl = UIViewAnimationOptionTransitionFlipFromRight;
    [UIView transitionWithView:self.cardImage duration:0.5 options:(UIViewAnimationOptionCurveEaseInOut | curl) animations:^{
        
    } completion:nil];
    UIViewAnimationOptions curls = UIViewAnimationOptionTransitionFlipFromRight;
    [UIView transitionWithView:self.blackCoting duration:0.5 options:(UIViewAnimationOptionCurveEaseInOut | curls) animations:^{
    } completion:^(BOOL finished) {
        if (finished){
            [self.txtCVV setHidden:NO];
        }
    }];
}
-(void)FlipAnimationWithLeft
{
    UIViewAnimationOptions curslss = UIViewAnimationOptionTransitionFlipFromLeft;
    [UIView transitionWithView:self.cardImage duration:0.5 options:(UIViewAnimationOptionCurveEaseInOut | curslss) animations:^{
        
    } completion:nil];
    
    UIViewAnimationOptions curl = UIViewAnimationOptionTransitionFlipFromLeft;
    [UIView transitionWithView:self.txtMonthTitle duration:0.5 options:(UIViewAnimationOptionCurveEaseInOut | curl) animations:^{
        
    } completion:nil];
    UIViewAnimationOptions curls = UIViewAnimationOptionTransitionFlipFromLeft;
    [UIView transitionWithView:self.txtMonthYear duration:0.5 options:(UIViewAnimationOptionCurveEaseInOut | curls) animations:^{
        
    } completion:nil];
    UIViewAnimationOptions curlss = UIViewAnimationOptionTransitionFlipFromLeft;
    [UIView transitionWithView:self.txtCard duration:0.5 options:(UIViewAnimationOptionCurveEaseInOut | curlss) animations:^{
        
    } completion:nil];
}
- (IBAction)clickFlip:(id)sender {
    if (clickFlip) {
        clickFlip = NO;
        [self FlipAnimationWithLeft];
        [self.blackCoting setHidden:YES];
        [self.txtCVV setHidden:YES];
        [self.txtCard setHidden:NO];
        [self.txtMonthYear setHidden:NO];
        [self.txtMonthTitle setHidden:NO];
    }else{
        clickFlip = YES;
        [self.txtCard setHidden:YES];
        [self.txtMonthYear setHidden:YES];
        [self.txtMonthTitle setHidden:YES];
        [self.blackCoting setHidden:NO];
        [self FlipAnimationWithRight];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
