//
//  ViewController.h
//  CardView
//
//  Created by Thabresh on 9/8/16.
//  Copyright © 2016 VividInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtCard;
@property (weak, nonatomic) IBOutlet UILabel *txtMonthYear;
@property (weak, nonatomic) IBOutlet UITextField *CVVDig;
@property (weak, nonatomic) IBOutlet UITextField *example;
@property (weak, nonatomic) IBOutlet UIView *blackCoting;
@property (weak, nonatomic) IBOutlet UITextField *txtCVV;
@property (weak, nonatomic) IBOutlet UILabel *txtMonthTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtCVVCVC;
@property (weak, nonatomic) IBOutlet UIImageView *cardImage;
@end

