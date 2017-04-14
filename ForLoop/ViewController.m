//
//  ViewController.m
//  ForLoop
//
//  Created by ma c on 16/2/20.
//  Copyright © 2016年 gdd. All rights reserved.
//

#import "ViewController.h"

#define selfW   self.view.frame.size.width
#define selfH   self.view.frame.size.height
#define selfWScreen [[UIScreen mainScreen] bounds].size.width
#define selfHScreen [[UIScreen mainScreen] bounds].size.height
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textContext;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textContext.inputView=[self customInputKey];
}
-(UIView *)customInputKey{
    NSDictionary *dic=@{@"0":@[@"D",@"E",@"F"],
                        @"1":@[@"A",@"B",@"C"],
                        @"2":@[@"7",@"8",@"9"],
                        @"3":@[@"4",@"5",@"6"],
                        @"4":@[@"1",@"2",@"3"],
                        @"5":@[@"删除",@"0",@"确定"]
                        };
    
    UIView *cusView=[[UIView alloc]initWithFrame:CGRectMake(0, selfHScreen*0.5, selfWScreen, selfHScreen*0.5)];
    NSInteger allRow=6;     //行数
    NSInteger allArrange=3; //列数
    NSInteger distanceBtn=3; //边距
    
    CGFloat eachButtonW=(selfWScreen-(allArrange-1)*distanceBtn)/allArrange; //按钮的宽度
    CGFloat eachButtonH=(selfHScreen*0.5-(allRow-1)*distanceBtn)/allRow; //按钮的高度
    
    for (NSInteger i=0; i<allRow; i++) { //先添加行数,再添加列数
        NSArray *arrData=[dic objectForKey:[NSString stringWithFormat:@"%zi",i]]; //通过key,取数组
        for (NSInteger q=0; q<allArrange; q++) {
            UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake((eachButtonW+distanceBtn)*q,(eachButtonH+distanceBtn)*i, eachButtonW,eachButtonH)];
            button.titleLabel.font=[UIFont systemFontOfSize:24.0];
            [button setBackgroundColor:[UIColor orangeColor]];
            [cusView addSubview:button];
            [button addTarget:self action:@selector(keyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:arrData[q] forState:UIControlStateNormal];
            [button setTitle:arrData[q] forState:UIControlStateHighlighted];
            [button setTitle:arrData[q] forState:UIControlStateSelected];
        }
    }
    [cusView setBackgroundColor:[UIColor darkGrayColor]];
    return cusView;
}
#pragma mark 键盘上的Button操作
-(void)keyButtonAction:(UIButton *)keyButton{
    NSString *buttonTitle=keyButton.titleLabel.text; // 按钮上面的文字
    NSString *textStr=self.textContext.text; //文本框上面的文字
    if([buttonTitle isEqualToString:@"删除"]){
        if(textStr.length>0){
            NSLog(@"单个删除");
            self.textContext.text=[textStr substringToIndex:textStr.length-1];
        }
        else{
            NSLog(@"输入框的内容为空,不能删除!");
        }
    }
    else if([buttonTitle isEqualToString:@"确定"]){
        if(textStr.length>0){
            NSLog(@"执行确定操作,并且隐藏键盘,最终得到的数据是:%@",textStr);
            [self.textContext resignFirstResponder];
        }
        else{
            NSLog(@"输入框的内容不能为空!");
        }
    }
    else{
        NSLog(@"拼接字符串:%@",buttonTitle);
        self.textContext.text=[textStr stringByAppendingString:[NSString stringWithFormat:@"%@",buttonTitle]]; //拼接字符串
    }
}
#pragma mark 隐藏键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textContext resignFirstResponder];
}
@end
