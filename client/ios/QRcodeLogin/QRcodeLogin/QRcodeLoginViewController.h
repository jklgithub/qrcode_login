//
//  QRcodeLoginViewController.h
//  qrcodelogin
//
//  Created by jkl on 12-10-18.
//  Copyright (c) 2012年 jkl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface QRcodeLoginViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
 //   ZBarReaderController *reader;
}

@property (strong, nonatomic) IBOutlet UITextView *loginView;
@property (strong, nonatomic) IBOutlet UITextField *userInput;
@property (strong, nonatomic) IBOutlet UITextView *loggedView;
@property (strong, nonatomic) IBOutlet UILabel* welcomeLabel;
@property (nonatomic, retain) NSString *user;
@property (nonatomic, retain) NSString *msg;
@property (nonatomic, retain) NSTimer *timer;
//@property (nonatomic, retain) ZBarReaderController *reader;

@end
