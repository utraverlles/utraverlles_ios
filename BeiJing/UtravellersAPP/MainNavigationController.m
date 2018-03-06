//
//  MainNavigationController.m
//
#import "MainNavigationController.h"

//extern NSMutableDictionary *User_Dict;

@interface MainNavigationController ()
@end
@implementation MainNavigationController
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		// Initialization code
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //隐藏白线
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        NSArray *list = self.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = (UIImageView *)obj;
                NSArray *list2 = imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2 = (UIImageView *)obj2;
                        imageView2.hidden = YES;
                    }
                }
            }
        }
    }
    
    /*
    BOOL isFirstLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstLogin"];
//    isFirstLogin = NO;
    if (!isFirstLogin) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstLogin"];
        UIStoryboard *secondStoryBoard = nil;
        UIViewController *door = nil;
        secondStoryBoard = [UIStoryboard storyboardWithName:@"Startup" bundle:nil];
        door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"Startup"];
        [self pushViewController:door animated:NO];
    }else{
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MainTabBar" bundle:nil];
        UIViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"MainTabBar"];
        [self pushViewController:door animated:NO];
    }
    */
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MainTabBar" bundle:nil];
    UIViewController *door = [secondStoryBoard instantiateViewControllerWithIdentifier:@"MainTabBar"];
    [self pushViewController:door animated:NO];
    
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
