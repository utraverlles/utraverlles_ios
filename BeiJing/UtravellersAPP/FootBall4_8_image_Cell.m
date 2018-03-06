//
//  FootBall4_8_Cell.m
//  FootBall3
//
//  Created by 王登鹏 on 15/10/28.
//  Copyright © 2015年 王登鹏. All rights reserved.
//
#import "FootBall4_8_image_Cell.h"
#import "OthersViewController.h"
//#import "ShowImageView.h"


@interface FootBall4_8_image_Cell ()
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;
@property (nonatomic, strong) NSMutableArray *selections;

- (IBAction)buttonCallBack:(UIButton *)sender;
- (IBAction)imageCallBack:(UIButton *)sender;
@end

@implementation FootBall4_8_image_Cell
- (void)awakeFromNib {
	[super awakeFromNib];
	[self updateImageView:_image];
}

- (void)updateImageView:(UIImageView *)imageView {
	CGSize size = imageView.image.size;
	NSLayoutConstraint *sizeCon = [self findLayout:@"imageHeight" superView:imageView];
	[imageView removeConstraint:sizeCon];
	if (size.height == 0 || size.width == 0) {
		return;
	}
	float scale = size.height / size.width;
	NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeWidth multiplier:scale constant:0];
	c3.identifier = @"imageHeight";
	[imageView addConstraint:c3];
}

- (NSLayoutConstraint *)findLayout:(NSString *)nameID superView:(UIView *)superView {
	NSArray *a = [superView constraints];
	for (NSLayoutConstraint *aa in a) {
		if ([aa.identifier isEqualToString:nameID]) {
			return aa;
		}
	}
	return nil;
}

- (IBAction)buttonCallBack:(UIButton *)sender {
    
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"OthersViewController" bundle:nil];
    OthersViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"OthersViewController"];  //
    //    door.m_dict = _m_dict;
    _superViewCon.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [_superViewCon.navigationController pushViewController:door animated:YES];
    
}

- (IBAction)imageCallBack:(UIButton *)sender {
   
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    NSMutableArray *thumbs = [[NSMutableArray alloc] init];
    [photos addObject:[MWPhoto photoWithImage:_image.image]];
    [thumbs addObject:[MWPhoto photoWithImage:_image.image]];
    self.photos = photos;
    self.thumbs = thumbs;
    
    BOOL displayActionButton = NO;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = NO;
    BOOL startOnGrid = NO;
    BOOL autoPlayOnAppear = NO;
    
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    //browser.m_ID = _m_otherUserID;
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = autoPlayOnAppear;
    [browser setCurrentPhotoIndex:0];
    
    // Reset selections
    if (displaySelectionButtons) {
        _selections = [NSMutableArray new];
        for (int i = 0; i < _photos.count; i++) {
            [_selections addObject:[NSNumber numberWithBool:NO]];
        }
    }
    
    // Push
    [_superViewCon.navigationController pushViewController:browser animated:YES];
//    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"FootBall4_8_Cell" bundle:nil];
//    ShowImageView *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ShowImageView"];
//    door.img = _image.image;
////    NSLog(@"_image.image.size.width==%f  _image.image.size.height==%f", _image.image.size.width, _image.image.size.height);
//    _superViewCon.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//   [_superViewCon.navigationController pushViewController:door animated:YES];
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
    [_superViewCon dismissViewControllerAnimated:YES completion:nil];
}

@end
