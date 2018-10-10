//
//  YDCelloutView.m
//  YDSmartBike
//
//  Created by DZM on 2017/11/27.
//  Copyright © 2017年 Archermind. All rights reserved.
//

#import "YDCelloutView.h"

#define kArrorHeight        10

//#define kPortraitMargin     5
//#define kPortraitWidth      70
//#define kPortraitHeight     50
//
//#define kTitleWidth         120
//#define kTitleHeight        20


@interface YDCelloutView ()

//@property (nonatomic, strong) UIImageView *portraitView;
@property (nonatomic, strong) UILabel *cellNumLabel;
@property (nonatomic, strong) UILabel *titleLabel;



@end

@implementation YDCelloutView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    //    // 添加图片，即商户图
    //    self.portraitView = [[UIImageView alloc] initWithFrame:CGRectMake(kPortraitMargin, kPortraitMargin, kPortraitWidth, kPortraitHeight)];
    //
    //    self.portraitView.backgroundColor = [UIColor blackColor];
    //    [self addSubview:self.portraitView];
    
    
    _cellButton = [[UIButton alloc] init];
    [_cellButton setImage:[UIImage imageNamed:@"dt_phone_btn"] forState:UIControlStateNormal];
//    [cellButton setTitle:@"拨号:" forState:UIControlStateNormal];

    _cellButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_cellButton addTarget:self action:@selector(cellWithOther:) forControlEvents:UIControlEventTouchUpInside];
//    _cellButton.backgroundColor = [UIColor redColor];
    _cellButton.titleLabel.textColor = [UIColor blueColor];
    [_cellButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

    [self addSubview:_cellButton];
    _cellButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    _navButton = [[UIButton alloc] init];
    [_navButton  setImage:[UIImage imageNamed:@"dt_position_btn"] forState:UIControlStateNormal];
//    [navButton setTitle:@" 导航:" forState:UIControlStateNormal];
    _navButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _navButton.titleLabel.textColor = [UIColor lightGrayColor];
    [_navButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_navButton addTarget:self action:@selector(navToThree:) forControlEvents:UIControlEventTouchUpInside];
//    navButton.backgroundColor = [UIColor redColor];
    
    _navButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_navButton];
    
//    // 添加标题，即商户名
//    self.cellNumLabel = [[UILabel alloc] init];//WithFrame:CGRectMake(kPortraitMargin * 2 + kPortraitWidth, kPortraitMargin, kTitleWidth, kTitleHeight)];
//    self.cellNumLabel.font = [UIFont boldSystemFontOfSize:36/3];
//    //    self.cellNumLabel.textColor = [UIColor whiteColor];
//    //    self.cellNumLabel.text = @"titletitletitletitle";
//    self.cellNumLabel.textColor = UIColorFromRGB(0x666666);
//    self.cellNumLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    [self addSubview:self.cellNumLabel];
//
//    // 添加副标题，即商户地址
//    self.titleLabel = [[UILabel alloc] init];//WithFrame:CGRectMake(kPortraitMargin * 2 + kPortraitWidth, kPortraitMargin * 2 + kTitleHeight, kTitleWidth, kTitleHeight)];
//    self.titleLabel.numberOfLines = 0;
//    self.titleLabel.font = [UIFont systemFontOfSize:36/3];
//    self.titleLabel.textColor = UIColorFromRGB(0x666666);
//    //    self.titleLabel.textColor = [UIColor lightGrayColor];
//    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    [self addSubview:self.titleLabel];
    
    CGSize iconImageSize = [UIImage imageNamed:@"dt_phone_btn"].size;
    NSDictionary *metricsDic = @{
                                 @"topHeight"                 : @(41),
                                 @"bottomHeight"              :@(61),
                                 @"leftWidth"                 :@(28),
                                 @"rightWidth"                :@(5),
                                 @"viewWidth"                 :@(643),
                                 @"WidthOfInterval"           :@(26),
                                 @"heigthOfInterval"          :@(28),
                                 @"iconWidthTitleInterval"    :@(16),
                                 @"iconImageHeight"           :@(iconImageSize.height),
                                 @"iconImagewidth"            :@(iconImageSize.width),
                                 };
    
    
    
    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(leftWidth)-[_cellButton]-(WidthOfInterval)-[_cellNumLabel]-(>=0)-|" options:0 metrics:metricsDic views:NSDictionaryOfVariableBindings(_cellButton)]];
    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(topHeight)-[_cellNumLabel]-(heigthOfInterval)-[_titleLabel]-(bottomHeight)-|" options:0 metrics:metricsDic views:NSDictionaryOfVariableBindings(_cellNumLabel,_titleLabel,_cellButton)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(topHeight)-[_cellButton]-(heigthOfInterval)-[_navButton]-(bottomHeight)-|" options:0 metrics:metricsDic views:NSDictionaryOfVariableBindings(_navButton,_cellButton)]];
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(leftWidth)-[_cellButton]-(>=0)-|" options:0 metrics:metricsDic views:NSDictionaryOfVariableBindings(_cellButton)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(leftWidth)-[_navButton]-(>=0)-|" options:0 metrics:metricsDic views:NSDictionaryOfVariableBindings(_navButton)]];
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor whiteColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
}

- (void)drawInContext:(CGContextRef)context
{
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);

    [self getDrawPath:context];
    CGContextFillPath(context);
    
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}


- (void)setTitle:(NSString *)title
{
//    self.titleLabel.text = title;dt_position_btn
    [_navButton setImage:[UIImage imageNamed:@"dt_position_btn"] forState:UIControlStateNormal];
    [_navButton setTitle:[NSString stringWithFormat:@" 导航: %@",title] forState:UIControlStateNormal];
    _title = title;
}

- (void)setSubtitle:(NSString *)subtitle
{
//    self.cellNumLabel.text = subtitle;
    [_cellButton setImage:[UIImage imageNamed:@"dt_phone_btn"] forState:UIControlStateNormal];
    [_cellButton setTitle:[NSString stringWithFormat:@" 拨号: %@",subtitle] forState:UIControlStateNormal];
    _subtitle = subtitle;
}

#pragma mark - action

- (void)navToThree:(id)sender
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"导航地图选择",nil)
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* baiduAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"百度地图", nil) style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {
                                                            [self navBaidu];
                                                        }];
    UIAlertAction* gaodeAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"高德地图", nil) style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {
                                                            
                                                            [self navGaode];
                                                        }];
    
    UIAlertAction* canaelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                         }];
    [alert addAction:baiduAction];
    [alert addAction:gaodeAction];
    [alert addAction:canaelAction];
    [[self appRootViewController] presentViewController:alert animated:YES completion:nil];
}

#pragma mark -
- (void)navGaode
{
    //导航
    NSURL *appURL = [NSURL URLWithString:[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%f&slon=%f&sname=A&did=BGVIS2&dlat=%f&dlon=%f&dname=B&dev=0&t=0",self.bikelocationCoordinate.latitude,self.bikelocationCoordinate.longitude,self.locationCoordinate.latitude,self.locationCoordinate.longitude]];
    //路线规划
    //                                                            iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=39.92848272&slon=116.39560823&sname=A&did=BGVIS2&dlat=39.98848272&dlon=116.47560823&dname=B&dev=0&t=0
    if ([[UIApplication sharedApplication] canOpenURL:appURL])
    {
        [[UIApplication sharedApplication] openURL:appURL options:@{} completionHandler:nil];
    }
    else
    {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"未安装高德地图", nil) preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        
        [controller addAction:okAction];
        
        [self.appRootViewController presentViewController:controller animated:YES completion:nil];
        
    }
}

- (void)navBaidu
{
    CLLocationCoordinate2D baiduBikelocationCoordinate = [self getBaiDuCoordinateByGaoDeCoordinate:self.bikelocationCoordinate];
    CLLocationCoordinate2D baidulocationCoordinate = [self getBaiDuCoordinateByGaoDeCoordinate:self.locationCoordinate];
    
    NSURL *appURL = [NSURL URLWithString:[NSString stringWithFormat:@"baidumap://map/direction?origin=%f,%f&destination=%f,%f&mode=driving&src=webapp.navi.yourCompanyName.yourAppName",baiduBikelocationCoordinate.latitude,baiduBikelocationCoordinate.longitude,baidulocationCoordinate.latitude,baidulocationCoordinate.longitude]];
    if ([[UIApplication sharedApplication] canOpenURL:appURL])
    {
        [[UIApplication sharedApplication] openURL:appURL options:@{} completionHandler:nil];
    }
    else
    {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"未安装百度地图", nil) preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        
        [controller addAction:okAction];
        
        [self.appRootViewController presentViewController:controller animated:YES completion:nil];
    }
}

- (void)cellWithOther:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.subtitle]] options:@{} completionHandler:nil];
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

// 高德地图经纬度转换为百度地图经纬度
- (CLLocationCoordinate2D)getBaiDuCoordinateByGaoDeCoordinate:(CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(coordinate.latitude + 0.006, coordinate.longitude + 0.0065);
}


@end

