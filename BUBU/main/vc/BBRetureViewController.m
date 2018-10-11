//
//  BBRetureViewController.m
//  BUBU
//
//  Created by 董志盟 on 2018/10/11.
//  Copyright © 2018年 DZM. All rights reserved.
//
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#import "BBRetureViewController.h"
#import "UITextView+YLTextView.h"

@interface BBRetureViewController ()
@property (nonatomic , strong) UITextField *tTextField;
@property (nonatomic , strong) UITextView *suggestTV;

@end

@implementation BBRetureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton  *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 44, KIsiPhoneX?88-37:64-37, 30, 30)];
    [button setImage:[UIImage imageNamed:@"icon_remove"] forState:UIControlStateNormal];
    button.layer.cornerRadius = 15;
    [button addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:17.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"反馈";
    [self.view addSubview:titleLabel];
    
    _tTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 200, 30)];
    _tTextField.translatesAutoresizingMaskIntoConstraints = NO;
    _tTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_tTextField setPlaceholder:@"邮箱"];
    _tTextField.tag = 10086;
    _tTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_tTextField];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.translatesAutoresizingMaskIntoConstraints = NO;
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    
    _suggestTV = [[UITextView alloc] init];
    _suggestTV.translatesAutoresizingMaskIntoConstraints = NO;
    _suggestTV.layer.cornerRadius = 5;
    _suggestTV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _suggestTV.layer.borderWidth = 1.0;
    _suggestTV.limitLength = @60;
    _suggestTV.placeholder = @"请输入您的反馈内容";
    _suggestTV.placeholdColor = [UIColor lightGrayColor];
    _suggestTV.limitPlaceColor = [UIColor lightGrayColor];
    _suggestTV.placeholdFont = [UIFont systemFontOfSize:17];
    _suggestTV.limitPlaceFont = [UIFont systemFontOfSize:17];
    _suggestTV.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:_suggestTV];
    
    UIButton  *sureButton = [[UIButton alloc] init];
    sureButton.translatesAutoresizingMaskIntoConstraints = NO;
    sureButton.layer.cornerRadius = 5;
    sureButton.backgroundColor = [UIColor blueColor];
    [sureButton setTitle:@"发送" forState:UIControlStateNormal];
//    [sureButton setTitleColor:[UIColor ] forState:<#(UIControlState)#>]
    [sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureButton];
    
    NSDictionary *dic = @{
                          @"top":@(KIsiPhoneX?(44 + 7):(20 + 7))
                          };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(top)-[titleLabel(30)]-(27)-[_tTextField(30)]-(0)-[lineView(1)]-(25)-[_suggestTV(200)]-(40)-[sureButton(44)]" options:0 metrics:dic views:NSDictionaryOfVariableBindings(titleLabel,_tTextField,lineView,_suggestTV,sureButton)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[titleLabel]-(20)-|" options:0 metrics:dic views:NSDictionaryOfVariableBindings(titleLabel)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[_tTextField]-(20)-|" options:0 metrics:dic views:NSDictionaryOfVariableBindings(_tTextField)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[lineView]-(20)-|" options:0 metrics:dic views:NSDictionaryOfVariableBindings(lineView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[_suggestTV]-(20)-|" options:0 metrics:dic views:NSDictionaryOfVariableBindings(_suggestTV)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[sureButton]-(20)-|" options:0 metrics:dic views:NSDictionaryOfVariableBindings(sureButton)]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(transformView:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
}

- (void)keyboardHide:(UITapGestureRecognizer *)tap
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)butClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sureButtonClick:(id)sender
{
    if ([self isEmail:_tTextField.text] && _suggestTV.text.length > 0 && _suggestTV.text) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"发送成功",nil)
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction* canaelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"返回", nil) style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * action) {
                                                                 //响应事件
                                                                 [self dismissViewControllerAnimated:YES completion:nil];
                                                             }];
        [alert addAction:canaelAction];
        [[self appRootViewController] presentViewController:alert animated:YES completion:nil];
        
    }else{
        
    }
}

-(void)transformView:(NSNotification *)aNSNotification
{
    //获取键盘弹出前的Rect
    NSValue *keyBoardBeginBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect=[keyBoardBeginBounds CGRectValue];
    
    //获取键盘弹出后的Rect
    NSValue *keyBoardEndBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  endRect=[keyBoardEndBounds CGRectValue];
    
    //获取键盘位置变化前后纵坐标Y的变化值
    CGFloat deltaY=endRect.origin.y-beginRect.origin.y;
    NSLog(@"看看这个变化的Y值:%f",deltaY);
    
    //在0.25s内完成self.view的Frame的变化，等于是给self.view添加一个向上移动deltaY的动画
    [UIView animateWithDuration:0.25f animations:^{
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+deltaY/5, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}


- (BOOL)isEmail:(NSString *)email{
    // 注意xxx@yahoo.com.cn后缀的邮箱
    NSString *emailRegex = @"[a-zA-Z0-9_.-]+@[a-zA-Z0-9-_]+(\\.[a-zA-Z0-9-_]+)*\\.[a-zA-Z0-9-_]{2,6}";//@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//获取顶层视图
- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController)
    {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

@end
