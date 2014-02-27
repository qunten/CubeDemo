//
//  CDViewController.m
//  CubeDemo
//
//  Created by esperado on 14-2-27.
//  Copyright (c) 2014年 AttackOnDobby. All rights reserved.
//

#import "CDViewController.h"

@interface CDViewController ()

@property (nonatomic, strong) NSMutableArray *faces;

@end

@implementation CDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (NSMutableArray *)faces
{
    if (!_faces) {
        _faces = [NSMutableArray array];
    }
    return _faces;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    for (int i = 0; i < 6; i++) {
        UIView *face = [[UIView alloc] initWithFrame:CGRectMake(80, 200, 160, 160)];
        CGFloat red = arc4random() % 256 / 255.f;
        CGFloat green = arc4random() % 256 / 255.f;
        CGFloat blue = arc4random() % 256 / 255.f;
        face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:0.7];
        [self.view addSubview:face];
        [self.faces addObject:face];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(65, 65, 30, 30)];
        label.text = [NSString stringWithFormat:@"%d", i + 1];
        [face addSubview:label];
        label.font = [UIFont systemFontOfSize:30];
        label.textColor = [UIColor blackColor];
    }
    
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 80);
    ((UIView *)self.faces[0]).layer.transform = transform;
    
    transform = CATransform3DMakeTranslation(80, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    ((UIView *)self.faces[1]).layer.transform = transform;
    
    transform = CATransform3DMakeTranslation(-80, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, -1, 0);
    ((UIView *)self.faces[2]).layer.transform = transform;
    
    transform = CATransform3DMakeTranslation(0, 80, 0);
    transform = CATransform3DRotate(transform, M_PI_2, -1, 0, 0);
    ((UIView *)self.faces[3]).layer.transform = transform;
    
    transform = CATransform3DMakeTranslation(0, -80, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    ((UIView *)self.faces[4]).layer.transform = transform;
    
    transform = CATransform3DMakeTranslation(0, 0, -80);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    ((UIView *)self.faces[5]).layer.transform = transform;
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    self.view.layer.sublayerTransform = perspective;
    
    // animate
    
    CABasicAnimation *animationY = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.rotation.y"];
    animationY.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationY.fromValue = [NSNumber numberWithFloat:0.0f];
    animationY.toValue = [NSNumber numberWithFloat:M_PI * 2];
    
    CABasicAnimation *animationX = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.rotation.x"];
    animationX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationX.fromValue = [NSNumber numberWithFloat:0.0f];
    animationX.toValue = [NSNumber numberWithFloat:M_PI * 2];
    
//    animate sequence
//    animationY.beginTime = 2;
//    animationY.duration = 2;
//    animationX.beginTime = 0;
//    animationX.duration = 2;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animationX, animationY];
    group.duration = 4.f;
    group.repeatCount = HUGE_VALF;
    [self.view.layer addAnimation:group forKey:@"ratateAnimation"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
