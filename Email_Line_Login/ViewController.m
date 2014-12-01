//
//  ViewController.m
//  Practice1128_Pihan
//
//  Created by PiHan Hsu on 2014/11/28.
//  Copyright (c) 2014年 PiHan Hsu. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "Line.h"


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate, UIActionSheetDelegate    , MFMailComposeViewControllerDelegate>
{
    CALayer *_boarder;
    
    UITextField *memberNameText;
    UITextField *passwordText;
    
    IBOutlet UIButton * loginButton;
    IBOutlet UIButton * forgetButton;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.loginButton.layer.cornerRadius = 5.0f;
    // Init input text field
    memberNameText = [[UITextField alloc]initWithFrame:CGRectMake(40, 0, 275, 40)];
    memberNameText.textColor = [UIColor darkGrayColor];
    memberNameText.delegate =self;
    memberNameText.textAlignment = NSTextAlignmentLeft;
    memberNameText.tag =101;
    memberNameText.font =[UIFont fontWithName:@"STHeitiSC-Medium" size:13.0];
    memberNameText.autocapitalizationType =UITextAutocapitalizationTypeNone;
    memberNameText.placeholder = @"e-mail";
    
    passwordText = [[UITextField alloc]initWithFrame:CGRectMake(40, 0, 275, 40)];
    passwordText.textColor = [UIColor blackColor];
    passwordText.delegate =self;
    passwordText.textAlignment = NSTextAlignmentLeft;
    [passwordText setSecureTextEntry:YES];
    passwordText.tag =102;
    passwordText.font =[UIFont fontWithName:@"STHeitiSC-Medium" size:13.0];
    passwordText.autocapitalizationType =UITextAutocapitalizationTypeNone;
    passwordText.placeholder = @"6-12位英數字，不含標點符號";

    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [gestureRecognizer setDelegate:self];
    
    [self.view addGestureRecognizer:gestureRecognizer];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    //add bottom line
    _boarder = [CALayer layer];
    
    _boarder.borderColor =[ [UIColor colorWithRed:150/255.0 green:195/255.0 blue:35.0/255.0 alpha:1 ]CGColor];
    
    _boarder.borderWidth =2;
    
    CALayer *layer =self.navigationController.navigationBar.layer;
    
    _boarder.frame =CGRectMake(0, layer.bounds.size.height, layer.bounds.size.width, 2);
    
    [layer addSublayer:_boarder];
    
    
}


-(void) hideKeyboard
{
    [self.view endEditing:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//欄位高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}
//要顯示幾個欄位
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *requestIdentifier = @"LoginCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:requestIdentifier];
    
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:requestIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:14.0];
        cell.detailTextLabel.font =[UIFont fontWithName:@"STHeitiSC-Medium" size:14.0];
        cell.accessoryType =UITableViewCellAccessoryNone;
        cell.textLabel.textAlignment= NSTextAlignmentLeft;
        cell.textLabel.textColor =[UIColor colorWithRed:121/255.0 green:121/255.0 blue:121/255.0 alpha:1];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text =@"";
            [cell.contentView addSubview:memberNameText];
            break;
        case 1:
            cell.textLabel.text =@"";
            [cell.contentView addSubview:passwordText];
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (IBAction) showOption1
{
    
    UIActionSheet * actionSheet = [ [UIActionSheet alloc]initWithTitle:@"請選擇"
                                                              delegate:self
                                                     cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"Email",@"Line", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    actionSheet.tag =1;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
}

- (IBAction) showOption2
{
    
    UIActionSheet * actionSheet = [ [UIActionSheet alloc]initWithTitle:@"性別"
                                                              delegate:self
                                                     cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"男", @"女", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    actionSheet.tag =2;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"You choose %ld in actionSheet %ld", buttonIndex, actionSheet.tag);
    
    switch (actionSheet.tag) {
        case 1:
        {
            if (buttonIndex == 0) {
                NSLog(@"Open Mail");
                [self openmail];
            }else if(buttonIndex ==1)
            {
                NSLog(@"OpenLine");
                [self openLine];
            }
            break;
        }
            
        case 2:
        {
            if (buttonIndex == 0) {
                NSLog(@"You chose Male");
            }else{
                NSLog(@"You chose Femail");
            }
            break;
        }
        
        default:
            break;
    }
}
-(void)openmail
{
    NSString *emailTitle =@"Hello";
    NSString *messageBody =@"Test Message";
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mc =[[MFMailComposeViewController alloc]init];
        mc.mailComposeDelegate =self;
        
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:YES];
        
        [self presentViewController:mc animated:YES completion:nil];
        
        
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"測試" message:@"Email 尚未設定" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil];
        [alertView show];
    }
}

-(void)openLine
{
    
    if (![Line isLineInstalled]) {
        NSLog(@"Line is not installed.");
    }
    else{
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, self.view.opaque, 0.0);
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *imageScreen =UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        NSString *savePath = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/share.png"];
        
        BOOL ret = [UIImagePNGRepresentation(imageScreen) writeToFile:savePath atomically:YES];
        
        
        
        
        //[Line shareText:@"This is ALphacamp"];
        [Line shareImage:imageScreen];
        
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSLog(@"didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error");
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"MFMailComposeResultSaved:");
        case MFMailComposeResultFailed:
            NSLog(@"MFMailComposeResultFailed:");
        case MFMailComposeResultSent:
            NSLog(@"MFMailComposeResultSent:");
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}


@end
