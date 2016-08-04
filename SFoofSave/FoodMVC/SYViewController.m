//
//  SYViewController.m
//  SFoofSave
//
//  Created by Lff on 16/8/3.
//  Copyright © 2016年 Lff. All rights reserved.
//

#import "SYViewController.h"
#import "SDCycleScrollView.h"
//#import "ScanCodeViewController.h"
#import "ScanViewController.h"
#import "CertificationGoodsViewController.h"
#import "ManualSearchSYViewController.h"



#import "AuthenticationEnterpriseViewController.h"

#import "UITabBarCustemView.h"
#import "MyViewController.h"


#define ENTERPRISE_URL @"http://shfda.org/data/showdatamobile.do?menu-id=enterprise"
#define PRODUCT_URL @"http://shfda.org/data/showdatamobile.do?menu-id=product"

@interface SYViewController ()
{
    UITabBarCustemView *_tabBarCustemView;
    
    
}
@property (weak, nonatomic) IBOutlet UIButton *commodityInquireBtn;//商品溯源btn

@property (weak, nonatomic) IBOutlet UIButton *commodityTraceBtn;//追溯数据btn

@property (weak, nonatomic) IBOutlet UIButton *commodityPublicBtn;//信息公开btn
@property (nonatomic,strong) NSString *UrlStr1;//拼接条形码网址所用的
@property (nonatomic,strong) NSString *UrlStr2;//拼接条形码网址所用的
@property (nonatomic,strong) NSString *UrlStr3;//拼接条形码网址所用的
@property (nonatomic,strong) NSString *UrlStr4;//拼接条形码网址所用的
@property (nonatomic,strong) MyViewController *myviewController;



@end

@implementation SYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上食安";
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"更多选项"] style:UIBarButtonItemStyleDone target:self action:@selector(rightTouchClick)];
    self.navigationItem.rightBarButtonItem = rightBarItem;

    //我的
    _myviewController = [[MyViewController alloc] init];
    [self addChildViewController:_myviewController];
    [self.view addSubview:_myviewController.view];
    _myviewController.view.hidden  = YES;

    _tabBarCustemView = [[UITabBarCustemView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width+40, 0) CustomTabBarSelectBtnBlock:^(NSInteger index) {
        NSLog(@"%ld",(long)index);
        if (index == 1) {  //首页
             _myviewController.view.hidden  = YES;
            self.title = @"上食安";
        
        }
        else if (index == 2){  //扫码
            
        }
        else if (index == 3){ //我的
            self.title = @"我的";
             _myviewController.view.hidden  = NO;
            
        }
    }];//图片360*71
    
    [self.view addSubview:_tabBarCustemView];
    [_tabBarCustemView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(71);
        make.width.mas_offset(360);
        make.left.mas_equalTo(self.view.mas_left).offset(-20);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
    }];

}

- (void)rightTouchClick{
    
}

//商品企业
- (IBAction)CommodityInquire:(UIButton *)sender {
    NSLog(@"商品企业");

        //已经登陆
        
        AuthenticationEnterpriseViewController *AuthenticaionVC = [[AuthenticationEnterpriseViewController alloc]init];
        AuthenticaionVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:AuthenticaionVC animated:YES];

}


//溯源商品
- (IBAction)CommodityTrace:(UIButton *)sender {
      NSLog(@"溯源商品");
        //已经登陆
        CertificationGoodsViewController *certificationVC = [[CertificationGoodsViewController alloc]init];
        certificationVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:certificationVC animated:YES];
}

//扫一扫
- (IBAction)CommodityPublic:(UIButton *)sender {
    NSLog(@"扫一扫");
//        
//        if ([self validateCamera]) {
//            [self showScanCodeViewController];
//        }else{
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请检查摄像头" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *ture = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//            [alertController addAction:ture];
//            [self presentViewController:alertController animated:YES completion:nil];
//        }

}
- (IBAction)NFCInduction:(id)sender {//NFC感应
    NSLog(@"NFC");
    [Common showMsgBox:nil msg:@"正在建设中..." parentCtrl:self];
}

- (IBAction)ManualInput:(id)sender {//手动输入
    NSLog(@"手动输入");
    ManualSearchSYViewController *v = [[ManualSearchSYViewController alloc] initWithNibName:@"ManualSearchSYViewController" bundle:nil];
    v.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:v animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)validateCamera {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
    [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

//- (void)showScanCodeViewController {
//    ScanCodeViewController *scanCode = [[ScanCodeViewController alloc] init];
//    [scanCode setQrUrlBlock:^(NSString *stringValue,BOOL Barcode) {
//        
//        NSLog(@"ScanCodeViewController:%@",stringValue);
//        
//        ScanViewController *scanVC = [[ScanViewController alloc]init];
//        
//        if (Barcode) {
//            Barcode = NO;
//            self.UrlStr1 = @"http://shfda.org/c/p-";
//            self.UrlStr3 = @".html?";
//            self.UrlStr4 = @"longitude=121.627536&latitude=31.250526&scanType=barcode&type=EAN_13&address=%E4%B8%8A%E6%B5%B7%E5%B8%82%E9%87%91%E8%B1%AB%E8%B7%AF818%E5%8F%B7&city=%E4%B8%8A%E6%B5%B7%E5%B8%82";
//            self.UrlStr2 = stringValue;
//            
//            stringValue = [NSString stringWithFormat:@"%@%@%@%@",self.UrlStr1,self.UrlStr2,self.UrlStr3,self.UrlStr4];
//            
//            scanVC.scanCode = stringValue;
//            [self.navigationController pushViewController:scanVC animated:YES];
//            
//        }
//        else {
//            BOOL ret1 = [stringValue hasPrefix:@"http://stfic.com"];
//            if (ret1) {
//                //说明是
//                scanVC.scanCode = stringValue;
//                [self.navigationController pushViewController:scanVC animated:YES];
//                
//            }else {
//                //                [Common showMsgBox:@"" msg:@"二维码格式错误" parentCtrl:self];
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"二维码格式错误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
//                [alert show];
//            }
//        }
//    }];
//    [self presentViewController:scanCode animated:YES completion:nil];
//}

@end
