//
//  CommunityCellViewController.m
//  SaleApp
//
//  Created by LuNian on 16/5/11.
//  Copyright © 2016年 LuNian. All rights reserved.
//

#import "CommunityCellViewController.h"
#import "NoteDetailViewController.h"
#import "OthersViewController.h"
//#import "VideoModel.h"

@interface CommunityCellViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth2;

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;
@end

@implementation CommunityCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.imageArray = [[NSMutableArray alloc] init];
//    [_imageArray addObject:@"1"];
//    [_imageArray addObject:@"1"];
//    [_imageArray addObject:@"1"];
//    [_imageArray addObject:@"1"];
    
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    NSMutableArray *thumbs = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_imageArray count]; i ++) {
//        NSString* image_path = [_imageArray objectAtIndex:i];
//        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:image_path]]];
//        [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:image_path]]];
        UIImage* image_ = [_imageArray objectAtIndex:i];
        [photos addObject:[MWPhoto photoWithImage:image_]];
        [thumbs addObject:[MWPhoto photoWithImage:image_]];
    }
    self.photos = photos;
    self.thumbs = thumbs;
    
    if ([_imageArray count] == 1) {
        imageWidth = ViewSize(self.view).width-10*2;
    }else if ([_imageArray count] == 2 || [_imageArray count] == 4){
        imageWidth = (ViewSize(self.view).width-(2-1)*10-10*2)/2;
    }else{
        imageWidth = (ViewSize(self.view).width-(3-1)*10-10*2)/3;
    }
    if ([_imageArray count] == 0) {
        [_viewHeight setConstant:0];
    }else{
        if ([_imageArray count] <= 3) {
            [_viewHeight setConstant:imageWidth*1+(1-1)*10];
            [_viewWidth setConstant:imageWidth*[_imageArray count]+([_imageArray count]-1)*10];
        }else{
            [_viewHeight setConstant:imageWidth*2+(2-1)*10];
            if ([_imageArray count] == 4)
                [_viewWidth setConstant:imageWidth*2+(2-1)*10];
            else
            [_viewWidth setConstant:imageWidth*3+(3-1)*10];
        }
    }
    
    
    if (_videoDict) {
        NSString* cover = [_videoDict objectForKey:@"cover"];
        NSString* mp4_url = [_videoDict objectForKey:@"mp4_url"];
        [_viewWidth2 setConstant:ViewSize(self.view).width-10*2];
        [_backgroundIV sd_setImageWithURL:[NSURL URLWithString:cover] placeholderImage:[UIImage imageNamed:@"Vlogo"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getData:(NSDictionary *)dict postID:(NSInteger)postID error:(NSError *)error {
    if (error != nil) {
        return;
    }
    if ([[dict objectForKey:@"code"] intValue] != 0) {
        NSLog(@"error = %@", [dict objectForKey:@"info"]);
        return;
    }
    
    if (postID == 6){
        _lbLikeCount.text = [NSString stringWithFormat:@"%d", [_lbLikeCount.text intValue]+1];
        [_ivZan setHidden:NO];
        [_btZan setEnabled:NO];
        
        NSMutableDictionary* udict = _m_dict.mutableCopy;
        [udict setObject:_lbLikeCount.text forKey:@"likeCount"];
        [udict setObject:@"1" forKey:@"is_like"];
        _m_dict = udict;
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"点赞成功";
        hud.labelFont = [UIFont systemFontOfSize:13];
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
    }
}


- (IBAction)detailAction:(id)sender {
        
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"NoteDetailViewController" bundle:nil];
    NoteDetailViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"NoteDetailViewController"];  //
    door.m_dict = _m_dict;
    door.m_bbsID = [_m_dict objectForKey:@"id"];
    door.imageArray = _imageArray;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

- (IBAction)zanAction:(id)sender{
    
}

- (IBAction)othersAction:(id)sender{
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"OthersViewController" bundle:nil];
    OthersViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"OthersViewController"];  //
    door.m_dict = _m_dict;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:door animated:YES];
}

-(IBAction)startPlayVideo:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(playVideo:)]) {
        [self.delegate playVideo:self];
    }
}

//-(void)setModel:(VideoModel *)model{
//    [self.backgroundIV sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"logo"]];
//}

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_imageArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"imageCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
//    NSString* image_path = [_imageArray objectAtIndex:indexPath.row];
//    UIImageView* ivLogo = (UIImageView*)[cell viewWithTag:2000];
//    [ivLogo sd_setImageWithURL:[NSURL URLWithString:image_path] completed: ^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (image == nil) {
//        }
//    }];
    UIImage* image_ = [_imageArray objectAtIndex:indexPath.row];
    UIImageView* ivLogo = (UIImageView*)[cell viewWithTag:2000];
    [ivLogo setImage:image_];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(imageWidth-2, imageWidth-2);
}

//定义每个UICollectionView 的 margin
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
//    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"ShowImage" bundle:nil];
//    ShowImage *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ShowImage"];
//    door.m_list = _imageArray;
//    door.row = indexPath.row;
//    [self.navigationController pushViewController:door animated:YES];
    
    // Browser
//    MWPhoto *photo, *thumb;
    BOOL displayActionButton = NO;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = NO;
    BOOL startOnGrid = NO;
    BOOL autoPlayOnAppear = NO;
    
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = autoPlayOnAppear;
    [browser setCurrentPhotoIndex:indexPath.row];
    
    // Reset selections
    if (displaySelectionButtons) {
        _selections = [NSMutableArray new];
        for (int i = 0; i < _photos.count; i++) {
            [_selections addObject:[NSNumber numberWithBool:NO]];
        }
    }
    
    // Push
    [self.navigationController pushViewController:browser animated:YES];
//    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
//    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:nc animated:YES completion:nil];
    
}

//返回这个UICollectionView是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}



#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return [[_selections objectAtIndex:index] boolValue];
}

//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
//    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
