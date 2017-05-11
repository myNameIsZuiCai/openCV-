//
//  ViewController.m
//  openCV对图片美白
//
//  Created by 这个男人来自地球 on 2017/5/11.
//  Copyright © 2017年 zhang yannan. All rights reserved.
//

#import "ViewController.h"
#import "imageUtils.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)originalImage:(id)sender {
    _imageView.image=[UIImage imageNamed:@"test.png"];
}


- (IBAction)imageWhitening:(id)sender {
    _imageView.image=[imageUtils imageWhitening:_imageView.image];
}



@end
