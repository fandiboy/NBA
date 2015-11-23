//
//  NewsDetailController.m
//  掌上NBA
//
//  Created by fandi on 15/11/18.
//  Copyright © 2015年 fandi. All rights reserved.
//

#import "NewsDetailController.h"
#import "NewsModels.h"

@interface NewsDetailController ()<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *view4Web;


@property (nonatomic, strong) NewsModels *models;

@property (nonatomic, strong) UIWebView *webView;
@end

@implementation NewsDetailController





- (void)viewDidLoad {
    [super viewDidLoad];
//    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.newsDetailDM dataParseWithUrl:self.url];
    NSURL *url = [NSURL URLWithString:self.url];

    // 2.创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    // 3.建立会话
    NSURLSession *sesson = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [sesson dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSDictionary *dict1 = dic[@"result"];
            NSDictionary *dict2 = dict1[@"share"];
            //                self.models = [NewsDetailModel new];
            //                [_models setValuesForKeysWithDictionary:dict2];
            //                [_dataArray addObject:_models];
            NSString *urlString = dict2[@"url"];
            NSLog(@"dic2 = %@", urlString);
            
            NSURLRequest *requstUrl = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.view4Web loadRequest:requstUrl];
            });
        }
        
        
       
        
    }];
    // 使用resume方法启动任务
    [task resume];

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
