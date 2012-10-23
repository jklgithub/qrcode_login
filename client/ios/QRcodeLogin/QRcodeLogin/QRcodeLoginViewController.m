//
//  QRcodeLoginViewController.m
//  qrcodelogin
//
//  Created by jkl on 12-10-18.
//  Copyright (c) 2012年 jkl. All rights reserved.
//

#import "QRcodeLoginViewController.h"
//#import "ZBarSDK.h"
#import "ZBarReaderController.h"
#import "JSONKit.h"

@interface QRcodeLoginViewController ()

@end

@implementation QRcodeLoginViewController

@synthesize loginView;
@synthesize userInput;
@synthesize user;
@synthesize loggedView;
@synthesize welcomeLabel;
@synthesize msg;
@synthesize timer;
//@synthesize reader;


-(IBAction)startScan:(id)sender
{
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    ZBarImageScanner *scanner = reader.scanner;
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    [self presentModalViewController:reader animated:YES];
//    [reader release];
    
 /*   reader = [[ZBarReaderController alloc] init];
    reader.delegate = self;
    reader.readerDelegate = self;
 //   reader.cameraMode = ZBarReaderControllerCameraModeSampling;
    
    reader.cameraMode = ZBarReaderControllerCameraModeDefault;
    
    ZBarImageScanner *scanner = reader.scanner;
    [scanner setSymbology: ZBAR_I25 config: ZBAR_CFG_ENABLE to:0];
    
    [self presentModalViewController: reader animated:YES];*/
}

- (void) imagePickerController: (UIImagePickerController*) picker didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
    
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    
    for(symbol in results)
    {
        break;
    }
    
    if(!symbol || !image)
    {
        return;
    }
    
    NSLog(@"symbol.data = %@", symbol.data);
    
    [self sendRQcode:symbol.data];
    
    //最关键的移行代码
 //   self.resultLabel.text = symbol.data;
    
    [picker dismissModalViewControllerAnimated: YES];
}

- (void)addLoginView
{
    if(loginView == nil)
    {
        loginView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 300, 200)];
        [loginView setEditable:NO];
        [[self view] addSubview:loginView];
        
        userInput = [[UITextField alloc] initWithFrame:CGRectMake(70, 100, 160, 30)];
        [userInput setPlaceholder:@"请输入用户名"];
        [userInput setBorderStyle:UITextBorderStyleBezel];
        [userInput setFont:[UIFont fontWithName:@"TimesNewRomanPS-BoldItalicMT" size:18]];
        [userInput setTextColor:[UIColor colorWithRed:255 green:0 blue:0 alpha:0.9]];
        [loginView addSubview:userInput];
        
        UIButton* loginBut = [[UIButton alloc] initWithFrame:CGRectMake(115, 150, 60, 30)];
        [loginBut setTitle:@"登录" forState:UIControlStateNormal];
        [loginBut setBackgroundColor:[UIColor colorWithRed:255 green:0 blue:0 alpha:0.9]];
        [loginBut setShowsTouchWhenHighlighted:YES];
        [loginBut addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
 //       [loginBut addTarget:self action:@selector(startScan:) forControlEvents:UIControlEventTouchUpInside];
        [loginView addSubview:loginBut];
        
        //    [loginBut release];
        
        NSLog(@"-------addLoginView----ok:------");
    }
    
    //   [tip1 release];
}//addLoginView
//添加登录后的视图
- (void)addLoggedView
{
    if(loggedView == nil)
    {
        loggedView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 300, 200)];
        [loggedView setEditable:NO];
        [loggedView setHidden:YES];
        [[self view] addSubview:loggedView];
        
        welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 40, 200, 30)];
        //   [welcomeLabel setText:@"ABC"];
        [welcomeLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
        [welcomeLabel setTextColor:[UIColor colorWithRed:255 green:0 blue:0 alpha:0.9]];
        [loggedView addSubview:welcomeLabel];
        
        
        UIButton* QRBut = [[UIButton alloc] initWithFrame:CGRectMake(85, 100, 120, 30)];
        [QRBut setTitle:@"扫描登录码" forState:UIControlStateNormal];
        [QRBut setBackgroundColor:[UIColor colorWithRed:255 green:0 blue:0 alpha:0.9]];
        [QRBut setShowsTouchWhenHighlighted:YES];
        [QRBut addTarget:self action:@selector(startScan:) forControlEvents:UIControlEventTouchUpInside];
        [loggedView addSubview:QRBut];
        
        
        UIButton* logoutBut = [[UIButton alloc] initWithFrame:CGRectMake(105, 160, 80, 30)];
        [logoutBut setTitle:@"退出" forState:UIControlStateNormal];
        [logoutBut setBackgroundColor:[UIColor colorWithRed:255 green:0 blue:0 alpha:0.9]];
        [logoutBut setShowsTouchWhenHighlighted:YES];
        [logoutBut addTarget:self action:@selector(logoutClick:) forControlEvents:UIControlEventTouchUpInside];
        [loggedView addSubview:logoutBut];
        
        NSLog(@"-------loggedView----ok:------");
    }
}//addMainView

- (void) sendRQcode:(NSString*)code
{
    NSLog(@"-------sendRQcode----start---%@---", code);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSLog(@"-------loginClick------user:%@", timeString);
    NSString *url = [[[[[@"http://dev.jiangkunlun.com/client_login.php?user=" stringByAppendingString:user]             stringByAppendingString:@"&source="] stringByAppendingString:code]stringByAppendingString:@"&time="]
                     stringByAppendingString:timeString];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //[NSURLConnection connectionWithRequest:request delegate:self ];
    //   [request release];
    NSLog(@"-------sendRQcode--:------%@", url);
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSLog(@"-------sendRQcode--status:------%d", [urlResponse statusCode]);
    NSString *login = @"0";
    if(returnData != NULL && [urlResponse statusCode] == 200) {
        NSDictionary *data = [returnData objectFromJSONData];
        NSLog(@"-------sendRQcode----returnData:------%@", data);
        login = [data objectForKey:@"login"];
    }
    NSLog(@"-------sendRQcode----login:------%@", login);
    msg = @"";
    if([login isEqual: @"1"]){
        msg = @"登录成功！";
    }else if([login isEqual:@"0"]){
        msg = @"网络连接错误，请检查网络设置后重试！";
    }else{
        msg = [[@"未知错误(login:" stringByAppendingString:login] stringByAppendingString:@")，请检查网络设置后重试！"];
    }
    NSLog(@"-------sendRQcode----msg:------%@", msg);
    [self alertWithMessage:msg];
}//sendRQcode

- (void)logoutClick:(id)sender
{
    [self sendRQcode:@"abcd"];
    user = nil;
    [loggedView setHidden:YES];
    [loginView setHidden:NO];
}

- (void)loginClick:(id)sender
{
    //trim
    user = [userInput.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"-------loginClick------user:%@", user);
    //“登录“成功
    if([user length] > 0)
    {
        [welcomeLabel setText:[user stringByAppendingString:@"，欢迎回来!"]];
        //     [welcomeLabel setText:@"1234"];
        [loginView setHidden:YES];
        [loggedView setHidden:NO];
    }
}//loginClick

- (void)alertWithMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"二维码登录测试"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addLoginView];
    [self addLoggedView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
