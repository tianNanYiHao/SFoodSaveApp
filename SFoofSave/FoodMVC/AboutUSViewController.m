//
//  AboutUSViewController.m
//  SFoofSave
//
//  Created by Lff on 16/8/4.
//  Copyright © 2016年 Lff. All rights reserved.
//

#import "AboutUSViewController.h"

@interface AboutUSViewController ()
@property (weak, nonatomic) IBOutlet UILabel *infoLab;

@end

@implementation AboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"关于我们";
    _infoLab.text = @"上海银统金融服务有限公司欢迎您";
    
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

@end
