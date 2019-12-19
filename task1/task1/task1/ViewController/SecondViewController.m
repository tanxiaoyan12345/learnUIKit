//
//  SecondViewController.m
//  task1
//
//  Created by tanxiaoyan on 2019/12/16.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import "SecondViewController.h"
#import "RootViewController.h"
#import "PopAnimator.h"
#import "LXRCollectionViewCell.h"
#import "BiggerClickAreaButton.h"
@interface SecondViewController ()

@property (nonatomic,strong) UICollectionView * lxrInfoView;
@property (nonatomic,strong) NSArray * pictures;
@property (nonatomic,strong) NSArray * names;
@property (nonatomic,strong) BiggerClickAreaButton * flagButton;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
    [self createcollectionview];
    [self initButton];
    NSLog(@"%@",NSStringFromCGRect(self.lxrInfoView.frame));
    NSLog(@"%@",NSStringFromCGRect(self.flagButton.frame));
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    self.navigationController.delegate = self;
}


- (void)setup{
    self.title = @"通讯录";
    // self.view.backgroundColor = [UIColor yellowColor];
}
- (void)initButton{
    //[self.lxrInfoView insertSubview:self.flagButton atIndex:0];
    self.flagButton = [[BiggerClickAreaButton alloc]initWithFrame:CGRectMake(325, 85, 50, 50)];
    UIImage *image = [UIImage imageNamed:@"flag.png"];
    self.flagButton.layer.contents = (__bridge id)image.CGImage;
    self.flagButton.layer.contentsGravity = kCAGravityResizeAspectFill;
    self.flagButton.layer.masksToBounds = YES;
    [self.lxrInfoView insertSubview:self.flagButton atIndex:0];
    
    [self.flagButton addTarget:self action:@selector(dragMoving:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [self.flagButton addTarget:self action:@selector(dragEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
}


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop) {
        return [[PopAnimator alloc] init];
    }
    return nil;
}


- (void) createcollectionview{
    self.pictures = [NSArray arrayWithObjects:@"1.jpg",@"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg", @"6.jpg", @"7.jpg", @"8.jpg", @"9.jpg", @"10.jpg",nil];
    self.names = [NSArray arrayWithObjects:@"小钙",@"小铁", @"小锌", @"小溪", @"小青", @"小海", @"小莉", @"小皮", @"小鹏", @"小碳",nil];
    
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //flowLayout.itemSize = CGSizeMake(100, 100);
    
    self.lxrInfoView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    [self.view addSubview:self.lxrInfoView];
    
    self.lxrInfoView.delegate = self;
    self.lxrInfoView.dataSource = self;
    self.lxrInfoView.backgroundColor = [UIColor whiteColor];
    
    [self.lxrInfoView registerClass:[LXRCollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
    [self.lxrInfoView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADER"];
    flowLayout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 60);

    
    
    [self.view addSubview:self.lxrInfoView];
    
    
}

#pragma mark - button对应事件
- (void) dragMoving: (UIControl *) c withEvent:ev
{
//    函数返回一个CGPoint类型的值，表示触摸在lxrinfoview这个视图上的位置，这里返回的位置是针对lxrinfoview的坐标系的。调用时传入的view参数为空的话，返回的时触摸点在整个窗口的位置。
    //c.center = [[[ev allTouches] anyObject] locationInView:self.lxrInfoView];
    CGPoint center = [[[ev allTouches] anyObject] locationInView:self.lxrInfoView];
    CGPoint windowcenter = [[[ev allTouches] anyObject] locationInView:nil]; if(center.x<self.lxrInfoView.frame.size.width-50&&center.x>50&&center.y>100&&center.y<self.lxrInfoView.contentSize.height-30){
      c.center = center;
    }
   
    NSLog(@"%@",NSStringFromCGPoint(center));
    NSLog(@"window  %@",NSStringFromCGPoint(windowcenter));
    NSLog(@"TouchDragInside");

}

- (void) dragEnded: (UIControl *) c withEvent:ev
{
    
    CGPoint templocation= [[[ev allTouches] anyObject] locationInView:self.lxrInfoView];
    NSIndexPath * indexPath = [self.lxrInfoView indexPathForItemAtPoint:templocation];
//    NSLog(@"%@",indexPath);
    UICollectionViewLayoutAttributes *attributes = [self.lxrInfoView layoutAttributesForItemAtIndexPath:indexPath];
    CGRect rectcell = attributes.frame;
    CGPoint position = {rectcell.origin.x + 350,rectcell.origin.y+50};
    c.center = position;
//    NSLog(@"TouchUpOutside");

}






#pragma mark - UICollectionViewDataSource
//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.pictures.count;
}
//每个Cell展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LXRCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:255/255.0 alpha:1];
    cell.myImgView.image =  [UIImage imageNamed:[self.pictures objectAtIndex:indexPath.row]];
    cell.myLabel.text = [self.names objectAtIndex:indexPath.row];
    
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout
//每个cell的大小，因为有indexPath，所以可以判断哪一组，或者哪一个item，可一个给特定的大小，等同于layout的itemSize属性
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 90);
}
// 设置整个组的缩进量是多少
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [self.lxrInfoView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HEADER" forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[UICollectionReusableView alloc] init];
        }
        UILabel * headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 200, 50)];
        headerlabel.text = @"联系人列表";
        headerlabel.textColor = [UIColor blackColor];
        headerView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:headerlabel];
        
        return headerView;
    }
    return nil;
}


@end
